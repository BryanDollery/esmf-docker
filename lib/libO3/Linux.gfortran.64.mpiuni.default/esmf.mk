# ESMF application makefile fragment
#
# Use the following ESMF_ variables to compile and link
# your ESMF application against this ESMF build.
#
# !!! VERY IMPORTANT: If the location of this ESMF build is   !!!
# !!! changed, e.g. libesmf.a is copied to another directory, !!!
# !!! this file - esmf.mk - must be edited to adjust to the   !!!
# !!! correct new path                                        !!!
#
# Please see end of file for options used on this ESMF build
#


ESMF_VERSION_STRING=7.1.0r

ESMF_VERSION_MAJOR=7
ESMF_VERSION_MINOR=1
ESMF_VERSION_REVISION=0
ESMF_VERSION_PATCHLEVEL=0
ESMF_VERSION_PUBLIC='T'
ESMF_VERSION_BETASNAPSHOT='F'


ESMF_APPSDIR=/root/src/esmf/apps/appsO3/Linux.gfortran.64.mpiuni.default
ESMF_LIBSDIR=/root/src/esmf/lib/libO3/Linux.gfortran.64.mpiuni.default


ESMF_F90COMPILER=gfortran
ESMF_F90LINKER=gfortran

ESMF_F90COMPILEOPTS= -fPIC  -m64 -mcmodel=small -pthread -ffree-line-length-none  -fopenmp
ESMF_F90COMPILEPATHS=-I/root/src/esmf/mod/modO3/Linux.gfortran.64.mpiuni.default -I/root/src/esmf/src/include -I/usr/include
ESMF_F90COMPILECPPFLAGS=-DESMF_NO_INTEGER_1_BYTE -DESMF_NO_INTEGER_2_BYTE -DESMF_LAPACK=1 -DESMF_LAPACK_INTERNAL=1 -DESMF_MOAB=1 -DESMF_NO_ACC_SOFTWARE_STACK=1 -DESMF_NETCDF=1 -DESMF_NO_OPENACC -DESMF_TESTCOMPTUNNEL -DSx86_64_small=1 -DESMF_OS_Linux=1 -DESMF_MPIUNI
ESMF_F90COMPILEFREECPP=
ESMF_F90COMPILEFREENOCPP=-ffree-form
ESMF_F90COMPILEFIXCPP=-cpp -ffixed-form
ESMF_F90COMPILEFIXNOCPP=

ESMF_F90LINKOPTS=  -m64 -mcmodel=small -pthread -Wl,--no-as-needed  -fopenmp
ESMF_F90LINKPATHS=-L/root/src/esmf/lib/libO3/Linux.gfortran.64.mpiuni.default -L/usr/local/lib -L/usr/lib/gcc/x86_64-linux-gnu/7/
ESMF_F90ESMFLINKPATHS=-L/root/src/esmf/lib/libO3/Linux.gfortran.64.mpiuni.default
ESMF_F90LINKRPATHS=-Wl,-rpath,/root/src/esmf/lib/libO3/Linux.gfortran.64.mpiuni.default  -Wl,-rpath,/usr/local/lib -Wl,-rpath,/usr/lib/gcc/x86_64-linux-gnu/7/
ESMF_F90ESMFLINKRPATHS=-Wl,-rpath,/root/src/esmf/lib/libO3/Linux.gfortran.64.mpiuni.default
ESMF_F90LINKLIBS= -lrt -lstdc++ -ldl -lnetcdf -lnetcdff
ESMF_F90ESMFLINKLIBS=-lesmf  -lrt -lstdc++ -ldl -lnetcdf -lnetcdff

ESMF_CXXCOMPILER=g++
ESMF_CXXLINKER=g++

