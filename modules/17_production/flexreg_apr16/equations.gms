*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations

q17_prod_reg(i2,k) ..
vm_prod_reg(i2,k) =e= sum(cell(i2,j2), vm_prod(j2,k));

$ontext
*############################### DEVELOPMENT ###################################
q17_prod_distr(j2) ..
     sum(kpm, vm_prod(j2,"pasture")) =e=  sum((cell(i2,j2),kpm),vm_prod_reg(i2,"pasture")) * sum(ct, p70_lsus_dist_weight(ct,j2));
       vm_prod(j2,"pasture") =g=  sum((cell(i2,j2),ct), p70_total_past_demand(ct,i2)) * sum(ct, p70_lsus_dist_weight(ct,j2));
*############################### DEVELOPMENT ###################################
$offtext
*' The equation above describes regional production of a MAgPIE plant commodity
*' `vm_prod_reg` as the sum of the cluster level production `vm_prod` of the
*' same commodity.
