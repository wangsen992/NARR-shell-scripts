#!/bin/bash

if [ $# -eq 0 ]; then
	echo "List variables available  in the grib1 file."
	echo "Usage: wgribListVar filename [-s]"
	echo "options: -s short names only for extraction"
else
	SRC_NAME=$1
	if [ -f ${SRC_NAME} ]; then
		if [ $# -eq 1 ]; then
			wgrib -V ${SRC_NAME} | sed -n "/\[*\]/p" | sort | uniq
		else
			wgrib -V ${SRC_NAME} | sed -n "/\[*\]/p" | sort | uniq \
				| cut -d =  -f 1
		fi
	fi
fi
