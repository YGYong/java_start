Add-Type -AssemblyName System.Drawing
$script:outDir = $PSScriptRoot
$script:font = [System.Drawing.Font]::new('Microsoft YaHei',19)
$script:small = [System.Drawing.Font]::new('Microsoft YaHei',16)
$script:heading = [System.Drawing.Font]::new('Microsoft YaHei',29,[System.Drawing.FontStyle]::Bold)
$script:ink = [System.Drawing.SolidBrush]::new([System.Drawing.ColorTranslator]::FromHtml('#15314D'))
$script:center = [System.Drawing.StringFormat]::new()
$script:center.Alignment = 'Center'
$script:center.LineAlignment = 'Center'
function Canvas([string]$title,[string]$subtitle,[int]$height=1080) {
    $script:bmp = [System.Drawing.Bitmap]::new(1600,$height)
    $script:g = [System.Drawing.Graphics]::FromImage($script:bmp)
    $script:g.Clear([System.Drawing.ColorTranslator]::FromHtml('#F7FAFD'))
    $script:g.SmoothingMode = 'AntiAlias'
    $script:g.TextRenderingHint = 'AntiAliasGridFit'
    $script:g.DrawString($title,$script:heading,$script:ink,[System.Drawing.RectangleF]::new(35,22,1530,62),$script:center)
    $script:g.DrawString(('教学示意，非实际运行验证 · '+$subtitle),$script:small,$script:ink,[System.Drawing.RectangleF]::new(35,90,1530,50),$script:center)
}
function Box([int]$x,[int]$y,[int]$w,[int]$h,[string]$label,[string]$hex='#E8F1FD',[int]$size=19) {
    $drawFont=$script:font
    if ($size -eq 16) { $drawFont=$script:small }
    $r = [System.Drawing.RectangleF]::new($x,$y,$w,$h)
    $fill=[System.Drawing.SolidBrush]::new([System.Drawing.ColorTranslator]::FromHtml($hex))
    $script:g.FillRectangle($fill,$r)
    $border=[System.Drawing.Pen]::new([System.Drawing.ColorTranslator]::FromHtml('#CBD9E8'),2)
    $script:g.DrawRectangle($border,$x,$y,$w,$h)
    $inner=[System.Drawing.RectangleF]::new($x+14,$y+10,$w-28,$h-20)
    $measured=$script:g.MeasureString($label,$drawFont,($w-28))
    if ($measured.Height -gt ($h-16)) { throw "文字可能溢出：$label" }
    $script:g.DrawString($label,$drawFont,$script:ink,$inner,$script:center)
    $fill.Dispose(); $border.Dispose()
}
function Arrow([int]$x1,[int]$y1,[int]$x2,[int]$y2) {
    $p=[System.Drawing.Pen]::new([System.Drawing.ColorTranslator]::FromHtml('#58799A'),3)
    $p.CustomEndCap=[System.Drawing.Drawing2D.AdjustableArrowCap]::new(5,6)
    $script:g.DrawLine($p,$x1,$y1,$x2,$y2)
    $p.Dispose()
}
function Caption([string]$label,[int]$y) {
    $script:g.DrawString($label,$script:small,$script:ink,[System.Drawing.RectangleF]::new(45,$y,1510,75),$script:center)
}
function Save([string]$name) {
    $script:bmp.Save((Join-Path $script:outDir ($name+'.png')),[System.Drawing.Imaging.ImageFormat]::Png)
    $script:g.Dispose(); $script:bmp.Dispose()
}

