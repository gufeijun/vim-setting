## vim

### 快捷键

> normal模式

进入方法：ESC或者ctrl+[或者ctrl+c

ctrl已修改为capslock按键，现在都通过capslock+c进入ESC。

```shell
gi		光标立马定位到上一次编辑地方
h(←) j(↓) k(↑) l(→)
w		移动到下一个word的开头
e		移动到下一个word的末尾
b		移动到上一个词的开头
0		移动到行首第一个字符
$		移动到行尾最后一个字符
gg		光标定位到文件开头
G		光标定位到结尾
ctrl+o	快速返回

H		快速定位到屏幕开头
M		快速定位到屏幕中间
L		快速定位到屏幕结尾

ctrl+u	向上翻页
ctrl+f  向下翻页

zz		将光标所在行放在屏幕中间

x		删除一个字符
u		撤销
dt[char]   	删除到char对应的字符

dd		删除一行
2dd		删除两行

r+[char]	将选中字母replace成char
s+[char]	将选中字母replace成char并立马进入insert模式

#下面一定要掌握
#y表示复制，d表示删除，c代表change，w表示word
y+i+w		#i与a的区别就是i选中的不会包含单词旁的空格
y+a+w		#超级使用，复制单词，会包含这个单词旁边的空格
d+a+w		#超级使用，删除单词
c+a+w		#超级实用，删除光标所在的单词并进入插入模式\
C			#超级实用，删除后面所有进入插入模式
c+t+[char]	#修改到char所在位置(change to)
#另一种模式，：很实用
c+i+"		#光标只要在""内，就可以删除""内的文字
c+i+(
c+a+"		#除了删文字外还删除""
#vim-go扩展：d(c)+i(a)+f可以删除函数


ZZ			#保存并退出

“+ 	指定系统寄存器
```

> insert模式

进入：i。在光标所在位置前插入

进入：I。在当前行的最前面插入

进入：a。在光标所在位置后插入

进入：A。在当前行的最后插入

进入：o。在下一行插入。

进入：O。在上一行插入。

```shell
ctrl+w	删除上一个单词
ctrl+u  删除当前行光标前的文字
ctrl+d	删除后面一个字母

#更改后的按键
alt+hjkl   移动
alt+HJKL	切换到ESC
```

> visual模式

进入：v(块选)或V(行选)。

```shell
y		复制
yy		复制一行
p		粘贴
d		剪切
c+[chars]	#将选中的文字替换成chars
```

> 命令模式

```shell
# /或者?查询单词
:/fuck	#向后搜索
:?fuck	#向前搜索


# !执行shell指令
:!echo hello

# 替换命令
:[range]s[ubstitude]/{pattern}/{string}/[flags]
range表示范围，比如：10,20表示10到20行，%表示全部
pattern为正则表达
string表示要替换成的文本
flags:
	g表示全局范围执行
	c(confirm)表示可以确认和拒绝修改
	n返回匹配的次数，并不替换
例子： :% s/haha/nima/g		#将haha替换为nima

#屏幕分割
ctrl+w+s	#水平分割
ctrl+w+v	#垂直分割
ctrl+w		#在分割屏幕间跳转或者ctrl+w+hjkl中一个
#在一个窗口里面
:e b.txt	#则可以让这个窗口编辑b.txt这个文件

#打开多个文件
:tabedit 文件

#关闭行号
:set nu!
```



## 映射

```shell
#insert模式
ctrl+a=home		#调到行头
ctrl+e=end		#调到行尾
ctrl+h=left
ctrl+j=down
ctrl+k=up
ctrl+d			#立马将光标定位到函数的花括号哪，然后按di{即可删除函数内部
ctrl+l=right
alt+y =del$		#删除到行末尾

#normal模式
alt+y			#删除到行末尾
hsr				#立即给文件头部加入作者信息
cdm				#立即加入c语言的模板
cxdm 			#立即加入c++语言的模板
```

## 插件

> vim-easymotion

```shell
\\f+要查找的字母
```

> ClangFormat

```shell
:cl+tab键会自动补全为 :ClangFormat
#自动格式化代码
```

> tpopo/vim-conmmenary

```shell
gcc 	注释或un注释当前行
gcap	注释或un注释当前段落
gc		注释选中的块
```


> vim-scripts/DoxygenTookit.vim

```shell
#光标定位到函数上
:Dox
#则可以给函数快速添加注释
```

> worp/ale

```shel
自动高亮错误
```

> ycm-core/YouCompleteMe

```shell
ctrl+n	#使用下一个候选
ctrl+p	#使用上一个候选
#当然也可以用方向键
```


> vim-go

```shell
:GoDef	#转到定义，可以是变量也可以是函数		#我自定义了映射，只需gd如：
#au FileType go nmap gd <Plug>(go-def-tab)，只需要gd即可
:GoRun										#我自定义了映射，只需gr
:GoInfo										
:GoTest
:GoFiles	#显示当前包下的文件
:GoImplements #查看那些实现了该接口
:GoCallers		#查看在哪调用了这个函数
:GoImpl f *Foo io.Writer		#为io.Writer接口生成Foo结构体
:GoIfErr						#查看变量的定义，可以看类型，只需leader+i
:GoRename						#重构功能，能把用到这个变量的所有地方都改名
:GoImports						#自动导入包

ctrl+]		#跳转到定义，超级使用
ctrl+o		#即可跳回
ctrl+i		#可以前进
```

> preservim/nerdtree

```shell
#显示项目结构
:NERDTreeToggle		#即可打开或关闭目录结构，已改建为F3

#光标选中文件
t			#打开选中的文件。并且光标跳转到对应
ctrl+w		#光标在在不同页面跳转
T			#安静打开文件，即不跳转
C			#把文件root目录标记为选中的文件夹
u			#把文件root目录定位到..
```

