# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------------
# description: Interpolates land pools to 0.5 degree resolution
# comparison script: FALSE
# ---------------------------------------------------------------

library(lucode2)
library(magpie4)
library(luscale)
library(madrat)
library(dplyr)

############################# BASIC CONFIGURATION ##############################
if(!exists("source_include")) {
  outputdir <- "output/SSP2_Ref_c200"
  readArgs("outputdir")
}
map_file                   <- Sys.glob(file.path(outputdir, "clustermap_*.rds"))
gdx                        <- file.path(outputdir,"fulldata.gdx")
land_hr_file               <- file.path(outputdir,"avl_land_t_0.5.mz")
land_hr_out_file           <- file.path(outputdir,"cell.land_0.5.mz")
land_hr_share_out_file     <- file.path(outputdir,"cell.land_0.5_share.mz")
croparea_hr_share_out_file <- file.path(outputdir,"cell.croparea_0.5_share.mz")
land_hr_split_file         <- file.path(outputdir,"cell.land_split_0.5.mz")
land_hr_shr_split_file     <- file.path(outputdir,"cell.land_split_0.5_share.mz")
lsu_ha_file                <- file.path(outputdir,"lsu_ha.nc")

load(paste0(outputdir, "/config.Rdata"))
################################################################################

if(length(map_file)==0) stop("Could not find map file!")
if(length(map_file)>1) {
  warning("More than one map file found. First occurrence will be used!")
  map_file <- map_file[1]
}

extend2luhv2 <- function(x, land = deparse(substitute(x))) {

  if (land == "land_lr") {
    grassland_areas <- readGDX(gdx, "ov31_past_area")[, , "rainfed.level"]
    grassland_areas <- collapseNames(grassland_areas)
    grassland_areas <- setNames(grassland_areas, getNames(grassland_areas) %<>% gsub("range", "range", .) %>% gsub("pastr", "pastr", .))
    land_lr <- mbind(x, grassland_areas)
    drop_past <- !grepl("past$", getNames(land_lr))
    land_lr <- land_lr[, , drop_past]
    return(land_lr)
  }

  if (land == "land_ini_hr") {
    land_ini_LUH2v2 <- read.magpie("./modules/14_yields/input/f14_LUH2v2.mz")[, , c("pastr", "range")]
    land_ini_hr <- mbind(x, land_ini_LUH2v2[, 1995, ])
    drop_past <- !grepl("past$", getNames(land_ini_hr))
    land_ini_hr <- land_ini_hr[, , drop_past]
    getYears(land_ini_hr) <- NULL
    return(land_ini_hr)
  }
}

if (cfg$gms$crop=="endo_apr21"){

  # Load input data
  land_ini_lr  <- readGDX(gdx,"f10_land","f_land", format="first_found")[,"y1995",]
  land_lr      <- land(gdx,sum=FALSE,level="cell")
  land_ini_hr  <- read.magpie(land_hr_file)[,"y1995",]
  land_ini_hr  <- land_ini_hr[,,getNames(land_lr)]
  if(any(land_ini_hr < 0)) {
    warning(paste0("Negative values in inital high resolution dataset detected and set to 0. Check the file ",land_hr_file))
    land_ini_hr[which(land_ini_hr < 0,arr.ind = T)] <- 0
  }
  avl_cropland_hr <- file.path(outputdir, "avl_cropland_0.5.mz")       # available cropland (at high resolution)
  marginal_land <- cfg$gms$c30_marginal_land                      # marginal land scenario
  set_aside_shr <- cfg$gms$s30_set_aside_shr                      # set aside share (default: 0)
  target_year <- cfg$gms$c30_set_aside_target                     # target year of set aside policy (default: "none")
  set_aside_fader  <- readGDX(gdx,"f30_set_aside_fader", format="first_found")[,,target_year]

  if (grepl("grass", cfg$gms$yields)) {
    land_lr <- extend2luhv2(land_lr)
    land_ini_hr <-  extend2luhv2(land_ini_hr)
  }

  # Start interpolation (use interpolateAvlCroplandWeighted from luscale)
  print("Disaggregation")
  land_hr <- interpolateAvlCroplandWeighted(x          = land_lr,
                                            x_ini_lr   = land_ini_lr,
                                            x_ini_hr   = land_ini_hr,
                                            avl_cropland_hr = avl_cropland_hr,
                                            map        = map_file,
                                            marginal_land = marginal_land,
                                            set_aside_shr = set_aside_shr,
                                            set_aside_fader = set_aside_fader)

}else if (cfg$gms$crop=="endo_jun13") {

  # Load input data
  land_lr   <- land(gdx,sum=FALSE,level="cell")
  land_ini_hr  <- setYears(read.magpie(land_hr_file)[,"y1995",],NULL)
  land_ini_hr  <- land_ini_hr[,,getNames(land_lr)]
  if(any(land_ini_hr < 0)) {
    warning(paste0("Negative values in inital high resolution dataset ",
                   "detected and set to 0. Check the file ",land_hr_file))
    land_ini_hr[which(land_ini_hr < 0,arr.ind = T)] <- 0
  }

  if (grepl("grass", cfg$gms$yields)) {
    land_lr <- extend2luhv2(land_lr)
    land_ini_hr <-  extend2luhv2(land_ini_hr)
  }

  # Start interpolation (use interpolate from luscale)
  message("Disaggregation")
  land_hr <- luscale::interpolate2(x     = land_lr,
                                   x_ini = land_ini_hr,
                                   map   = map_file)
}

