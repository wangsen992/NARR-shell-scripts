#!/bin/bash

CC=gcc

# wgrib script related envs
if [[ -z "${WGRIB_SCRIPT_ROOT}" ]]; then
  export WGRIB_SCRIPT_ROOT=$(pwd)
fi
export WGRIB_SCRIPT_SRC=${WGRIB_SCRIPT_ROOT}/src
export WGRIB_SCRIPT_BIN=${WGRIB_SCRIPT_ROOT}/bin #change if needed
if [ ! -d ${WGRIB_SCRIPT_BIN} ]; then
  mkdir -p ${WGRIB_SCRIPT_BIN}
fi
export PATH=$WGRIB_SCRIPT_BIN:$PATH

if [ ! -f $WGRIB_SCRIPT_BIN/wgrib ]; then
	${CC} $WGRIB_SCRIPT_SRC/wgrib.c -o $WGRIB_SCRIPT_BIN/wgrib
	chmod 755 $WGRIB_SCRIPT_BIN/wgrib
fi

for BASH_SCRIPT in list_var extract_var extract_all_vars process_tar
do
  chmod 755 $WGRIB_SCRIPT_SRC/$BASH_SCRIPT.sh
	ln -s $WGRIB_SCRIPT_SRC/$BASH_SCRIPT.sh $WGRIB_SCRIPT_BIN/$BASH_SCRIPT
done

chmod 755 $WGRIB_SCRIPT_SRC/"load_var.py"
ln -s $WGRIB_SCRIPT_SRC/"load_var.py" $WGRIB_SCRIPT_BIN/"load_var"

chmod 755 $WGRIB_SCRIPT_SRC/"rdams_client.py"
ln -s $WGRIB_SCRIPT_SRC/"rdams_client.py" $WGRIB_SCRIPT_BIN/"rdams"

# data related envs
export DATA_PATH=$WORKSPACE/Projects/wgrib-workflow/data
export WGRIB_TAR_PATH=${DATA_PATH}/tar_files
export WGRIB_TMP1_PATH=${DATA_PATH}/tmp1_grib
export WGRIB_TMP2_PATH=${DATA_PATH}/tmp2_grib
export WGRIB_OUTPUT_PATH=${DATA_PATH}/output_grib
