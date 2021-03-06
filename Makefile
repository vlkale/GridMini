GPUARCH=-m64 -gencode arch=compute_70,code=sm_70
MAIN=Benchmark_su3

##PGI
#CXX=pgc++
#CXXFLAGS=-fast --c++14 -mp -Mllvm -Minfo=accel

##Clang
#CXX=clang++
#CXXFLAGS=-std=c++14 -fopenmp -O3

##NVCC
CXX=nvcc
CXXFLAGS=--x cu ${GPUARCH} -I. -ccbin g++ -rdc=true --expt-extended-lambda --expt-relaxed-constexpr -std=c++14

##GCC
#CXX=g++
#CXXFLAGS=-std=c++14 -O3 -fopenmp


INCLUDES=./


all:
	$(CXX) $(CXXFLAGS) -I$(INCLUDES) \
		benchmarks/${MAIN}.cc \
                Grid/util/Init.cc \
                Grid/communicator/SharedMemory.cc \
                Grid/communicator/SharedMemoryNone.cc \
                Grid/allocator/AlignedAllocator.cc \
                Grid/communicator/Communicator_base.cc \
                Grid/communicator/Communicator_none.cc  \
                Grid/log/Log.cc \
                -o ${MAIN}.x \
                -DGEN \
                -DGEN_SIMD_WIDTH=16 \
                -DHAVE_MALLOC_H \
                -DGRID_COMMS_NONE \
                -DGRID_DEFAULT_PRECISION_DOUBLE \
                -DRNG_RANLUX

