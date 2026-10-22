Add-Type -AssemblyName System.Drawing
$bmp = [System.Drawing.Bitmap]::new(1600, 1470)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.Clear([System.Drawing.Color]::White)
$g.SmoothingMode = 'AntiAlias'
$font = [System.Drawing.Font]::new('Microsoft YaHei', 20)
$titleFont = [System.Drawing.Font]::new('Microsoft YaHei', 29, [System.Drawing.FontStyle]::Bold)
$pen = [System.Drawing.Pen]::new([System.Drawing.Color]::SteelBlue, 3)
$brush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::AliceBlue)
$format = [System.Drawing.StringFormat]::new()
$format.Alignment = 'Center'
$format.LineAlignment = 'Center'
function Box($x, $y, $w, $h, $label) {
    $rect = [System.Drawing.Rectangle]::new($x, $y, $w, $h)
    $g.FillRectangle($brush, $rect)
    $g.DrawRectangle($pen, $rect)
    $g.DrawString($label, $font, [System.Drawing.Brushes]::Black, [System.Drawing.RectangleF]::new($x+10, $y+5, $w-20, $h-10), $format)
}
function Arrow($x1, $y1, $x2, $y2) {
    $arrowPen = [System.Drawing.Pen]::new([System.Drawing.Color]::SteelBlue, 3)
    $arrowPen.CustomEndCap = [System.Drawing.Drawing2D.AdjustableArrowCap]::new(5, 6)
    $g.DrawLine($arrowPen, $x1, $y1, $x2, $y2)
    $arrowPen.Dispose()
}
$g.DrawString('Repository 分层与内存数据访问', $titleFont, [System.Drawing.Brushes]::Black, [System.Drawing.RectangleF]::new(20, 15, 1560, 65), $format)
$g.DrawString('教学示意：不是实际运行或断点验证', $font, [System.Drawing.Brushes]::DimGray, [System.Drawing.RectangleF]::new(20, 85, 1560, 50), $format)
Box 100 155 1400 100 'Controller 接收 HTTP 请求，通过 TaskService 接口调用业务'
Arrow 800 255 800 295
Box 100 295 1400 130 "Service：校验标题、完成状态和分页参数，决定业务异常`n通过构造器接收 TaskRepository；不再保存 tasks、nextId"
Arrow 800 425 800 465
Box 100 465 1400 130 "TaskRepository 约定数据访问能力`ncount / findAll / findById / insert / updateCompleted / deleteById"
Arrow 800 595 800 635
Box 100 635 1400 130 "InMemoryTaskRepository：@Repository，由 Spring 管理`n唯一保存 tasks 与 nextId；生成编号、查找、新增、修改、删除"
Arrow 800 765 800 805
Box 100 805 1400 85 '以按编号查询为例：Repository 查找任务，返回结果给 Service'
Arrow 800 890 410 945
Arrow 800 890 1190 945
Box 100 945 620 130 "找到：返回任务对象`nService → Controller → 正常响应"
Box 880 945 620 130 "未找到：返回 null`nService 抛 TaskNotFoundException"
Arrow 1190 1075 1190 1115
Box 880 1115 620 110 "GlobalExceptionHandler`n将异常转换为 HTTP 404"
Box 100 1115 620 110 "删除未找到返回 false`n更新未找到返回 null"
Box 100 1280 1400 135 "findAll：新列表容器，元素对象仍共享引用`nclear 只清空返回列表；修改元素状态会影响当前内存对象`n当前仍是内存存储：应用重启后数据与编号重新初始化"
$bmp.Save((Join-Path $PSScriptRoot 'Repository分层与内存数据访问流程图.png'), [System.Drawing.Imaging.ImageFormat]::Png)
$g.Dispose()
$bmp.Dispose()
$font.Dispose()
$titleFont.Dispose()
$pen.Dispose()
$brush.Dispose()
$format.Dispose()
