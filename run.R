source("config.R")
library(targets)
tar_source()
load_packages(T)
tar_visnetwork(targets_only = T)
tar_make()

# useful
tar_invalidate()
tar_objects()
tar_load_everything()