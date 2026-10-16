from pathlib import Path
from PIL import Image, ImageDraw, ImageFont

root = Path(__file__).parent
im = Image.new('RGB', (1500, 1000), '#f5f7fb')
d = ImageDraw.Draw(im)
def text(x, y, value, size=27, color='#263449'):
    d.text((x, y), value, font=ImageFont.truetype('C:/Windows/Fonts/msyh.ttc', size), fill=color)
text(55, 30, '第六节 · 集合与任务列表', 40)
text(55, 95, '助手制作的知识与流程示意图｜不是实际调试截图', 24)
items = [
    ('列表与类型', 'ArrayList<Task>：用于保存 Task 的可变长度列表', 'add 添加；size 获取数量；get 按索引读取，索引从 0 开始'),
    ('对象引用', '列表元素 → Task 对象 ← 当前循环变量 task', '两处引用指向同一对象；调用行为方法会改变该对象状态'),
    ('遍历流程', '初始化计数为 0 → 依次取出任务 → 判断是否未完成', '未完成：计数加一；已完成：保持计数；继续下一条'),
    ('本次调试观察', '标题1：0 → 1    标题2：1 → 1    标题3：1 → 2', '循环结束后输出 2；调试结果由学习者文字确认'),
    ('空列表', '没有元素 → 循环体执行 0 次 → 计数保持初始值 0', '空列表不能 get(1)；该操作会因索引越界抛出异常')
]
for i, (title, a, b) in enumerate(items):
    y = 155 + i * 160
    d.rounded_rectangle((55, y, 1445, y + 140), radius=18, fill='white', outline='#3874cb', width=3)
    text(80, y + 12, title, 30, '#3874cb')
    text(80, y + 57, a)
    text(80, y + 96, b, 25)
im.save(root / '知识与流程图_集合与任务列表.png')
