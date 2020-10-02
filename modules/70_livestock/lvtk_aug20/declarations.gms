*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


positive variables
 vm_dem_feed(i,kap,kall)          Regional feed demand including byproducts (mio. tDM per yr)
;

equations
 q70_feed(i,kap,kall)             Regional feed demand
 q70_cost_prod_liv(i,kall)        Regional factor input costs for livestock production
 q70_cost_prod_fish(i)            Regional factor input costs for fish production
;

parameters
 im_slaughter_feed_share(t_all,i,kap,attributes)  Share of feed that is incorporated in animal biomass (1)
 i70_livestock_productivity(t_all,i,sys)          Productivity indicator for livestock production (t FM per animal per yr)
 im_feed_baskets(t_all,i,kap,kall)                Feed baskets in tDM per tDM livestock product (1)
 p70_cattle_stock_proxy(t,i)                      Proxy for cattle stocks needed to fullfil domestic food demand (mio. animals per yr)
 p70_incr_cattle(t,i)                             Change in estimated cattle stocks attributed to food demand projections (1)
 pm_past_mngmnt_factor(t,i)                       Regional pasture management intensification factor (1)
;

*###################################### DEVELOPMENT #############################
parameters
p70_lsus_dist(t,j)                               development
p70_livestock_conversion(t,i)                    development
p70_livestock_reg(i)                                 development
p70_lsus_dist_reg(t,i)                           development
p70_lsus_dist_weight(t,j)                        development
p70_total_ap_food_demand(t,i,kfo_ap)                       development
p70_mow_yld_corr(t,j)                           development
p70_total_past_demand(t,i)                      development
im_feed_baskets2(t_all,i,kfo_ap,kall)                Feed baskets in tDM per tDM livestock product (1)
;


equations
q70_lsus_past(j)               development
*q70_lsus_mowing(j)             development
*q70_lsus_reg(i)               development
*q70_lsu_range_max(j)             development
*q70_lsu_range_min(j)             development
*q70_lsus_production(j)       development
*q70_dem_past(j)                  development
*q70_lsu_constraint(i) development
*q70_lsus_distr(j)              development
q70_yld_lsu(j,w) development
;

variables
*v70_lsus(j, kpm)               development
*v70_dem_past(j)                  development
*v70_lsus_reg(i)            development
;

positive variable
vm_lsu_ha(t,j)  development
;

*variable
*lsu_disagg(j) teste
*;


*###################################### DEVELOPMENT #############################

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_dem_feed(t,i,kap,kall,type)    Regional feed demand including byproducts (mio. tDM per yr)
 oq70_feed(t,i,kap,kall,type)      Regional feed demand
 oq70_cost_prod_liv(t,i,kall,type) Regional factor input costs for livestock production
 oq70_cost_prod_fish(t,i,type)     Regional factor input costs for fish production
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
