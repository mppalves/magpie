*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de
i31_manpast_suit(t_all,j) = f31_past_suitability(t_all,j,"past_suit","ssp126");
i31_ratio(j) = f31_LUH2v2("y2010",j,"pastr") / f31_LUH2v2("y2010",j,"range");
