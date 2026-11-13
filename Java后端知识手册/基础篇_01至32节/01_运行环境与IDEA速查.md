# 01 运行环境与 IDEA 速查

## 一页重点速记

| 【重点记住】 | 直接怎么用 |
| --- | --- |
| 运行链路 | .java源码 → 编译 → .class字节码 → JVM执行 |
| 工具分工 | JDK提供开发运行工具；IDEA组织编辑调试；Maven管理依赖构建 |
| 入口 | `public static void main(String[] args)` |
| 先核对工程 | 打开正确的子工程，确认Project/Module/启动配置使用JDK 21 |
| 高频编辑 | Alt+Enter修复，Ctrl+Alt+L格式化，Shift+F6重命名 |
| 高频导航 | Ctrl+B声明，Ctrl+Shift+F工程查找，Ctrl+Shift+A查动作 |
| 运行调试 | Shift+F10运行，Shift+F9调试，F7进入/F8跳过/F9继续 |
| 验证结果 | 编译成功、退出码0，都不等于业务结果正确 |

**使用顺序：**先看这张表恢复记忆；配置或快捷键忘了，查下面详细表格。快捷键以默认Windows Keymap为前提。

## 详细图文说明

## 1. 【重点记住】Java 程序从编写到执行

```text
Main.java → javac 编译 → Main.class → java 启动 JVM → 执行 main
```

| 名称 | 用途 | 不要混淆 |
| --- | --- | --- |
| JDK | 编译、运行、调试 Java 的工具包 | IDEA 不能代替 JDK |
| JVM | 运行字节码的虚拟机 | 运行的是编译后的字节码 |
| JRE | 运行环境的概念，包含 JVM 与运行库 | 使用 JDK 21 开发通常无需再单装 JRE |
| javac | 把源码编译成字节码 | 编译通过只说明满足编译规则 |
| java | 启动 Java 程序 | 退出码 0 不证明业务逻辑正确 |
| IDEA | 编辑、运行、调试和项目管理工具 | 需要正确配置工程 SDK |
| Maven | 管理依赖并组织构建 | 自身不是 Java 编译器 |

### 命令行最小示例

```java
public class Main {
    public static void main(String[] args) {
        System.out.println("Hello Java");
    }
}
```

在保存 Main.java 的目录打开 PowerShell：

```powershell
java -version
javac -version
javac -encoding UTF-8 Main.java
java Main
```

最后一条写类名 Main，不写 Main.class。JDK 21 也支持 `java Main.java` 的单文件源码启动；这不等于跳过编译，也不代替 Maven 工程构建。含 package 的工程需要按包路径和 classpath 运行，优先由 IDEA 或 Maven 组织。

## 2. 【重点记住】main 与基本书写规则

| 片段 | 含义 |
| --- | --- |
| public | 允许外部访问 |
| static | 属于类，不需要先创建实例 |
| void | 不返回值 |
| main | 这里约定的入口方法名 |
| String[] args | 命令行字符串参数数组 |

普通源码中，public 顶层类 Main 对应 Main.java。Java 区分大小写；代码结构使用英文半角符号。方法、类的代码块用 `{}`，普通声明和表达式语句常以 `;` 结束，if/for 的代码块后一般不再添加分号。

```java
// 单行注释
/* 多行注释 */
/** 文档注释：用于类、方法、字段的 API 说明 */
```

常用命名：类名 `TaskService`，方法/变量 `findById`、`taskId`，常量 `MAX_PAGE_SIZE`，包名 `com.example.task`。这是风格约定，不是所有名称都由编译器强制。

## 3. 【常用查阅】SDK 与工程配置排查

| 配置 | 影响什么 | IDEA 入口 |
| --- | --- | --- |
| Project SDK | 工程使用哪个 JDK | File → Project Structure → Project |
| Module SDK | 模块使用哪个 JDK | Project Structure → Modules → Dependencies |
| Language level | 编辑器/编译允许的语言特性 | Project / Modules 的 Language level |
| Maven Runner JRE | Maven 命令在哪个 Java 上运行 | Settings → Build Tools → Maven → Runner |
| Maven Importer JDK | 导入 Maven 工程的 Java 环境 | Settings 中搜索 Maven Importing |
| Run Configuration JRE | 某次启动使用哪个 JDK | Run → Edit Configurations |

工程按 JDK 21 编写时，优先让这些配置保持一致。终端 `java -version` 反映终端 PATH，不能单独证明 IDEA 的启动 JDK。Spring Boot 工程应打开包含 pom.xml 的目录；仅把它放在外层文件夹里，不保证 IDEA 已导入模块。

## 4. 【常用查阅】Windows 常用快捷键

**【重点记住】先熟悉这组：**Alt+Enter修复提示、Ctrl+Alt+L格式化、Shift+F6重命名、Ctrl+B看声明、Ctrl+Shift+F工程查找、Shift+F10运行、Shift+F9调试、F7/F8/F9单步与继续。其余按需查表。

以下按 IntelliJ IDEA 默认 Windows 键位。Eclipse、VS Code 等 Keymap 会不同；笔记不是对当前 Keymap 的截图确认。`Ctrl+Alt+S` 打开设置，在 Keymap 搜索英文动作名可核对或修改；`Ctrl+Shift+A` 可直接搜索动作，无需记每一个快捷键。

### 编辑与补全

