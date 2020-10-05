*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations

*' Demand for different feed items is derived by multiplying the regional
*' livestock production with the respective feed baskets. Additionally,
*' inconsistencies with the FAO inventory of national feed use in the case of
*' crops as well as consideration of alternative feed sources that reduce e.g.
*' the demand for grazed biomass like scavenging and roadside grazing are
*' balanced out by the parameter `fm_feed_balanceflow`.

q70_feed(i2,kap,kall) ..
 vm_dem_feed(i2,kap,kall) =g= vm_prod_reg(i2,kap)
     *sum(ct,im_feed_baskets(ct,i2,kap,kall))
     +sum(ct,fm_feed_balanceflow(ct,i2,kap,kall));

*' Factor requirement costs (e.g. labour, capital, but without costs for feed)
*' of livestock production depend on the amount of production and the per-unit
*' costs. For ruminant products (milk and meet), we use a regression of per-unit
*' factor costs from the GTAP database [@narayanan_gtap7_2008] and livestock
*' productivity. Here, factor costs rise with intensification. The per-unit
*' costs for non-ruminants and fish are assumed to be independent from
*' productivity trajectories for simplification. Therefore,
*' `f70_cost_regr(kli,"cost_regr_b")` is set to zero in the case of livestock
*' products generated in monogastric systems.

q70_cost_prod_liv(i2,kli) ..
 vm_cost_prod(i2,kli) =e= vm_prod_reg(i2,kli)
     *(f70_cost_regr(kli,"cost_regr_a") + f70_cost_regr(kli,"cost_regr_b")
     *sum((ct, sys_to_kli(sys,kli)),i70_livestock_productivity(ct,i2,sys)));

q70_cost_prod_fish(i2) ..
 vm_cost_prod(i2,"fish") =e=
     vm_prod_reg(i2,"fish")*f70_cost_regr("fish","cost_regr_a");

*###################################### DEVELOPMENT ############################

q70_yld_lsu(j2,w) ..
  vm_yld(j2,"cont_grazing","rainfed") =e= sum(ct, vm_lsu_ha(ct,j2)) * ((4000 * 2.25/1e6) * 365);

*q70_lsus_past(j2)..
*  v70_lsus(j2, kpm) =e= sum(ct, vm_lsu_ha(ct,j2)) * vm_past_area(j2,"pasture","rainfed");

q70_lsus(j2,kpm)..
  v70_lsus(j2, kpm) =e=  vm_prod(j2,kpm) / ((4000 * 2.25/1e6) * 365);

*q70_lsus_reg(i2)..
*  v70_lsus_reg(i2) =g= vm_supply(i2,"pasture") / ((4000 * 2.25/1e6) * 365);

*q70_lsus_distr(j2)..
*  sum(kpm, v70_lsus(j2,kpm)) =g=  sum(cell(i2,j2),v70_lsus_reg(i2)) * sum(ct, p70_lsus_dist_weight(ct,j2));


* q70_lsus_distr(j2)..
*   lsu_disagg(j2) =g= s70_dist_fact * sum(cell(i2,j2),v70_lsus_reg(i2)) * sum(ct, p70_lsus_dist_weight(ct,j2));

*q70_lsu_constraint(i2)..
*  v70_lsus_reg(i2) =l= sum((cell(i2,j2), kpm), v70_lsus(j2, kpm));

$ontext

 next implementation

 q70_dem_past(j2)..
    v70_dem_past(j2) =e= sum((cell(i2,j2),kli), vm_dem_feed(i2,kli,"pasture"));

q70_lsu_range_max(j2)..
  v70_lsus(j2) =l= 1.1 * sum(ct, p70_lsus_dist(ct,j2));

q70_lsu_range_min(j2)..
  v70_lsus(j2) =g= 0.9 * sum(ct, p70_lsus_dist(ct,j2));
*  v70_lsus(j2) =g= sum(ct, f70_livestock_GLW3(ct,j2)/1e6);

q70_lsus(j2)..
  v70_lsus(j2) =e= vm_prod_rum(j2,"livst_rum","pasture") * fm_attributes("wm","livst_rum") / sum((cell(i2,j2),ct), i70_livestock_productivity(ct,i2,"sys_beef"));
$offtext

*###################################### DEVELOPMENT ############################
