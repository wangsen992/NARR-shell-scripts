#!/bin/bash

SRC_NAME=$1
OUTPUT_DIR=$2
ARGS=$3

if [ $# -eq 0 ]; then
  echo "Extract all varaibles into a directory containing single-var gribs"
  echo "Usage: extract_all_vars src_name output_dir"
else
  if [ ! -d $OUTPUT_DIR ]; then
    mkdir -p $OUTPUT_DIR
    echo "mkdir -p $OUTPUT_DIR"
  fi
  for VAR_NAME in $(list_var ${SRC_NAME} -s)
  do
    echo "extracting $VAR_NAME"
    if [  -z $ARGS ]; then
      extract_var ${VAR_NAME} ${SRC_NAME} ${OUTPUT_DIR}
    else
      extract_var ${VAR_NAME} ${SRC_NAME} ${OUTPUT_DIR} "${ARGS}"
    fi
  done
fi
