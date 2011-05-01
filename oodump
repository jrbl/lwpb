#!/bin/sh
# A wrapper script for odt2txt.py, to establish essentially correct default 
# behavior.

pwd=`pwd`
filename=`echo $1 | sed -e 's/^\.\///'`
fileout=`echo $filename | sed -e 's/\.odt$//'`.txt

# TODO: trim .odt from input filename

echo -n "Dumping $pwd/$filename as $pwd/$fileout... "
odt2txt "$filename" > "$fileout"
echo "done."
