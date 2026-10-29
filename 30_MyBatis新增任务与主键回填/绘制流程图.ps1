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
$g.DrawString('MyBatis 新增任务与主键回填',$title,$brush,320,25)
$g.DrawString('教学示意：不是实际运行验证截图',$small,$brush,450,85)
$labels = @('Postman：POST /database/tasks，发送 JSON 标题','Controller：读取请求体，委托 Service','Service：标题非法抛异常返回 400；合法则创建 Task','Repository → Mapper：传递同一个 Task 对象','MyBatis：绑定 title / completed，执行 INSERT','MySQL 生成 id → MyBatis 回填 Task.id，返回影响行数')
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
$g.DrawString("影响行数为 1`nService 读取回填后的 Task.id`n构造 TaskResponse → JSON`nHTTP 200",$font,$brush,$left,$fmt)
$g.DrawString("影响行数非 1`n抛出 IllegalStateException`n表示服务端写入结果异常`n不作为参数错误返回 400",$font,$brush,$right,$fmt)
$g.DrawString('影响行数 1 ≠ 主键编号 6；编号 6 来自本节实际数据库截图。',$small,$brush,320,1220)
$bmp.Save((Join-Path $PSScriptRoot 'images/新增任务与主键回填流程图.png'),[System.Drawing.Imaging.ImageFormat]::Png)
$g.Dispose()
$bmp.Dispose()