| 功能 | 默认快捷键 | 英文动作/提示 |
| --- | --- | --- |
| 基本补全 | Ctrl+Space | Basic Completion；可能被输入法占用 |
| 按类型补全 | Ctrl+Shift+Space | Type-Matching Completion |
| 修复提示、导包、意图操作 | Alt+Enter | Show Context Actions |
| 参数提示 | Ctrl+P | Parameter Info |
| 快速文档 | Ctrl+Q | Quick Documentation |
| 生成构造器/getter/setter | Alt+Insert | Generate |
| 重写方法 | Ctrl+O | Override Methods |
| 实现接口方法 | Ctrl+I | Implement Methods |
| 格式化代码 | Ctrl+Alt+L | Reformat Code |
| 优化 import | Ctrl+Alt+O | Optimize Imports |
| 行注释 | Ctrl+/ | Comment with Line Comment |
| 块注释 | Ctrl+Shift+/ | Comment with Block Comment |
| 复制当前行/选区 | Ctrl+D | Duplicate Line or Selection |
| 删除当前行 | Ctrl+Y | Delete Line；不是默认的重做 |
| 移动语句 | Ctrl+Shift+↑ / ↓ | Move Statement Up / Down |
| 新建下一行 | Shift+Enter | Start New Line |
| 扩大/缩小选区 | Ctrl+W / Ctrl+Shift+W | Extend / Shrink Selection |
| 历史粘贴 | Ctrl+Shift+V | Paste from History |
| 撤销/重做 | Ctrl+Z / Ctrl+Shift+Z | Undo / Redo |
| 保存全部 | Ctrl+S | Save All；IDEA 也有自动保存机制 |

### 查找、导航与重构

| 功能 | 默认快捷键 | 英文动作/提示 |
| --- | --- | --- |
| 全局搜索入口 | 连按两次 Shift | Search Everywhere |
| 按类名找类 | Ctrl+N | Go to Class |
| 按文件名找文件 | Ctrl+Shift+N | Go to File |
| 当前文件查找/替换 | Ctrl+F / Ctrl+R | Find / Replace |
| 工程内查找/替换 | Ctrl+Shift+F / Ctrl+Shift+R | Find / Replace in Files |
| 跳到声明 | Ctrl+B | Go to Declaration；也可 Ctrl+单击 |
| 跳到实现 | Ctrl+Alt+B | Go to Implementation |
| 查找使用位置 | Alt+F7 | Find Usages |
| 最近文件 | Ctrl+E | Recent Files |
| 返回/前进导航位置 | Ctrl+Alt+← / → | Back / Forward |
| 当前文件结构 | Ctrl+F12 | File Structure |
| 跳转行号 | Ctrl+G | Go to Line |
| 重命名并更新引用 | Shift+F6 | Rename；优于文本批量替换 |
| 提取局部变量 | Ctrl+Alt+V | Extract Variable |
| 提取方法 | Ctrl+Alt+M | Extract Method |
| 项目窗口 | Alt+1 | Project |
| 终端 | Alt+F12 | Terminal |
| 查找动作 | Ctrl+Shift+A | Find Action |

### 运行与调试

| 功能 | 默认快捷键 | 使用说明 |
| --- | --- | --- |
| 运行当前选定配置 | Shift+F10 | Run |
| 调试当前选定配置 | Shift+F9 | Debug |
| 停止进程 | Ctrl+F2 | Stop |
| 设置/取消行断点 | Ctrl+F8 | Toggle Line Breakpoint |
| 查看全部断点 | Ctrl+Shift+F8 | View Breakpoints |
| 单步进入 | F7 | Step Into，进入被调用方法 |
| 单步跳过 | F8 | Step Over，执行当前行，不进入调用 |
| 跳出当前方法 | Shift+F8 | Step Out |
| 继续执行 | F9 | Resume Program |
| 运行到光标 | Alt+F9 | Run to Cursor |
| 计算表达式 | Alt+F8 | Evaluate Expression，需暂停在有效上下文 |

补全、生成方法和重构在 Code / Refactor 菜单可找；运行与调试在 Run 菜单可找。笔记本 F 键可能需要配合 Fn，系统或输入法也可能占用快捷键。

## 5. 【重点记住】正确观察断点

1. 设置断点，用 Debug 启动。
2. 高亮行通常是下一条要执行的语句，停在赋值行不代表已经赋值。
3. 在 Variables 查看当前方法的局部变量和对象字段。
4. 在 Frames/调用栈查看“谁调用了谁”。
5. 对自己的业务方法用 F7，跳过暂不需要看的框架代码可用 F8。

普通 Run 不会因行断点而暂停。调试器中的表达式可能调用方法并产生副作用，不要随意计算写库或删除方法。接口调试需要先 Debug 启动后端，再由 Postman 发请求。

## 独立练习：先自己完成，再按标准检查

**练习1：从文件到运行。** 在新的临时练习目录写一个Main，声明总数量和完成数量，调用一个方法返回剩余数量。分别通过IDEA与终端运行，并用自己的话说明.java、.class和JVM的关系。

验收：两种方式输出一致；能指出源码和编译产物的位置；不把退出码0当作计算正确的证据。

**练习2：用调试解释执行。** 在计算方法的调用行设断点，使用Step Into进入，观察参数，再回到调用处观察返回值。随后用Rename重命名该方法。

验收：能区分“当前行尚未执行”和“已执行”；重命名后调用处同步更新。无需把调试器每个按钮都操作一遍。

## 工作中先记这些

编译错误看 Build；运行异常看调用栈；逻辑错误对照预期看变量。源码放 src，生成文件放 out/target，不修改编译产物。忘记快捷键就用 Find Action 搜索。

参考：[JetBrains 默认 Windows 键位表](https://www.jetbrains.com/help/idea/reference-keymap-win-default.html)、[单步调试](https://www.jetbrains.com/help/idea/stepping-through-the-program.html)、[JDK 21 java 命令](https://docs.oracle.com/en/java/javase/21/docs/specs/man/java.html)。
