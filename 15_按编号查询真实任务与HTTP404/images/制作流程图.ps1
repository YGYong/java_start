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
$g.DrawString('按编号查询真实任务与 HTTP 404',$tf,[System.Drawing.Brushes]::Black,[System.Drawing.RectangleF]::new(20,15,1460,65),$fmt)
$g.DrawString('教学示意：解释当前代码，不是实际运行验证',$f,[System.Drawing.Brushes]::DimGray,[System.Drawing.RectangleF]::new(20,80,1460,45),$fmt)
Box 350 145 800 85 'Postman 发送 GET /tasks/{id}'
Arrow 750 230 750 265
Box 350 265 800 95 "Controller 接收路径编号 taskId`n调用 Service.getTaskById(taskId)"
Arrow 750 360 750 395
Box 350 395 800 95 "Service 依次遍历 tasks`n比较 task.getId() == taskId"
$g.DrawLine($p,750,490,750,525)
$g.DrawLine($p,370,525,1130,525)
Arrow 370 525 370 565
Arrow 1130 525 1130 565
Box 60 565 620 105 "发现编号匹配的任务`n立即 return task，结束整个方法"
Box 820 565 620 105 "遍历结束仍未找到`n抛出 TaskNotFoundException"
Arrow 370 670 370 715
Arrow 1130 670 1130 715
Box 60 715 620 115 "返回已保存任务的真实内容`nSpring 转为 JSON，响应 HTTP 200"
Box 820 715 620 115 "Spring 调用对应异常处理方法`n读取 ex.getMessage()，创建错误对象"
Arrow 1130 830 1130 870
Box 820 870 620 105 "status(HttpStatus.NOT_FOUND) 设置404`nbody(errorResponse) 设置错误正文"
$g.DrawString('观察重点：编号不等于下标；错误文字不决定状态码；查询不修改任务数量',$f,[System.Drawing.Brushes]::DimGray,[System.Drawing.RectangleF]::new(20,995,1460,45),$fmt)
$bmp.Save((Join-Path $PSScriptRoot '按编号查询与404流程图.png'),[System.Drawing.Imaging.ImageFormat]::Png)
$g.Dispose()
$bmp.Dispose()
$f.Dispose()
$tf.Dispose()
$p.Dispose()
$b.Dispose()
$fmt.Dispose()
