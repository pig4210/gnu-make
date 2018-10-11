# 这个 Makefile 用于使用 GNU make 在 Windows 下编译 GNU make
# http://www.gnu.org/software/make/

# 如果只是单纯的 clean ，则无需 环境 和 路径
ifneq "$(MAKECMDGOALS)" "clean"

  ifeq "$(filter x64 x86,$(Platform))" ""
    $(error Need VS Environment)
  endif

  ifeq "$(SRCPATH)" ""
    $(error Need SRCPATH)
  endif

endif

DESTPATH	:= $(Platform)


# make.exe 添加路径，避免与原始 make.exe 冲突
# 在 源代码目录 下，有生成两个文件，不主动删除，避免每次 make 都需要生成
.PHONY : all
all : $(DESTPATH)/make.exe
	@echo make done.


OUTDIR		:= $(Platform)

######## 以下参考 NMakefile ########
guile = $(OUTDIR)/guile.obj

## 注意到 NMakefile 的 OBJS 少一个 loadapi （好像可有可无）
OBJS = \
	$(OUTDIR)/ar.obj \
	$(OUTDIR)/arscan.obj \
	$(OUTDIR)/commands.obj \
	$(OUTDIR)/default.obj \
	$(OUTDIR)/dir.obj \
	$(OUTDIR)/expand.obj \
	$(OUTDIR)/file.obj \
	$(OUTDIR)/function.obj \
	$(OUTDIR)/getloadavg.obj \
	$(OUTDIR)/getopt.obj \
	$(OUTDIR)/getopt1.obj \
	$(OUTDIR)/hash.obj \
	$(OUTDIR)/implicit.obj \
	$(OUTDIR)/job.obj \
	$(OUTDIR)/load.obj \
	$(OUTDIR)/main.obj \
	$(OUTDIR)/misc.obj \
	$(OUTDIR)/output.obj \
	$(OUTDIR)/read.obj \
	$(OUTDIR)/remake.obj \
	$(OUTDIR)/remote-stub.obj \
	$(OUTDIR)/rule.obj \
	$(OUTDIR)/signame.obj \
	$(OUTDIR)/strcache.obj \
	$(OUTDIR)/variable.obj \
	$(OUTDIR)/version.obj \
	$(OUTDIR)/vpath.obj \
	$(OUTDIR)/glob.obj \
	$(OUTDIR)/fnmatch.obj \
	$(OUTDIR)/dirent.obj \
	$(OUTDIR)/pathstuff.obj \
	$(OUTDIR)/posixfcn.obj \
	$(OUTDIR)/w32os.obj \
	$(guile)

# 添加依赖的搜索路径
vpath config.h.W32 $(SRCPATH)

## 修改命令
config.h: config.h.W32
	copy /y "$(?D)\\$(?F)" "$(?D)\\$(@F)"

$(OUTDIR)/ar.obj: ar.c makeint.h config.h \
 gnumake.h \
 getopt.h \
 gettext.h \
 filedef.h hash.h dep.h

# .deps/arscan.Po
$(OUTDIR)/arscan.obj: arscan.c makeint.h config.h \
 gnumake.h \
 getopt.h \
 gettext.h \

# .deps/commands.Po
$(OUTDIR)/commands.obj: commands.c makeint.h config.h \
 gnumake.h \
 getopt.h \
 gettext.h \
 filedef.h hash.h dep.h variable.h job.h output.h \
 commands.h

# .deps/default.Po
$(OUTDIR)/default.obj: default.c makeint.h config.h \
 gnumake.h \
 getopt.h \
 gettext.h \
 filedef.h hash.h variable.h rule.h dep.h job.h \
 output.h \
 commands.h

# .deps/dir.Po
$(OUTDIR)/dir.obj: dir.c makeint.h config.h \
 gnumake.h \
 getopt.h \
 gettext.h \
 hash.h \
 filedef.h dep.h \

# .deps/expand.Po
$(OUTDIR)/expand.obj: expand.c makeint.h config.h \
 gnumake.h \
 getopt.h \
 gettext.h \
 filedef.h hash.h job.h output.h \
 commands.h variable.h rule.h

# .deps/file.Po
$(OUTDIR)/file.obj: file.c makeint.h config.h \
 gnumake.h \
 getopt.h \
 gettext.h \
 filedef.h hash.h dep.h job.h output.h \
 commands.h variable.h \
 debug.h

# .deps/function.Po
$(OUTDIR)/function.obj: function.c makeint.h config.h \
 gnumake.h \
 getopt.h \
 gettext.h \
 filedef.h hash.h variable.h dep.h job.h output.h \
 commands.h debug.h

# .deps/getloadavg.Po
# dummy

# .deps/getopt.Po
$(OUTDIR)/getopt.obj: getopt.c config.h \

