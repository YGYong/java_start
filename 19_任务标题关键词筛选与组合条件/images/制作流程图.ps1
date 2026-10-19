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
$g.DrawString('任务标题关键词筛选与组合条件',$tf,[System.Drawing.Brushes]::Black,[System.Drawing.RectangleF]::new(20,15,1460,65),$fmt)
$g.DrawString('教学示意：解释执行路径，不是实际运行验证',$f,[System.Drawing.Brushes]::DimGray,[System.Drawing.RectangleF]::new(20,80,1460,45),$fmt)
Box 350 140 800 75 'GET /tasks：可选 completed 和 keyword'
Arrow 750 215 750 240
Box 350 240 800 75 'Controller 接收参数，传给 Service'
Arrow 750 315 750 340
Box 350 340 800 85 '关键词非空引用时 strip；创建新结果列表'
Arrow 750 425 750 450
Box 350 450 800 85 '遍历每条任务，分别计算两个匹配结果'
Arrow 750 535 750 560
Box 100 560 1300 100 "状态匹配：未传 completed 或状态相同`n标题匹配：无有效关键词或标题包含关键词"
Arrow 750 660 750 690
Box 350 690 800 85 '两个条件都成立（AND）？'
$g.DrawLine($p,750,775,750,800)
$g.DrawLine($p,370,800,1130,800)
Arrow 370 800 370 825
Arrow 1130 800 1130 825
Box 60 825 620 75 '是：加入结果列表，继续下一条'
Box 820 825 620 75 '否：跳过当前任务，继续下一条'
$g.DrawString('遍历结束返回结果：HTTP 200 + JSON 数组；无匹配返回 []',$f,[System.Drawing.Brushes]::Black,[System.Drawing.RectangleF]::new(20,920,1460,50),$fmt)
$g.DrawString('查询不修改原任务；contains 区分大小写；strip 返回处理后的字符串',$f,[System.Drawing.Brushes]::DimGray,[System.Drawing.RectangleF]::new(20,975,1460,50),$fmt)
$bmp.Save((Join-Path $PSScriptRoot '任务标题关键词与组合筛选流程图.png'),[System.Drawing.Imaging.ImageFormat]::Png)
$g.Dispose()
$bmp.Dispose()
$f.Dispose()
$tf.Dispose()
$p.Dispose()
$b.Dispose()
$fmt.Dispose()



