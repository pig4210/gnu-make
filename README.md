# make

素闻使用 make 才好意思称真正的程序员。然而，写程序十载，未曾好好地写过 makefile ，也未认认真真学习过 make 的语法规则。

近来需整合一些通用支持库，如 curl 、 openssl 、 zlib 、 Lua 等，却悲哀地发现，这些公共库对 windows 的 nmake ，即算有支持，也颇为有限，无法满足我的特别需求。（特别是 Lua ，至今未专门支持 nmake 。 ）

原是写了 BAT 实现自动化编译，但作为一个完美主义强迫症病患，内心总不甘于如此平庸的实现。

遂专门花时间学习了 [nmake参考](https://docs.microsoft.com/zh-cn/cpp/build/nmake-reference) ，想着能否写一写适用于 nmake 的 makefile 。也做了多次尝试，仍是被 nmake 的局限搞得灰头土脸。最终，还是坚定了使用 GNU make 的想法。

百度 make 或 make for windows ，无法引导你找到正宗的 GNU make 。只有搜索 gnumake 才能真正找到 [GNU make](http://www.gnu.org/software/make/) 。

而我欣喜地发现，GNU make 已原生地支持 windows 下使用 msvc 编译。

奈何，固执如我还是决定写一个特化的 Makefile。

然后，一遍遍地 review ，锱铢必校，以期能尽量贴近我心中的所谓“完美” 。

---- ---- ---- ----

## 特化编译

参考 GNU make 提供的 windows 下的编译手段，实现特化 Makefile 。

`Makefile` 使用 GNU make 编译自身，故需先假他法编译一份 *make.exe* ，并置于同级目录。

`Makefile.bat` 检测当前环境，决定编译结果：

  - 在 对应的编译环境 下，编译对应平台版本，有编译回显。
  - 无编译环境时，自行编译 x64 & x86 版本，无编译回显。

---- ---- ---- ----

## BAT编译

GNU make 支持 BAT 编译。生成结果 : `./WinRel/gnumake.exe` 。

```cmd
cd /d C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build
call vcvarsall.bat amd64
cd /d ./gnu/make/make-*
build_w32.bat
```

---- ---- ---- ----

## NMake编译

GNU make 支持 NMake 编译。

实际上，原生的 NMakefile 并没写好，这个编译会失败。

```cmd
cd /d C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build
call vcvarsall.bat amd64
cd /d ./gnu/make/make-*
nmake /f NMakefile Release
```

---- ---- ---- ----

## VisualStudio编译

GNU make 支持 VisualStudio 编译。

打开目录下的 `make_msvc_net2003.sln` 工程文件，编译之。