*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
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

*marcos_develop
q31_prod_pm(j2) ..
  vm_prod(j2,"pasture") =e= sum(past_mngt, vm_past_area(j2,past_mngt,"rainfed") * vm_past_yld(j2,past_mngt,"rainfed"));

q31_pasture_areas(j2)..
  vm_land(j2,"past") =e= sum(past_mngt, vm_past_area(j2,past_mngt,"rainfed"));

q31_cost_prod_past(i2) ..
 vm_cost_prod(i2,"pasture") =e= sum(cell(i2,j2), vm_past_area(j2,"mowing","rainfed") * vm_past_yld(j2,"mowing","rainfed")) * im_mow_cost(i2) + sum((cell(i2,j2),ct), v31_lsu_ha(ct,j2));

*' On the basis of the required pasture area, cellular above ground carbon stocks are calculated:

q31_carbon(j2,ag_pools) ..
 vm_carbon_stock(j2,"past",ag_pools) =e=
         sum(ct, vm_land(j2,"past")*fm_carbon_density(ct,j2,"past",ag_pools));

*' In the initial calibration time step, where the pasture calibration factor
*' is calculated that brings pasture biomass demand and pasture area in balance,
*' small costs are attributed to the production of pasture biomass in order to
*' avoid overproduction of pasture in the model:

*' For all following time steps, factor requriements `s31_test_scalar` are set
*' to zero.

*** EOF constraints.gms ***
