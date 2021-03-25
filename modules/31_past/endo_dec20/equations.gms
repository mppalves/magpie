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

*marcos_develop
q31_prod_pm(j2) ..
  vm_prod(j2,"pasture") =e= sum(past_mngt, v31_past_area(j2,past_mngt,"rainfed") * vm_past_yld(j2,past_mngt,"rainfed"));

q31_pasture_areas(j2)..
  vm_land(j2,"past") =e= sum(past_mngt, v31_past_area(j2,past_mngt,"rainfed"));

q31_cost_prod_past(i2) ..
  vm_cost_prod(i2,"pasture") =e= sum(cell(i2,j2), v31_past_area(j2,"mowing","rainfed") * vm_past_yld(j2,"mowing","rainfed")) * im_mow_cost(i2) + sum((cell(i2,j2),ct), v31_lsu_ha(ct,j2));

*' Soil carbon target calculation

q31_lsu_convert(j2)..
  v31_lsu(j2) =e= sum(ct, (v31_lsu_ha(ct,j2) - s31_mean) / s31_std);

q31_yld_lsu(j2,w)..
  vm_past_yld(j2,"cont_grazing","rainfed") =e= sum(ct, v31_lsu_ha(ct,j2)) * s31_lsu_yr_consumption;

* model hash ID 65707bf8d0cfd62280f48b8ed49cd7cdd77fa702
q31_inlsu(j2,lns1)..  v31_inlsu(j2,lns1) =e= sum(in_lsu_s, v31_lsu(j2) * f31_w1(in_lsu_s,lns1));
q31_inEnv(j2,lns1)..  v31_inEnv(j2,lns1) =e= sum(in_env_s, f31_nn_input(j2,in_env_s) * f31_w1(in_env_s,lns1));
q31_z1(j2,lns1)..  v31_z1(j2,lns1) =e= v31_inlsu(j2,lns1) + v31_inEnv(j2,lns1) + f31_b1(lns1);
q31_a1(j2,lns1)..  v31_a1(j2,lns1) =e= 1/( 1 + system.exp(-v31_z1(j2,lns1)));
q31_z2(j2,lns2)..  v31_z2(j2,lns2) =e= sum(lns1, v31_a1(j2,lns1) * f31_w2(lns1,lns2)) + f31_b2(lns2);
q31_a2(j2,lns2)..  v31_a2(j2,lns2) =e= 1/( 1 + system.exp(-v31_z2(j2,lns2)));
q31_soilc_yld(j2)..  v31_soilc(j2) =e= sum((lns2,lns3), v31_a2(j2,lns2) * f31_w3(lns2,lns3) + f31_b3(lns3));

q31_soilc_convert(j2)..
    v31_soilc_target(j2) =e= (v31_soilc(j2) * 11000.11 + 10319.38) * v31_past_area(j2,"cont_grazing","rainfed");

q31_suitability(j2)  ..
    vm_land(j2,"crop") + v31_past_area(j2,"mowing","rainfed") =l= fm_land_si(j2,"si0");

*marcos_develop

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
