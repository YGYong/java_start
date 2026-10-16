from pathlib import Path
from PIL import Image, ImageDraw, ImageFont

ROOT = Path(__file__).parent
FONT = 'C:/Windows/Fonts/msyh.ttc'
def font(size): return ImageFont.truetype(FONT, size)
def text(draw, xy, value, size=25, color='#263449'):
    draw.text(xy, value, font=font(size), fill=color)
def box(draw, rect, title, lines, color):
    draw.rounded_rectangle(rect, radius=18, fill='white', outline=color, width=3)
    x,y,_,_ = rect
    text(draw, (x+24,y+18), title, 29, color)
    for i,line in enumerate(lines): text(draw, (x+24,y+66+i*39), line, 23)

im = Image.new('RGB', (1640,1060), '#f5f7fb'); d=ImageDraw.Draw(im)
text(d,(65,35),'第二节 · 变量与方法知识导图',40)
text(d,(65,95),'助手制作的概念示意图｜用于回顾本节知识，不代表实际运行结果',22,'#667085')
branches = [
 ((565,160,1565,305),'变量与类型',['int：整数数量    String：文本    boolean：true / false','局部变量先赋值再使用；不能存入不兼容类型的值'],'#3874cb'),
 ((565,330,1565,475),'表达式与赋值',['= 是赋值；== 判断相等；> 判断是否大于','变量保存当次计算结果，重新赋值才会更新，不会自动联动'],'#15977c'),
 ((565,500,1565,645),'方法与参数',['方法定义在类里，与 main 并列；调用才执行方法体','参数按位置接收值；main 局部变量与方法参数各自独立'],'#8b59c5'),
 ((565,670,1565,815),'返回值与输出',['return：结束当前方法，把结果交回调用处','println：显示内容；void：不提供结果值'],'#c47a20'),
 ((565,840,1565,985),'本节实践',['calculateRemainingTasks：返回 int 差值','isAllCompleted：返回 remainingTasks == 0 的 boolean 结果'],'#cb5966')]
for rect,title,lines,color in branches:
    mid=(rect[1]+rect[3])//2
    d.line([(440,570),(505,570),(505,mid),(565,mid)],fill=color,width=4)
    box(d,rect,title,lines,color)
d.rounded_rectangle((65,495,440,645),radius=25,fill='#263449')
text(d,(100,520),'变量与方法',38,'white')
text(d,(100,580),'给数据命名，把操作封装',23,'white')
im.save(ROOT/'知识导图_变量与方法.png')

im=Image.new('RGB',(1600,1040),'#f5f7fb'); d=ImageDraw.Draw(im)
text(d,(65,35),'一次方法调用：值如何传入，又如何返回',38)
text(d,(65,95),'助手制作的流程示意图｜以 calculateRemainingTasks(8, 3) 为例',23,'#667085')
box(d,(65,170,1535,315),'① main 发起调用',['int remainingTasks = calculateRemainingTasks(8, 3);'],'#3874cb')
box(d,(65,370,1535,535),'② 进入计算方法：按位置接收值',['第一个值 8 → 参数 totalTasks；第二个值 3 → 参数 completedTasks','参数是本次方法调用中的变量，名字不与调用处自动匹配'],'#8b59c5')
box(d,(65,590,1535,735),'③ 执行 return，结束计算方法',['return totalTasks - completedTasks;    →    8 - 3 = 5'],'#15977c')
box(d,(65,790,1535,935),'④ 回到 main，保存结果并继续执行',['remainingTasks 接收到返回值 5；随后才执行 main 的下一条语句'],'#c47a20')
for y in (315,535,735):
    d.line([(800,y+5),(800,y+43)], fill='#64748b', width=4)
    d.polygon([(790,y+35),(810,y+35),(800,y+49)],fill='#64748b')
text(d,(65,976),'记住：return 返回结果；println 显示结果。计算方法返回后，main 仍会继续。',24)
im.save(ROOT/'流程图_方法调用与返回.png')
