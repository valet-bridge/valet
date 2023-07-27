# This is the Valet Makefile for Windows and the Microsoft Visual C++
# compiler.  It assumes a Unix-like setup for some commands.

INCL_SOURCE	= Makefiles/sources.txt
INCL_DEPENDS	= Makefiles/depends_obj.txt

# If your Microsoft compiler is not called cl, change it here.
CC		= cl
LINK		= link

# We compile with aggressive warnings, but we have to turn off some
# of them as they appear in Windows libraries in great numbers...

WARN_FLAGS      =               \
        /Wall                   \
        /wd4365                 \
        /wd4464                 \
        /wd4514                 \
        /wd4555                 \
        /wd4571                 \
        /wd4623                 \
        /wd4625                 \
        /wd4626                 \
        /wd4668                 \
        /wd4710                 \
        /wd4711                 \
        /wd4774                 \
        /wd4820                 \
        /wd4996                 \
        /wd5026                 \
        /wd5027                 \
        /wd5045                 \
        /WX

COMPILE_FLAGS	= /O2 /Oi /Ot /Oy /Ox /GL /EHs /Zi /std:c++17 $(WARN_FLAGS)

LINK_FLAGS1	= /LTCG /DEBUG

LIB_FLAGS       = /link /DLL

DLLBASE         = valet
DLL             = $(DLLBASE).dll
DLIB            = $(DLLBASE).lib

VFILE           = valetres

LIB_FILES 	=		\
	$(VALET_FILES)		\
	vlib.cpp

DRIVER_FILES =			\
	driver.cpp              \
	dsupport.cpp		\
	vstrings.cpp

include $(INCL_SOURCE)

VOBJ_FILES 	= $(subst .cpp,.obj,$(VALET_FILES)) valet.obj
LOBJ_FILES 	= $(subst .cpp,.obj,$(LIB_FILES)) $(VFILE).obj
DOBJ_FILES 	= $(subst .cpp,.obj,$(DRIVER_FILES)) 

valet:	$(VOBJ_FILES)
	$(LINK) $(LINK_FLAGS1) $(VOBJ_FILES) /OUT:valet.exe

dll:	$(LOBJ_FILES)
	$(CC) $(CC_FULL_FLAGS) $(LOBJ_FILES) $(LIB_FLAGS) /out:$(DLL)

driver:	$(DOBJ_FILES)
	link /LTCG $(DOBJ_FILES) $(DLIB) /out:driver.exe

%.obj:	%.cpp
	$(CC) $(COMPILE_FLAGS) /c $< -Fo$@

$(DLLBASE).res:	$(DLLBASE).rc
	windres $(DLLBASE).rc $(DLLBASE).res

$(VFILE).obj:	$(DLLBASE).res
	cvtres /MACHINE:X64 /OUT:$(VFILE).obj $(DLLBASE).res

depend:
	makedepend -Y -o.obj -- $(CC_FLAGS) -- $(VALET_FILES) $(LIB_FILES) $(DRIVER_FILES)

clean:
	rm -f $(VOBJ_FILES) $(LOBJ_FILES) $(DOBJ_FILES) valet.exe driver.exe $(DLL) $(DLLBASE).{lib,exp,def,obj,res}

include $(INCL_DEPENDS)

# DO NOT DELETE
