CC = gcc
CFLAGS = -g -O2 -c

OC = ocamlopt
MLFLAGS = -g
DBGFLAGS = $(MLFLAGS) -p -inline 0
OPTFLAGS = $(MLFLAGS) -inline 100 -unsafe -noassert

INCLUDE = -I +lablgl -I math -I extra -I ocagl -I p1 lablgl.cmxa lablglut.cmxa unix.cmxa

MATH = math/vector.ml math/quaternion.ml
EXTRA = extra/magic.mli extra/magic.ml
OCAGL = ocagl/v3a.mli ocagl/v3a.ml ocagl/devices.mli ocagl/devices.ml

FILES = extra/c_magic.o $(MATH) $(EXTRA) $(OCAGL) p1/p1.ml p1/main.ml

all: extra/c_magic.o main

debug: extra/c_magic.o main.dbg

optimized: extra/c_magic.o main.opt

extra/c_magic.o: extra/c_magic.c
	$(CC) $(CFLAGS) -o extra/c_magic.o extra/c_magic.c 

main: $(FILES)
	$(OC) $(MLFLAGS) $(INCLUDE) -o main $(FILES)

main.dbg: $(FILES)
	$(OC) $(DBGFLAGS) $(INCLUDE) -o main.dbg $(FILES)

main.opt: $(FILES)
	$(OC) $(OPTFLAGS) $(INCLUDE) -o main.opt $(FILES)
	
clean:
	rm -f *.o *.cmx *.cmi */*.o */*.cmx */*.cmi main main.*
