Add-Type -AssemblyName System.Drawing
$bitmap = [System.Drawing.Bitmap]::new(1500,1400)
$g = [System.Drawing.Graphics]::FromImage($bitmap)
$g.Clear([System.Drawing.ColorTranslator]::FromHtml('#f3f6fc'))
$g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit
$ink = [System.Drawing.SolidBrush]::new([System.Drawing.ColorTranslator]::FromHtml('#20334d'))
function Write-Label($x,$y,$value,$size=26) {
    $f=[System.Drawing.Font]::new('Microsoft YaHei',$size,[System.Drawing.FontStyle]::Regular,[System.Drawing.GraphicsUnit]::Pixel)
    $g.DrawString($value,$f,$ink,[single]$x,[single]$y)
    $f.Dispose()
}
function Draw-Box($y,$title,$detail) {
    $g.FillRectangle([System.Drawing.Brushes]::White,60,$y,1380,125)
    $g.DrawRectangle([System.Drawing.Pens]::SteelBlue,60,$y,1380,125)
    Write-Label 85 ($y+15) $title 32
    Write-Label 85 ($y+70) $detail 27
}
function Draw-Arrow($y) {
    $pen=[System.Drawing.Pen]::new([System.Drawing.Color]::SteelBlue,4)
    $pen.EndCap=[System.Drawing.Drawing2D.LineCap]::ArrowAnchor
    $g.DrawLine($pen,750,$y,750,($y+35))
    $pen.Dispose()
}
Write-Label 60 35 '批量删除与 foreach：从集合到一条 SQL' 44
Write-Label 60 100 '教学示意｜用于解释调用与参数绑定，不是实际运行验证' 27
Draw-Box 165 '① Postman → Controller：接收编号列表' 'POST /database/tasks/batch-delete    JSON：{"ids":[11,12,13]}'
Draw-Arrow 290
Draw-Box 325 '② Service：先完整校验，失败返回400且不执行删除' '列表非空、最多100项、每项为正整数；全部通过才进入下一步'
Draw-Arrow 450
Draw-Box 485 '③ Repository → Mapper：传递集合' 'deleteByIds(@Param("ids") List<Integer> ids)'
Draw-Arrow 610
Draw-Box 645 '④ XML：foreach 为每个元素生成参数占位符' 'collection="ids" 引用集合；item="id" 命名元素；#{id} 绑定当前值'
Draw-Arrow 770
Draw-Box 805 '⑤ 数据库：执行一条 DELETE' 'DELETE FROM task WHERE id IN (?, ?, ?)    参数依次为11、12、13'
Draw-Arrow 930
Draw-Box 965 '⑥ 影响行数原路返回 → HTTP 200，正文为实际删除数' '重复编号只影响同一行一次；不存在编号不会增加删除数'
Write-Label 70 1140 'open="("、separator=","、close=")"：组织括号和元素间逗号。' 30
Write-Label 70 1200 '重点：foreach 循环生成 SQL 片段，本例只执行一条删除语句。' 30
Write-Label 70 1260 '空列表应先拒绝；不能通过省略整个 WHERE 来兼容空列表。' 30
Write-Label 70 1320 '编号是讲解示例；100项是本课接口约定，并非 MyBatis 语法限制。' 26
$bitmap.Save((Join-Path $PSScriptRoot '批量删除与foreach流程图.png'),[System.Drawing.Imaging.ImageFormat]::Png)
$g.Dispose()
$bitmap.Dispose()
$ink.Dispose()
