Add-Type -AssemblyName System.Drawing
$bmp = [System.Drawing.Bitmap]::new(1500,1120)
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
$g.DrawString('MyBatis 删除任务与不存在处理',$title,$brush,330,25)
$g.DrawString('教学示意：不是实际运行验证；本节按主键删除一条任务',$small,$brush,345,85)
$labels = @('Postman：DELETE /database/tasks/{id}，无请求正文','Controller：读取路径中的编号，调用 Service','Service → Repository → Mapper：传递编号','执行 SQL：DELETE FROM task WHERE id = #{id}','MyBatis 返回影响行数 → Repository 返回 → Service 判断')
for ($i=0; $i -lt $labels.Count; $i++) {
 $y=145+$i*115
 $r=[System.Drawing.RectangleF]::new(150,$y,1200,80)
 $g.FillRectangle($fill,$r)
 $g.DrawString($labels[$i],$font,$brush,$r,$fmt)
 if ($i -lt $labels.Count-1) { $g.DrawLine($pen,750,$y+80,750,$y+110) }
}
$xs=@(40,530,1020)
$texts=@("删除 1 行：成功`nController 正常结束`nHTTP 204，无正文", "删除 0 行：任务不存在`nTaskNotFoundException`n异常处理器 → HTTP 404", "其他计数：不符合预期`nIllegalStateException`n服务端异常，未实际触发验证")
for($i=0;$i -lt 3;$i++) {
 $g.DrawLine($pen,750,685,$xs[$i]+220,770)
 $r=[System.Drawing.RectangleF]::new($xs[$i],780,440,190)
 $g.FillRectangle($fill,$r)
 $g.DrawString($texts[$i],$font,$brush,$r,$fmt)
}
$g.DrawString('异常处理器决定错误响应映射；成功的 204 由 Controller 的 @ResponseStatus 指定。',$small,$brush,110,1030)
$bmp.Save((Join-Path $PSScriptRoot 'images/删除任务与不存在处理流程图.png'),[System.Drawing.Imaging.ImageFormat]::Png)
$g.Dispose()
$bmp.Dispose()
