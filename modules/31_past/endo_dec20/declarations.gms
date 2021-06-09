*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


equations
*q31_prod(j)              Cellular pasture production constraint (mio. tDM per yr)
 q31_carbon(j,ag_pools)   Above ground carbon content calculation for pasture (mio tC)
 q31_cost_prod_past(i)    Costs for putting animals on pastures (mio. USD05MER per yr)
 q31_bv_manpast(j,potnatveg)    Biodiversity value for managed pastures (Mha)
 q31_bv_rangeland(j,potnatveg)    Biodiversity value for rangeland (Mha)
;

*marcos_develop
positive variables
v31_past_area(j,past_mngt,w) marcos_develop
;

equations
q31_pasture_areas(j) marcos_develop
q31_prod_pm(j) Cellular pasture production constraint (mio. tDM per yr)
;
*marcos_develop

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_past_area(t,j,past_mngt,w,type) marcos_develop
 ov31_lsu(t,j,type)                 LSU variable
 ov31_inlsu(t,j,lns1,type)          LSU input layer
 ov31_inEnv(t,j,lns1,type)          Environmental input layer
 ov31_z1(t,j,lns1,type)             layer neurons
 ov31_a1(t,j,lns1,type)             layer activation
 ov31_z2(t,j,lns2,type)             layer neurons
 ov31_a2(t,j,lns2,type)             layer activation
 ov31_lsu_ha(t,j,type)              marcos_develop
 ov31_soilc(t,j,type)               output variable
 ov_soilc_target(t,j,type)          marcos_develop
 oq31_carbon(t,j,ag_pools,type)     Above ground carbon content calculation for pasture (mio tC)
 oq31_cost_prod_past(t,i,type)      Costs for putting animals on pastures (mio. USD05MER per yr)
 oq31_pasture_areas(t,j,type)       marcos_develop
 oq31_prod_pm(t,j,type)             Cellular pasture production constraint (mio. tDM per yr)
 oq31_lsu_convert(t,j,type)         marcos_develop
 oq31_suitability(t,j,type)         marcos_develop
 oq31_yld_lsu(t,j,w,type)           marcos_develop
 oq31_inlsu(t,j,lns1,type)          LSU input equation
 oq31_inEnv(t,j,lns1,type)          LSU input equation
 oq31_soilc_yld(t,j,type)           output equation
 oq31_z1(t,j,lns1,type)             layer equation
 oq31_a1(t,j,lns1,type)             activation equation
 oq31_z2(t,j,lns2,type)             layer equation
 oq31_a2(t,j,lns2,type)             activation equation
 oq31_soilc_convert(t,j,type)       marcos_develop
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################

*** EOF declarations.gms ***
