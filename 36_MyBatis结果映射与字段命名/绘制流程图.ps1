Add-Type -AssemblyName System.Drawing
$canvas = New-Object System.Drawing.Bitmap 1200,900
$g = [System.Drawing.Graphics]::FromImage($canvas)
$g.Clear([System.Drawing.Color]::White)
$g.SmoothingMode = 'AntiAlias'
$font = New-Object System.Drawing.Font 'Microsoft YaHei',19
$titleFont = New-Object System.Drawing.Font 'Microsoft YaHei',26
$pen = New-Object System.Drawing.Pen ([System.Drawing.Color]::SteelBlue),3
$brush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(235,244,252))
$g.DrawString('结果列如何变成接口字段', $titleFont, [System.Drawing.Brushes]::Black, 320,25)
$g.DrawString('教学示意：不是实际运行验证', $font, [System.Drawing.Brushes]::DimGray, 350,78)
function Box($y, $line1, $line2) {
    $g.FillRectangle($brush,100,$y,1000,110)
    $g.DrawRectangle($pen,100,$y,1000,110)
    $g.DrawString($line1,$font,[System.Drawing.Brushes]::Black,125,($y+13))
    $g.DrawString($line2,$font,[System.Drawing.Brushes]::Black,125,($y+58))
}
Box 140 '① 数据库查询：SELECT title AS task_title FROM task' '实际表列：title；结果列标签：task_title'
Box 300 '② Mapper XML：resultMap 定义对应关系' 'column="task_title"  →  property="title"'
Box 460 '③ Java 实体：Task.title' 'MyBatis 创建对象并填充属性；Repository 返回实体'
Box 620 '④ Service 转成 TaskResponse，Controller 返回 JSON' '接口字段 title 由响应对象决定，不由 SQL 别名决定'
foreach ($y in @(250,410,570)) { $g.DrawLine($pen,600,$y,600,($y+45)); $g.DrawLine($pen,600,($y+45),590,($y+32)); $g.DrawLine($pen,600,($y+45),610,($y+32)) }
$g.DrawString('计数分支：COUNT(*) → long，不使用 Task 的结果映射', $font,[System.Drawing.Brushes]::Black,120,780)
$canvas.Save((Join-Path $PSScriptRoot 'images/结果映射与接口字段流程图.png'))
$g.Dispose(); $canvas.Dispose(); $font.Dispose(); $titleFont.Dispose(); $pen.Dispose(); $brush.Dispose()
