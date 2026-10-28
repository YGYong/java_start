Add-Type -AssemblyName System.Drawing
$bmp = [System.Drawing.Bitmap]::new(1400,1320)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.Clear([System.Drawing.Color]::White)
$g.SmoothingMode = 'AntiAlias'
$font = [System.Drawing.Font]::new('Microsoft YaHei',19)
$title = [System.Drawing.Font]::new('Microsoft YaHei',27,[System.Drawing.FontStyle]::Bold)
$small = [System.Drawing.Font]::new('Microsoft YaHei',16)
$brush = [System.Drawing.Brushes]::MidnightBlue
$fill = [System.Drawing.Brushes]::AliceBlue
$pen = [System.Drawing.Pen]::new([System.Drawing.Color]::SteelBlue,3)
$pen.EndCap = [System.Drawing.Drawing2D.LineCap]::ArrowAnchor
$fmt = [System.Drawing.StringFormat]::new()
$fmt.Alignment = 'Center'
$fmt.LineAlignment = 'Center'
$g.DrawString('MyBatis 参数绑定与按编号查询',$title,$brush,320,25)
$g.DrawString('教学示意：不是实际运行验证截图',$small,$brush,450,85)
$labels = @('Postman：GET /database/tasks/某个编号','Controller：@PathVariable 提取路径编号','Service → Repository → Mapper：逐层传递 id','@Param("id") 为参数命名；#{id} 创建 SQL 占位参数','MyBatis：执行 WHERE id = ? 并绑定编号值','MySQL 查询结果 → MyBatis 映射 → 返回 Service')
for ($i=0; $i -lt $labels.Count; $i++) {
 $y=145+$i*125
 $r=[System.Drawing.RectangleF]::new(150,$y,1100,85)
 $g.FillRectangle($fill,$r)
 $g.DrawRectangle([System.Drawing.Pens]::SteelBlue,150,$y,1100,85)
 $g.DrawString($labels[$i],$font,$brush,$r,$fmt)
 if ($i -lt $labels.Count-1) { $g.DrawLine($pen,700,$y+85,700,$y+120) }
}
$g.DrawLine($pen,700,855,360,925)
$g.DrawLine($pen,700,855,1040,925)
$left=[System.Drawing.RectangleF]::new(60,930,600,230)
$right=[System.Drawing.RectangleF]::new(740,930,600,230)
$g.FillRectangle($fill,$left)
$g.FillRectangle($fill,$right)
$g.DrawString("存在：返回 Task`nService 转为 TaskResponse`nController 返回 → JSON 对象`nHTTP 200",$font,$brush,$left,$fmt)
$g.DrawString("不存在：返回 null`nService 抛 TaskNotFoundException`n统一异常处理器返回错误信息`nHTTP 404",$font,$brush,$right,$fmt)
$g.DrawString('参数作为值绑定；本节保留列表查询与原内存接口。',$small,$brush,320,1220)
$bmp.Save((Join-Path $PSScriptRoot 'images/按编号查询与404处理流程图.png'),[System.Drawing.Imaging.ImageFormat]::Png)
$g.Dispose()
$bmp.Dispose()
