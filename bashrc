#!/bin/bash

# Note
# If you want to install the sripts for long-term usage, set WGRIB_SCRIPT_BIN
# to a environment path such as $CONDABIN or add the default path to PATH in
# .bashrc file. The default behaviour is to create a bin directory in the
# current folder, and then add the bin to PATH. Therefore, if a new terminal is
# opened with refresh settings, you will need to source it again. 

CC=gcc

# wgrib script related envs
if [[ -z "${WGRIB_SCRIPT_ROOT}" ]]; then
  export WGRIB_SCRIPT_ROOT=$(pwd)
fi
export WGRIB_SCRIPT_SRC=${WGRIB_SCRIPT_ROOT}/src

# set bin path for executables
if [[ -z "${WGRIB_SCRIPT_BIN}" ]]; then
	export WGRIB_SCRIPT_BIN=${WGRIB_SCRIPT_ROOT}/bin #change if needed
fi
if [ ! -d ${WGRIB_SCRIPT_BIN} ]; then
  mkdir -p ${WGRIB_SCRIPT_BIN}
fi
export PATH=$WGRIB_SCRIPT_BIN:$PATH

if [ ! -f $WGRIB_SCRIPT_BIN/wgrib ]; then
	${CC} $WGRIB_SCRIPT_SRC/wgrib.c -o $WGRIB_SCRIPT_BIN/wgrib
	chmod 755 $WGRIB_SCRIPT_BIN/wgrib
fi

for BASH_SCRIPT in wgribListVar wgribExtractVar wgribExtractAllVars wgribProcessTar
do
  chmod 755 $WGRIB_SCRIPT_SRC/$BASH_SCRIPT.sh
	ln -s $WGRIB_SCRIPT_SRC/$BASH_SCRIPT.sh $WGRIB_SCRIPT_BIN/$BASH_SCRIPT
done

chmod 755 $WGRIB_SCRIPT_SRC/"wgribLoadVar.py"
ln -s $WGRIB_SCRIPT_SRC/"wgribLoadVar.py" $WGRIB_SCRIPT_BIN/"wgribLoadVar"

chmod 755 $WGRIB_SCRIPT_SRC/"rdams_client.py"
ln -s $WGRIB_SCRIPT_SRC/"rdams_client.py" $WGRIB_SCRIPT_BIN/"rdams"

# data related envs
# NOTE: Those envs are not used
export DATA_PATH=$WORKSPACE/Projects/wgrib-workflow/data
export WGRIB_TAR_PATH=${DATA_PATH}/tar_files
export WGRIB_TMP1_PATH=${DATA_PATH}/tmp1_grib
export WGRIB_TMP2_PATH=${DATA_PATH}/tmp2_grib
export WGRIB_OUTPUT_PATH=${DATA_PATH}/output_grib
