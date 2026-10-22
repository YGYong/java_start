Add-Type -AssemblyName System.Drawing
$bmp = [System.Drawing.Bitmap]::new(1500, 1120)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.Clear([System.Drawing.Color]::White)
$g.SmoothingMode = 'AntiAlias'
$f = [System.Drawing.Font]::new('Microsoft YaHei', 21)
$tf = [System.Drawing.Font]::new('Microsoft YaHei', 29, [System.Drawing.FontStyle]::Bold)
$p = [System.Drawing.Pen]::new([System.Drawing.Color]::SteelBlue, 3)
$b = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::AliceBlue)
$fmt = [System.Drawing.StringFormat]::new()
$fmt.Alignment = 'Center'
$fmt.LineAlignment = 'Center'
function Box($x,$y,$w,$h,$s) {
$r = [System.Drawing.Rectangle]::new($x,$y,$w,$h)
$g.FillRectangle($b,$r)
$g.DrawRectangle($p,$r)
$g.DrawString($s,$f,[System.Drawing.Brushes]::Black,[System.Drawing.RectangleF]::new($x+10,$y+5,$w-20,$h-10),$fmt)
}
function Arrow($x,$y1,$y2) {
$g.DrawLine($p,$x,$y1,$x,$y2)
$g.DrawLine($p,$x,$y2,$x-8,$y2-12)
$g.DrawLine($p,$x,$y2,$x+8,$y2-12)
}
$g.DrawString('Service 接口与实现分离',$tf,[System.Drawing.Brushes]::Black,[System.Drawing.RectangleF]::new(20,15,1460,65),$fmt)
$g.DrawString('教学示意：不是实际运行或断点验证',$f,[System.Drawing.Brushes]::DimGray,[System.Drawing.RectangleF]::new(20,85,1460,50),$fmt)
Box 120 155 1260 120 "启动阶段：Spring 扫描 @Service 实现类`nInMemoryTaskService implements TaskService"
Arrow 750 275 315
Box 120 315 1260 120 "Spring 创建并管理 InMemoryTaskService 对象`n当前只有一个匹配的 TaskService 服务 Bean"
Arrow 750 435 475
Box 120 475 1260 120 "创建 TaskController：构造器需要 TaskService`nSpring 将实现对象传入，保存在 taskService 字段中"
Arrow 750 595 635
Box 120 635 1260 120 "请求阶段：Postman → Controller → taskService 方法`n声明类型是接口；具体执行 InMemoryTaskService 的方法体"
Arrow 750 755 795
Box 120 795 1260 120 "实现类操作内存列表，返回结果或抛出异常`n沿用已有响应转换与异常处理，HTTP 行为保持一致"
Box 120 960 1260 110 "TaskService：约定能力；InMemoryTaskService：具体实现`nimplements 建立类型关系；@Override 检查方法；@Service 注册 Bean"
$bmp.Save((Join-Path $PSScriptRoot 'Service接口与实现注入流程图.png'), [System.Drawing.Imaging.ImageFormat]::Png)
$g.Dispose(); $bmp.Dispose(); $f.Dispose(); $tf.Dispose(); $p.Dispose(); $b.Dispose(); $fmt.Dispose()
