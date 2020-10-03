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


#test <- c(0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1)
test <- c(1)


for(i in 1:length(test)){
  cfg$title <- paste0("mow19.6_",test[i])
  cfg$gms$s70_dist_fact <- as.character(test[i])
  cfg$output <- c("rds_report","lsu_evaluation","validation","disaggregation")
  cfg$gms$livestock <- "lvtk_aug20"           # def = fbask_jan16, lvtk_aug20
  #cfg$gms$disagg_lvst <- "off"           # def = fbask_jan16, lvtk_aug20
  cfg$gms$yields <- "dynamic_aug20"           # def = dynamic_aug18,dynamic_aug20
  cfg$gms$past <- "develop_set20"             # def = endo_jun13
  cfg$gms$s31_fac_req_past  <- 0
  cfg$gms$c_timesteps <- "coup2100"           # "coup2100"
#  cfg$recalibrate <- "TRUE"
  start_run(cfg=cfg,codeCheck=F)
}
