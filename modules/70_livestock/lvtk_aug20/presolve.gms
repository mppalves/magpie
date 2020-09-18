*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


*' @code
*' The fbask_jan16 realization of the livestock module also estimates an exogenous
*' pasture management factor `pm_past_mngmnt_factor` that is used to scale
*' biophysical pasture yields in the module [14_yields].

*' The exogenous calculation of pasture management requires information on
*' the number of cattle reared to fulfil the domestic demand for ruminant
*' livestock products:

*p70_cattle_stock_proxy(t,i) = im_pop(t,i)*pm_kcal_pc_initial(t,i,"livst_rum")
*		              /i70_livestock_productivity(t,i,"sys_beef");


p70_cattle_stock_proxy(t,i) = ((sum(ct,im_pop(t,i) * p15_kcal_pc_calibrated(t,i,"livst_rum")) * 365)
																/ (sum(ct,f15_nutrition_attributes(ct,"livst_rum","kcal")) * 1e6)) * fm_attributes("wm","livst_rum")
									    					/i70_livestock_productivity(t,i,"sys_beef") +
																((sum(ct,im_pop(t,i) * p15_kcal_pc_calibrated(t,i,"livst_milk")) * 365)
																/ (sum(ct,f15_nutrition_attributes(ct,"livst_milk","kcal")) * 1e6)) * fm_attributes("wm","livst_milk")
																/i70_livestock_productivity(t,i,"sys_dairy");

p70_cattle_stock_proxy_calib(t,i) =	p70_cattle_stock_proxy(t,i);
* f70_livestock_balanace_flow(i);

$ontext
v17_past_fraction(i2) =e= (sum((ct,kli_rum),im_feed_baskets(ct,i2,kli_rum,"pasture")) /
                         sum((ct,kli_rum,kall),im_feed_baskets(ct,i2,kli_rum,kall)));
$offtext

$ontext
v70_total_lsus(j2) =g= (vm_prod_rum(j2,"livst_rum","pasture") / sum((cell(i2,j2),ct), i70_livestock_productivity(ct,i2,"sys_beef")) +
									  vm_prod_rum(j2,"livst_milk","pasture") / sum((cell(i2,j2),ct), i70_livestock_productivity(ct,i2,"sys_dairy")))*
									  sum((i_to_iso(i,iso),ct), f70_livestock_conversion(ct,iso, "Large"));
$offtext

*' The lower bound for `p70_cattle_stock_proxy` is set to 20% of initial cattle
*' stocks in 1995:

p70_cattle_stock_proxy(t,i)$(p70_cattle_stock_proxy(t,i) < 0.2*p70_cattle_stock_proxy("y1995",i)) = 0.2*p70_cattle_stock_proxy("y1995",i);

*' The parameter `p70_incr_cattle` describes the changes in cattle stocks
*' relative to the previous time step:

p70_incr_cattle(t,i)  =  1$(ord(t)=1)
			+ (p70_cattle_stock_proxy(t,i)/p70_cattle_stock_proxy(t-1,i))$(ord(t)>1);

*' The pasture management factor is calculated by applying a linear relationship
*' that links changes in pasture management with changes in cattle stocks:

if (sum(sameas(t_past,t),1) = 1,
   pm_past_mngmnt_factor(t,i) = 1;
else
   pm_past_mngmnt_factor(t,i) =   ( (s70_pyld_intercept + f70_pyld_slope_reg(i)*p70_incr_cattle(t,i)**(5/(m_year(t)-m_year(t-1)))
	         )**((m_year(t)-m_year(t-1))/5) )*pm_past_mngmnt_factor(t-1,i);
 );

 if (sum(sameas(t_past,t),1) <> 1,
 	 p70_lsu_limit(t,j) = p70_lsu_limit(t-1,j);
  );

display p70_cattle_stock_proxy;

*' @stop
