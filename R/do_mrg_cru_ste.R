#' Title do_mrg_cru_ste
#'
#' @param in_cru 
#' @param in_ste 
#'
#' @return e_out
#' @examples
# tar_load(dat_cru)
# tar_load(dat_ste)
do_mrg_cru_ste <- function(
    in_cru = dat_cru
    , 
    # tar_load(dat_ste_Zimbabwe)
    #in_ste = dat_ste_Zimbabwe
    in_ste = dat_ste
    ,
    date_range = NULL
    ,
    country_name
){
  r_cru <- rast(in_cru)
  time_cru <- as.character(terra::time(r_cru))
  names(r_cru) <- paste0("X", time_cru)
  e <- exactextractr::exact_extract(r_cru, in_ste, fun = 'mean')
  
  e2 <- cbind(st_drop_geometry(in_ste), e)
  setDT(e2)
  #paste(names(in_ste), collapse = "','", sep = "")
  # e_out <- melt(e2, id.var = c('ID_0','COUNTRY','ID_1','NAME_1','VARNAME_1','NL_NAME_1','TYPE_1','ENGTYPE_1','CC_1','HASC_1','ISO_1', 'ID'))
  
  # id_vars <- c('UID','GID_0','NAME_0','VARNAME_0',
  #              'GID_1','NAME_1','VARNAME_1','NL_NAME_1','ISO_1','HASC_1','CC_1','TYPE_1','ENGTYPE_1','VALIDFR_1',
  #              'GID_2','NAME_2','VARNAME_2','NL_NAME_2','HASC_2','CC_2','TYPE_2','ENGTYPE_2','VALIDFR_2',
  #              'GID_3','NAME_3','VARNAME_3','NL_NAME_3','HASC_3','CC_3','TYPE_3','ENGTYPE_3','VALIDFR_3',
  #              'GID_4','NAME_4','VARNAME_4','CC_4','TYPE_4','ENGTYPE_4','VALIDFR_4',
  #              'GID_5','NAME_5','CC_5','TYPE_5','ENGTYPE_5',
  #              'GOVERNEDBY','SOVEREIGN','DISPUTEDBY','REGION','VARREGION','COUNTRY', "CONTINENT", "SUBCONT"
  # )
  
  id_vars <- c("adm0", "adm1", "adm2"
               # , "adm3"
  )
  
  e_out <- melt(e2, id.vars = id_vars)
  
  e_out$date <- gsub("mean.X", "", gsub("\\.", ".", e_out$variable))
  
  e_out$date <- as.Date(e_out$date)
  
  # date range if specified
  if (!is.null(date_range) && length(date_range) == 2) {
    start_date <- as.Date(date_range[1])
    end_date <- as.Date(date_range[2])
    e_out <- e_out[date >= start_date & date <= end_date]
  }
  file_name <- paste0("data_derived/cru_", country_name, ".rds")
  saveRDS(e_out, file = file_name)
  return(e_out)
}