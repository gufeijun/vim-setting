## 安装

### 环境

vim版本：>=v8.1.2269

gcc版本：>=8

g++版本：>=8

ubuntu：20.04

```
sudo apt install clang-format -y
sudo apt install cmake build-essential python3-dev
sudo apt install g++
```

youcompleteme需要单独编译：

```
~/.vim/bundles/YouCompleteMe/install.py --clangd-completer --go-completer 
```



注意：wsl用户需要单独下载win32yank，具体见.vimrc

非wsl用户注释掉
