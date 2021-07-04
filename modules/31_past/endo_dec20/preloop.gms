*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de
i31_manpast_suit(t_all,j) = f31_past_suitability(t_all,j,"past_suit","ssp126");
i31_ratio(j) = fm_LUH2v2("y2010",j,"pastr") / (fm_LUH2v2("y2010",j,"range")+1e-6);


p31_past_suit_corr(t,j) =  (fm_LUH2v2(t,j,"pastr") / f31_past_suitability(t,j,"past_suit","ssp126")+1e-9)$(sum(sameas(t_past,t),1) = 1)
                                + sum(t_past,(fm_LUH2v2(t_past,j,"pastr") / (f31_past_suitability(t_past,j,"past_suit","ssp126")+1e-9))$(ord(t_past)=card(t_past)))$(sum(sameas(t_past,t),1) <> 1);
i31_manpast_suit(t,j) = i31_manpast_suit(t,j) * p31_past_suit_corr(t,j);

display p31_past_suit_corr;
display i31_manpast_suit;