Canvas 'Java 后端知识结构：每一层解决什么问题' '先认清职责，再记语法'
Box 70 165 700 155 "Java 语言：类型、方法、对象、集合、异常`n规定代码如何表达数据与行为"
Box 830 165 700 155 "Maven：依赖、编译、测试、打包`n规定工程如何组织与构建" '#E6F5EE'
Box 70 365 1460 150 "Spring 容器：创建 Bean、通过构造器注入依赖`n@Service / @Repository 等标记角色，方法逻辑仍需自己写" '#FFF3D9'
Arrow 800 320 800 365
Box 70 565 330 160 "Controller`n参数与 HTTP 响应`n@RestController"
Box 445 565 330 160 "Service`n校验与业务判断`n@Service"
Box 820 565 330 160 "Repository`n封装数据访问`n@Repository"
Box 1195 565 330 160 "Mapper`nSQL 与结果映射`n@Mapper"
Arrow 400 645 445 645; Arrow 775 645 820 645; Arrow 1150 645 1195 645
Box 70 810 1460 135 "MyBatis → JDBC → MySQL 驱动 → MySQL 数据库`n把 Java 参数绑定成 SQL 值，把结果行映射成 Java 对象" '#E6F5EE'
Arrow 1360 725 1360 810
Caption '重点：分层是职责约定；注解提供框架元数据；业务规则由代码决定。' 975
Save 'Java后端知识结构图'

Canvas 'Java 类型地图：八种基本类型 + 引用类型' 'String 不是基本类型'
Box 60 160 720 95 '基本类型：变量直接保存对应的值' '#E6F5EE'
Box 820 160 720 95 '引用类型：变量保存对象引用，可为 null'
$left=@('byte：8 位整数','short：16 位整数','int：32 位整数，常用计数','long：64 位整数，常用大编号','float：32 位近似小数，字面量加 F','double：64 位近似小数','char：16 位 UTF-16 代码单元','boolean：只有 true / false')
for($i=0;$i -lt 8;$i++){ Box 60 (275+$i*68) 720 58 $left[$i] '#E6F5EE' }
$right=@('类：String / Task / Integer / BigDecimal','接口：List / Map / TaskService','数组：int[] / String[] / Task[]','特殊类：enum 枚举、record 数据载体','泛型类型变量：T / E / K / V')
for($i=0;$i -lt 5;$i++){ Box 820 (275+$i*108) 720 90 $right[$i] }
Box 60 865 1480 110 "包装类型：int ↔ Integer，boolean ↔ Boolean（其余也有对应包装类）`nInteger 可为 null；int 不可。null 自动拆箱会抛异常。" '#FFF3D9'
Caption '工作中先记：计数 int，大总数 long，文字 String，真假 boolean，可选真假 Boolean。' 995
Save 'Java类型分类图'

Canvas '方法声明拆解：每一块写在哪里' '普通 Java 方法定义在类体中' 1030
Box 65 165 1470 110 'public static int calculateRemaining(int total, int completed)'
$x=@(65,365,665,965,1265)
$labels=@("public`n谁能访问", "static`n属于类，不需实例", "int`n返回值的类型", "calculateRemaining`n方法名，描述用途", "(int total, ...)`n参数类型与名称")
for($i=0;$i -lt 5;$i++){ Box $x[$i] 325 270 150 $labels[$i] '#E6F5EE' 16 }
Box 65 530 1470 110 "{ return total - completed; }`nreturn 把结果交回调用处，并结束本次方法执行。" '#FFF3D9'
Box 65 700 670 150 "调用：calculateRemaining(8, 3)`n第一个实参 → total`n第二个实参 → completed"
Box 865 700 670 150 "接收：int remaining = 返回结果;`n返回值为 5，保存到 remaining`nprintln 负责显示，不替代 return" '#E6F5EE'
Arrow 735 775 865 775
Caption '重点：参数按位置、按值传递；只改返回类型不能构成重载；void 表示不返回值。' 900
Save '方法声明拆解图'

