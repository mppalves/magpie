*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


positive variables
 vm_dem_feed(i,kap,kall)          Regional feed demand including byproducts (mio. tDM per yr)
 v70_total_lvstk(j)               development
 v70_dem_past(j)                  development
;

parameter
 p70_check(t,j)  development
 p70_lsu_limit_reg(t,i) development
;

equations
 q70_feed(i,kap,kall)             Regional feed demand
 q70_cost_prod_liv(i,kall)        Regional factor input costs for livestock production
 q70_cost_prod_fish(i)            Regional factor input costs for fish production
 q70_total_lvstk(j)               development
*q70_lsu_range_max(j)             development
*q70_lsu_range_min(j)             development
*q70_total_lvstk_regress(j)       development
q70_dem_past(j)                  development
;

parameters
 im_slaughter_feed_share(t_all,i,kap,attributes)  Share of feed that is incorporated in animal biomass (1)
 i70_livestock_productivity(t_all,i,sys)          Productivity indicator for livestock production (t FM per animal per yr)
 im_feed_baskets(t_all,i,kap,kall)                Feed baskets in tDM per tDM livestock product (1)
 p70_cattle_stock_proxy(t,i)                      Proxy for cattle stocks needed to fullfil domestic food demand (mio. animals per yr)
 p70_incr_cattle(t,i)                             Change in estimated cattle stocks attributed to food demand projections (1)
 pm_past_mngmnt_factor(t,i)                       Regional pasture management intensification factor (1)
 p70_lsu_limit(t,j)                               development
 p70_livestock_conversion(t_all,i)                development
 p70_gdp_pc_ppp(t_all,j)                          development
 p70_pop(t_all,j)                                 development
 p70_urb_ratio(t_all,j)                           development
 p70_total_lvstk(i)                             development
;


*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_dem_feed(t,i,kap,kall,type)    Regional feed demand including byproducts (mio. tDM per yr)
 oq70_feed(t,i,kap,kall,type)      Regional feed demand
 oq70_cost_prod_liv(t,i,kall,type) Regional factor input costs for livestock production
 oq70_cost_prod_fish(t,i,type)     Regional factor input costs for fish production
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
