A list of smiple shell functions making use of wgrib

list_var: List  variables available in the grib1 file. 
extract_var: Extract single variable value from source file to target directory. 
load_var.py: Load grib to xarray and save to new directory. 

Steps to convert a NARR file to netcdf of multiple variables:

	1. run `list_var $FILENAME` to survey available variables
	2. run `extract_all_vars $FILENAME $GRIB_DIR` to extract all variables into
		 separate grib files. 
	3. run `load_var $GRIB_DIR $OUTPUT_DIR` to produce the final netcdf file to
		 be loaded directly from python xarray.  

Note: 
Currently there is no one-liner to extract all variables at the same time. Use
a custom bash script for each project then. 
