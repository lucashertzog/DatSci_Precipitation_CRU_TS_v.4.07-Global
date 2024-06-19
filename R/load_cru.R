#' Title load_cru
#'
#' @param infile 
#'
#' @return r_rast_out
#' @examples
# indir_spei <- "data_provided"
# infile <- file.path(indir_cru, "cru_ts4.07.1901.2022.pre.dat.nc")
load_cru <- function(infile){
  
  # r_nc <- nc_open(infile)
  # r_nc
  # varlist <- names(r_nc[['var']])
  # varlist
  # nc_close(infile)
  r_rast <- raster::brick(infile, varname = "pre")
  # str(r_rast)
  # r <- r_rast[[which(getZ(r_rast) >= as.Date("2022-12-01") & getZ(r_rast) < as.Date("2022-12-31"))]]
  # plot(r)
  r_rast_out <- terra::rast(r_rast)
  r_rast_out <- terra::wrap(r_rast_out)
  return(r_rast_out)
}



