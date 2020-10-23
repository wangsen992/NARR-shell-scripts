#!/bin/bash

# wgrib script related envs
export WGRIB_SCRIPT_ROOT=$(pwd)
export WGRIB_SCRIPT_SRC=${WGRIB_SCRIPT_SRC}/src
export WGRIB_SCRIPT_BIN=${WGRIB_SCRIPT_ROOT}/bin
export PATH=$WGRIB_SCRIPT_BIN:$PATH

if [ ! -f $WGRIB_SCRIPT_BIN/wgrib ]; then
	${CC} $WGRIB_SCRIPT_SRC/wgrib.c -o $WGRIB_SCRIPT_BIN/wgrib
	chmod 755 $WGRIB_SCRIPT_BIN/wgrib
fi

for BASH_SCRIPT in list_var extract_var extract_all_vars
do
	ln -s $WGRIB_SCRIPT_SRC/$BASH_SCRIPT.sh $WGRIB_SCRIPT_BIN/$BASH_SCRIPT
done

alias load_var="python $WGRIB_SCRIPT_SRC/load_var.py"

# data related envs
export DATA_PATH=$WORKSPACE/Projects/wgrib-workflow/data
export WGRIB_TAR_PATH=${DATA_PATH}/tar_files
export WGRIB_TMP1_PATH=${DATA_PATH}/tmp1_grib
export WGRIB_TMP2_PATH=${DATA_PATH}/tmp2_grib
export WGRIB_OUTPUT_PATH=${DATA_PATH}/output_grib
