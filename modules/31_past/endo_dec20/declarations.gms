*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


equations
*q31_prod(j)              Cellular pasture production constraint (mio. tDM per yr)
 q31_carbon(j,ag_pools)   Above ground carbon content calculation for pasture (mio tC)
 q31_cost_prod_past(i)    Costs for putting animals on pastures (mio. USD05MER per yr)
;

*marcos_develop
positive variables
vm_past_area(j,past_mngt,w) marcos_develop
;

equations
q31_pasture_areas(j) marcos_develop

q31_prod_pm(j) Cellular pasture production constraint (mio. tDM per yr)
q31_lsu_convert(j) marcos_develop
q31_suitability(j) marcos_develop
q31_yld_lsu(j,w) marcos_develop
;

* model hash ID 8b6df3c9
variables
v31_lsu(j) LSU variable
v31_inlsu(j,lns1) LSU input layer
v31_inEnv(j,lns1) Environmental input layer
v31_z1(j,lns1) layer neurons
v31_a1(j,lns1) layer activation
v31_z2(j,lns2) layer neurons
v31_a2(j,lns2) layer activation
v31_lsu_ha(t,j) marcos_develop
v31_soilc(j) output variable
;

equations
q31_inlsu(j,lns1) LSU input equation
q31_inEnv(j,lns1) LSU input equation
q31_soilc_yld(j) output equation
q31_z1(j,lns1) layer equation
q31_a1(j,lns1) activation equation
q31_z2(j,lns2) layer equation
q31_a2(j,lns2) activation equation
q31_soilc_convert(j) marcos_develop
;

Variable
vm_soilc_target(j) marcos_develop
;

scalars
* 4000 = Daily carbon consumption per LSU
* 2.25 = from C to DM
* 1e6 = from m2 to ha
* 365 = days per year
* ((4000 * 2.25/1e6) * 365) =  3.285 tDM/yr
s31_lsu_yr_consumption LSU year DM consumption equivalent / 3.285 /
;

scalars
s31_min output conversion factor /4.86866188049316/
s31_max output conversion factor /504.505218505859/
;


*marcos_develop

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ovm_past_area(t,j,past_mngt,w,type) marcos_develop
 ov31_lsu(t,j,type)                   LSU variable
 ov31_inlsu(t,j,lns1,type)            LSU input layer
 ov31_inEnv(t,j,lns1,type)            Environmental input layer
 ov31_z1(t,j,lns1,type)               layer neurons
 ov31_a1(t,j,lns1,type)               layer activation
 ov31_z2(t,j,lns2,type)               layer neurons
 ov31_a2(t,j,lns2,type)               layer activation
 ov31_lsu_ha(t,j,type)                marcos_develop
 ov31_soilc(t,j,type)                 output variable
 ovm_soilc_target(t,j,type)          marcos_develop
 oq31_carbon(t,j,ag_pools,type)       Above ground carbon content calculation for pasture (mio tC)
 oq31_cost_prod_past(t,i,type)        Costs for putting animals on pastures (mio. USD05MER per yr)
 oq31_pasture_areas(t,j,type)         marcos_develop
 oq31_prod_pm(t,j,type)               marcos_develop
 oq31_lsu_convert(t,j,type)           marcos_develop
 oq31_suitability(t,j,type)           marcos_develop
 oq31_yld_lsu(t,j,w,type)             marcos_develop
 oq31_inlsu(t,j,lns1,type)            LSU input equation
 oq31_inEnv(t,j,lns1,type)            LSU input equation
 oq31_soilc_yld(t,j,type)             output equation
 oq31_z1(t,j,lns1,type)               layer equation
 oq31_a1(t,j,lns1,type)               activation equation
 oq31_z2(t,j,lns2,type)               layer equation
 oq31_a2(t,j,lns2,type)               activation equation
 oq31_soilc_convert(t,j,type)         marcos_develop
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################

*** EOF declarations.gms ***