ESMF_CXXCOMPILEOPTS= -fPIC -DESMF_LOWERCASE_SINGLEUNDERSCORE -m64 -mcmodel=small -pthread  -fopenmp
ESMF_CXXCOMPILEPATHS= -I/root/src/esmf/src/include  -I/usr/include -I/root/src/esmf/src/Infrastructure/stubs/mpiuni
ESMF_CXXCOMPILECPPFLAGS=-DESMF_NO_INTEGER_1_BYTE -DESMF_NO_INTEGER_2_BYTE -DESMF_LAPACK=1 -DESMF_LAPACK_INTERNAL=1 -DESMF_MOAB=1 -DESMF_NO_ACC_SOFTWARE_STACK=1 -DESMF_NETCDF=1 -DESMF_NO_OPENACC -DESMF_TESTCOMPTUNNEL -DSx86_64_small=1 -DESMF_OS_Linux=1 -D__SDIR__='' -DESMF_MPIUNI

ESMF_CXXLINKOPTS= -m64 -mcmodel=small -pthread -Wl,--no-as-needed  -fopenmp
ESMF_CXXLINKPATHS=-L/root/src/esmf/lib/libO3/Linux.gfortran.64.mpiuni.default -L/usr/local/lib -L/usr/lib/gcc/x86_64-linux-gnu/7/
ESMF_CXXESMFLINKPATHS=-L/root/src/esmf/lib/libO3/Linux.gfortran.64.mpiuni.default
ESMF_CXXLINKRPATHS=-Wl,-rpath,/root/src/esmf/lib/libO3/Linux.gfortran.64.mpiuni.default  -Wl,-rpath,/usr/local/lib -Wl,-rpath,/usr/lib/gcc/x86_64-linux-gnu/7/
ESMF_CXXESMFLINKRPATHS=-Wl,-rpath,/root/src/esmf/lib/libO3/Linux.gfortran.64.mpiuni.default
ESMF_CXXLINKLIBS= -lrt -lgfortran -ldl -lnetcdf -lnetcdff
ESMF_CXXESMFLINKLIBS=-lesmf  -lrt -lgfortran -ldl -lnetcdf -lnetcdff

ESMF_SO_F90COMPILEOPTS=-fPIC
ESMF_SO_F90LINKOPTS=-shared
ESMF_SO_F90LINKOPTSEXE=-Wl,-export-dynamic
ESMF_SO_CXXCOMPILEOPTS=-fPIC
ESMF_SO_CXXLINKOPTS=-shared
ESMF_SO_CXXLINKOPTSEXE=-Wl,-export-dynamic

ESMF_OPENMP_F90COMPILEOPTS= -fopenmp
ESMF_OPENMP_F90LINKOPTS= -fopenmp
ESMF_OPENMP_CXXCOMPILEOPTS= -fopenmp
ESMF_OPENMP_CXXLINKOPTS= -fopenmp

ESMF_OPENACC_F90COMPILEOPTS=
ESMF_OPENACC_F90LINKOPTS=
ESMF_OPENACC_CXXCOMPILEOPTS=
ESMF_OPENACC_CXXLINKOPTS=

# Internal ESMF variables, do NOT depend on these!

ESMF_INTERNAL_DIR=/root/src/esmf

#
# !!! The following options were used on this ESMF build !!!
#
# ESMF_DIR: /root/src/esmf
# ESMF_OS: Linux
# ESMF_MACHINE: x86_64
# ESMF_ABI: 64
# ESMF_COMPILER: gfortran
# ESMF_BOPT: O3
# ESMF_COMM: mpiuni
# ESMF_SITE: default
# ESMF_PTHREADS: ON
# ESMF_OPENMP: ON
# ESMF_OPENACC: OFF
# ESMF_ARRAY_LITE: FALSE
# ESMF_NO_INTEGER_1_BYTE: TRUE
# ESMF_NO_INTEGER_2_BYTE: TRUE
# ESMF_FORTRANSYMBOLS: default
# ESMF_DEFER_LIB_BUILD: ON
# ESMF_SHARED_LIB_BUILD: ON
# 
# ESMF environment variables pointing to 3rd party software:
# ESMF_MOAB:              internal
# ESMF_LAPACK:            internal
#ESMF_ACC_SOFTWARE_STACK:            none
# ESMF_NETCDF:            local
# ESMF_NETCDF_INCLUDE:    /usr/include
# ESMF_NETCDF_LIBS:       -lnetcdf -lnetcdff
# ESMF_NETCDF_LIBPATH:    /usr/local/lib
