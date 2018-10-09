# 这个 Makefile 用于使用 GNU make 在 Windows 编译自身
# http://www.gnu.org/software/make/

ifeq "$(filter x64 x86,$(Platform))" ""
$(error Need VS Environment)
endif

ifeq "$(VPATH)" ""
$(error Need VPATH)
endif

LINK 		:= link.exe
CC 			:= cl.exe

GPATH		:= $(Platform)

######## CFLAGS		注意到 CFLAGS 不能使用 UNICODE
CFLAGS		:= /c /MP /GS- /Qpar /GL /analyze- /W4 /Gy /Zc:wchar_t /Zi /Gm- /Ox /Zc:inline /fp:precise /D WIN32 /D NDEBUG /fp:except- /errorReport:none /GF /WX /Zc:forScope /GR- /Gd /Oy /Oi /MT /EHa /nologo
CFLAGS		:= $(CFLAGS) /D WINDOWS32 /D _WINDOWS \
	/D HAVE_CONFIG_H /D _CONSOLE
CFLAGS		:= $(CFLAGS) /I"$(VPATH)"\
	/I"$(VPATH)/glob" \
	/I"$(VPATH)/w32/subproc" \
	/I"$(VPATH)/w32/subproc/../include" \
	/I"$(GPATH)"
CFLAGS		:= $(CFLAGS) /Fd"$(GPATH)/make.pdb"
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


OUTDIR		:= $(GPATH)


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
	$(OUTDIR)/loadapi.obj \
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
	$(OUTDIR)/glob/glob.obj \
	$(OUTDIR)/glob/fnmatch.obj \
	$(OUTDIR)/w32/compat/dirent.obj \
	$(OUTDIR)/w32/pathstuff.obj \
	$(OUTDIR)/w32/compat/posixfcn.obj \
	$(OUTDIR)/w32/w32os.obj \
	$(guile)
################################################

######## 以下参考 ./w32/subproc/NMakefile ########
## 前置 SUBPROC_
## 替换 $(OUTDIR) $(GPATH)/w32/subproc
SUBPROC_OBJS = $(GPATH)/w32/subproc/misc.obj \
	$(GPATH)/w32/subproc/w32err.obj \
	$(GPATH)/w32/subproc/sub_proc.obj
################################################

.PHONY : all
all : $(GPATH)/config.h $(GPATH)/make.exe
	@echo make done.

$(GPATH)/make.exe : $(OBJS) $(SUBPROC_OBJS)
	$(LINK) $(LDFLAGS) $? /OUT:"$@"

######## 以下参考 NMakefile ########
$(GPATH)/config.h: $(VPATH)\\config.h.W32
	@for %%F in ("$@") do @if not exist "%%~dpF" @mkdir "%%~dpF"
	copy "$?" "$@"

vpath config.h $(GPATH)

## 去除命令
## 添加路径 才能触发模式匹配
$(OUTDIR)/glob/glob.obj : glob/glob.c
$(OUTDIR)/glob/fnmatch.obj : glob/fnmatch.c
$(OUTDIR)/w32/compat/dirent.obj : w32/compat/dirent.c
$(OUTDIR)/w32/compat/posixfcn.obj : w32/compat/posixfcn.c
$(OUTDIR)/w32/pathstuff.obj : w32/pathstuff.c
$(OUTDIR)/w32/w32os.obj : w32/w32os.c


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
################################################

######## 以下参考 ./w32/subproc/NMakefile ########
## 替换 $(OUTDIR) $(GPATH)/w32/subproc
## 添加 $(VPATH)/w32/subproc/
$(GPATH)/w32/subproc/misc.obj: \
	$(VPATH)/w32/subproc/misc.c \
	$(VPATH)/w32/subproc/proc.h

$(GPATH)/w32/subproc/sub_proc.obj: \
	$(VPATH)/w32/subproc/sub_proc.c  \
	$(VPATH)/w32/subproc/../include/sub_proc.h \
	$(VPATH)/w32/subproc/../include/w32err.h \
	$(VPATH)/w32/subproc/proc.h

$(GPATH)/w32/subproc/w32err.obj: \
	$(VPATH)/w32/subproc/w32err.c \
	$(VPATH)/w32/subproc/../include/w32err.h
################################################



$(GPATH)/%.obj : $(VPATH)/%.c
	@for %%F in ("$@") do @if not exist "%%~dpF" @mkdir "%%~dpF"
	$(CC) $(CFLAGS) "$<" -Fo"$@"