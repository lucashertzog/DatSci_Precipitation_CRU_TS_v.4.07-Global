# select date range
date_range <- c("1901-01-01", "2022-12-31")
# select countries
countries_list <- c(
  "Botswana",
  "Cambodia", 
  "Colombia",
  "Côte d'Ivoire",
  "El Salvador",
  "Kenya",
  "Lesotho",
  "Malawi",
  "Moldova",
  "Mozambique",
  "Namibia",
  "Nigeria",
  "Rwanda",
  "Eswatini",
  "Uganda",
  "Zambia",
  "Zimbabwe"
)

if(!dir.exists("figures_and_tables")) dir.create("figures_and_tables")
if(!dir.exists("data_derived")) dir.create("data_derived")
if(!dir.exists("data_provided")) dir.create("data_provided")
if(!dir.exists("R")) dir.create("R")
if(!file.exists("run.R")) file.create("run.R")
if(!file.exists("_targets.R")) file.create("_targets.R")
if(!file.exists("R/load_packages.R")) file.create("R/load_packages.R")

  # hostname solution for multiple-user config.R
  hostname <- Sys.info()["nodename"]

if (hostname == "C-A0055162" || hostname == "C-A0063844") {
  indir_cru <- "data_provided"
  indir_ste <- "data_provided"
  infile_ste = file.path(indir_ste, "vacs_adm3_clean.gpkg")
} else if (hostname == "u-a0053509") {
  indir_spei <- "../Research_DATA/Drought_SPEI_CSIC_global_drought_monitor_1950_2023"
  indir_ste <- "../Research_DATA/GADM_Global_Administrative_Areas/data_provided/"
} else if (hostname == "C-A0062972") {
  # Ivan to add his other host dirs
  stop("Hostname C-A0062972 recognised, but specific directories are not configured. Please add configurations for this machine.")
} else {
  stop("Hostname not recognised. Please add a configuration for this machine.")
}