# .deps/getopt1.Po
$(OUTDIR)/getopt1.obj: getopt1.c config.h getopt.h \

# .deps/guile.Po
$(OUTDIR)/guile.obj: guile.c makeint.h config.h \
 gnumake.h \
 getopt.h \
 gettext.h \
 debug.h filedef.h hash.h dep.h variable.h \
 gmk-default.h

# .deps/hash.Po
$(OUTDIR)/hash.obj: hash.c makeint.h config.h \
 gnumake.h \
 getopt.h \
 gettext.h \
 hash.h

# .deps/implicit.Po
$(OUTDIR)/implicit.obj: implicit.c makeint.h config.h \
 gnumake.h \
 getopt.h \
 gettext.h \
 filedef.h hash.h rule.h dep.h debug.h variable.h job.h output.h \
 commands.h

# .deps/job.Po
$(OUTDIR)/job.obj: job.c makeint.h config.h \
 gnumake.h \
 getopt.h \
 gettext.h \
 job.h output.h \
 debug.h filedef.h hash.h \
 commands.h variable.h os.h

# .deps/load.Po
$(OUTDIR)/load.obj: load.c makeint.h config.h \
 gnumake.h \
 getopt.h \
 gettext.h \
 debug.h \
 filedef.h hash.h variable.h

# .deps/loadapi.Po
$(OUTDIR)/loadapi.obj: loadapi.c makeint.h config.h \
 gnumake.h \
 getopt.h \
 gettext.h \
 filedef.h hash.h variable.h dep.h

# .deps/loadavg-getloadavg.Po
# dummy

# .deps/main.Po
$(OUTDIR)/main.obj: main.c makeint.h config.h \
 gnumake.h \
 getopt.h \
 gettext.h \
 os.h \
 filedef.h hash.h dep.h variable.h job.h output.h \
 commands.h rule.h debug.h \
 getopt.h

# .deps/misc.Po
$(OUTDIR)/misc.obj: misc.c makeint.h config.h \
 gnumake.h \
 getopt.h \
 gettext.h \
 filedef.h hash.h dep.h debug.h \

# .deps/output.Po
$(OUTDIR)/output.obj: output.c makeint.h config.h \
 gnumake.h \
 getopt.h \
 gettext.h \
 job.h \
 output.h \

# .deps/posixos.Po
$(OUTDIR)/posixos.obj: posixos.c makeint.h config.h \
 gnumake.h \
 getopt.h \
 gettext.h \
 debug.h job.h output.h os.h

# .deps/read.Po
$(OUTDIR)/read.obj: read.c makeint.h config.h \
 gnumake.h \
 getopt.h \
 gettext.h \
 filedef.h hash.h dep.h job.h output.h \
 commands.h variable.h rule.h \
 debug.h

# .deps/remake.Po
$(OUTDIR)/remake.obj: remake.c makeint.h config.h \
 gnumake.h \
 getopt.h \
 gettext.h \
 filedef.h hash.h job.h output.h \
 commands.h dep.h variable.h \
 debug.h

# .deps/remote-cstms.Po
# dummy

# .deps/remote-stub.Po
$(OUTDIR)/remote-stub.obj: remote-stub.c makeint.h \
 config.h \
 gnumake.h \
 getopt.h \
 gettext.h \
 filedef.h hash.h job.h output.h \
 commands.h

# .deps/rule.Po
$(OUTDIR)/rule.obj: rule.c makeint.h config.h \
 gnumake.h \
 getopt.h \
 gettext.h \
 filedef.h hash.h dep.h job.h output.h \
 commands.h variable.h rule.h

# .deps/signame.Po
$(OUTDIR)/signame.obj: signame.c makeint.h config.h \
 gnumake.h \
 getopt.h \
 gettext.h \

# .deps/strcache.Po
$(OUTDIR)/strcache.obj: strcache.c makeint.h config.h \
 gnumake.h \
 getopt.h \
 gettext.h \
 hash.h

# .deps/variable.Po
$(OUTDIR)/variable.obj: variable.c makeint.h config.h \
 gnumake.h \
 getopt.h \
 gettext.h \
 filedef.h hash.h dep.h job.h output.h \
 commands.h variable.h rule.h

# .deps/version.Po
$(OUTDIR)/version.obj: version.c config.h

# .deps/vmsjobs.Po
# dummy

# .deps/vpath.Po
$(OUTDIR)/vpath.obj: vpath.c makeint.h config.h \
 gnumake.h \
 getopt.h \
 gettext.h \
 filedef.h hash.h variable.h

## glob 等对应的规则，由于没有其它依赖，则利用默认依赖，这里不需要复制过来
################################################

