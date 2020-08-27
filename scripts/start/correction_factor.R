# |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de


######################################
#### Script to start a MAgPIE run ####
######################################

library(lucode)
source("scripts/start_functions.R")
source("config/default.cfg")


test <- c(4,10,45,100)
test <- c(5)

for(i in 1:length(test)){
  cfg$title <- paste0("lvtk_aug20_output_script",test[i])
  cfg$gms$s14_corr_fact <- as.character(test[i])
  cfg$gms$c_timesteps <- "1"
  cfg$output <- c("disaggregation","lsu_evaluation")
#  cfg$recalibrate <- "TRUE"
  start_run(cfg=cfg,codeCheck=T)
}
