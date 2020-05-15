# Python数据可视化

## 1.生成数据
Numpy是Python的一个科学计算的库，在学习数据可视化时，我们可以用Numpy库来生成数据。
```Python
numpy.linspace(start, stop, num=50, endpoint=True, retstep=False, dtype=None)
```
上面的方法可以在指定的间隔内返回均匀间隔的数字。
```Python
numpy.random.normal(loc=0.0, scale=1.0, size=None)
```
上面的方法用于生成正态分布的一组数据，参数为均值、标准差、数量。
```Python
numpy.random.randn()
```
上面的方法用于生成一组标准正态分布数据，参数为数量。


## 2.导入数据
### 2.1.导入标准CSV
CSV是以逗号分隔的值，其中还包含一个文件头，也是以逗号分隔的。
Python中可以用csv模块来读取CSV文件，例如：
```Python
import csv
filename = "ch02-data.csv"
data = []
try:
    with open(filename) as f:
        reader = csv.reader(f)
        header = next(reader)
        data = [row for row in reader]
        print(data)
except csv.Error as e:
    print("Error reading CSV file at line %s: %s" %(reader.line_num, e))
    exit(-1)

if header:
    print(header)
    print("=================")
for datarow in data:
    print(datarow)
```
除标准CSV文件外，还有一些方言CSV文件，也能用csv模块的读取，略。

### 2.2.导入Excel
使用xlrd模块，可以进行Excel文件的读写操作，我们不必为了操作Excel文件而下载Microsoft Excel。
读取Excel文件：
```Python
import xlrd

filename = 'ch02-xlsxdata.xlsx'
wb = xlrd.open_workbook(filename=filename)
ws = wb.sheet_by_name('Sheet1')
dataset = []
for r in range(ws.nrows):
    col = []
    for c in range(ws.ncols):
        col.append(ws.cell(r, c).value)
    dataset.append(col)

for line in dataset:
    print(line)
```

### 2.3.导入Json
Json是一种无关平台的格式，被广泛应用于数据交换。
Json格式在Python中对应的是字典和列表，因此处理JSON文件可以先打开文件用字典获取或列表，再用遍历的方式获取需要可视化的列表。
```Python
import requests

url = 'https://github.com/timeline.json'
r = requests.get(url)
json_obj = r.json()
## print(json_obj)
for key, value in json_obj.items():
    print(key, ':', value)
```
需要注意的是，JSON中的数据一般是字符串类型，字符串在绘图的时候不能自动比较大小，所以要先转换成数字或日期等类型。

