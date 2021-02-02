*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

i14_yields(t,j,kve,w) = f14_yields(t,j,kve,w);
i14_past_yields(t,j,past_mngt,w) = f14_past_yields(t,j,past_mngt,w);

***YIELD CORRECTION FOR 2ND GENERATION BIOENERGY CROPS*************************************
i14_yields(t,j,"begr",w) = i14_yields(t,j,"begr",w)*sum(cell(i,j),fm_tau1995(i))/smax(i,fm_tau1995(i));
i14_yields(t,j,"betr",w) = i14_yields(t,j,"betr",w)*sum(cell(i,j),fm_tau1995(i))/smax(i,fm_tau1995(i));

***YIELD CORRECTION FOR PASTURE ACCOUNTING FOR REGIONAL DIFFERENCES IN MANAGEMENT***
p14_pyield_LPJ_reg(t,i) = (sum(cell(i,j),i14_yields(t,j,"pasture","rainfed")*pm_land_start(j,"past"))/sum(cell(i,j),pm_land_start(j,"past")) );

p14_pyield_corr(t,i) = (f14_pyld_hist(t,i)/p14_pyield_LPJ_reg(t,i))$(sum(sameas(t_past,t),1) = 1)
			+ sum(t_past,(f14_pyld_hist(t_past,i)/(p14_pyield_LPJ_reg(t_past,i)+0.000001))$(ord(t_past)=card(t_past)))$(sum(sameas(t_past,t),1) <> 1);
i14_yields(t,j,"pasture",w) = i14_yields(t,j,"pasture",w)*sum(cell(i,j),p14_pyield_corr(t,i));

***YIELD CALIBRATION***********************************************************************
i14_yields(t,j,kcr,w)       = i14_yields(t,j,kcr,w)      *sum(cell(i,j),fm_yld_calib(i,"crop"));
i14_yields(t,j,"pasture",w) = i14_yields(t,j,"pasture",w)*sum(cell(i,j),fm_yld_calib(i,"past"));

***YIELD CORRECTION FOR MOWING ACCOUNTING FOR REGIONAL DIFFERENCES IN MANAGEMENT***
*marcos_develop
p14_myield_LPJ_reg(t,i) = (sum(cell(i,j),i14_past_yields(t,j,"mowing","rainfed")*pm_land_start(j,"past"))/sum(cell(i,j),pm_land_start(j,"past")));

p14_myield_corr(t,i) = (f14_pyld_hist(t,i)/p14_myield_LPJ_reg(t,i))$(sum(sameas(t_past,t),1) = 1)
			+ sum(t_past,(f14_pyld_hist(t_past,i)/(p14_myield_LPJ_reg(t_past,i)+0.000001))$(ord(t_past)=card(t_past)))$(sum(sameas(t_past,t),1) <> 1);
				p14_myield_corr(t,i)$(p14_myield_corr(t,i) < 1)  = 1;
i14_past_yields(t,j,"mowing",w) = i14_past_yields(t,j,"mowing",w)*sum(cell(i,j),p14_myield_corr(t,i));

* The continuous grazing option is not corrected as MAgPIE can decide its yields by managing
* the livestock density.

display p14_myield_corr;
display p14_pyield_corr;
*marcos_develop


*############################## DEVELOPMENT ####################################
$ontext
p70_total_ap_food_demand(t,i,kfo_ap) =  (im_pop(t,i) *  p15_kcal_pc_calibrated(t,i,kfo_ap) * 365) /
																				 (f15_nutrition_attributes(t,kfo_ap,"kcal") * 10**6) -
																				 sum(ct, f15_household_balanceflow(ct,i,kfo_ap,"dm"));

p70_total_past_demand(t,i) = sum(kfo_ap, p70_total_ap_food_demand(t,i,kfo_ap) *
																	im_feed_baskets2(t,i,kfo_ap,"pasture"));

if (sum(sameas(t_past,t),1) = 1,
	p70_mow_yld_corr(t,i) = 1;
	p70_mow_yld_corr(t,i)$(sum(cell(i,j),im_past_yields(t,j,"mowing","rainfed") * pm_land_hist(t,j)) > 0) =
											 p70_total_past_demand(t,i) /
											 sum(cell(i,j), im_past_yields(t,j,"mowing","rainfed") * pm_land_hist(t,j));
	p70_mow_yld_corr(t,i)$(p70_mow_yld_corr(t,i) < 1)  = 1;
 	);

im_past_yields(t,j,"mowing","rainfed") = (im_past_yields(t,j,"mowing","rainfed") * sum(cell(i,j), p70_mow_yld_corr(t,i)))$(sum(sameas(t_past,t),1) = 1) +
sum(t_past,(im_past_yields(t,j,"mowing","rainfed") * sum(cell(i,j), p70_mow_yld_corr(t_past,i)))$(ord(t_past)=card(t_past)))$(sum(sameas(t_past,t),1) <> 1);

vm_lsu_ha.up(ct,j2) = 2.5;

display s31_test_scalar;
display vm_land.l;
display p70_mow_yld_corr;
display f10_land;
display p70_total_past_demand;
display im_past_yields;
$offtext
*############################## DEVELOPMENT ####################################
