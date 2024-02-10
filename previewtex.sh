#!/bin/sh

myfile="$1"
fwoext="${myfile%.*}"
mydvi="$fwoext.dvi"

compile() {
	latex "$myfile"
}

compile_and_show() {
	compile
	xdvi -unique $mydvi
}

compile
xdvi -unique $mydvi &
inotifywait -m -e close_write "$1" | 
   while read file_path file_event file_name; do 
	   echo ${file_path}${file_name} event: ${file_event}
	   compile_and_show
   done
