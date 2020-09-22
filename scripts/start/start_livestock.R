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


test <- c(1,2,3,4,5,6,7,8,9,10)


for(i in 1:length(test)){
  cfg$title <- paste0("try56_",test[i])
  cfg$gms$s14_corr_fact <- as.character(test[i])
  cfg$output <- c("rds_report","lsu_evaluation","validation","disaggregation")
  #cfg$output <- c("lsu_evaluation")
  cfg$gms$livestock <- "fbask_jan16"                  # def = fbask_jan16, lvtk_aug20
  cfg$gms$yields <- "dynpast_aug20"          # def = dynamic_aug18
  cfg$gms$s31_fac_req_past  <- 0
  cfg$gms$c_timesteps <- "coup2100"                 # "coup2100"
#  cfg$recalibrate <- "TRUE"
  start_run(cfg=cfg,codeCheck=F)
}
