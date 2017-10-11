## definitions

CC = g++
SDL_LIB = -L/usr/local/lib -lSDL2 -Wl,-rpath=/usr/local/lib
SDL_INCLUDE = -I/usr/local/include
CCFLAGS = -std=c++11 -Wall $(SDL_INCLUDE)
LDFLAGS = $(SDL_LIB)
OBJS1 = main.o 

## targets and prerequisites
.PHONY : all
all : main
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
