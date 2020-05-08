*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

sets
  ltype14 calibration land types
       / crop, past /
;

* model hash ID a0045b6118215f5e5ffdaaef64fbc7168f1bc851
sets
in_types_p Neural net input features / temperature, precipitation, wetdays, lwnet, rsds, co2, soil, Ks, Sf, w_pwp, w_fc, w_sat, hsg, tdiff_0, tdiff_15, tdiff_100, cond_pwp, cond_100, cond_100_ice, lsu /
in_lsu_p(in_types_p) LSU input type / LSU /
in_env_p(in_types_p) Weather input types /temperature, precipitation, wetdays, lwnet, rsds, co2, soil, Ks, Sf, w_pwp, w_fc, w_sat, hsg, tdiff_0, tdiff_15, tdiff_100, cond_pwp, cond_100, cond_100_ice, lsu/
lnp1 layer 1 / n1_1 * n1_19 /
lnp2 layer 2 / n2_1 * n2_5 /
lnp3 layer 3 / n3_1 * n3_5 /
lnp4 layer 4 / n4_1 * n4_5 /
lnp5 layer 5 / n5_1 * n5_5 /
lnp6 layer 6 / n6_1 * n6_5 /
lnp7 layer 7 / n7_1 * n7_5 /
lnp8 layer 8 / n8_1 /
;
