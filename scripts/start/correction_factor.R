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


test <- c(1,5,10,20,30,40,45,50,60,70,80,90,100)

for(i in 1:length(test)){
  cfg$title <- paste0("basic_run",test[i])
  cfg$gms$s14_corr_fact <- test[i]
  start_run(cfg=cfg,codeCheck=F)
}