Canvas 'Spring 分层与注解：位置决定含义' '构造器把依赖对象传进来' 1100
$ys=@(160,355,550,745)
$roles=@('Controller','Service','Repository','Mapper 接口')
$anns=@('@RestController','@Service','@Repository','@Mapper')
$duties=@("接收 HTTP 请求，读取参数`n返回对象或 ResponseEntity", "校验参数，组织业务流程`n解释影响行数，抛出业务异常", "对业务提供数据访问方法`n隐藏内存或数据库实现细节", "@Select / @Insert / @Update / @Delete`n声明 SQL，由 MyBatis 代理执行")
for($i=0;$i -lt 4;$i++) {
 Box 55 $ys[$i] 300 145 ($roles[$i]+"`n"+$anns[$i])
 Box 405 $ys[$i] 1140 145 $duties[$i] '#E6F5EE'
 Arrow 355 ($ys[$i]+72) 405 ($ys[$i]+72)
 if($i -lt 3){ Arrow 205 ($ys[$i]+145) 205 ($ys[$i]+190) }
}
Box 55 950 1490 90 'private final Repository repository;  →  构造器接收并赋给字段' '#FFF3D9'
Caption '重点：DTO / Entity 通常不加组件注解；@Override 是 Java 重写检查，不是依赖注入。' 1040
Save '分层注解位置图'

Canvas '异常记忆图：先分原因，再选处理方式' 'throw 发起失败，catch 或边界处理器接住' 1100
Box 575 155 450 80 'Throwable：异常与错误的根类型'
Arrow 700 235 370 290; Arrow 900 235 1230 290
Box 60 295 620 100 'Exception：应用可按情况处理' '#E6F5EE'
Box 930 295 610 100 'Error：通常不用于业务分支' '#FDEBE7'
Arrow 250 395 250 450; Arrow 510 395 750 450
Box 60 455 540 145 "受检异常`nIOException / SQLException`n编译器要求捕获或声明 throws" '#E6F5EE'
Box 660 455 880 145 "RuntimeException 及子类：非受检异常`n编译器不强制 catch / throws`n不代表无需处理、也不代表一定是严重故障"
Box 60 670 460 155 "参数不适合`nIllegalArgumentException`n例如标题为空" '#FFF3D9'
Box 570 670 460 155 "目标任务不存在`nTaskNotFoundException`n项目自定义业务异常" '#FFF3D9'
Box 1080 670 460 155 "状态或结果不符合预期`nIllegalStateException`n例如单条操作计数异常" '#FFF3D9'
Box 60 875 1480 110 "Service 抛出异常 → 请求处理边界接收 → GlobalExceptionHandler 决定 HTTP 响应`n异常名不会自动变成 400 / 404；当前处理器中的映射代码才决定结果。"
Caption '重点：不要空 catch，不把异常当成功返回；throw 不会自动撤销已经完成的数据库写入。' 1000
Save '异常分类与处理图'

Canvas 'HTTP 正常返回与异常响应：两条不同路径' '成功状态与错误状态分别由对应代码决定' 1100
Box 60 165 330 110 'Postman / 前端请求'
Box 445 165 330 110 'Controller 参数绑定'
Box 830 165 330 110 'Service 业务处理'
Box 1215 165 330 110 'Repository / Mapper'
Arrow 390 220 445 220; Arrow 775 220 830 220; Arrow 1160 220 1215 220
Box 70 365 690 150 "正常完成并返回`nController 返回对象 → 通常 200 + JSON`n无正文且指定 NO_CONTENT → 204" '#E6F5EE'
Box 840 365 690 150 "处理期间抛出异常`n后续正常调用路径中断`n寻找匹配的异常处理方式" '#FDEBE7'
Arrow 990 275 415 365; Arrow 990 275 1185 365
Box 840 585 690 155 "统一处理：@RestControllerAdvice`n匹配：@ExceptionHandler(异常类型.class)`n未匹配：交由框架后续错误处理" '#FFF3D9'
Arrow 1185 515 1185 585
Box 60 800 460 150 "参数错误`nIllegalArgumentException`n当前映射 HTTP 400" '#FFF3D9'
Box 570 800 460 150 "目标不存在`nTaskNotFoundException`n当前映射 HTTP 404" '#FFF3D9'
Box 1080 800 460 150 "未预期的服务端失败`n记录内部错误详情`n通常 HTTP 500" '#FDEBE7'
Arrow 1185 740 290 800; Arrow 1185 740 800 800; Arrow 1185 740 1310 800
Caption '重点：HTTP 状态码与 JSON 业务 code 是两套东西；204 不携带 JSON 正文。' 995
Save '请求与异常处理流程图'

