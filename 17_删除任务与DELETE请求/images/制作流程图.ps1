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
$g.DrawString('删除任务与 DELETE 请求',$tf,[System.Drawing.Brushes]::Black,[System.Drawing.RectangleF]::new(20,15,1460,65),$fmt)
$g.DrawString('教学示意：解释执行路径，不是实际运行验证',$f,[System.Drawing.Brushes]::DimGray,[System.Drawing.RectangleF]::new(20,80,1460,45),$fmt)
Box 350 140 800 85 'Postman：DELETE /tasks/{id}，无请求体'
Arrow 750 225 750 255
Box 350 255 800 85 'Controller 取得路径编号，调用 Service.deleteTask'
Arrow 750 340 750 370
Box 350 370 800 85 'Service 复用 getTaskById，按任务编号查找'
$g.DrawLine($p,750,455,750,485)
$g.DrawLine($p,370,485,1130,485)
Arrow 370 485 370 520
Arrow 1130 485 1130 520
Box 60 520 620 100 "找到任务：取得列表中的对象`n执行 tasks.remove(task)"
Box 820 520 620 100 "未找到任务`n抛出 TaskNotFoundException"
Arrow 370 620 370 660
Arrow 1130 620 1130 660
Box 60 660 620 100 "Service 正常结束，Controller 正常结束`n@ResponseStatus 指定 HTTP 204，无正文"
Box 820 660 620 100 "已有异常处理器接管`nHTTP 404，返回错误正文；不执行删除"
Box 60 810 620 110 "删除后：数量减一，其余任务编号不变`nnextId 不变，新建任务继续使用新编号"
Box 820 810 620 110 "重复删除：仍走未找到分支，返回 404`n数据最终仍是任务不存在，符合幂等性"
$g.DrawString('注意：remove(int) 按索引删除；remove(task) 删除指定对象',$f,[System.Drawing.Brushes]::DimGray,[System.Drawing.RectangleF]::new(20,960,1460,65),$fmt)
$bmp.Save((Join-Path $PSScriptRoot '删除任务与DELETE流程图.png'),[System.Drawing.Imaging.ImageFormat]::Png)
$g.Dispose()
$bmp.Dispose()
$f.Dispose()
$tf.Dispose()
$p.Dispose()
$b.Dispose()
$fmt.Dispose()

