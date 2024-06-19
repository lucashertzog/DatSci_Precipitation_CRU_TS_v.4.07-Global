library(targets)
library(tarchetypes)
source("config.R")
tar_source()

tar_option_set(
  packages = c("data.table", "ncdf4", "raster", "terra", "sf", "exactextractr"),
  format = "rds"
)


# Targets list with dynamic branching for processing different countries
list(
  # Static target for loading global data
  tar_target(
    dat_cru,
    load_cru(
      infile = file.path(indir_cru, "cru_ts4.07.1901.2022.pre.dat.nc")
    )
  )
  ,

  # Dynamic branching over countries for shapefile
  tar_map(
    values = data.frame(country = countries_list, stringsAsFactors = FALSE),
    tar_target(
      dat_ste,
      load_ste(
        infile_ste = file.path(indir_ste, "vacs_adm3_clean.gpkg"),
        # levels = admin_levels,
        countries = country
      )
    )
    ,
    tar_target(
      dat_mrg_cru_ste,
      do_mrg_cru_ste(
        in_cru = dat_cru,
        in_ste = dat_ste,
        date_range = date_range,
        country_name = country)
    )
  )
)


# Replace the target list below with your own:
# list(
#   #### dat_cru ####
#   tar_target(dat_cru,
#              load_cru(infile = file.path(indir_cru, "cru06.nc"))
#   )
#   ,
#   ### dat_ste ####
#   tar_target(dat_ste,
#              load_ste(
#                infile_ste = file.path(indir_ste, "gadm404-levels.gpkg"),
#                levels = admin,
#                countries = countries
#                )
#              )
#   ,
#   #### dat_mrg_cru_ste ####
#   tar_target(dat_mrg_cru_ste,
#              do_mrg_cru_ste(in_cru = dat_cru,
#                              in_ste = dat_ste,
#                              date_range = dates
#                              )
#              )
# ,
# #### fig_ts_plot ####
# tar_target(fig_ts_plot,
#            do_fig_ts_plot(indat = dat_mrg_cru_ste
#                           ,
#                           outfile = "figures_and_tables/fig_ts_plot.png"
#                           )
#            )
# ,
# #### fig_map ####
# tar_target(fig_map,
#            do_fig_map(indat = dat_cru
#                       ,
#                       outfile = "figures_and_tables/cru06_20191201.tif"
#                       )
#            )
# )
