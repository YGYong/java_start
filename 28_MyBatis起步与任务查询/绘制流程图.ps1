Add-Type -AssemblyName System.Drawing
$bmp = [System.Drawing.Bitmap]::new(1200,1510)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.Clear([System.Drawing.Color]::FromArgb(245,248,252))
$g.SmoothingMode = 'AntiAlias'
$font = [System.Drawing.Font]::new('Microsoft YaHei',20)
$title = [System.Drawing.Font]::new('Microsoft YaHei',28,[System.Drawing.FontStyle]::Bold)
$small = [System.Drawing.Font]::new('Microsoft YaHei',16)
$brush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(30,48,72))
$fill = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(226,237,250))
$pen = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(63,106,160),3)
$pen.EndCap = [System.Drawing.Drawing2D.LineCap]::ArrowAnchor
$fmt = [System.Drawing.StringFormat]::new()
$fmt.Alignment = 'Center'
$fmt.LineAlignment = 'Center'
$g.DrawString('MyBatis 任务查询与响应流程',$title,$brush,170,30)
$g.DrawString('教学示意：正常调用路径，不是实际运行验证截图',$small,$brush,170,90)
$labels = @('Postman：GET /database/tasks','Controller：接收请求，调用 Service','Service：调用查询 Repository','Repository：委托 TaskMapper.findAll()','MyBatis 代理：执行 @Select 中的 SQL','通过数据源和 MySQL 驱动查询 task 表','MyBatis：将每行记录映射为 Task，返回列表','结果返回 Service：逐个转换为 TaskResponse','Controller 返回列表，框架序列化为 JSON','Postman：观察 200 OK 与 JSON 数组')
for ($i=0; $i -lt $labels.Count; $i++) {
 $y=150+$i*123
 $r=[System.Drawing.RectangleF]::new(140,$y,920,85)
 $g.FillRectangle($fill,$r)
 $g.DrawRectangle([System.Drawing.Pens]::SteelBlue,140,$y,920,85)
 $g.DrawString($labels[$i],$font,$brush,$r,$fmt)
 if ($i -lt $labels.Count-1) { $g.DrawLine($pen,600,$y+85,600,$y+118) }
}
$g.DrawString('连接配置来自 spring.datasource；SQL 由开发者编写。',$small,$brush,140,1400)
$g.DrawString('原 /tasks 使用内存；本图仅表示 /database/tasks 查询链。',$small,$brush,140,1445)
$bmp.Save((Join-Path $PSScriptRoot 'images/MyBatis任务查询流程图.png'),[System.Drawing.Imaging.ImageFormat]::Png)
$g.Dispose()
$bmp.Dispose()