######## 以下参考 ./w32/subproc/NMakefile ########
## 前置 SUBPROC_
## 修改 misc 避免冲突
SUBPROC_OBJS = $(OUTDIR)/misc1.obj $(OUTDIR)/w32err.obj $(OUTDIR)/sub_proc.obj

## 对应修改 misc
## 添加特殊处理，避免首次编译找不到 misc1.c 导致失败
$(OUTDIR)/misc1.obj: misc1.c proc.h
	$(CC) $(CFLAGS) "$(SRCPATH)/w32/subproc/$(<F)" -Fo"$@"
$(OUTDIR)/sub_proc.obj: sub_proc.c  ../include/sub_proc.h ../include/w32err.h proc.h
$(OUTDIR)/w32err.obj: w32err.c ../include/w32err.h

## 添加 misc1.c 的生成
misc1.c : $(SRCPATH)/w32/subproc/misc.c
	copy /y "$(?D)\\$(?F)" "$(?D)\\$(@F)"
################################################


LINK 		:= link.exe
CC 			:= cl.exe

######## CFLAGS		注意到 CFLAGS 不能使用 UNICODE
CFLAGS		:= /c /MP /GS- /Qpar /GL /analyze- /W4 /Gy /Zc:wchar_t /Zi /Gm- /Ox /Zc:inline /fp:precise /D WIN32 /D NDEBUG /fp:except- /errorReport:none /GF /WX /Zc:forScope /GR- /Gd /Oy /Oi /MT /EHa /nologo
CFLAGS		:= $(CFLAGS) /D WINDOWS32 /D _WINDOWS \
	/D HAVE_CONFIG_H /D _CONSOLE
CFLAGS		:= $(CFLAGS) /I"$(SRCPATH)" \
	/I"$(SRCPATH)/glob" \
	/I"$(SRCPATH)/w32/subproc" \
	/I"$(SRCPATH)/w32/include"
CFLAGS		:= $(CFLAGS) /Fd"$(DESTPATH)/make.pdb"
CFLAGS		:= $(CFLAGS) /wd4267 /wd4214 /wd4244 /wd4477 /wd4307 /wd4115 /wd4130 /wd4310 /wd4389 /wd4090 /wd4018 /wd4456 /wd4996 /wd4706 /wd4701

ifeq "$(Platform)" "x86"
CFLAGS		:= $(CFLAGS) /D _USING_V110_SDK71_
endif

######## LDFLAGS
LDFLAGS		:= /MANIFEST:NO /LTCG /NXCOMPAT /DYNAMICBASE "kernel32.lib" "user32.lib" "gdi32.lib" "winspool.lib" "comdlg32.lib" "advapi32.lib" "shell32.lib" "ole32.lib" "oleaut32.lib" "uuid.lib" "odbc32.lib" "odbccp32.lib" /OPT:REF /INCREMENTAL:NO /OPT:ICF /ERRORREPORT:NONE /NOLOGO /MACHINE:$(Platform)

ifeq "$(Platform)" "x86"
LDFLAGS		:= $(LDFLAGS) /SAFESEH /SUBSYSTEM:CONSOLE",5.01"
else
LDFLAGS		:= $(LDFLAGS) /SUBSYSTEM:CONSOLE
endif

LDFLAGS		:= $(LDFLAGS) /STACK:0x400000 advapi32.lib


# 源文件搜索路径
vpath %.c $(SRCPATH)
vpath %.h $(SRCPATH)

vpath %.c $(SRCPATH)/glob
vpath %.h $(SRCPATH)/glob
vpath %.c $(SRCPATH)/w32
vpath %.h $(SRCPATH)/w32
vpath %.c $(SRCPATH)/w32/compat
vpath %.h $(SRCPATH)/w32/compat
vpath %.c $(SRCPATH)/w32/subproc
vpath %.h $(SRCPATH)/w32/subproc

# 目标文件搜索路径
vpath %.o 	$(DESTPATH)


$(DESTPATH)/make.exe : $(OBJS) $(SUBPROC_OBJS)
	$(LINK) $(LDFLAGS) $^ /OUT:"$(DESTPATH)/$(@F)"

# 添加依赖 config.h，以及一次性的目录依赖 
$(OBJS) $(SUBPROC_OBJS) : config.h | $(DESTPATH)

$(DESTPATH) :
	@mkdir $@

# 模式规则
$(DESTPATH)/%.obj : %.c
	$(CC) $(CFLAGS) "$<" -Fo"$@"
	
.PHONY : clean
clean :
	@if exist "x64" @rd /s /q "x64"
	@if exist "x86" @rd /s /q "x86"
	@for /d %%P in ("make*") do \
		@if exist "%%~P\\config.h" @del /q "%%~P\\config.h"
	@for /d %%P in ("make*") do \
		@if exist "%%~P\\/w32/subproc\\misc1.c" @del /q "%%~P\\/w32/subproc\\misc1.c"