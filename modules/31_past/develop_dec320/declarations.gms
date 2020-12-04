*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


equations
 q31_prod(j)              Cellular pasture production constraint (mio. tDM per yr)
 q31_carbon(j,ag_pools)   Above ground carbon content calculation for pasture (mio tC)
 q31_cost_prod_past(i)    Costs for putting animals on pastures (mio. USD05MER per yr)
;
*############################# DEVELOPMENT #####################################
positive variables
vm_past_area(j,kpm,w) development
vm_grazing_prod(j)
vm_mowing_prod(j)
;

equations
q31_pasture_areas(j) development
q31_grazing_prod(j) development
q31_mowing_prod(j) development
q31_prod_pm(j, kpm) development
q31_lsu_convert(j) development
;

* model hash ID 65707bf8d0cfd62280f48b8ed49cd7cdd77fa702
variables
vm_lsu(j) LSU variable
v31_inlsu(j,lns1) LSU input layer
v31_inEnv(j,lns1) Environmental input layer
v31_z1(j,lns1) layer neurons
v31_a1(j,lns1) layer activation
v31_z2(j,lns2) layer neurons
v31_a2(j,lns2) layer activation
;
equations
q31_inlsu(j,lns1) LSU input equation
q31_inEnv(j,lns1) LSU input equation
*q31_rlsu(j) real lsu equation
*q31_maxlsu(j) max LSU
*q31_minlsu(j) min LSU
q31_soilc_yld(j) output equation
q31_z1(j,lns1) layer equation
q31_a1(j,lns1) activation equation
q31_z2(j,lns2) layer equation
q31_a2(j,lns2) activation equation
;
positive variables
v31_soilc_yld(j) output variable
*v31_rlsu(j) real LSU variable
;
scalars
s31_mean lsu conversion factor /1.12482040765598/
s31_std lsu conversion factor /0.733714157685237/
;


*############################# DEVELOPMENT #####################################

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 oq31_prod(t,j,type)            Cellular pasture production constraint (mio. tDM per yr)
 oq31_carbon(t,j,ag_pools,type) Above ground carbon content calculation for pasture (mio tC)
 oq31_cost_prod_past(t,i,type)  Costs for putting animals on pastures (mio. USD05MER per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################

*** EOF declarations.gms ***
