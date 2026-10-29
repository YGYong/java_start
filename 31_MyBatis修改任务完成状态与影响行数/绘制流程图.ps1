Add-Type -AssemblyName System.Drawing
$bmp = [System.Drawing.Bitmap]::new(1500,1320)
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
$g.DrawString('MyBatis 修改完成状态与影响行数',$title,$brush,330,25)
$g.DrawString('教学示意：不是实际运行验证；不表示多条语句具有并发原子性',$small,$brush,280,85)
$labels = @('Postman：PATCH /database/tasks/{id}/completed','Controller：读取编号和 JSON 中的 completed','Service：completed 为 null → 参数异常 → HTTP 400','Repository → Mapper：绑定 id 和 completed，执行 UPDATE')
for ($i=0; $i -lt $labels.Count; $i++) {
 $y=145+$i*120
 $r=[System.Drawing.RectangleF]::new(150,$y,1200,80)
 $g.FillRectangle($fill,$r)
 $g.DrawString($labels[$i],$font,$brush,$r,$fmt)
 if ($i -lt $labels.Count-1) { $g.DrawLine($pen,750,$y+80,750,$y+115) }
}
$g.DrawLine($pen,750,585,750,640)
$r=[System.Drawing.RectangleF]::new(150,645,1200,85)
$g.FillRectangle($fill,$r)
$g.DrawString('检查影响行数：1 → 成功；0 → 查询复核；其他值 → 服务端异常',$font,$brush,$r,$fmt)
$g.DrawLine($pen,750,730,750,790)
$r=[System.Drawing.RectangleF]::new(150,795,1200,85)
$g.FillRectangle($fill,$r)
$g.DrawString('0 行：TaskQueryRepository.findById(id) 查询当前任务',$font,$brush,$r,$fmt)
$xs=@(40,530,1020)
$texts=@("查不到任务`nTaskNotFoundException`nHTTP 404", "任务存在，已是目标状态`n重复设置也算成功`nHTTP 200，正文 true", "任务存在，状态不符`nIllegalStateException`n服务端异常")
for($i=0;$i -lt 3;$i++) {
 $g.DrawLine($pen,750,880,$xs[$i]+220,950)
 $r=[System.Drawing.RectangleF]::new($xs[$i],960,440,190)
 $g.FillRectangle($fill,$r)
 $g.DrawString($texts[$i],$font,$brush,$r,$fmt)
}
$g.DrawString('WHERE 按主键限定任务，只修改 completed；返回 true 表示业务成功，不表示任务状态为 true。',$small,$brush,95,1225)
$bmp.Save((Join-Path $PSScriptRoot 'images/修改状态与影响行数流程图.png'),[System.Drawing.Imaging.ImageFormat]::Png)
$g.Dispose()
$bmp.Dispose()