# Write outputs

.dissagcrop <- function(gdx, land_hr, map) {
  message("Disaggregation crop types")
  area     <- croparea(gdx, level="cell", products="kcr",
                       product_aggr=FALSE,water_aggr = FALSE)
  area_shr <- area/(dimSums(area,dim=3) + 10^-10)

  # calculate share of crop land on total cell area
  crop_shr <- land_hr/dimSums(land_hr, dim=3)
  crop_shr <- setNames(crop_shr[,getYears(area_shr),"crop"],NULL)
  # calculate crop area as share of total cell area
  area_shr_hr <- madrat::toolAggregate(area_shr, map, to="cell") * crop_shr
  return(area_shr_hr)
}

.tmpwrite <- function(x,file,comment,message) {
  write.magpie(x, file, comment=comment)
  write.magpie(x, sub(".mz",".nc",file), comment=comment, verbose=FALSE)
}

.tmpwrite(land_hr, land_hr_out_file, comment="unit: Mha per grid-cell",
          message="Write outputs cell.land")
.tmpwrite(land_hr/dimSums(land_hr,dim=3.1), land_hr_share_out_file,
          comment="unit: grid-cell land area fraction",
          message="Write outputs cell.land_share")

area_shr_hr <- .dissagcrop(gdx, land_hr, map=map_file)

.tmpwrite(area_shr_hr, croparea_hr_share_out_file,
          comment="unit: grid-cell land area fraction",
          message="Write outputs cell.cropara_share")


.cropsplit <- function(area_shr_hr, land_hr, land_hr_split_file,
                       land_hr_shr_split_file) {
  land_hr <- land_hr[,getYears(area_shr_hr),]
  area_hr <- area_shr_hr*dimSums(land_hr, dim=3)

  # replace crop in land_hr in with crop_kfo_rf, crop_kfo_ir, crop_kbe_rf
  # and crop_kbe_ir
  kbe <- c("betr","begr")
  kfo <- setdiff(getNames(area_hr,dim=1),kbe)
  crop_kfo_rf <- setNames(dimSums(area_hr[,,kfo][,,"rainfed"],dim=3),
                          "crop_kfo_rf")
  crop_kfo_ir <- setNames(dimSums(area_hr[,,kfo][,,"irrigated"],dim=3),
                          "crop_kfo_ir")
  crop_kbe_rf <- setNames(dimSums(area_hr[,,kbe][,,"rainfed"],dim=3),
                          "crop_kbe_rf")
  crop_kbe_ir <- setNames(dimSums(area_hr[,,kbe][,,"irrigated"],dim=3),
                          "crop_kbe_ir")
  crop_hr <- mbind(crop_kfo_rf,crop_kfo_ir,crop_kbe_rf,crop_kbe_ir)
  #drop crop
  land_hr <- land_hr[,,"crop",invert=TRUE]
  #combine land_hr with crop_hr.
  land_hr <- mbind(crop_hr,land_hr)
  #write landpool
  .tmpwrite(land_hr, land_hr_split_file,
            comment="unit: Mha per grid-cell",
            message="Write cropsplit land area")

  .tmpwrite(land_hr/dimSums(land_hr,dim=3), land_hr_shr_split_file,
            comment="unit: grid-cell land area fraction",
            message="Write cropsplit land area share")
}

.cropsplit(area_shr_hr, land_hr, land_hr_split_file,land_hr_shr_split_file)

.pastProd <- function(land_hr, map_file, gdx, lsu_ha_file){

  #calculating pasture production after optimization
  grass_areas <- gdx::readGDX(gdx, "ov31_past_area")[, , "level"][,,"rainfed"]
  grass_yields <- gdx::readGDX(gdx, "ov_past_yld")[, , "level"][,,"rainfed"]
  grass_prod_lr <-  grass_areas * grass_yields #* 1e6 #tDM y-1
  grass_prod_lr <-  collapseNames(grass_prod_lr)
  grass_prod_lr <-  setNames(grass_prod_lr, getNames(grass_prod_lr) %<>% gsub("range", "range",.) %>% gsub("pastr", "pastr", .))

  years <- getYears(grass_prod_lr)

  # Calculating potential yields before calibration
  lpjml_yields <- read.magpie("./modules/14_yields/input/lpj_grasslands_yld.mz")[,,"rainfed"]
  lpjml_yields <- setNames(collapseNames(lpjml_yields),c("range", "pastr"))
  poten_prod <- lpjml_yields[,years,] * land_hr[,years,c("range","pastr")]

  #disaggregation weighted by potential yields
  prod <- toolAggregate(grass_prod_lr, map_file, weight = poten_prod, from = "cluster", to = "cell")

  # calculating LSU densities
  lsu_eq <- (8.9 * 365)/1000 # tDM y-1
  lsus <- prod/lsu_eq
  lsu_ha <- lsus/land_hr[,years,c("range","pastr")]
  lsu_ha[is.nan(lsu_ha) | is.infinite(lsu_ha)] <- 0
  lsu_ha[lsu_ha[,,"range"]>2.5] <-  2.5

  .tmpwrite(lsu_ha, lsu_ha_file,
            comment="unit: Lsu per ha",
            message="Write Livestock density per cluster")


}

if (grepl("grass", cfg$gms$yields)) {
  .pastProd(land_hr, map_file, gdx, lsu_ha_file)
}
