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

*################################# DEVELOPMENT #################################
im_past_yields(t,j,kpm,"rainfed") = f14_past_yields(t,j, kpm) * (10000 * 2.21 / 1e6);
*################################# DEVELOPMENT #################################

***YIELD CORRECTION FOR 2ND GENERATION BIOENERGY CROPS*************************************
i14_yields(t,j,"begr",w) = i14_yields(t,j,"begr",w)*sum(cell(i,j),fm_tau1995(i))/smax(i,fm_tau1995(i));
i14_yields(t,j,"betr",w) = i14_yields(t,j,"betr",w)*sum(cell(i,j),fm_tau1995(i))/smax(i,fm_tau1995(i));

***YIELD CALIBRATION***********************************************************************
i14_yields(t,j,kcr,w)       = i14_yields(t,j,kcr,w)      *sum(cell(i,j),f14_yld_calib(i,"crop"));
