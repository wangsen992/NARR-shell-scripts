#!/bin/bash

if [ $# -eq 0 ]; then
	echo "Convient function to extract variables to an xarray loadable grib file"
	echo "Usage: extract_var variable-short-name filename  output-dir [args] "
	echo "Arguments:"
	echo "=========="
	echo "filename : you know what"
	echo "variable-short-name: Capitalized abbreviation. E.g. TKE for turbulent kintetic energy" 
	echo "output-dir: output directory for the file."
	echo "args(optional): arguments used for slicing the entry."
else
	VAR_NAME=$1
	SRC_NAME=$2
	OUTPUT_DIR=$3
	ARGS=$4

	echo "ARGS is :$ARGS"
	if [ -f ${OUTPUT_DIR}/${VAR_NAME}.grib ]; then
		echo "File Present. Append"
		WGRIB_FLAG=-append
	fi
	if [ -f ${SRC_NAME} ]; then
		echo "Extracting variable ${VAR_NAME} from file ${SRC_NAME}..."
		wgrib -s ${SRC_NAME} | \
			grep "${VAR_NAME}" | \
			grep "${ARGS}" | \
			wgrib -i -grib ${SRC_NAME} ${WGRIB_FLAG} -o "${OUTPUT_DIR}/${VAR_NAME}.grib"

		echo "Completed. Output to ${OUTPUT_DIR}/${VAR_NAME}.grib"
	else
					echo "Something went wrong.."
	fi
fi
