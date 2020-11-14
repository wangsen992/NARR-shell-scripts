#!/bin/bash

if [ $# -eq 0 ];  then
    echo "One stop to produce all loadable files"
    echo "wgribProcessTar tar_file output_dir"
else
    TAR_FILE=$1
    OUTPUT_DIR=$2
    mkdir -p tar_tmp
    if [ ! -d $OUTPUT_DIR ]; then
        mkdir -p ${OUTPUT_DIR}
    fi
    tar xvf ${TAR_FILE} -C tar_tmp
    
    for KEY in 3D clm pbl
    do
        # iterate over all 3D files
        for FILE in $(ls tar_tmp/NARR${KEY}*)
        do
            wgribExtractAllVars ${FILE} ${OUTPUT_DIR}/${KEY}
            echo "wgribExtractAllVars ${FILE} ${OUTPUT_DIR}/${KEY}"
        done
        load_var ${OUTPUT_DIR}/${KEY} ${OUTPUT_DIR}/
        rm -r ${OUTPUT_DIR}/${KEY}
    done

    for KEY in flx sfc
    do
        # iterate over all 3D files
        for FILE in $(ls tar_tmp/NARR${KEY}*)
        do
            wgribExtractAllVars ${FILE} ${OUTPUT_DIR}/${KEY}
            echo "wgribExtractAllVars ${FILE} ${OUTPUT_DIR}/${KEY}"
        done
    done
    rm -r tar_tmp
fi

