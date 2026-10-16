from pathlib import Path
from PIL import Image, ImageDraw, ImageFont

root = Path(__file__).parent
im = Image.new('RGB', (1500, 1000), '#f5f7fb')
d = ImageDraw.Draw(im)
def text(x, y, value, size=27, color='#263449'):
    d.text((x,y), value, font=ImageFont.truetype('C:/Windows/Fonts/msyh.ttc',size),fill=color)
text(55,30,'第五节 · 构造方法与封装',40)
text(55,95,'助手制作的概念与流程示意图｜不是实际调试截图',24)
items = [
 ('创建与初始化', 'new Task("学习构造方法") → 字段初始化 → 执行构造方法体', '本例：complete = false；随后 this.title = title'),
 ('构造方法与 this', '构造方法名与类名相同，没有返回类型，也不写 void', 'this.title 是当前对象字段；右侧 title 是传入参数'),
 ('读取状态', 'Main → getTitle() / isCompleted() → 返回私有字段的值', 'private 阻止外部直接访问；Task 内部仍可访问字段'),
 ('修改状态', 'Main → markCompleted() → this.complete = true', 'public 方法决定外部可执行的操作，不必为每个字段提供 setter'),
 ('封装边界', '公开 setCompleted(value) 会允许外部任意切换状态', '设计公开方法时，要考虑对象允许哪些行为')]
for i,(title,a,b) in enumerate(items):
    y = 155+i*160
    d.rounded_rectangle((55,y,1445,y+140),radius=18,fill='white',outline='#3874cb',width=3)
    text(80,y+12,title,30,'#3874cb')
    text(80,y+57,a)
    text(80,y+96,b,25)
im.save(root/'知识与流程图_构造方法与封装.png')
