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


test <- c(5,6,7,8,9,10,20,30,40,45,50,60,70,80,100)


for(i in 1:length(test)){
  cfg$title <- paste0("try15_",test[i])
  cfg$gms$s14_corr_fact <- as.character(test[i])
  cfg$output <- c("rds_report","validation","disaggregation","lsu_evaluation")
  cfg$gms$livestock <- "lvtk_aug20"                  # def = fbask_jan16, lvtk_aug20
#  cfg$recalibrate <- "TRUE"
  start_run(cfg=cfg,codeCheck=T)
}
