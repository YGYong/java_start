Add-Type -AssemblyName System.Drawing
$bmp = [System.Drawing.Bitmap]::new(1500, 1040)
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
$g.DrawString('创建参数校验与 HTTP 错误响应',$tf,[System.Drawing.Brushes]::Black,[System.Drawing.RectangleF]::new(20,15,1460,65),$fmt)
$g.DrawString('教学示意：用于解释代码，不是实际运行验证',$f,[System.Drawing.Brushes]::DimGray,[System.Drawing.RectangleF]::new(20,80,1460,45),$fmt)
Box 350 145 800 80 'Postman 发送 POST /tasks 与 JSON 请求体'
Arrow 750 225 750 255
Box 350 255 800 85 'Spring 绑定请求 DTO → Controller 调用 Service'
Arrow 750 340 750 375
Box 350 375 800 95 "Service 校验标题：title == null || title.isBlank()`n先判断 null，短路避免空引用调用"
$g.DrawLine($p,750,470,750,505)
$g.DrawLine($p,370,505,1130,505)
Arrow 370 505 370 555
Arrow 1130 505 1130 555
Box 60 555 620 110 "标题合法`n生成编号 → 创建对象 → 加入列表"
Box 820 555 620 110 "标题非法：抛出 IllegalArgumentException`n方法中断，不执行编号自增和保存"
Arrow 370 665 370 715
Arrow 1130 665 1130 715
Box 60 715 620 115 "返回 TaskResponse`nSpring 转成 JSON，当前成功响应为 200"
Box 820 715 620 115 "Spring 调用匹配的异常处理方法`n提取 ex.getMessage()，创建 ErrorResponse"
Arrow 1130 830 1130 865
Box 820 865 620 110 "badRequest() 指定 HTTP 400`nbody(...) 设置正文，再转换为 JSON"
$g.DrawString('观察重点：HTTP 状态码与 JSON 正文是不同部分；非法请求不能改变任务数量或编号',$f,[System.Drawing.Brushes]::DimGray,[System.Drawing.RectangleF]::new(25,985,1450,45),$fmt)
$bmp.Save((Join-Path $PSScriptRoot '参数校验与错误响应流程图.png'),[System.Drawing.Imaging.ImageFormat]::Png)
$g.Dispose()
$bmp.Dispose()
$f.Dispose()
$tf.Dispose()
$p.Dispose()
$b.Dispose()
$fmt.Dispose()
