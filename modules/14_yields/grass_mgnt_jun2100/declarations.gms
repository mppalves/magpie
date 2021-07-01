*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

parameters
 i14_yields_calib(t,j,kve,w)                             Calibrated biophysical input yields (excluding technological change) (tDM per ha per yr)
 p14_pyield_LPJ_reg(t_all,i)                             Regional average input yields aggregated from clusters with initial pasture area as weights (tDM per ha per yr)
 p14_pyield_corr(t,i)                                    Regional pasture management correction for historical time steps (1)
 i14_croparea_total(t_all,j)                             Cellular croparea (mio. ha)
 i14_modeled_yields_hist(t_all,i,kcr)                    Biophysical input yields average over region and water supply type at the historical reference year (tDM per ha per yr)
 i14_fao_yields_hist(t,i,kcr)                            FAO yields per region at the historical referende year (tDM per ha per yr)
 i14_lambda_yields(t,i,kcr)                              Scaling factor for non-linear management calibration (1)
 i14_managementcalib(t,j,kcr,w)                          Regional management calibration factor accounting for FAO yield levels (1)
 p14_growing_stock(t,j,ac,forest_land,forest_type)       Forest growing stock (tDM per ha per yr)
 pm_timber_yield(t,j,ac,forest_land)                     Forest growing stock (tDM per ha per yr)
 p14_growing_stock_initial(j,ac,forest_land,forest_type) Initial Forest growing stock (tDM per ha per yr)
 pm_timber_yield_initial(j,ac,forest_land)               Initial Forest yield (tDM per ha per yr)
 i14_grass_yields_reg(t_all,i,past_mngt)                 marcos_develop
 p14_grass_corr(t_all,j,past_mngt)                       marcos_develop
 p14_grass_yields(t_all,i,past_mngt)                     marcos_develop
 ;

positive variables
 vm_yld(j,kve,w)                     Yields (variable because of technical change) (tDM per ha per yr)
 vm_past_yld(j,past_mngt,w)           marcos_develop
;

equations
 q14_yield_crop(j,kcr,w)             Crop yields (tDM per ha per yr)
 q14_yield_past(j,w)                 Pasture yields (tDM per ha per yr)
* q14_yield_past_contg(j,past_mngt,w) marcos_develop
* q14_yield_past_mow(j,past_mngt,w)   marcos_develop
 q14_yield_grassl(j,past_mngt,w) marcos_develop
;

parameter
 im_mow_cost(i)                           marcos_develop
 i14_grass_yields(t_all,j,past_mngt,w)    marcos_develop
 i14_grassland_total(t,j)             marcos_develop
* i14_lambda_grass(t,i,past_mngt)          marcos_develop
* i14_grassl_yld_hist_reg(t,i,past_mngt) marcos_develop
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_yld(t,j,kve,w,type)                      Yields (variable because of technical change) (tDM per ha per yr)
 ov_past_yld(t,j,past_mngt,w,type)           marcos_develop
 oq14_yield_crop(t,j,kcr,w,type)             Crop yields (tDM per ha per yr)
 oq14_yield_past(t,j,w,type)                 Pasture yields (tDM per ha per yr)
 oq14_yield_past_contg(t,j,past_mngt,w,type) marcos_develop
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
