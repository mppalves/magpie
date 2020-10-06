# |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

###########################
#### Check development ####
###########################
# Version 1.0, Marcos Alves
#
library(lucode)
library(magclass)
library(luplot)
library(magpie4)
library(ggplot2)
library(gdx)

# options(error = function() traceback(2))

############################# BASIC CONFIGURATION #############################

fname <- "factor"
# Define arguments that can be read from command line
readArgs("fname")

outputdirs <-
  file.path(
    "output",
    list.dirs("output/", full.names = FALSE, recursive = FALSE)
  )
outputdirs <- outputdirs[grep(fname, outputdirs)]

###############################################################################
cat("\nStarting output generation\n")

variables <-
  c(
    "ov_lsu_ha",
    "ov70_lsus",
    "ov_yld",
    "past",
    "pasture", 
    "livst_milk", 
    "livst_rum",
    "ov_grazing_prod",
    "ov_mowing_prod"
  )
# gdx <-
#   "C:/Users/pedrosa/github/Models/MAgPIE Validation/fulldata.gdx"
# variable <- "ov_yld"
# outputdirs <-
#   list.dirs("C:/Users/pedrosa/github/Models/MAgPIE Validation/test_errase",
#     recursive = FALSE
#   )


for (variable in variables) {
  magpie <- NULL
  missing <- NULL
  print(paste("Processing", variable))
  for (i in 1:length(outputdirs)) {
    x <- NULL
    print(paste("Processing", outputdirs[i]))
    # gdx file
    gdx <- path(outputdirs[i], "fulldata.gdx")
    if (file.exists(gdx)) {
      # get scenario name
      load(path(outputdirs[i], "config.Rdata"))
      scen <- cfg$title
      # read-in reporting file
      if (variable %in% c("past")) {
        try({
          x <- gdx::readGDX(gdx, "ov_land")[,,"level"][,,variable]
          x <- gdxAggregate(gdx, x, to = "reg", absolute = T)
          title <- paste0("Land", " | ", variable)
        })
      }
      if (variable %in% c("pasture", "livst_milk", "livst_rum")) {
        try({
          x <- gdx::readGDX(gdx, "ov_prod")[,,"level"][,,variable]
          x <- gdxAggregate(gdx, x, to = "reg", absolute = T)
          title <- paste0("Production", " | ", variable)
        })
      }
      if (variable %in% c("ov_lsu_ha", "ov14_past_yld", "ov70_dem_past","ov_grazing_prod","ov_mowing_prod")) {
        try({
          x <- gdx::readGDX(gdx, variable, select = list(type = "level"))
          if (is.magpie(x) && !all(x==0)) {
            regions <- getRegions(x)
            temp <- list()
            title <- paste0("Average", " | ", variable)
            for (r in regions) {
              temp[[r]] <- colSums(x[r, , ]) / dim(x[r, , ])[1]
            }
            x <- do.call(mbind, temp)
            x <- as.magpie(aperm(x, c(3, 2, 1)), spatial = 1)
            getCells(x) <- regions
          }
        })
      }

      if (variable %in% c("ov70_lsus", "ov14_lsus")) {
        try({
          x <- gdx::readGDX(gdx, variable, select = list(type = "level"))
          if(is.magpie(x) && !all(x==0)){
            x <- gdxAggregate(gdx, x, to = "reg", absolute = T)
            title <- paste0("Total", " | ", variable, dimnames(x)[3])
            # x <- collapseNames(x)
          }
        })
      }

      if (variable %in% c("pm_past_mngmnt_factor", "p70_cattle_stock_proxy")) {
        try({
          x <- gdx::readGDX(gdx, variable)
          # x <- collapseNames(x)
        })
      }

      if (variable %in% c("ov_yld")) {
        try({
          x <- gdx::readGDX(gdx, variable, select = list(type = "level", kve=c("pasture", "mowing"),w = "rainfed"))
          # x <- dimSums(x[,,c(1,2)])
          title <- paste0("Total", " | ", variable)
          weight <- as.magpie(rep(1,200),spatial =1)
          x <- gdxAggregate(gdx, x, to = "reg", absolute = F, weight = weight)
          # x <- collapseNames(x)

        })
      }

      if (is.magpie(x) && !all(x==0)) {
        getNames(x) <- paste(scen, getNames(x))
        try(magpie <- mbind(magpie, x))
      } else {
        print(paste("==>", variable, "not processed"))
      }
    } else {
      missing <- c(missing, outputdirs[i])
    }
  }

  if (!is.null(missing)) {
    cat("\nList of folders with missing fulldata.gdx\n")
    print(missing)
  }

  if (!is.null(magpie)) {
    p <-
      magpie2ggplot2(
        magpie,
        scenario = 1,
        ylab = variable,
        legend_position = "bottom",
        group = NULL,
        title = title
      )

    print(p)

    ggsave(
      plot = p,
      filename = paste0(variable, ".pdf"),
      width = 20,
      height = 10
    )
  }
}



