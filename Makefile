# Linux makefile for FreeImage

# This file can be generated by ./gensrclist.sh
include Makefile.srcs

# General configuration variables:
CC = gcc
CPP = g++
AR = ar

INSTALLDIR = /usr/lib

# Converts cr/lf to just lf
DOS2UNIX = dos2unix

COMPILERFLAGS = -O3
LIBRARIES = -lstdc++

MODULES = $(SRCS:.c=.o)
MODULES := $(MODULES:.cpp=.o)
CFLAGS = $(COMPILERFLAGS) $(INCLUDE)
CPPFLAGS = $(COMPILERFLAGS)  -Wno-ctor-dtor-privacy $(INCLUDE)

TARGET  = freeimage
STATICLIB = lib$(TARGET).a
SHAREDLIB = lib$(TARGET)-$(VER_MAJOR).$(VER_MINOR).so
LIBNAME = lib$(TARGET).so.$(VER_MAJOR)



default: all

all: dist

dist: FreeImage
	cp *.a Dist
	cp *.so Dist
	cp Source/FreeImage.h Dist

dos2unix:
	@$(DOS2UNIX) $(SRCS) $(INCLS)

FreeImage: $(STATICLIB) $(SHAREDLIB)

.c.o:
	$(CC) $(CFLAGS) -c $< -o $@

.cpp.o:
	$(CPP) $(CPPFLAGS) -c $< -o $@

$(STATICLIB): $(MODULES)
	$(AR) r $@ $(MODULES)

$(SHAREDLIB): $(MODULES)
	$(CC) -s -shared -Wl,-soname,$(LIBNAME) -o $@ $(MODULES) $(LIBRARIES)

install:
	install -m 644 -o root -g root $(STATICLIB) $(INSTALLDIR)
	install -m 755 -o root -g root $(SHAREDLIB) $(INSTALLDIR)
	ln -sf $(SHAREDLIB) $(INSTALLDIR)/$(LIBNAME)
	ldconfig

clean:
	rm -f core Dist/*.* u2dtmp* $(MODULES) $(STATICLIB) $(SHAREDLIB) $(LIBNAME)

osx:
	make -f Makefile.osx

osxinstall:
	make -f Makefile.osx install
