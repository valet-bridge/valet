# This is the Valet Makefile for Windows and the Microsoft Visual C++
# compiler.  It does assume a Unix-like setup for some commands,
# but if you only want to call "make" with the default target,
# you should be OK.

# If your Microsoft compiler is not called cl, change it here.
CC		= cl
CC_FLAGS     	= /O2 /Oi /Ot /Oy /GL

# These flags are not turned on by default, but Valet should pass them.
# Turn them on below.
WARN_FLAGS	=		\
	/W4			\
	/wd4127			\
	/wd4555			\
	/wd4668			\
	/wd4701			\
	/wd4710			\
	/wd4711			\
	/wd4820			\
	/wd4986			\
	/wd4987			\
	/wd4996			\
	/WX                     \
        /EHsc

# Here you can turn on warnings.
# CC_FULL_FLAGS	= $(CC_FLAGS)
CC_FULL_FLAGS	= $(CC_FLAGS) $(WARN_FLAGS)

SOURCE_FILES 	=		\
        valet.cpp               \
        args.cpp                \
        files.cpp               \
        parse.cpp               \
        scoring.cpp             \
        misc.cpp                \
        Pairs.cpp               \
        Hand.cpp                \
        Scores.cpp

OBJ_FILES 	= $(subst .cpp,.obj,$(SOURCE_FILES)) 


valet:	$(OBJ_FILES)
	$(CC) $(CC_FULL_FLAGS) $(OBJ_FILES)

%.obj:	%.cpp
	$(CC) $(CC_FULL_FLAGS) /c $<

depend:
	makedepend -Y -o.obj -- $(CC_FLAGS) -- $(SOURCE_FILES)

clean:
	rm -f $(OBJ_FILES) valet.exe


# DO NOT DELETE

valet.obj: cst.h args.h files.h scoring.h misc.h Pairs.h Hand.h Scores.h
args.obj: args.h cst.h
files.obj: files.h Pairs.h cst.h Hand.h parse.h
parse.obj: Pairs.h cst.h parse.h
scoring.obj: cst.h scoring.h
misc.obj: Pairs.h cst.h misc.h
Pairs.obj: cst.h Pairs.h
Hand.obj: cst.h Pairs.h Hand.h scoring.h
Scores.obj: Scores.h cst.h Pairs.h
