*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations

q17_prod_reg(i2,k) ..
vm_prod_reg(i2,k) =e= sum(cell(i2,j2), vm_prod(j2,k));

*' The equation above describes regional production of a MAgPIE plant commodity
*' `vm_prod_reg` as the sum of the cluster level production `vm_prod` of the
*' same commodity.

q17_prod_lsu(j2,k) ..
vm_prod(j2,"pasture") =g= (vm_rlsu(j2) * vm_land(j2,"past") * ((4000 * 2.225)/100000) * 365) *
                          (sum((ct,cell(i2,j2),kli_rum),im_feed_baskets(ct,i2,kli_rum,"pasture")) /
                          sum((ct,cell(i2,j2),kli_rum,kall),im_feed_baskets(ct,i2,kli_rum,kall)));

*q30_prod(j2,kcr) ..
* vm_prod(j2,kcr) =e= sum(w, vm_area(j2,kcr,w) * vm_yld(j2,kcr,w));

*q31_prod(j2) ..
* vm_prod(j2,"pasture") =l= vm_land(j2,"past")
* 						   * vm_yld(j2,"pasture","rainfed");



*q70_feed(i2,kap,kall) ..
* vm_dem_feed(i2,kap,kall) =g= vm_prod_reg(i2,kap)
*     *sum(ct,im_feed_baskets(ct,i2,kap,kall))
*     +sum(ct,fm_feed_balanceflow(ct,i2,kap,kall));
