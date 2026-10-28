Add-Type -AssemblyName System.Drawing
$bmp = New-Object System.Drawing.Bitmap 1200,1400
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.Clear([System.Drawing.Color]::FromArgb(245,248,252))
$g.SmoothingMode = 'AntiAlias'
$font = New-Object System.Drawing.Font 'Microsoft YaHei',20
$titleFont = [System.Drawing.Font]::new('Microsoft YaHei', [single]28, [System.Drawing.FontStyle]::Bold)
$small = New-Object System.Drawing.Font 'Microsoft YaHei',16
$brush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(30,48,72))
$fill = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(226,237,250))
$pen = New-Object System.Drawing.Pen ([System.Drawing.Color]::FromArgb(63,106,160)),3
$arrow = New-Object System.Drawing.Pen ([System.Drawing.Color]::FromArgb(63,106,160)),3
$arrow.EndCap = [System.Drawing.Drawing2D.LineCap]::ArrowAnchor
$fmt = New-Object System.Drawing.StringFormat
$fmt.Alignment = 'Center'
$fmt.LineAlignment = 'Center'
$g.DrawString('JDBC 连接与逐行查询流程',$titleFont,$brush,120,35)
$g.DrawString('教学示意：正常查询路径，不是实际运行验证截图',$small,$brush,120,95)
function Box($y,$text) {
 $r = New-Object System.Drawing.RectangleF 170,$y,780,92
 $g.FillRectangle($fill,$r)
 $g.DrawRectangle($pen,170,$y,780,92)
 $g.DrawString($text,$font,$brush,$r,$fmt)
}
Box 155 '读取 DB_PASSWORD 环境变量，准备 URL 与用户名'
Box 285 'getConnection：建立 Connection 连接'
Box 415 'prepareStatement：创建 PreparedStatement'
Box 545 'executeQuery：取得 ResultSet，游标在第一行之前'
Box 675 'next()：向后移动一行，是否有当前行？'
Box 825 'true：读取当前行的三个字段，并打印任务'
$g.DrawLine($arrow,560,247,560,280)
$g.DrawLine($arrow,560,377,560,410)
$g.DrawLine($arrow,560,507,560,540)
$g.DrawLine($arrow,560,637,560,670)
$g.DrawLine($arrow,560,767,560,820)
$g.DrawLine($pen,170,871,100,871)
$g.DrawLine($pen,100,871,100,721)
$g.DrawLine($arrow,100,721,165,721)
$g.DrawString('继续循环',$small,$brush,10,780)
$g.DrawLine($pen,950,721,1070,721)
$g.DrawLine($pen,1070,721,1070,1005)
$g.DrawLine($arrow,1070,1005,955,1005)
$g.DrawString('false',$small,$brush,990,675)
Box 960 '离开内层 try：先关闭 ResultSet，再关闭查询对象'
Box 1090 'Connection 仍可使用：调用 getCatalog()'
Box 1220 '离开外层 try：关闭 Connection'
$g.DrawLine($arrow,560,1052,560,1085)
$g.DrawLine($arrow,560,1182,560,1215)
$g.DrawString('异常退出也会关闭已经成功创建的受管资源。',$small,$brush,170,1340)
$out = Join-Path (Get-Location) '27_JDBC起步与数据库连接/images/JDBC连接与逐行查询流程图.png'
$bmp.Save($out,[System.Drawing.Imaging.ImageFormat]::Png)
$g.Dispose()
$bmp.Dispose()

