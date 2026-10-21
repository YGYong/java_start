Add-Type -AssemblyName System.Drawing
$bmp = [System.Drawing.Bitmap]::new(1500, 1540)
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
function Arrow($x1,$y1,$x2,$y2) {
 $g.DrawLine($p,$x1,$y1,$x2,$y2)
 $g.DrawLine($p,$x2,$y2,$x2-8,$y2-12)
 $g.DrawLine($p,$x2,$y2,$x2+8,$y2-12)
}
$g.DrawString('任务列表分页与参数校验',$tf,[System.Drawing.Brushes]::Black,[System.Drawing.RectangleF]::new(20,15,1460,65),$fmt)
$g.DrawString('教学示意：不是实际运行或断点验证',$f,[System.Drawing.Brushes]::DimGray,[System.Drawing.RectangleF]::new(20,85,1460,50),$fmt)
Box 250 155 1000 90 'GET /tasks → 查询 DTO → Controller → Service'
Arrow 750 245 750 275
Box 250 275 1000 100 "校验：page 非空且 ≥ 1；size 非空且为 1～100`n先判 null，再做数值比较"
Box 30 400 430 100 "不合法 → 抛出异常`n全局处理 → HTTP 400"
$g.DrawLine($p,250,325,170,325)
Arrow 170 325 170 400
Arrow 750 375 750 420
Box 500 420 900 110 "合法 → 先按状态和标题组合筛选（AND）`n得到 filteredTasks，保持原列表不变"
Arrow 950 530 950 565
Box 500 565 900 100 "计算跳过条数 offset`n(long) (page - 1) * size"
Arrow 950 665 950 700
Box 500 700 900 95 'offset ≥ 筛选结果条数？'
Box 30 825 430 100 "是 → 返回空数组 []`n空结果或页码超出范围"
$g.DrawLine($p,500,747,245,747)
Arrow 245 747 245 825
Arrow 950 795 950 835
Box 500 835 900 115 "否 → start = (int) offset`nend = (int) min(offset + size, 结果条数)"
Arrow 950 950 950 990
Box 500 990 900 110 "截取 [start, end)，左闭右开`nnew ArrayList<>(filteredTasks.subList(start, end))"
Arrow 950 1100 950 1140
Box 500 1140 900 85 '返回 HTTP 200：当前页任务数组'
Box 100 1280 1300 170 "示例：筛选后共 5 条，page=3，size=2`n跳过 4 条 → start=4，end=5 → 返回最后 1 条`n页码超出范围是合法查询；非法参数才返回 400"
$bmp.Save((Join-Path $PSScriptRoot '任务列表分页与参数校验流程图.png'), [System.Drawing.Imaging.ImageFormat]::Png)
$g.Dispose(); $bmp.Dispose(); $f.Dispose(); $tf.Dispose(); $p.Dispose(); $b.Dispose(); $fmt.Dispose()
