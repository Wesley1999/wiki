# 在目录之外执行git命令

```
alias blogpull="pushd /home/wwwroot/blog && git pull && popd"
```
`pushd`会切换到该目录并且将该目录置于目录栈的栈顶
`popd`会将目录栈中的栈顶元素出栈，这时，栈顶元素发生变化，自然当前目录也会发生相应的切换

## Reference
[git怎么在工作区之外的目录执行pull功能？](https://www.oschina.net/question/878142_146126)
[Linux中的pushd和popd](https://blog.csdn.net/xia7139/article/details/50726971)