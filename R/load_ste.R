load_ste <- function(
    infile_ste, 
    countries = NULL
){
  
  # Load shapefile
  shp_sf <- st_read(infile_ste, layer = "vacs_adm3_clean")
  
  # Convert to data.table for any further operations if necessary
  shpdt <- setDT(shp_sf)[, adm3 := NULL]
  
  # Filter by countries if the countries parameter is provided
  if (!is.null(countries)) {
    shpdt <- shpdt[adm0 %in% countries, ]
  }
  
  # Convert back to sf object
  shp_sf <- st_as_sf(shpdt, sf_column_name = "geom")
  
  return(shp_sf)
}