Add-Type -AssemblyName System.Drawing
$bmp = [System.Drawing.Bitmap]::new(1500, 1050)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.Clear([System.Drawing.Color]::White)
$g.SmoothingMode = 'AntiAlias'
$f = [System.Drawing.Font]::new('Microsoft YaHei', 19)
$tf = [System.Drawing.Font]::new('Microsoft YaHei', 27, [System.Drawing.FontStyle]::Bold)
$p = [System.Drawing.Pen]::new([System.Drawing.Color]::SteelBlue, 3)
$b = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::AliceBlue)
$fmt = [System.Drawing.StringFormat]::new()
$fmt.Alignment = 'Center'
$fmt.LineAlignment = 'Center'
function Box($x,$y,$w,$h,$s) {
 $r = [System.Drawing.Rectangle]::new($x,$y,$w,$h)
 $g.FillRectangle($b,$r)
 $g.DrawRectangle($p,$r)
 $g.DrawString($s,$f,[System.Drawing.Brushes]::Black,[System.Drawing.RectangleF]::new($x+8,$y+4,$w-16,$h-8),$fmt)
}
function Arrow($x1,$y1,$x2,$y2) {
 $g.DrawLine($p,$x1,$y1,$x2,$y2)
 $g.DrawLine($p,$x2,$y2,$x2-8,$y2-12)
 $g.DrawLine($p,$x2,$y2,$x2+8,$y2-12)
}
$g.DrawString('任务列表查询与可选条件筛选',$tf,[System.Drawing.Brushes]::Black,[System.Drawing.RectangleF]::new(20,15,1460,65),$fmt)
$g.DrawString('教学示意：解释执行路径，不是实际运行验证',$f,[System.Drawing.Brushes]::DimGray,[System.Drawing.RectangleF]::new(20,80,1460,45),$fmt)
Box 350 140 800 85 'GET /tasks，可选查询参数 completed'
Arrow 750 225 750 255
Box 350 255 800 85 'Controller：以可选 Boolean 接收参数，传给 Service'
Arrow 750 340 750 370
Box 350 370 800 85 'Service：判断 completed != null'
$g.DrawLine($p,750,455,750,485)
$g.DrawLine($p,370,485,1130,485)
Arrow 370 485 370 520
Arrow 1130 485 1130 520
Box 60 520 620 100 "否：参数为 null，不筛选`nnew ArrayList<>(tasks) 复制全部列表容器"
Box 820 520 620 100 "是：参数为 true 或 false`n创建空结果列表，遍历原任务列表"
Arrow 1130 620 1130 650
Box 820 650 620 100 "逐条比较任务状态与 completed`n匹配则加入结果列表，否则跳过"
Arrow 370 620 370 790
Arrow 1130 750 1130 790
Box 60 790 620 100 '返回包含全部任务的新列表'
Box 820 790 620 100 '遍历结束，返回结果列表（无匹配则为空）'
$g.DrawString('统一响应：HTTP 200 + JSON 数组；空列表为 []，原任务列表不变',$f,[System.Drawing.Brushes]::Black,[System.Drawing.RectangleF]::new(20,915,1460,55),$fmt)
$g.DrawString('浅拷贝：容器独立，任务对象仍共享引用；false 是有效条件，不是缺失',$f,[System.Drawing.Brushes]::DimGray,[System.Drawing.RectangleF]::new(20,975,1460,55),$fmt)
$bmp.Save((Join-Path $PSScriptRoot '任务列表查询与可选筛选流程图.png'),[System.Drawing.Imaging.ImageFormat]::Png)
$g.Dispose()
$bmp.Dispose()
$f.Dispose()
$tf.Dispose()
$p.Dispose()
$b.Dispose()
$fmt.Dispose()


