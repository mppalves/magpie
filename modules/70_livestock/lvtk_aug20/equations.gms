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

q70_total_lvstk(j2)..
  v70_total_lvstk(j2) =e= sum(ct,vm_rlsu(ct,j2)) * vm_land(j2,"past");


q70_lsu_range_max(j2)..
  v70_total_lvstk(j2) =l= 1.05 * sum(ct, p70_lsu_limit(ct,j2));

q70_lsu_range_min(j2)..
  v70_total_lvstk(j2) =g= 0.95 * sum(ct, p70_lsu_limit(ct,j2));
*  v70_total_lvstk(j2) =g= sum(ct, f70_livestock_cell(ct,j2)/1e6);

$ontext
q70_total_lvstk((j2)..
v70_total_lvstk(j2) =e= - 2.96e+00 + 3.08e-05 * gpdpc_region + 1.96e+03 *
meat_cell - 4.84e+02 * milk_cell + 8.58e-03 * pop_region + 2.34e+01 *
urban_ratio_region - 1.49e-01 * gpdpc_region * meat_cell + 5.69e-02 *
gpdpc_region * milk_cell - 2.48e+03 * meat_cell * LU_region + 6.65e+02 *
milk_cell * LU_region - 5.65e+00 * meat_cell * pop_region + 8.54e-01 *
milk_cell * pop_region - 3.53e+03 * meat_cell * urban_ratio_region + 7.34e+02 *
milk_cell * urban_ratio_region - 2.07e+01 * LU_region * urban_ratio_region - 5.63e-02 *
pop_region * urban_ratio_region + 3.97e-02 * gpdpc_region * meat_cell *
milk_cell + 1.70e-01 * gpdpc_region * meat_cell * LU_region - 6.34e-02 *
gpdpc_region * milk_cell * LU_region - 6.10e+01 * meat_cell * milk_cell *
LU_region + 4.00e-04 * gpdpc_region * meat_cell * pop_region - 9.99e-05 *
gpdpc_region * milk_cell * pop_region + 7.85e+00 * meat_cell * LU_region *
pop_region - 1.36e+00 * milk_cell * LU_region * pop_region + 2.69e-01 *
gpdpc_region * meat_cell * urban_ratio_region - 1.03e-01 * gpdpc_region *
milk_cell * urban_ratio_region + 4.28e+03 * meat_cell * LU_region *
urban_ratio_region - 9.62e+02 * milk_cell * LU_region * urban_ratio_region + 7.13e+00 *
meat_cell * pop_region * urban_ratio_region + 4.77e-02 * LU_region * pop_region *
urban_ratio_region - 4.29e-02 * gpdpc_region * meat_cell * milk_cell *
LU_region - 1.05e-04 * gpdpc_region * meat_cell * milk_cell * pop_region - 5.27e-04 *
gpdpc_region * meat_cell * LU_region * pop_region + 1.25e-04 * gpdpc_region *
milk_cell * LU_region * pop_region + 8.10e-02 * meat_cell * milk_cell * LU_region *
pop_region - 5.69e-02 * gpdpc_region * meat_cell * milk_cell * urban_ratio_region - 2.98e-01 *
gpdpc_region * meat_cell * LU_region * urban_ratio_region + 1.12e-01 * gpdpc_region *
milk_cell * LU_region * urban_ratio_region + 1.18e+02 * meat_cell * milk_cell *
LU_region * urban_ratio_region - 5.63e-04 * gpdpc_region * meat_cell * pop_region *
urban_ratio_region + 1.25e-04 * gpdpc_region * milk_cell * pop_region *
urban_ratio_region + 9.95e-02 * meat_cell * milk_cell * pop_region *
urban_ratio_region - 9.64e+00 * meat_cell * LU_region * pop_region *
urban_ratio_region + 4.45e-01 * milk_cell * LU_region * pop_region *
urban_ratio_region + 1.34e-04 * gpdpc_region * meat_cell * milk_cell *
LU_region * pop_region + 5.79e-02 * gpdpc_region * meat_cell * milk_cell *
LU_region * urban_ratio_region + 1.41e-04 * gpdpc_region * meat_cell *
milk_cell * pop_region * urban_ratio_region + 7.20e-04 * gpdpc_region *
meat_cell * LU_region * pop_region * urban_ratio_region - 1.52e-04 *
gpdpc_region * milk_cell * LU_region * pop_region * urban_ratio_region - 3.25e-01 *
meat_cell * milk_cell * LU_region * pop_region * urban_ratio_region - 1.72e-04 *
gpdpc_region * meat_cell * milk_cell * LU_region * pop_region * urban_ratio_region


gpdpc_region im_gdp_pc_ppp(t_all,i)
meat_cell
milk_cell
pop_region im_pop(t_all,i)
urban_ratio_region im_urb_ratio(t_all,i) fazer a desagregation usando a pop como weight
LU  i70_livestock_conversion(t_all,j)
$offtext
