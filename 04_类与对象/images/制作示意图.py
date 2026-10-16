from pathlib import Path
from PIL import Image, ImageDraw, ImageFont

ROOT = Path(__file__).parent
def text(d, xy, value, size=26, color='#263449'):
    d.text(xy, value, font=ImageFont.truetype('C:/Windows/Fonts/msyh.ttc', size), fill=color)
def box(d, rect, title, lines, color='#3874cb'):
    d.rounded_rectangle(rect, radius=20, fill='white', outline=color, width=3)
    x, y, _, _ = rect
    text(d, (x+24,y+18), title, 30, color)
    for i, line in enumerate(lines): text(d,(x+24,y+68+i*38),line,24)
def canvas(title, subtitle, height=1060):
    im=Image.new('RGB',(1640,height),'#f5f7fb'); d=ImageDraw.Draw(im)
    text(d,(60,30),title,40)
    text(d,(60,95),subtitle,22,'#667085')
    return im,d

im,d=canvas('第四节 · 类与对象知识导图','助手制作的概念示意图｜用于知识回顾，不是实际操作截图')
items=[
    ('类与对象',['Task 类：定义任务有哪些属性和行为','new Task()：创建一条具体任务对象'],'#3874cb'),
    ('实例字段',['title 保存标题，complete 保存完成状态','不同对象各自保存自己的实例字段'],'#15977c'),
    ('实例方法与 this',['markCompleted() 改变当前任务状态','this 指向调用该实例方法的对象'],'#8b59c5'),
    ('static 与实例成员',['实例方法通过对象调用，能够访问 this','static 方法属于类，没有当前实例 this'],'#c47a20'),
    ('对象引用',['Task alias = task1：复制引用，不复制对象','两个变量指向同一对象时，都能看到它的状态变化'],'#cb5966')]
for i,(title,lines,color) in enumerate(items):
    y=160+i*170
    d.line([(420,570),(490,570),(490,y+72),(550,y+72)],fill=color,width=4)
    box(d,(550,y,1580,y+145),title,lines,color)
d.rounded_rectangle((60,500,420,640),radius=22,fill='#263449')
text(d,(95,525),'类与对象',38,'white'); text(d,(95,586),'组织数据与行为',25,'white')
im.save(ROOT/'知识导图_类与对象.png')

im,d=canvas('引用关系 · 两个变量不一定代表两个对象','助手制作的结构示意图｜箭头表示引用关系，不表示内存地址',1000)
box(d,(60,155,1580,300),'① 两次 new：两个独立对象',[
    'Task task1 = new Task();        Task task2 = new Task();',
    'task1 → 对象 A（complete = false）    task2 → 对象 B（complete = true）'])
box(d,(60,345,1580,490),'② 引用赋值：两个变量指向同一对象',[
    'Task alias = task1;',
    'task1 → 对象 A ← alias    赋值后仍然只有一个对象 A'],'#8b59c5')
box(d,(60,535,1580,680),'③ 通过 alias 调用实例方法',[
    'alias.markCompleted(); → this 指向对象 A → this.complete = true;',
    '再读取 task1.complete，得到同一个对象 A 的最新状态 true'],'#15977c')
box(d,(60,725,1580,870),'④ 调试时观察',[
    '调用前：task1 和 alias 的对象标识相同，complete 为 false',
    '进入方法：this 指向该对象；执行赋值后，complete 变为 true'],'#c47a20')
text(d,(60,918),'核心：变量保存引用；字段属于对象；引用赋值不会复制整个对象。',28)
im.save(ROOT/'结构图_对象引用与实例调用.png')
