# 11 JDBC 与 MyBatis

## 一页重点速记

| 【重点记住】 | 规则/写法 |
| --- | --- |
| 调用关系 | Mapper代理 → JDBC → 驱动 → 数据库 |
| JDBC参数 | PreparedStatement的?绑定值，索引从1开始 |
| Mapper注解 | @Select/@Insert/@Update/@Delete声明SQL |
| 多参数 | @Param命名与SQL中的#{}名称一致 |
| 值绑定 | 优先#{}；${}直接替换文本，不能接任意用户输入 |
| 查询结果 | 单条可能null，列表通常空集合；列与属性需正确映射 |
| 插入回填 | 返回值是行数；@Options把生成键写入对象id属性 |
| 更新与删除 | 更新0行不一定不存在；删除0行无“值未改变”的歧义 |

**底线：**SQL写清WHERE；行数不是id；资源要关闭；多条语句不会自动获得并发一致性。

## 详细图文说明

## 1. 【重点记住】各工具的关系

```text
Service → Repository → MyBatis Mapper代理 → JDBC → MySQL驱动 → MySQL服务
```

JDBC是Java访问关系数据库的标准API，MySQL驱动实现具体通信，MyBatis简化SQL绑定、执行和结果映射。MyBatis不替你设计表，也不会自动把所有业务规则写进SQL。

## 2. 【重点记住】JDBC查询结构

```java
String sql = "SELECT id, title, completed FROM task WHERE id = ?";

try (Connection connection = DriverManager.getConnection(url, username, password);
     PreparedStatement statement = connection.prepareStatement(sql)) {
    statement.setInt(1, taskId);
    try (ResultSet resultSet = statement.executeQuery()) {
        if (resultSet.next()) {
            int id = resultSet.getInt("id");
            String title = resultSet.getString("title");
            boolean completed = resultSet.getBoolean("completed");
        }
    }
}
```

需要java.sql中的Connection、DriverManager、PreparedStatement、ResultSet，调用方法还要处理或声明SQLException。url/username/password/taskId为事先准备的变量，密码从环境配置读取，不硬编码。

| API | 作用 | 重点 |
| --- | --- | --- |
| getConnection | 获取连接 | 连接数据库服务，不是连接Navicat |
| prepareStatement | 准备带参数SQL | ?占位，参数索引从1开始 |
| setInt/setString等 | 绑定值 | 不要把?放进字符串引号里 |
| executeQuery | 执行有结果集查询 | 返回ResultSet |
| executeUpdate | 插入/更新/删除等 | 返回更新计数，不是主键 |
| ResultSet.next | 移动到下一行 | 初始位置在第一行之前 |
| getXxx | 读取当前行列值 | 基本类型getter读SQL NULL时需wasNull等方式辨别 |

try-with-resources负责关闭资源。参数化查询让SQL结构与值分离，避免把用户输入拼接成SQL语法；它不能直接把表名、列名、ASC/DESC作为普通值参数绑定。

【常用查阅】连接池提供DataSource来复用连接；应用中每次借连接、用完归还，通常不把一个全局Connection给所有请求共享。Spring管理事务时应使用配套数据访问机制，不随意手动commit破坏事务边界。

