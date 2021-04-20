COMPILER := gfortran
COMPILER_OPTIONS := -ffree-form -ffree-line-length-none -fimplicit-none \
                    -O3 -mtune=native -fdefault-integer-8 -fdefault-real-8 \
                    -fdefault-double-8

all: hxh-dgemm.x

hxh-dgemm.x: hxh-dgemm.o dgemm.o lsame.o xerbla.o
	$(COMPILER) $(COMPILER_OPTIONS) hxh-dgemm.o dgemm.o lsame.o xerbla.o -o hxh-dgemm.x

hxh-dgemm.o: hxh-dgemm.f90
	$(COMPILER) $(COMPILER_OPTIONS) -c hxh-dgemm.f90 -o hxh-dgemm.o

dgemm.o: dgemm.f
	$(COMPILER) $(COMPILER_OPTIONS) -c dgemm.f -o dgemm.o

lsame.o: lsame.f
	$(COMPILER) $(COMPILER_OPTIONS) -c lsame.f -o lsame.o

xerbla.o: xerbla.f
	$(COMPILER) $(COMPILER_OPTIONS) -c xerbla.f -o xerbla.o

.PHONY: clean
clean:
	rm *.x *.o
