## sudo apt-get install libsdl2-dev
## sudo apt-get install libsdl2-image-dev

## definitions

CC = g++
SDL_LIB = -L/usr/local/lib -lSDL2 -lSDL2_image -Wl,-rpath=/usr/local/lib
SDL_INCLUDE = -I/usr/local/include
CCFLAGS = -std=c++11 -Wall $(SDL_INCLUDE)
LDFLAGS = $(SDL_LIB)
OBJS1 = main.o Game.o

## targets and prerequisites
.PHONY : all
all : install main
main : $(OBJS1)
	$(CC) $^ $(LDFLAGS) -o $@

# default rule for compiling .cc to .o
%.o: %.cc                               ## next line must begin with a TAB
	$(CC) -c $(CCFLAGS) $< -o $@

## generate the prerequistes and append to the desired file
.prereq : $(OBJS1:.o=.cc) $(wildcard *.h) Makefile
	rm -f .prereq
	$(CC) $(CCFLAGS) -MM $(OBJS1:.o=.cc)>> ./.prereq 

## include the generated prerequisite file
include .prereq

.PHONY : clean
clean :                 ## next lines must begin with a TAB
	rm -f *.o
	rm -f *~ *# .#*

.PHONY : clean-all
clean-all : clean      ## next line must begin with a TAB
	rm -f main

install:
ifeq ($(shell lsb_release -si), Ubuntu)
	sudo apt-get install libsdl2-dev libsdl2-image-dev
else 
	sudo yum install SDL2-devel SDL2_image
endif
