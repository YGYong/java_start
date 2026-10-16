from pathlib import Path
from PIL import Image, ImageDraw, ImageFont
root = Path(__file__).parent
im = Image.new('RGB', (1500, 1000), '#f5f7fb')
d = ImageDraw.Draw(im)
def text(x, y, value, size=27, color='#263449'):
    d.text((x, y), value, font=ImageFont.truetype('C:/Windows/Fonts/msyh.ttc', size), fill=color)
text(55, 30, '第七节 · 异常与任务输入校验', 40)
text(55, 95, '助手制作的知识与流程示意图｜不是实际运行或调试截图', 24)
items = [
 ('校验职责：Task', '先判断 title == null || title.isBlank()，再保存 title', '非法：throw new IllegalArgumentException(...)；合法：完成初始化'),
 ('失败路径', 'new Task(空标题) → 构造方法抛出异常 → main 的 catch', '创建失败，所以 add 不执行；跳过 try 内剩余语句'),
 ('处理职责：main', 'catch 捕获异常对象 e → 使用 e.getMessage() 说明原因', 'catch 正常结束 → 执行整个 try/catch 后面的语句'),
 ('本次列表流程', '先添加合法任务：1 条 → 非法添加失败：仍为 1 条', '在 try/catch 后再添加合法任务 → 最终 2 条'),
 ('关键边界', '若下一次添加放在 try 内、失败语句之后，会被跳过', '构造方法自己捕获后继续赋值，会让非法标题仍进入对象')
]
for i, (title, a, b) in enumerate(items):
    y = 155 + i * 160
    d.rounded_rectangle((55, y, 1445, y + 140), radius=18, fill='white', outline='#3874cb', width=3)
    text(80, y + 12, title, 30, '#3874cb')
    text(80, y + 57, a)
    text(80, y + 96, b, 25)
im.save(root / '知识与流程图_异常与任务输入校验.png')
