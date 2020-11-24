grid_sizes = 18 20 22 24
objects = $(patsubst %,line-height-%px.sass,$(grid_sizes))

all: $(objects)

line-height-%px.sass: line-height-%px.png
	php line.php $< > $@