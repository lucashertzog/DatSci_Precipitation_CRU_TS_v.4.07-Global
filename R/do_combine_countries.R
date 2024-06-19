do_combine_countries <- function(
    dir
){
  foo <- list.files(path = "data_derived",
                    pattern = "\\.rds$",
                    full.names = TRUE)
  list_t <- list()
  
  for (file in foo) {
    temp_d <- readRDS(file)
    list_t[[length(list_t) + 1]] <- temp_d
  }
  
  merged <- rbindlist(list_t,
                      use.names = TRUE,
                      fill = TRUE)
  
  result <- merged[, .(value = mean(value, na.rm = TRUE)), by = .(adm0, adm1, adm2, date)]
  
  saveRDS(result, file = "data_derived/combined/cru.rds")
}
