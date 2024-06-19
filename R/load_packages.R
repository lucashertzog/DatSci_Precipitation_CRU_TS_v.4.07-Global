#' Title load_packages
#'
#' @param do_it 
#'
#' @return nothing
load_packages <- function(do_it = F){
  if(!require('visNetwork')) install.packages('visNetwork'); library(visNetwork)
  if(!require('targets')) install.packages('targets'); library(targets)
  if(!require('ncdf4')) install.packages('ncdf4'); library(ncdf4)
  if(!require('sf')) install.packages('sf'); library(sf)
  if(!require('data.table')) install.packages('data.table'); library(data.table)
  if(!require('raster')) install.packages('raster'); library(raster)
  if(!require('terra')) install.packages('terra'); library(terra)
  if(!require('exactextractr')) install.packages('exactextractr'); library(exactextractr)
  
}
