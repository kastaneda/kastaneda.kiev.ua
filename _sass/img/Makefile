grid_sizes = 18 20 22 24
objects = $(patsubst %,grid-bg-%px.sass,$(grid_sizes))

all: $(objects)

grid-bg-%px.sass: grid-bg-%px.png
	php line.php $< > $@