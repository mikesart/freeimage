#!/bin/bash

DIRLIST=". Source Source/Metadata Source/FreeImageToolkit Source/Threads Source/LibJPEG Source/LibPNG Source/LibTIFF4 Source/ZLib Source/LibOpenJPEG Source/OpenEXR Source/OpenEXR/Half Source/OpenEXR/Iex Source/OpenEXR/IlmImf Source/OpenEXR/IlmThread Source/OpenEXR/Imath Source/OpenEXR/IexMath"

echo "VER_MAJOR = 3" > Makefile.srcs
echo "VER_MINOR = 18.0" >> Makefile.srcs

echo -e "\nSRCS = \n" >> Makefile.srcs
for DIR in $DIRLIST; do
	VCPRJS=`echo $DIR/*.2013.vcxproj`
	if [ "$VCPRJS" != "$DIR/*.2013.vcxproj" ]; then
		echo -e "# $DIR" >> Makefile.srcs
		echo -n "SRCS += " >> Makefile.srcs
		egrep 'ClCompile Include=.*\.(c|cpp)' $DIR/*.2013.vcxproj | cut -d'"' -f2 | tr '\\' '/' | awk '{print "'$DIR'/"$0}' | tr '\r\n' '  ' | tr -s ' ' >> Makefile.srcs
		echo -e "\n" >> Makefile.srcs
	fi
done
echo >> Makefile.srcs

echo -e "INCLS = \n" >> Makefile.srcs
for DIR in $DIRLIST; do
	VCPRJS=`echo $DIR/*.2013.vcxproj`
	if [ "$VCPRJS" != "$DIR/*.2013.vcxproj" ]; then
		echo -e "# $DIR" >> Makefile.srcs
		echo -n "INCLS += " >> Makefile.srcs
		egrep 'ClInclude Include=.*\.(h)' $DIR/*.2013.vcxproj | cut -d'"' -f2 | tr '\\' '/' | awk '{print "'$DIR'/"$0}' | tr '\r\n' '  ' | tr -s ' ' >> Makefile.srcs
		echo -e "\n" >> Makefile.srcs
	fi
done
echo >> Makefile.srcs

#echo -e "INCLS = \\" >> Makefile.srcs
#find . -name "*.h" -print | xargs -I{} echo "    {} \\" >> Makefile.srcs
#echo -e "\n" >> Makefile.srcs

echo -e "INCLUDE = \\" >> Makefile.srcs
for DIR in $DIRLIST; do
	echo "    -I$DIR \\" >> Makefile.srcs
done
echo -e "\n" >> Makefile.srcs

