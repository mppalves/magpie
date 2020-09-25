*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations

*' Production of pasture biomass is restricted to pasture area which is
*' delivered as module output together with the resulting geographically
*' explicit production of pasture biomass. Cellular production is calculated by
*' multiplying pasture area `vm_land` with cellular rainfed pasture yields
*' `vm_yld` which are delivered by the module [14_yields]:

*################################ DEVELOPMENT ##################################

q31_prod(j2) ..
  vm_prod(j2,"pasture") =e= sum(kpm, vm_past_area(j2,kpm,"rainfed") * vm_yld(j2,kpm,"rainfed"));

q31_pasture_areas(j2)  ..
  sum(kpm, vm_past_area(j2,kpm,"rainfed")) =e= vm_land(j2,"past");

*q30_suitability(j2)  ..
*    vm_land(j2,"crop") + vm_past_area(j2,"mowing","rainfed") =l= f30_land_si(j2,"si0");
* check if that constraint makes sense

*################################ DEVELOPMENT ##################################

*' On the basis of the required pasture area, cellular above ground carbon stocks are calculated:

q31_carbon(j2,ag_pools) ..
 vm_carbon_stock(j2,"past",ag_pools) =e=
         sum(ct, vm_land(j2,"past")*fm_carbon_density(ct,j2,"past",ag_pools));

*' In the initial calibration time step, where the pasture calibration factor
*' is calculated that brings pasture biomass demand and pasture area in balance,
*' small costs are attributed to the production of pasture biomass in order to
*' avoid overproduction of pasture in the model:

q31_cost_prod_past(i2) ..
 vm_cost_prod(i2,"pasture") =e= vm_prod_reg(i2,"pasture")
 								* s31_fac_req_past;

*' For all following time steps, factor requriements `s31_fac_req_past` are set
*' to zero.

*** EOF constraints.gms ***