### 2.4.从MySQL导入
[参考我的上一篇博客。](https://www.wangshaogang.com/2018/09/26/Python%E6%95%B0%E6%8D%AE%E9%87%87%E9%9B%86/#more)

## 3.导出数据
### 3.1.导出到Json
```Python
## 读csv
import csv
import json

data = {}
filename = 'ch02-data.csv'
with open(filename) as f:
    reader = csv.reader(f)
    for row in reader:
        data[row[0]] = row[1]

## 写json
filename2 = 'fileFor05.json'
with open(filename2, 'w') as f_obj:
    json.dump(data, f_obj)
```

### 3.2.导出到CSV
```Python
## 读json
import csv
import json

data = {}
filename = 'fileFor05.json'
with open(filename) as f:
    data = json.load(f)

## 写CSV方式1
filename2 = 'fileFor06.csv'
with open(filename2, 'w') as f:
    for key, value in data.items():
        line = key + ',' + value + '\n'
        f.write(line)

## 写CSV方式2
filename3 = 'fileFor06_2.csv'
csvFile = open(filename3, 'w', newline='')
try:
    writer = csv.writer(csvFile)
    for key, value in data.items():
        writer.writerow((key, value))
finally:
    csvFile.close()
```

## 4.基本图
### 4.1.折线图
plot(x, y)，第一个参数是横坐标列表，第二个参数是纵坐标列表。

### 4.2.垂直柱状体
bar(x, y)，第一个参数是横坐标列表，第二个参数是纵坐标列表。

### 4.3.水平柱状图
barh(x, y)，第一个参数是纵坐标列表，第二个参数是横坐标列表。

### 4.4.堆叠柱状图
bar(x, y1, bottom=y, color='r')，参数是横坐标列表、堆叠的纵坐标列表，可以设置参数bottom指定底部的柱状图，参数color可以指定堆叠柱状图的颜色。

### 4.5.箱线图
boxplot(x, vert=False)，参数是一个列表，vert=False用于指定箱线图横置（更常见）。
箱线图可以呈现五种数据：

	最小值：数据集合的最小值
	第二四分位数：其下为集合中较低的25%数据，例如[1, 2, 3, 4]中的1.75
	中值：数据集合的中值，例如[1, 2, 3, 4]中的2.5
	第三四分位数：其下为集合中较低的25%数据，例如[1, 2, 3, 4]中的3.25
	最大值：数据集合的最大值
	
### 4.6.散点图
scatter(x, y)，第一个参数是横坐标列表，第二个参数是纵坐标列表。

## 5.定制化
### 5.1.标题
设置标题文字使用方法plt.title()
```Python
## &&中是斜体
plt.title("Function $sin$ and $cos$")
```
这个方法还可以设置一些参数：
```Python
plt.title(title, color='brown', fontsize=18, verticalalignment='bottom')
```
第一个参数是标题的内容，fontsize指定标题字体大小，verticalalignment用来布置文本，值有'top', 'bottom', 'center', 'baseline'，设置成bottom离图表最远。

这个方法是有返回值的，返回的是标题对象，可用于对标题的后续操作。


还有另一种方式：
```Python
ax = plt.gca()
ax.set_title('This is title')
```

### 5.2.变量范围和坐标轴刻度
设置变量值的范围使用plt.xlim()和plt.ylim()，参数是作用端点值。
```Python
plt.xlim(-np.pi, np.pi)
plt.ylim(-1.0, 1.0)
```
设置横纵坐标轴使用plt.xticks()和plt.yticks()，参数是两个列表，第一个列表是原本的值，第二个列表是显示的值。
如果变量值范围和坐标轴范围不同，会按较大范围呈现。
```Python
# \pi表示希腊字母π
plt.xticks([-np.pi, -np.pi/2, 0, np.pi/2, np.pi],
           ['$-\pi$', '$-\pi/2$', '$0$', '$\pi/2$', '$\pi$'])
plt.yticks([-1, -0.5, 0, 0.5, 1], ['$-1$', '$-0.5$', '$0$', '$0.5$', '$1$'])
```

### 5.3.坐标轴刻度间隔
#### 5.3.1.方式一
使用ax = gca()获取当前坐标轴，再设置将坐标轴平分为几份：
```Python
ax.locator_params('x', nbins = 10)
ax.locator_params('y', nbins = 25)
```
#### 5.3.2.方式二
使用ax = gca()获取当前坐标轴，再设置坐标轴刻度间隔：
```Python
ax.xaxis.set_major_locator(matplotlib.ticker.MultipleLocator(6))
```


### 5.4.坐标轴标签
```Python
ax.set_xlabel('Values')
ax.set_ylabel('Frequency')
```

### 5.5.移动坐标轴
图表默认有四个轴，如果需要把坐标轴移到中间，需要进行三步：
```Python
## 隐藏上右两个轴
ax = plt.gca()
ax.spines['right'].set_color('none')
ax.spines['top'].set_color('none')
## 移动下左两个轴到中间
ax.spines['bottom'].set_position(('data', 0))
ax.spines['left'].set_position(('data', 0))
## 指定显示刻度的轴
ax.xaxis.set_ticks_position('bottom')
ax.yaxis.set_ticks_position('left')
```


### 5.6.线的属性
#### 5.6.1.线条宽度和颜色
可以对plot()方法指定linewidth和color参数，例如：
```Python
plt.plot(x, y, linewidth=5, color='green')
```
还有也有一些其他的方式，暂且只掌握这一种吧。
关于颜色，除了用单词外，还可以使用十六进制字符串，以及0到1表示RGB的三元组。
#### 5.6.2.plot()方法的参数
详见《Python数据裤长我编程实战》P78
alpha：透明度，0~1的浮点数
color或c	线条颜色，常用颜色可以缩写：

	b：蓝色	g：绿色	r：红色	y：黄色
	c：青色	k：黑色	w：白色	m：洋红色
linestyle或ls：线的风格，有：

	'-'：实线	'--'：破折线
	'-.'：点划线	':'：虚线
marker：设置线条标志，就是把一些字符画在线条上
markeredgecolor或mec：设置标记边的边缘颜色，有标记才有用

### 5.7.添加图例
为每个plot指定了标签，图例才有意义：
```Python
plt.plot(x1, label='plot')
plt.plot(x2, label='plot2')
plt.plot(x3, label='plot3')
```
添加标签后可用下面的代码生成图例：
```Python
plt.legend(bbox_to_anchor=(0, -0.15, 0.4, 0.02), loc='upper right', ncol=3, mode="expand", borderaxespad=0)
```
plt.legend()方法的参数都是可选的，即使不写也会自动调整。
bbox_to_anchor参数指定边框，值为一个四元组，四元组的前两个值为起始点的位置，后两个参数为宽度和高度。大于1或小于0的值表示在图表外面。
loc参数指定起始点是哪一个
ncol是一行最多显示的列数
mode参数课设置为None或expand，当为expand时，图例框会水平扩展至整个坐标轴区域
borderaxespad参数指定坐标轴和图例边界之间的间距

### 5.8.添加注解
注解就是指向图中的某个位置的文本。可以用下面的代码生成：
```Python
plt.annotate("Important value", (55, 20), xycoords='data', xytext=(5, 38), arrowprops=dict(arrowstyle='->'))
```
第一个参数是注解的内容，第二个参数是注解指向的位置
ycoords='data'指定注解和数据使用相同的坐标系
xytext参数指定注解显示的位置
arrowprops参数指定箭头属性


### 5.9.填充区域
核心代码：
```Python
plt.fill_between(x, y1, y2, facecolor='yellow', alpha=1, where=y1>=y2)
plt.fill_between(x, y1, y2, facecolor='green', alpha=1, where=y1<=y2)
```
where指定条件。

### 5.10.标题和标签生成阴影
首先要导入patheffects模块：
```Python
from matplotlib import patheffects
```

标题生成阴影，需要利用plt.title()方法返回的对象
```Python
title_text_obj = plt.title(title, fontsize=fontsize, verticalalignment='bottom')
title_text_obj.set_path_effects([patheffects.withSimplePatchShadow()])
```
可以给patheffects.withSimplePatchShadow()方法传参数设置阴影的属性，例如：
```Python
title_text_obj.set_path_effects([patheffects.withSimplePatchShadow(shadow_rgbFace='red')])
```

标签生成阴影，与标题是类似的：
```Python
xlabel_obj = plt.xlabel(x_label, fontsize=fontsize, alpha=0.5)
ylabel_obj = plt.ylabel(y_label, fontsize=fontsize, alpha=0.5)
xlabel_obj.set_path_effects([patheffects.withSimplePatchShadow(shadow_rgbFace='red')])
ylabel_obj.set_path_effects([patheffects.withSimplePatchShadow(shadow_rgbFace='red')])
```

### 5.11.添加数据表
```Python
col_labels = ['col1', 'col2', 'col3']
row_labels = ['row1', 'row2', 'row3']
table_vals = [[11, 12, 13], [21, 22, 23], [28, 29, 30]]
row_colors = ['red', 'gold', 'green']

my_table = plt.table(cellText=table_vals, colWidths=[0.1]*3, rowLabels=row_labels,
                     colLabels=col_labels, rowColours=row_colors, loc='upper right')
```

### 5.12.添加子区
```Python
axes1 = plt.subplot2grid((3,3), (0, 0), colspan=3)
axes2 = plt.subplot2grid((3,3), (1, 0), colspan=2)
axes3 = plt.subplot2grid((3,3), (1, 2), rowspan=2)
axes4 = plt.subplot2grid((3,3), (2, 0))
axes5 = plt.subplot2grid((3,3), (2, 1))
```

plt.subplot2grid()方法可以用colspan和rowspan参数来实现跨行和跨列，这一点与HTML5的table类似。

#### 5.12.1.设置总标题：
```Python
plt.subplots_adjust(wspace=1, hspace=1)
```

#### 5.12.2.设置小标题
```Python
axes1.set_title("This is title1")
axes2.set_title("This is title2")
axes3.set_title("This is title3")
axes4.set_title("This is title4")
axes5.set_title("This is title5")
```

#### 5.12.3.设置子区的间隔
```Python
plt.subplots_adjust(wspace=1, hspace=1)
```
这里的1以最小子区的长宽为基准。

#### 5.12.4.同时操作多个子区
```Python
all_axes = plt.gcf().axes
for ax in all_axes:
    for ticklabel in ax.get_xticklabels() + ax.get_yticklabels():
        ticklabel.set_fontsize(10)
```

### 5.13.定制化网格
添加网格只需一行代码：
```Python
plt.grid(True)
```
需要定制化，可以给此方法设置一些参数：
```Python
plt.grid(color='g', linestyle='-', alpha=0.3, linewidth=0.5)
```

### 5.14.刻度不均匀的坐标轴
#### 5.14.1.对数标度
```Python
set_yscale('log')
```
#### 5.14.2.线性标度
```Python
set_yscale('Linear')
```

### 5.15.使用不同颜色的线
这个其实没有用新方法，而是一种思路，可以创建一个颜色列表，在画线的时候根据索引选择颜色。
这个网站可用于获取颜色：http://colorbrewer2.org
```Python
colors = ['#d73027', '#f46d43', '#fdae61', '#fee08b', '#ffffbf', '#d9ef8b', '#a6d96a', '#66bd63', '#1a9850']
for i in range(9):
	…
	ax.scatter(x, y, label=str(i), linewidths=0.1, edgecolors='grey', facecolor=colors[i])
```


## 6.高级图
### 6.1.直方图
表示一定间隔下数据点频率的垂直矩形称为bin。
下面的代码会生成直方图：
```Python
ax.(x, bins=100, facecolor='yellow', edgecolor='blue', normed=True)
```
bins参数指定bin的个数，facecolor是填充颜色，edgecolor是边框颜色。
normed=True将值进行归一化处理，即总面积为1。
除此之外，还可以用range参数指定bins的范围。

### 6.2.误差条形图
生成误差直方图的代码：
```Python
plt.bar(x, y, yerr=xe, width=0.4, align='center', ecolor='r', color='#bbffee', hatch='o', label='experiment #1')
```
yerr参数是纵坐标误差的一组数据（单侧误差）。
hatch填充的阴影的样式。有斜线、十字线、圆圈、点、星号等。

### 6.3.分裂式饼图
核心代码：
```Python
pie(x, explode=explode, labels=labels, autopct='%.2f%%', startangle=67)
```
第一个参数是每一个扇形的数值（元组），explode参数是偏移量（元组，相对半径的比例），labels是标签（元组），这三个元组的元素数量要保持一致。
autopct='%.2f%%'用于自动计算百分比，startangle参数指定倾斜角度（x轴正方向逆时针夹角）。