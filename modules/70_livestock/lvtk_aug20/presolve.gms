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

p70_cattle_stock_proxy(t,i) = im_pop(t,i)*pm_kcal_pc_initial(t,i,"livst_rum")
		              /i70_livestock_productivity(t,i,"sys_beef");

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

*############################## DEVELOPMENT ####################################

 if (sum(sameas(t_past,t),1) <> 1,
 	 p70_lsus_dist(t,j) = p70_lsus_dist(t-1,j);
	 p70_lsus_dist_reg(t,i) =  sum(cell(i,j),p70_lsus_dist(t,j));
	 p70_lsus_dist_weight(t,j)$(p70_lsus_dist(t,j) > 0) = p70_lsus_dist(t,j) / sum(cell(i,j),p70_lsus_dist_reg(t,i));
	);


	p70_total_ap_food_demand(t,i,kfo_ap) =  (im_pop(t,i) *  p15_kcal_pc_calibrated(t,i,kfo_ap) * 365) /
																				 (f15_nutrition_attributes(t,kfo_ap,"kcal") * 10**6) -
																				 sum(ct, f15_household_balanceflow(ct,i,kfo_ap,"dm"));

	p70_total_past_demand(t,i) = sum(kfo_ap, p70_total_ap_food_demand(t,i,kfo_ap) *
																	im_feed_baskets2(t,i,kfo_ap,"pasture"));

	p70_mow_yld_corr(t,j) = 1;
	p70_mow_yld_corr(t,j)$((im_past_yields(t,j,"mowing","rainfed") * pm_land_start(j,"past")) > 0) =
											 (sum(cell(i,j),p70_total_past_demand(t,i)) * p70_lsus_dist_weight(t,j)) /
											 (im_past_yields(t,j,"mowing","rainfed") * pm_land_start(j,"past"))$(sum(sameas(t_past,t),1) = 1) +
											 (sum(cell(i,j),p70_total_past_demand(t_past,i)) * p70_lsus_dist_weight(t_past,j)) /
											(im_past_yields(t_past,j,"mowing","rainfed") * pm_land_start(j,"past"))$(ord(t_past)=card(t_past)))$(sum(sameas(t_past,t),1) <> 1);;

*im_past_yields(t,j,"mowing","rainfed") = im_past_yields(t,j,"mowing","rainfed") * p70_mow_yld_corr(t,j);


vm_lsu_ha.up(ct,j2) = 2.5;

*display im_past_yields;
display p70_lsus_dist_weight;
display p70_total_ap_food_demand;
display p70_mow_yld_corr;

*############################## DEVELOPMENT ####################################
*' @stop
