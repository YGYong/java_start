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
$g.DrawString('修改任务完成状态与 PATCH 请求',$tf,[System.Drawing.Brushes]::Black,[System.Drawing.RectangleF]::new(20,15,1460,65),$fmt)
$g.DrawString('教学示意：解释代码执行顺序，不是实际运行验证',$f,[System.Drawing.Brushes]::DimGray,[System.Drawing.RectangleF]::new(20,80,1460,45),$fmt)
Box 350 140 800 85 'Postman：PATCH /tasks/{id}/completed'
Arrow 750 225 750 250
Box 350 250 800 95 "Controller 接收编号与 JSON 请求体`n请求 DTO 使用 Boolean：true / false / null"
Arrow 750 345 750 370
Box 350 370 800 85 'Service 首先判断 completed 是否为 null'
$g.DrawLine($p,750,455,750,480)
$g.DrawLine($p,370,480,1130,480)
Arrow 370 480 370 510
Arrow 1130 480 1130 510
Box 60 510 620 95 "状态缺失或为 null`n抛出 IllegalArgumentException → HTTP 400"
Box 820 510 620 95 "状态为 true 或 false（均合法）`n复用 getTaskById 查询原任务"
Arrow 1130 605 1130 635
Box 820 635 620 95 "编号不存在：抛出 TaskNotFoundException`n已有异常处理 → HTTP 404"
Box 60 635 620 95 "编号存在：取得列表中的原对象`nsetCompleted(completed) 设置状态"
$g.DrawLine($p,820,610,370,610)
Arrow 370 610 370 635
Arrow 370 730 370 760
Box 60 760 620 110 "返回原任务 → JSON → HTTP 200`n列表中同一对象的状态同步改变`n无需再次 add，不生成新编号"
Box 820 760 620 110 "注意：设置状态不是切换状态`n连续两次设置 true，结果仍为 true`n先完成空值校验，再进行自动拆箱"
$g.DrawString('观察重点：先校验后查询；false 合法；修改原对象；重启会清空内存数据',$f,[System.Drawing.Brushes]::DimGray,[System.Drawing.RectangleF]::new(20,960,1460,65),$fmt)
$bmp.Save((Join-Path $PSScriptRoot '修改完成状态与PATCH流程图.png'),[System.Drawing.Imaging.ImageFormat]::Png)
$g.Dispose()
$bmp.Dispose()
$f.Dispose()
$tf.Dispose()
$p.Dispose()
$b.Dispose()
$fmt.Dispose()

