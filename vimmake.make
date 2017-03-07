#! /bin/bash
cd "$VIM_FILEDIR"
# if a Makefile exist in file directory, just make
if [ -f Makefile ]; then
    make
    exit 0
fi

if [ -f build/Makefile ]; then
    cd build;make
    exit 0
fi

# 
case "$VIM_FILEEXT" in
    \.c )
        echo -e "CC=gcc\nCFLAGS=-g -Wall" > Makefile
        echo "$VIM_FILENOEXT:$VIM_FILENAME" >> Makefile
        echo -e "\t\${CC} \${CFLAGS} \$^ -o \$@" >> Makefile
        make
        rm Makefile
        ;;
    \.cpp|\.cc|\.cxx)
        echo -e "CC=g++\nCFLAGS=-g -Wall" > Makefile
        echo "$VIM_FILENOEXT:$VIM_FILENAME" >> Makefile
        echo -e "\t\${CC} \${CFLAGS} \$^ -o \$@" >> Makefile
        make
        rm Makefile
        ;;
    *)
        echo "Not supported file."
        ;;
esac

# vim:ft=sh

