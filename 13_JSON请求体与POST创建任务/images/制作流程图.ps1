Add-Type -AssemblyName System.Drawing
$bitmap = [System.Drawing.Bitmap]::new(1400, 1230)
$graphics = [System.Drawing.Graphics]::FromImage($bitmap)
$graphics.Clear([System.Drawing.Color]::White)
$graphics.SmoothingMode = 'AntiAlias'
$font = [System.Drawing.Font]::new('Microsoft YaHei', 20)
$titleFont = [System.Drawing.Font]::new('Microsoft YaHei', 28, [System.Drawing.FontStyle]::Bold)
$smallFont = [System.Drawing.Font]::new('Microsoft YaHei', 17)
$pen = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(52, 95, 150), 3)
$fill = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(237, 244, 252))
$format = [System.Drawing.StringFormat]::new()
$format.Alignment = 'Center'
$format.LineAlignment = 'Center'
$graphics.DrawString('POST 创建任务：请求与内存保存流程', $titleFont, [System.Drawing.Brushes]::Black, [System.Drawing.RectangleF]::new(30, 20, 1340, 65), $format)
$graphics.DrawString('教学示意：用于解释代码，不是实际运行验证', $smallFont, [System.Drawing.Brushes]::DimGray, [System.Drawing.RectangleF]::new(30, 85, 1340, 45), $format)
$labels = @(
('Postman：POST /tasks' + "`n" + 'Content-Type: application/json；请求体包含 title'),
('Spring 读取 JSON 请求体' + "`n" + '@RequestBody → CreateTaskRequest 对象'),
('Controller 读取 request.getTitle()' + "`n" + '调用 taskService.createTask(title)'),
('Service 创建 TaskResponse' + "`n" + '使用当前编号；nextId 加 1；completed 为 false'),
('Service 执行 tasks.add(newTask)' + "`n" + '对象保存在当前 Service 的内存列表中'),
('返回 TaskResponse → 转换为 JSON 响应' + "`n" + 'Postman 查看编号、标题、完成状态')
)
for ($index = 0; $index -lt $labels.Count; $index++) {
    $top = 155 + $index * 145
    $rect = [System.Drawing.Rectangle]::new(140, $top, 1120, 105)
    $graphics.FillRectangle($fill, $rect)
    $graphics.DrawRectangle($pen, $rect)
    $graphics.DrawString($labels[$index], $font, [System.Drawing.Brushes]::Black, [System.Drawing.RectangleF]::new(150, $top, 1100, 105), $format)
    if ($index -lt $labels.Count - 1) {
        $graphics.DrawLine($pen, 700, $top + 108, 700, $top + 138)
        $graphics.DrawLine($pen, 700, $top + 138, 691, $top + 128)
        $graphics.DrawLine($pen, 700, $top + 138, 709, $top + 128)
    }
}
$graphics.DrawString('GET /tasks/count → tasks.size()：读取同一列表的数量', $font, [System.Drawing.Brushes]::Black, [System.Drawing.RectangleF]::new(30, 1040, 1340, 55), $format)
$graphics.DrawString('当前边界：未校验标题；重启清空数据；GET /tasks/{id} 仍为演示响应', $smallFont, [System.Drawing.Brushes]::DimGray, [System.Drawing.RectangleF]::new(30, 1110, 1340, 60), $format)
$bitmap.Save((Join-Path $PSScriptRoot 'POST创建任务流程图.png'), [System.Drawing.Imaging.ImageFormat]::Png)
$graphics.Dispose()
$bitmap.Dispose()
$font.Dispose()
$titleFont.Dispose()
$smallFont.Dispose()
$pen.Dispose()
$fill.Dispose()
$format.Dispose()
