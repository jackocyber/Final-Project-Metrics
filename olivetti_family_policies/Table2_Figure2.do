*This do file re-creates Table 2, Figure 2 (and also online Appendix Tables A3 and A5) in Olivetti and Petrongolo "The Economic Consequences of Family Policies: Lessons from a Century of Legislation in High-Income Countries"

u Table2_Figure2.dta, clear


*Table 2: Institutions and Women's Outcomes 
foreach x in Epop2554 Egap2554 Wgap TFR {
		pwcorr `x' max_job_protected tot_paid_leave_moth_15 repl_ratio_mother_15 paid_father_perc_total ///
					ECEC_11 accumulatedaysoff_startend_13, sig obs
}


/*Figure 2: Employment Gap and Maximum Lenght of Job-Protected Leave for Mothers*/

replace country = "AU" if country == "AUS"
replace country = "AT" if country == "AUT"
replace country = "BL" if country =="BEL"
replace country = "CA" if country =="CAN"
replace country =  "CL" if country == "CHL"
 replace country = "CZ" if country == "CZE"
 replace country = "DK" if country == "DNK"
 replace country = "EE" if country == "EST"
 replace country = "FI" if country == "FIN"
replace country =  "FR" if country == "FRA" 
 replace country = "DE" if country == "DEU"
 replace country = "GR" if country == "GRC"
replace country = "HU" if country == "HUN" 
replace country = "IS" if country == "ISL" 
 replace country = "IE" if country == "IRL"
replace country = "IL" if country == "ISR" 
 replace country = "IT" if country == "ITA"
 replace country = "JP" if country == "JPN"
replace country = "KP" if country == "KOR" 
 replace country = "LU" if country == "LUX"
  replace country = "MX" if country =="MEX"
replace country = "NL" if country == "NLD" 
  replace country = "NZ" if country =="NZL"
replace country = "NO" if country == "NOR" 
 replace country = "PL" if country == "POL"
 replace country = "PT" if country == "PRT"
 replace country = "SVK" if country == "SVK"
replace country = "SI" if country == "SVN" 
 replace country = "ES" if country == "ESP"
 replace country = "SE" if country == "SWE"
 replace country = "CH" if country == "CHE"
replace country = "TR" if country == "TUR" 
replace country = "GB" if country == "GBR" 
 replace country = "US" if country == "USA"
replace country = "BR" if country == "BRA" 
 replace country = "LV" if country == "LVA"
 replace country = "LT" if country =="LTU" 

 
gen EU = (country == "AT" | country == "BL" |country == "CH" | country == "CL" | country == "CZ" | country == "DE" | country == "DK"| country == "ES"| country == "EE"| country == "FI"| country == "FR"| country == "GB"| country == "GR"| country == "HU"| country == "IE"| country == "IT"| country == "LT"| country == "LU"| country == "LV"| country == "NL"| country == "NO"| country == "PL"| country == "PT"| country == "SVK"| country == "SI"| country == "SE"| country == "TR")
gen Asia = ( country == "JP"| country == "KP")
gen NorthAmerica = (country == "MX"| country == "US" | country == "CA")
gen other = (country == "IS"| country == "IL")
gen Australia = (country == "AU"| country == "NZ")
 

*Figure 2: max_job_protected&Egap2554
twoway (scatter max_job_protected Egap2554 if NorthAmerica == 1, mcolor(red) msymbol(smdiamond) mlabel(country) mlabcolor(red) mlabsize(vsmall) mlabposition(12) ) ///
(scatter max_job_protected Egap2554 if Australia == 1, mcolor(purple) msize(small) msymbol(lgx) mlabel(country) mlabcolor(purple) mlabsize(vsmall) mlabcolor(purple) mlabposition(5)) ///
(scatter max_job_protected Egap2554 if EU == 1 & country!="BL" & country!="FR" & country!="SVK"& country!="NO"& country!="DK" & country!="HU",mcolor(orange) msize(small) mlabel(country) mlabsize(vsmall) mlabcolor(navy) mlabposition(6) ) ///
(scatter max_job_protected Egap2554 if country == "HU" | country=="BL", mcolor(orange) msize(small) mlabel(country) mlabsize(vsmall) mlabcolor(navy) mlabposition(5) ) ///
 (scatter max_job_protected Egap2554 if country == "SVK",mcolor(orange) msize(small) mlabel(country) mlabsize(vsmall) mlabcolor(navy) mlabposition(12) ) ///
  (scatter max_job_protected Egap2554 if country=="FR",mcolor(orange) msize(small) mlabel(country) mlabsize(vsmall) mlabcolor(navy) mlabposition(11) ) ///
 (scatter max_job_protected Egap2554 if country == "NO",mcolor(orange) msize(small) mlabel(country) mlabsize(vsmall) mlabcolor(navy) mlabposition(12) )  ///
 (scatter max_job_protected Egap2554 if country == "DK",mcolor(orange) msize(small) mlabel(country) mlabsize(vsmall) mlabcolor(navy) mlabposition(6) ) ///
 (scatter max_job_protected  Egap2554 if other == 1, mcolor(purple) msymbol(circle) mlabel(country) mlabsize(vsmall) mlabcolor(grey) mlabposition(1)) ///
 (scatter max_job_protected  Egap2554 if Asia == 1, mcolor(green) msymbol(triangle) mlabel(country) mlabsize(vsmall) mlabcolor(green) mlabposition(1)), ytitle(Maximum weeks of job-protected leave available to mothers, size(small)) xtitle("Gender employment gap, age group 25 - 54", size(small)) legend(off)
graph export "max_job_protected&Egap2554.pdf", replace

****************
*Table A3: institutions and gender norms 
foreach x in max_job_protected tot_paid_leave_moth_15 repl_ratio_mother_15 paid_father_perc_total ///
					ECEC_11 accumulatedaysoff_startend_13  {
					pwcorr `x' children_fulfilled men_political boys_university childsuffer men_business, sig obs
}

		
*Table A5: institutions and labor market outcomes by education
foreach x in Epop_e1 Epop_e2 Epop_e3 Egap_e1 Egap_e2 Egap_e3 Wgap_e1 Wgap_e2 Wgap_e3 {
pwcorr `x' max_job_protected tot_paid_leave_moth_15 repl_ratio_mother_15 paid_father_perc_total ///
					ECEC_11 accumulatedaysoff_startend_13, sig obs
}