Canvas 'SQL 语句拆解：动词、目标、条件各管什么' '以下为语法示例，不是待执行脚本' 1250
Box 60 160 1480 85 'SELECT id, title FROM task WHERE completed = FALSE ORDER BY id LIMIT 10;'
Box 60 270 450 115 "SELECT id, title`n要哪些列" '#E6F5EE'
Box 575 270 450 115 "FROM task`n从哪张表读" '#E6F5EE'
Box 1090 270 450 115 "WHERE completed = FALSE`n筛选哪些行" '#FFF3D9'
Box 60 435 1480 85 "INSERT INTO task (title, completed) VALUES ('学习 SQL', FALSE);"
Box 60 545 710 110 "(title, completed)`n明确列名与顺序" '#E6F5EE'
Box 830 545 710 110 "VALUES ('学习 SQL', FALSE)`n值与列按位置对应" '#E6F5EE'
Box 60 705 1480 85 'UPDATE task SET completed = TRUE WHERE id = 6;'
Box 60 815 710 110 "SET completed = TRUE`n修改哪些列、设为什么值" '#E6F5EE'
Box 830 815 710 110 "WHERE id = 6`n限定目标，漏写可能更新全表" '#FFF3D9'
Box 60 975 1480 90 'DELETE FROM task WHERE id = 6;  → 删除目标行，不写 DELETE *' '#FDEBE7'
Caption '重点：SQL 字符串用单引号；比较相等用 =；NULL 用 IS NULL；关键字大写是阅读习惯。' 1100
Save 'SQL语法拆解图'

Canvas '引用与对象：复制变量不等于复制对象' '对象赋值和列表复制都是常见误区' 1050
Box 65 175 600 120 'Task a = new Task("学习引用");'
Box 65 350 600 120 'Task b = a;'
Box 980 215 540 220 "同一个 Task 对象`ntitle = 学习引用`ncompleted = false" '#E6F5EE'
Arrow 665 235 980 275; Arrow 665 410 980 365
Box 65 540 1455 120 "b.complete(); → 修改同一个对象 → 通过 a 也能看到 completed = true" '#FFF3D9'
Box 65 740 680 135 "new ArrayList<>(tasks)`n创建新列表容器，可独立增删"
Box 845 740 675 135 "其中的 Task 通常仍是原对象`n修改对象字段可能两边都能看到" '#E6F5EE'
Arrow 745 805 845 805
Caption '重点：final 限制变量重新赋值，不保证对象内部不可变；深复制需要额外设计。' 920
Save '引用与浅复制示意图'

Canvas '分页记忆图：页码从 1 开始，索引从 0 开始' '先筛选再分页，total 是全部匹配数量' 1030
Box 65 160 1470 100 '示例：筛选后有 12 条，page = 2，size = 5，offset = (2 - 1) × 5 = 5'
for($i=0;$i -lt 12;$i++) {
 $hex='#E8F1FD'; if($i -ge 5 -and $i -lt 10){$hex='#CBEBDD'}
 Box (65+$i*123) 335 112 160 ("条目"+($i+1)+"`n索引"+$i) $hex 16
}
Box 65 545 450 145 "page = 1`n第 1～5 条`n索引 [0, 5)"
Box 575 545 450 145 "page = 2（绿色）`n第 6～10 条`n索引 [5, 10)" '#CBEBDD'
Box 1085 545 450 145 "page = 3`n第 11～12 条`n索引 [10, 12)"
Box 65 765 1470 115 "total = 12（全部匹配数），当前第 2 页 items.size() = 5`nend = min(offset + size, total)；offset 超出总数时返回空 items。" '#FFF3D9'
Caption '重点：page ≥ 1；size 设置上限；乘法前转 long；分页与总数使用同一套筛选条件。' 920
Save '分页区间示意图'

$script:font.Dispose(); $script:small.Dispose(); $script:heading.Dispose(); $script:ink.Dispose(); $script:center.Dispose()
