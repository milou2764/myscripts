#!/bin/sh

myfile="$1"
fwoext="${myfile%.*}"
mydvi="$fwoext.dvi"

compile() {
	latex "$myfile"
}

show() {
	xdvi + -s 4 -rv -unique $mydvi
}

compile
show &
inotifywait -m -e close_write "$1" | 
   while read file_path file_event file_name; do 
	   echo ${file_path}${file_name} event: ${file_event}
	   compile
	   show
   done
