# make

始终觉得使用 make 才能代表真正的程序员，然而，写程序十年了，却未好好地写过 makefile ，也未认认真真学习过 make 的语法规则

近来需要整合一些通用的支持库，如 curl 、 openssl 、 zlib 、 Lua 等，但悲哀地发现，这些公共库对 windows 的 nmake ，即算有支持，也颇为有限，无法满足我的需求。（特别是 Lua ，至今未专门支持 nmake ）

原是写了 BAT 用来代替 makefile ，但过一段时间后发现，不尽如人意

遂专门花时间学习了 [nmake参考](https://docs.microsoft.com/zh-cn/cpp/build/nmake-reference) ，想着能否写一写适用于 nmake 的 makefile 。也做了多次尝试，仍被 nmake 的局限搞得灰头土脸。最终，还是萌生了使用 gnu make 的想法

百度搜索 make 或 make for windows ，无法引导你找到正宗的 gnu make 。只有搜索 gnumake 才能真正找到 [gnu make](http://www.gnu.org/software/make/)

而我欣喜地发现，gnu make 已经原生的支持 windows 下使用 msvc 编译

---- ---- ---- ----

## BAT编译

gnu make 支持 BAT 编译

```cmd
cd /d C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build
call vcvarsall.bat amd64
cd /d ./gnu/make/make-4.2.1
build_w32.bat
```

生成结果 : `./WinRel/gnumake.exe`

---- ---- ---- ----

## NMake编译

gnu make 支持 NMake 编译

```cmd
cd /d C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build
call vcvarsall.bat amd64
cd /d ./gnu/make/make-4.2.1
nmake /f NMakefile Release
```

实际上 NMakefile 并没写好，这个编译会失败

---- ---- ---- ----

## VisualStudio编译

gnu make 支持 VisualStudio 编译

打开目录下的 `make_msvc_net2003.sln` 工程文件，编译之

---- ---- ---- ----

## 特化编译

参考 gnu make 提供的 windows 下的编译手段，自行实现 Makefile for gnu make

`Makefile` 使用 gnu make 编译自身，故需先用其他方法编译一份 make ，并放到同级目录

`Makefile.bat` 检测当前环境，决定编译结果
