使用HPL进行CPU硬件性能测试：

首先需要准备一下三个库：

- MPI运行环境

```shell
wget https://www.mpich.org/static/downloads/3.4.1/mpich-3.4.1.tar.gz
```

- GotoBlas2矩阵向量运算库

```shell
wget https://www.tacc.utexas.edu/documents/1084364/1087496/GotoBLAS2-1.13.tar.gz
```

- HPL测试配置平台

```shell
wget http://www.netlib.org/benchmark/hpl/hpl-2.3.tar.gz
```

分别解压

```shell
tar -zxvf 对应压缩包
```

编译步骤：


1. 编译mpi

```shell
cd mpich-3.4.1

创建mpi安装路径
mkdir /data/mpich

配置makefile
./configure --prefix=/data/mpich --with-device=ch4:ofi

make

make install
```

配置mpi的环境变量到自己的shell中，以fish shell为例

```shell
set PATH $PATH /data/mpich/bin 
set LD_LIBRARY_PATH /data/mpich/lib
```

2. 编译gotoblas2
将gotoblas2解压出的所有文件拷贝到/data/gotoblas2文件夹中，这个路径一会儿在编译hpl的时候会有用
```shell
cd /data/gotoblas2

以我的64位为例
chmod 755  quickbuild.64bit

修改makefile

TARGET=NEHALEM
BINARY=64
USE_OPENMP=1
INTERFACE64=1

编译：
./quickbuild.64bit
```





成功后，目录下将会生成一个libgoto2.a的一个符号链接，后面编译hpl的时候也会用上

3. 编译HPL配置平台

```shell
cd hpl-2.3

使用下面的这个通用配置文件
cp setup/Make.Linux_ATHLON_CBLAS WillMake

过滤掉注释信息：
cat WillMake | grep -v "#" > Make.Intel64

vim Make.Intel64 修改成如下配置


SHELL        = /bin/sh
CD           = cd
CP           = cp
LN_S         = ln -s
MKDIR        = mkdir
RM           = /bin/rm -f
TOUCH        = touch
ARCH         = Intel64
TOPdir       = /data/hpl   -----> 这个是当前编译hpl的根目录
INCdir       = $(TOPdir)/include
BINdir       = $(TOPdir)/bin/$(ARCH)
LIBdir       = $(TOPdir)/lib/$(ARCH)
HPLlib       = $(LIBdir)/libhpl.a 
MPdir        = /data/mpich	-----> 编译好的mpi目录
MPinc        = -I$(MPdir)/include
MPlib        = $(MPdir)/lib/libmpi.a  ---->这个符号链接具体请查看自己mpi目录
LAdir        = /data/gotoblas2   ----> gotoblas2库
LAinc        =
LAlib        = /data/gotoblas2/libgoto2.a  ----> 符号链接
F2CDEFS      =
HPL_INCLUDES = -I$(INCdir) -I$(INCdir)/$(ARCH) $(LAinc) $(MPinc)
HPL_LIBS     = $(HPLlib) $(LAlib) $(MPlib)
HPL_OPTS     = -DHPL_CALL_CBLAS
HPL_DEFS     = $(F2CDEFS) $(HPL_OPTS) $(HPL_INCLUDES)
CC           = /usr/bin/gcc
CCNOOPT      = $(HPL_DEFS)
CCFLAGS      = $(HPL_DEFS) -fomit-frame-pointer -O3 -funroll-loops -W -Wall -lpthread -lpciaccess -ldl -ludev -fopenmp -lrt -lX11 -lXNVCtrl ------> 这些动态链接库是必需的，没有的请安装谢谢
LINKER       = /usr/bin/gcc  -----> 注意是gcc编译器
LINKFLAGS    = $(CCFLAGS)
ARCHIVER     = ar
ARFLAGS      = r
RANLIB       = echo


然后编译
make arch=Intel64
```






编译完成后，会生成一个HPL.dat的配置文件和一个xhpl的可执行文件，HPL.dat是xhpl执行时读取的配置文件

最后测试即可：

mpirun -np 4 ./xhpl

请注意xhpl和HPL.dat必须在同一个目录下