for (i in 1:length(outputdirs)) {
  magpie <- NULL
  missing <- NULL
  print(paste("Processing", outputdirs[i]))
  for (variable in variables) {
    print(paste("Processing", variable))
    x <- NULL
    # gdx file
    gdx <- path(outputdirs[i], "fulldata.gdx")
    if (file.exists(gdx)) {
      # get scenario name
      load(path(outputdirs[i], "config.Rdata"))
      scen <- cfg$title
      # read-in reporting file

      if (variable %in% c("past")) {
        try({
          x <- gdx::readGDX(gdx, "ov_land")[,,"level"][,,variable]
          x <- gdxAggregate(gdx, x, to = "reg", absolute = T)
          # x <- collapseNames(x)
          title <- paste0("Land", " | ", variable)
        })
      }

      if (variable %in% c("pasture", "livst_milk", "livst_rum")) {
        try({
          x <- gdx::readGDX(gdx, "ov_prod")[,,"level"][,,variable]
          x <- gdxAggregate(gdx, x, to = "reg", absolute = T)
          # x <- collapseNames(x)
          title <- paste0("Production", " | ", variable)
        })
      }

      if (variable %in% c("ov_lsu_ha", "ov14_past_yld", "ov70_dem_past","ov_grazing_prod","ov_mowing_prod")) {
        try({
          x <- gdx::readGDX(gdx, variable, select = list(type = "level"))
          if (is.magpie(x)) {
            regions <- getRegions(x)
            temp <- list()
            title <- paste0("Average", " | ", variable)
            for (r in regions) {
              temp[[r]] <- colSums(x[r, , ]) / dim(x[r, , ])[1]
            }
            x <- do.call(mbind, temp)
            x <- as.magpie(aperm(x, c(3, 2, 1)), spatial = 1)
            getCells(x) <- regions
          }
        })
      }

      if (variable %in% c("ov70_lsus", "ov14_lsus", "ov70_dem_past")) {
        try({
          x <- gdx::readGDX(gdx, variable, select = list(type = "level"))
          if(is.magpie(x)){
            x <- gdxAggregate(gdx, x, to = "reg", absolute = T)
            title <- paste0("Total", " | ", variable)
            # x <- collapseNames(x)
          }
        })
      }


      if (variable %in% c("ov_yld")) {
        try({
          x <- gdx::readGDX(gdx, variable, select = list(type = "level", kve=c("cont_grazing", "mowing"),w = "rainfed"))
          # x <- dimSums(x[,,c(1,2)])
          title <- paste0("Total", " | ", variable)
          weight <- as.magpie(rep(1,200),spatial =1)
          x <- gdxAggregate(gdx, x, to = "reg", absolute = F, weight = weight)
          # x <- collapseNames(x)

        })
      }


      if (variable %in% c("pm_past_mngmnt_factor", "p70_cattle_stock_proxy")) {
        try({
          x <- gdx::readGDX(gdx, variable)
          # x <- collapseNames(x)
          title <- paste0("Factor", " | ", variable)
        })
      }

      if (is.magpie(x)) {
        getNames(x) <-  paste0(variable, "_", getNames(x))
        x <- (x - min(x)) / (max(x) - min(x))
        try(magpie <- mbind(magpie, x))
      } else {
        print(paste("==>", variable, "not processed"))
      }
    } else {
      missing <- c(missing, outputdirs[i])
    }
  }


  if (!is.null(missing)) {
    print("\nList of folders with missing fulldata.gdx\n")
    print(missing)
  }

  if (!is.null(magpie)) {
    # magpie <- (magpie - min(magpie)) / (max(magpie) - min(magpie))
    p <-
      magpie2ggplot2(
        magpie,
        scenario = 1,
        ylab = "Normalized values",
        legend_position = "bottom",
        group = NULL,
        title = scen
      )
    print(p)
    ggsave(
      plot = p,
      filename = paste0(scen, ".pdf"),
      width = 20,
      height = 10
    )
  }
}


for (i in 1:length(outputdirs)) {
  gdx <- path(outputdirs[i], "fulldata.gdx")
  if (file.exists(gdx)) {
    # get scenario name
    load(path(outputdirs[i], "config.Rdata"))
    scen <- cfg$title

    y <- production(gdx)[, , c("livst_milk", "livst_rum")]
    # y <- collapseNames(y)
    x <-
      readGDX(gdx, "ov70_lsus", select = list(type = "level"))
    x <- dimSums(x[,,1:dim(x)[3]])

    if (is.null(x)) {
      stop("This run do not have ov70_lsus")
    }

    if (is.magpie(x)) {
      regions <- getRegions(x)
      temp <- list()
      for (r in regions) {
        temp[[r]] <- colSums(x[r, , ]) / dim(x[r, , ])[1]
      }
      x <- do.call(mbind, temp)
      x <- as.magpie(aperm(x, c(3, 2, 1)), spatial = 1)
      getCells(x) <- regions

      w <- y / x

      p <-
        magpie2ggplot2(
          w,
          scenario = 1,
          ylab = "Production/Total LSUs",
          legend_position = "bottom",
          group = NULL,
          title = scen
        )
      print(p)
      ggsave(
        plot = p,
        filename = paste0(scen, "_productivity", ".pdf"),
        width = 20,
        height = 10
      )
    }
  }
}
