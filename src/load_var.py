#!$HOME/.conda/envs/cfog/bin/python
"""Load grib vars from extract_all_vars to xarray"""

import sys
import xarray as xr
from pathlib import Path

def combine_grib_vars_to_xr(grib_dir : Path, 
                            output_dir : Path):
    fname = grib_dir.parts[-1] + '.nc'
    xr_fpath = output_dir / fname
    if xr_fpath.exists():
        raise ValueError(f"{xr_fpath} already exists.")
    ds_dict = {}
    for f in grib_dir.iterdir():
        if f.suffix == '.grib':
            try:
                var_name = f.name.split('.')[0]
                ds_dict[var_name] = xr.load_dataarray(f, engine='cfgrib').rename(var_name)
            except :
                print("DatasetBuildError on ", f)
    # additinal loading just to load the attributes information
    ds = xr.Dataset(ds_dict)
    ds.to_netcdf(xr_fpath)

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Combine grib files in a directory to one single netcdf file.")
        print("Usage: load_var src_dir output_dir")
    else:
        grib_dir = Path(sys.argv[1])
        output_dir = Path(sys.argv[2])
        combine_grib_vars_to_xr(grib_dir, output_dir)
