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
$g.DrawString('泛型与通用分页响应',$tf,[System.Drawing.Brushes]::Black,[System.Drawing.RectangleF]::new(20,15,1460,65),$fmt)
$g.DrawString('教学示意：不是实际运行或断点验证',$f,[System.Drawing.Brushes]::DimGray,[System.Drawing.RectangleF]::new(20,85,1460,50),$fmt)
Box 200 155 1100 115 "定义一次：PageResponse<T>`nitems 为 List<T>；total、page、size 保留原有含义"
$g.DrawLine($p,750,270,750,300)
$g.DrawLine($p,370,300,1130,300)
Arrow 370 300 335
Arrow 1130 300 335
Box 60 335 620 110 "任务分页：指定 T 为 TaskResponse`nPageResponse<TaskResponse>"
Box 820 335 620 110 "字符串分页：指定 T 为 String`nPageResponse<String>"
Arrow 370 445 485
Arrow 1130 445 485
Box 60 485 620 100 "调用 getItems()`n得到 List<TaskResponse>"
Box 820 485 620 100 "调用 getItems()`n得到 List<String>"
Arrow 370 585 625
Arrow 1130 585 625
Box 60 625 620 100 "调用 get(0)`n得到 TaskResponse"
Box 820 625 620 100 "调用 get(0)`n得到 String，无需强制类型转换"
Box 100 785 1300 120 "类型参数让编译器检查元素类型是否匹配`n字符串分页不能接收 List<Integer>；任务分页不能接收 List<String>"
Box 100 950 1300 110 "任务接口仍返回 items、total、page、size`n泛型不会额外生成名为 T 的 JSON 字段"
$bmp.Save((Join-Path $PSScriptRoot '泛型类型传递流程图.png'), [System.Drawing.Imaging.ImageFormat]::Png)
$g.Dispose(); $bmp.Dispose(); $f.Dispose(); $tf.Dispose(); $p.Dispose(); $b.Dispose(); $fmt.Dispose()
