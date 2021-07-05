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
* q31_grassland_ratio(j) marcos_develop
;

*marcos_develop
positive variables
v31_past_area(j,past_mngt,w) marcos_develop
 pastr_cost(t,j) marcos_develop
;
parameters
i31_manpast_suit(t_all,j) marcos_develop
i31_ratio(j) marcos_develop
p31_past_suit_corr(j) marcos_develop
;
equations
q31_pasture_areas(j) marcos_develop
q31_manpast_suitability(j) marcos_develop
q31_prod_pm(j) Cellular pasture production constraint (mio. tDM per yr)
;
*marcos_develop

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov31_past_area(t,j,past_mngt,w,type)  marcos_develop
 oq31_carbon(t,j,ag_pools,type)        Above ground carbon content calculation for pasture (mio tC)
 oq31_cost_prod_past(t,i,type)         Costs for putting animals on pastures (mio. USD05MER per yr)
 oq31_bv_manpast(t,j,potnatveg,type)   Biodiversity value for managed pastures (Mha)
 oq31_bv_rangeland(t,j,potnatveg,type) Biodiversity value for rangeland (Mha)
 oq31_pasture_areas(t,j,type)          marcos_develop
 oq31_prod_pm(t,j,type)                Cellular pasture production constraint (mio. tDM per yr)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################

*** EOF declarations.gms ***
