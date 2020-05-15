# 区分Android中的各种单位——in、mm、pt、px、dp、dip、sp

Android常用的单位有in、mm、pt、px、dp、dip、sp。

in、mm、pt是屏幕的物理单位，1in=25.4mm=72pt。

px是屏幕的像素单位，例如，1080*1920的屏幕在横向有1080个像素，在纵向有1920个像素。

dp与屏幕大小和像素无关，与屏幕密度（dpi）有关。
当dpi=160时，1dp=1px；
当dpi=320时，1dp=2px；
当dpi=640时，1dp=4px。

**设置布局通常用dp**，dip与dp相同，1dip=1dp。

**设置字体通常用sp**，sp与dp类似，与屏幕大小和像素无关，会根据屏幕密度和用户字体配置而适配。

下面的两张图分别我是在dpi=320和dpi=640的条件下截取的，此外，我的屏幕分辨率是1080px*1920px，屏幕对角线长是5.5英寸。

<img src="https://img-blog.csdnimg.cn/2018110221434785.png" width="40%">
<img src="https://img-blog.csdnimg.cn/20181102214548536.png" width="40%">