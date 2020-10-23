#!/bin/bash

SRC_NAME=$1
OUTPUT_DIR=$2

if [ ! -d $OUTPUT_DIR ]; then
	mkdir -p $OUTPUT_DIR
	echo "mkdir -p $OUTPUT_DIR"
fi
for VAR_NAME in $(list_var ${SRC_NAME} -s)
do
	echo "extracting $VAR_NAME"
	extract_var ${VAR_NAME} ${SRC_NAME} ${OUTPUT_DIR}
done
