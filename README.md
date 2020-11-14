# Overview
A list of smiple shell functions making use of wgrib for NARR output, which is
in grib1 foramt

# Installation
## Basic Installation
Run `source bashrc` in the repo directory. The scripts should be available for
use in the current terminal session. Type `wgrib` and `Tab` for available
commands. 

Also, make sure use the script with the `environment.yml` satistfied. 

## Install to environments for long-term use
Refer to comments in `bashrc`. 


# Usage
wgribListVar: List  variables available in the grib1 file. 
wgribExtractVar: Extract single variable value from source file to target directory. 
wgribLoadVar.py: Load grib to xarray and save to new directory. 

Steps to convert a NARR file to netcdf of multiple variables:

	1. run `wgribListVar $FILENAME` to survey available variables
	2. run `wgribExtractAllVars $FILENAME $GRIB_DIR` to extract all variables into
		 separate grib files. 
	3. run `wgribLoadVar $GRIB_DIR $OUTPUT_DIR` to produce the final netcdf file to
		 be loaded directly from python xarray.  

# Examples
An example data is provided in the `data` directory. Here referred to as
`GRIB1_DATA`. 

To see a list of variables available in the grib file. 
`wgribListVar $GRIB1_DATA`

Extract a single variable to local directory as a grib file. 
`wgribExtractAllVars CDLYR $GRIB1_DATA .`

Extract all variables present in the grib file to `clm` directory. Create `clm`
if needed
`wgribExtractAllVars $GRIB1_DATA clm`

Combine created grib files in a directory to a netcdf file for loading. 
`wgribLoadVar clm .`


Note: 
For grib files with mixed level type or data type (reanalysis or forecast), `extract_all_vars` does not work well yet. Must enforce a single type to ensure the rest of the workflow. 

Reference: 

wgrib.c : https://www.cpc.ncep.noaa.gov/products/wesley/wgrib.html