参考：[JDBC参数化查询](https://docs.oracle.com/javase/tutorial/jdbc/basics/prepared.html)、[JDBC结果集](https://docs.oracle.com/javase/tutorial/jdbc/basics/retrieving.html)。

## 3. 【重点记住】Spring Boot连接配置

```yaml
spring:
  datasource:
    url: jdbc:mysql://localhost:3306/testspring
    username: ${DB_USERNAME}
    password: ${DB_PASSWORD}
```

配置位于src/main/resources/application.yaml，进程启动前设置环境变量。驱动JAR要在运行依赖中。不要因为数据库连接失败就盲目增加安全相关URL参数；先按报错判断端口、库名、账户、权限、认证和TLS配置。

MyBatis starter负责与Boot整合、配置SqlSessionFactory等组件并扫描Mapper。JDBC连接设置不在Controller中写。

参考：[MyBatis Spring Boot starter](https://mybatis.org/spring-boot-starter/mybatis-spring-boot-autoconfigure/)。

## 4. 【重点记住】Mapper注解速查

| 注解 | 放哪里 | 用途 |
| --- | --- | --- |
| @Mapper | 接口 | 在扫描整合下注册Mapper代理 |
| @Select | 方法 | 查询SQL |
| @Insert | 方法 | 新增SQL |
| @Update | 方法 | 更新SQL |
| @Delete | 方法 | 删除SQL |
| @Param("name") | 参数 | 为SQL引用的参数命名 |
| @Options | 方法 | 配置执行选项，例如生成主键回填 |
| @Results/@Result，常用查阅 | 查询方法 | 显式配置结果列与属性映射 |

这些SQL注解来自org.apache.ibatis.annotations，不是JPA注解。接口没有手写实现，是MyBatis生成的代理对象在执行映射SQL，不是Java接口本身“可以直接运行”。

## 5. 【重点记住】查询与结果映射

```java
@Mapper
public interface TaskMapper {
    @Select("SELECT id, title, completed FROM task ORDER BY id")
    List<Task> findAll();

    @Select("SELECT id, title, completed FROM task WHERE id = #{id}")
    Task findById(@Param("id") int id);
}
```

列表结果用List<Task>，单条结果用Task。普通单条对象查询没有结果返回null，多于一条通常抛TooManyResultsException；按主键查可限制最多一行。列表没有结果返回空列表，不要把空列表和单条null混为一谈。

结果列与Java属性需建立对应，常用可写JavaBean属性/setter；也有构造器映射等方式。下划线列created_at与驼峰属性createdAt可用别名、显式映射或配置驼峰转换处理，不是天然在所有配置下自动对应。

```java
@Select("SELECT created_at AS createdAt FROM task WHERE id = #{id}")
```

上行为列别名语法示例，当前课程表没有created_at时不能直接使用。Mapper不要写SELECT *依赖所有列自动恰好匹配。

## 6. 【重点记住】参数绑定：#{}与${}

```java
@Update("UPDATE task SET completed = #{completed} WHERE id = #{id}")
int updateCompleted(@Param("id") int id,
                    @Param("completed") boolean completed);
```

多个独立参数用@Param明确命名，SQL占位符名称要一致。接口方法调用的参数值仍按Java位置传递，@Param是给MyBatis命名，不是Java命名参数语法。

| 写法 | 行为 | 使用规则 |
| --- | --- | --- |
| #{id} | 绑定参数值，通常落到PreparedStatement占位符 | 用户输入的值优先用此形式 |
| ${column} | 直接替换SQL文本 | 不接收未验证用户输入；列名/排序等必须白名单控制 |

SQL里写 `id = #{id}`，不要写 `id = '#{id}'`。#{}不能代替表名、列名；`${}`不是更灵活就更推荐。Spring YAML里的`${DB_PASSWORD}`是配置占位符，与SQL文本替换不能混淆。

单个对象参数可按属性读取：`#{title}`对应Task的title属性。普通单对象参数与多个@Param参数的访问路径不同，参数多加了一层名称时SQL也要相应调整。

参考：[MyBatis参数与结果映射](https://mybatis.org/mybatis-3/sqlmap-xml.html)。

## 7. 【重点记住】新增与主键回填

```java
@Insert("INSERT INTO task (title, completed) VALUES (#{title}, #{completed})")
@Options(useGeneratedKeys = true, keyProperty = "id")
int insert(Task task);
```

```java
Task task = new Task();
task.setTitle(title);
task.setCompleted(false);
int affectedRows = mapper.insert(task);
int generatedId = task.getId();
```

示例假设Task有无参构造器和对应setter。输入title要先校验，不依赖数据库异常提供全部用户提示。

| 变量/配置 | 意义 |
| --- | --- |
| affectedRows | 插入影响行数，单条通常预期1 |
| task.id | 数据库生成后回填到同一Java对象的主键 |
| useGeneratedKeys=true | 请求读取JDBC生成键 |
| keyProperty="id" | 接收回填值的Java属性名，不是SQL列顺序 |

数据库生成id→驱动提供生成键→MyBatis设置task.id→Service读取同一对象。方法返回1不代表id就是1，不能用MAX(id)替代可靠的生成键获取。对象属性必须可被正确写入，数据库自增与驱动支持也要匹配。

## 8. 【重点记住】更新、重复更新与影响行数

```java
@Update("UPDATE task SET completed = #{completed} WHERE id = #{id}")
int updateCompleted(@Param("id") int id,
                    @Param("completed") boolean completed);
```

Service先校验Boolean不为null，再调用接收boolean的Mapper。一般按主键更新1行可视为成功；0行的含义需结合驱动计数规则，不能一律判不存在。

MySQL Connector/J的useAffectedRows配置影响“匹配行”与“实际改变行”计数，官方默认false。重复设置相同状态可能仍返回1；配置改变后可能返回0，业务目标仍已达成。

当前课程策略：

| 结果 | Service处理 |
| --- | --- |
| 1行 | 成功 |
| 0行，复核查不到 | TaskNotFoundException |
| 0行，任务已为目标状态 | 成功 |
| 0行，任务存在但状态不符 | IllegalStateException |
| 其他计数 | 执行结果异常 |

这是针对本次更新约定的处理，不要求每个Service照抄。更新与复核是多条语句，未由此获得并发原子保证；事务、锁和并发方案需后续专门设计。

参考：[Connector/J useAffectedRows](https://docs.oracle.com/cd/E17952_01/connector-j-en/connector-j-connp-props-connection.html)。

## 9. 【重点记住】删除与不存在处理

```java
@Delete("DELETE FROM task WHERE id = #{id}")
int deleteById(@Param("id") int id);
```

```java
int rows = repository.deleteById(id);
if (rows == 0) {
    throw new TaskNotFoundException("任务不存在：" + id);
}
if (rows != 1) {
    throw new IllegalStateException("删除结果异常：" + rows);
}
```

按主键删除1行成功；0行无匹配，不存在“值相同没变”的情况，不需要照搬更新的状态复核。当前HTTP约定首次成功204无正文，重复删除404，由Controller和统一异常处理器实现。

## 10. 【常用查阅】Repository与Service之间的边界

```java
@Repository
public class TaskDeleteRepository {
    private final TaskMapper mapper;

    public TaskDeleteRepository(TaskMapper mapper) {
        this.mapper = mapper;
    }

    public int deleteById(int id) {
        return mapper.deleteById(id);
    }
}
```

Repository返回计数/数据，Service判断计数对当前业务意味着什么。不同项目也可能Service直接使用Mapper，分层是按复杂度与约定选择，不是每个SQL都必须再新建四个文件。按新增/更新/删除分出独立类是练习组织方式，不是必须遵守的Java规范。

## 独立练习：先自己完成，再按标准检查

**练习1：查询与参数绑定。** 在独立练习工程/副本中，为练习表实现按主键查询及按编号修改状态的方法。保留原方法，自行添加参数命名和结果映射。

验收：找不到单条的返回值处理明确；多个参数名称匹配；只更新目标列和目标行；不使用拼接用户值的SQL。

**练习2：行数与主键。** 新增专门练习记录，分别观察方法返回行数和对象回填id；随后更新该行，最后删除并重复删除。先写出每一步的业务判断，再执行核对。

验收：不把1行当id为1；生成键来自同一对象回填；能解释重复更新与重复删除的不同；不把未实际观察的驱动计数分支当作已验证。

## 工作中先记这些

SQL值用#{}；多参数用@Param；查询列与属性对应；影响行数不是id；生成主键用可靠回填；UPDATE/DELETE别漏WHERE；重复更新的0行与删除0行意义不同；数据库异常不能伪装成业务不存在。

参考：[MyBatis Java API与注解](https://mybatis.org/mybatis-3/java-api.html)。
