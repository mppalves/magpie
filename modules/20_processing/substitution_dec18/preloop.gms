*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


loop(t_all,
 if(m_year(t_all) <= sm_fix_SSP2,
  i20_scp_type_shr(t_all,scptype) = f20_scp_type_shr(scptype,"mixed");
 else
  i20_scp_type_shr(t_all,scptype) = f20_scp_type_shr(scptype,"%c20_scp_type%");
 );
);

i20_processing_conversion_factors(t_all,processing20,ksd,kpr) = f20_processing_conversion_factors(t_all,processing20,ksd,kpr);
i20_processing_shares(t_all,i,ksd,kpr) = f20_processing_shares(t_all,i,ksd,kpr);
i20_processing_unitcosts(ksd,kpr) = f20_processing_unitcosts(ksd,kpr);

*SCP can be produced via different routes. The feedstock conversion_factor for SCP accounts for the mix of SCP routes.
i20_scp_conversion_factors(t_all,kpr) = sum(scptype,i20_scp_type_shr(t_all,scptype)*f20_scp_conversionmatrix(kpr,scptype));
i20_processing_conversion_factors(t,"breeding","scp",kpr) = i20_scp_conversion_factors(t,kpr);
*Processing shares for SCP depend on the type of SCP conversion. 
*In case of scp_hydrogen no land-based feedstock is needed. Therefore, the conversion factor is 0, and the processing shares are set to 0.
*In all other cases (scp_methane,scp_sugar,scp_cellulose) exactly one land-based feedstock is needed (foddr,sugr_cane,begr). 
*Therefore, the share of the respective feedstock is set to 1.
i20_processing_shares(t_all,i,"scp",kpr) = 0;
i20_processing_shares(t_all,i,"scp",kpr)$(i20_scp_conversion_factors(t_all,kpr) > 0) = 1;
