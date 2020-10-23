#!/bin/bash

OUTPUT_DIR='output'

extract_var (){
    local SRC_NAME=$1
    local VAR_NAME=$2
    local ARGS=$3
    local OUTPUT_DIR=$4
    echo "ARGS is :$ARGS"
    if [ -f ${SRC_NAME} ]; then
            echo "Extracting variable ${VAR_NAME} from file ${SRC_NAME}..."
            wgrib -s ${SRC_NAME} | \
              grep ":${VAR_NAME}:${ARGS}" | \
              wgrib -i -grib ${SRC_NAME} -o "${OUTPUT_DIR}/${VAR_NAME}.grib"

            echo "Completed. Output to ${OUTPUT_DIR}/${VAR_NAME}.grib"
    else
            echo "Something went wrong.."
    fi

    }

list_var () {
    local SRC_NAME=$1
    echo "If file is large, it could take a while...Be Patient." >> /dev/stderr
    if [ -f ${SRC_NAME} ]; then
        wgrib -V ${SRC_NAME} | sed -n "/\[*\]/p" | sort | uniq
    fi
}


