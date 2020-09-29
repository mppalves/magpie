*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.devm_dem_feed
$ontext
 Usar a demanda que sai do food module para caulcular o numero de lsus e calcular
 o fator de correcao para o mowing, depois fixar a area de pasto historica e deixar o modelo
 livre para escolher somente entre os tipos de pasto e o yield de cada um.
$offtext

i14_yields(t,j,kve,w) = f14_yields(t,j,kve,w);

*p14_total_pasture_demand(i) = sum(k, vm_dem_food(i,k) * sum(t,im_feed_baskets(t,i,k,"pasture")));
* p70_lsus_dist_weight(t,j)
*sum(cell(i2,j2),v70_lsus_reg(i2)) * sum(ct, p70_lsus_dist_weight(ct,j2))

*################################# DEVELOPMENT #################################
i14_past_yields(t,j,kpm,"rainfed") = f14_past_yields(t,j, kpm) * (10000 * 2.21 / 1e6);
* Mind that preloop adjustments are made only on continous mowing for now.
*################################# DEVELOPMENT #################################

***YIELD CORRECTION FOR 2ND GENERATION BIOENERGY CROPS*************************************
i14_yields(t,j,"begr",w) = i14_yields(t,j,"begr",w)*sum(cell(i,j),fm_tau1995(i))/smax(i,fm_tau1995(i));
i14_yields(t,j,"betr",w) = i14_yields(t,j,"betr",w)*sum(cell(i,j),fm_tau1995(i))/smax(i,fm_tau1995(i));

***YIELD CORRECTION FOR mowing ACCOUNTING FOR REGIONAL DIFFERENCES IN MANAGEMENT***
p14_pyield_LPJ_reg(t,i) = (sum(cell(i,j),i14_past_yields(t,j,"mowing","rainfed")*pm_land_start(j,"past"))/sum(cell(i,j),pm_land_start(j,"past")) );

p14_pyield_corr(t,i) = (f14_pyld_hist(t,i)/p14_pyield_LPJ_reg(t,i))$(sum(sameas(t_past,t),1) = 1)
			+ sum(t_past,(f14_pyld_hist(t_past,i)/(p14_pyield_LPJ_reg(t_past,i)+0.000001))$(ord(t_past)=card(t_past)))$(sum(sameas(t_past,t),1) <> 1);
i14_past_yields(t,j,"mowing",w) = i14_past_yields(t,j,"mowing",w)*sum(cell(i,j),p14_pyield_corr(t,i));

***YIELD CALIBRATION***********************************************************************
i14_yields(t,j,kcr,w)       = i14_yields(t,j,kcr,w)      *sum(cell(i,j),f14_yld_calib(i,"crop"));
i14_past_yields(t,j,"mowing",w) = i14_past_yields(t,j,"mowing",w)*sum(cell(i,j),f14_yld_calib(i,"past"));
