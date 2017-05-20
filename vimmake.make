#! /bin/bash
cd "$VIM_FILEDIR"

# if a Makefile exist in file directory, just make
if [ -f Makefile ]; then
    make
    exit 0
fi

if [ -f $VIM_CWD/Makefile ]; then
    cd $VIM_CWD;make
    exit 0
fi

# 
case "$VIM_FILEEXT" in
    \.c )
        cat <<EOF > Makefile
CC=gcc
CFLAGS=-g -Wall
$VIM_FILENOEXT:$VIM_FILENAME
	\${CC} \${CFLAGS} -o \$@ \$^
EOF
        make
        rm Makefile
        ;;
    \.cpp|\.cc|\.cxx)
        cat <<EOF > Makefile
CC=g++
CFLAGS=-g -Wall -std=c++14
$VIM_FILENOEXT:$VIM_FILENAME
	\${CC} \${CFLAGS} -o \$@ \$^
EOF
        make
        rm Makefile
        ;;
    *)
        echo "Not supported file."
        ;;
esac

# vim:ft=sh

