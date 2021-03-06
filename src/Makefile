# This is the Valet Makefile for Windows and the Microsoft Visual C++
# compiler.  It does assume a Unix-like setup for some commands,
# but if you only want to call "make" with the default target,
# you should be OK.

# If your Microsoft compiler is not called cl, change it here.
CC		= cl
# CC_FLAGS     	= /O2 /Oi /Ot /Oy /GL /Zi /EHsc
CC_FLAGS     	= /Ox /GL /Zi /EHsc

CC_LINK		= /LTCG /DEBUG /OPT:REF,ICF

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

LIB_FLAGS       = /link /DLL

DLLBASE         = valet
DLL             = $(DLLBASE).dll
DLIB            = $(DLLBASE).lib

VFILE           = valetres

VALET_FILES	=		\
	args.cpp                \
	files.cpp               \
        Hand.cpp		\
        misc.cpp                \
        Pairs.cpp               \
        parse.cpp               \
	Scores.cpp		\
        scoring.cpp             \
	valet.cpp

LIB_FILES 	=		\
        Hand.cpp		\
        Pairs.cpp               \
        parse.cpp               \
        scoring.cpp             \
	vlib.cpp

DRIVER_FILES =			\
	driver.cpp              \
	dsupport.cpp

VOBJ_FILES 	= $(subst .cpp,.obj,$(VALET_FILES)) 
LOBJ_FILES 	= $(subst .cpp,.obj,$(LIB_FILES)) $(VFILE).obj
DOBJ_FILES 	= $(subst .cpp,.obj,$(DRIVER_FILES)) 

valet:	$(VOBJ_FILES)
	$(CC) $(CC_FULL_FLAGS) $(VOBJ_FILES) /Fevalet.exe

dll:	$(LOBJ_FILES)
	$(CC) $(CC_FULL_FLAGS) $(LOBJ_FILES) $(LIB_FLAGS) /out:$(DLL)

driver:	$(DOBJ_FILES)
	link $(CC_LINK) $(DOBJ_FILES) $(DLIB) /out:driver.exe

%.obj:	%.cpp
	$(CC) $(CC_FULL_FLAGS) /c $<

$(DLLBASE).res:	$(DLLBASE).rc
	windres $(DLLBASE).rc $(DLLBASE).res

$(VFILE).obj:	$(DLLBASE).res
	cvtres /MACHINE:X86 /OUT:$(VFILE).obj $(DLLBASE).res

depend:
	makedepend -Y -o.obj -- $(CC_FLAGS) -- $(VALET_FILES) $(LIB_FILES) $(DRIVER_FILES)

clean:
	rm -f $(VOBJ_FILES) $(LOBJ_FILES) $(DOBJ_FILES) valet.exe driver.exe $(DLL) $(DLLBASE).{lib,exp,def,obj,res}


# DO NOT DELETE

args.obj: args.h cst.h
files.obj: files.h Pairs.h cst.h Hand.h parse.h valet.h
Hand.obj: valet.h Pairs.h cst.h Hand.h scoring.h
misc.obj: Pairs.h cst.h misc.h
Pairs.obj: Pairs.h cst.h
parse.obj: Pairs.h cst.h parse.h valet.h
Scores.obj: Scores.h cst.h Pairs.h
scoring.obj: valet.h cst.h scoring.h
valet.obj: cst.h args.h files.h scoring.h misc.h Pairs.h Hand.h Scores.h
Hand.obj: valet.h Pairs.h cst.h Hand.h scoring.h
Pairs.obj: Pairs.h cst.h
parse.obj: Pairs.h cst.h parse.h valet.h
scoring.obj: valet.h cst.h scoring.h
vlib.obj: valet.h parse.h cst.h scoring.h Pairs.h Hand.h
driver.obj: valet.h dsupport.h
dsupport.obj: valet.h dsupport.h
