all: cube 

# This requires a: chicken-install opengl-glew glfw3 gl-utils gl-math glls hyperscene gl-type soil noise hypergiant
# To get hypergiant to build I had to manually link against all the object files from hyperscene
cube: cube.scm
	csc cube.scm -o cube
	# clang -I /usr/local/include/chicken/ -I/usr/local/Cellar/libepoxy/1.5.4_1/include  -L/usr/local/Cellar/libepoxy/1.5.4_1/lib/  -isystem  /usr/local/include/ -L /usr/local/lib/ -lchicken -lm -lepoxy cube.c -o cube
	# rm cube.c
	

particleGen: particleGen.scm
	csc  -cflags -I/usr/local/include -framework OpenGL particleGen.scm 
	clang -I /usr/local/include/chicken/ -I/usr/local/Cellar/libepoxy/1.5.4_1/include  -L/usr/local/Cellar/libepoxy/1.5.4_1/lib/  -isystem  /usr/local/include/ -L /usr/local/lib/ -lchicken -lm -lepoxy particleGen.c -o particleGen
	rm particleGen.c

clean:
	rm 	particleGen.c cube.c cube.o particleGen.o
		