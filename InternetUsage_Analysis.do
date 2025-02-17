// Drop the country aggregates
drop if countrycode == "AFE" || countrycode == "AFW" || countrycode == "ARB" || countrycode == "CEB" || countrycode == "CSS" || countrycode == "EAP" || countrycode == "EAR" || countrycode == "EAS" || countrycode == "ECA" || countrycode == "ECS" || countrycode == "EMU" || countrycode == "EUU" || countrycode == "FCS" || countrycode == "HIC" || countrycode == "HPC" || countrycode == "IBD" || countrycode == "IBT" || countrycode == "IDA" || countrycode == "IDB" || countrycode == "IDX" || countrycode == "LAC" || countrycode == "LCN" || countrycode == "LDC" || countrycode == "LIC" || countrycode == "LMC" || countrycode == "LMY" || countrycode == "LTE" || countrycode == "MEA" || countrycode == "MIC" || countrycode == "MNA" || countrycode == "NAC" || countrycode == "OED" || countrycode == "OSS" || countrycode == "PRE" || countrycode == "PSS" || countrycode == "PST" || countrycode == "SAS" || countrycode == "SSA" || countrycode == "SSF" || countrycode == "SST" || countrycode == "TEA" || countrycode == "TEC" || countrycode == "TLA" || countrycode == "TMN" || countrycode == "TSA" || countrycode == "TSS" || countrycode == "UMC" || countrycode == "WLD"


rename individualsusingtheinternetofpop internetuse
encode countrycode, gen(ccode)
xtset ccode year , yearly

// Divide fdinetinbopcurrusd by 1 billion
gen b_fdinetinbopcurrusd = fdinetinbopcurrusd / 1000000000
label var b_fdinetinbopcurrusd "FDI, net inflows (Billions)"

// Best model 
xtreg internetuse e_peedgini e_polcomp e_gdppc fdinetinbopcurrusd i.year, fe vce(robust)
xtreg internetuse e_peedgini e_polcomp e_gdppc b_fdinetinbopcurrusd i.year, fe vce(robust)
estimates store best_model
estimates label best_model "Best Model"
coefplot best_model, keep(e_peedgini e_polcomp e_gdppc b_fdinetinbopcurrusd) xline(0) title("Best Model - Internet Usage Around The World (1975-2010)", size(medium))
graph export "BestModel_coefplot.png", replace

outreg2 [ best_model ] using BestModelResults.xls, replace

// Robustness check: fdi inflow replaced by overall fdi 
xtreg internetuse e_peedgini v2x_libdem e_gdppc fdinetinbopcurrusd i.year, fe vce(robust)
xtreg internetuse e_peedgini v2x_libdem e_gdppc b_fdinetinbopcurrusd i.year, fe vce(robust)
outreg2 using "robustness.doc", replace
estimates store robust1
estimates label robust1 "Liberal Democracy Model"

//Robustness check: gdp per capita replaced by gdp
xtreg internetuse e_peedgini e_polcomp e_gdp fdinetinbopcurrusd i.year, fe vce(robust)
xtreg internetuse e_peedgini e_polcomp e_gdp b_fdinetinbopcurrusd i.year, fe vce(robust)
outreg2 using "robustness.doc", append
estimates store robust2
estimates label robust2 "GDP Model"

//Robustness check: political competition replaced by ...

//How would I make the coefplot? 2 seperate coefplots or still one coefplot?
coefplot best_model robust1 robust2, xline(0) title("Robustness Check - Internet Usage around the World (1998-2019)")

outreg2 [best_model robust1 robust2] using Robustness.xls, replace label


// Best model, adding weights
// xtreg internetuse e_peedgini e_polcomp e_gdppc fdinetinbopcurrusd  i.year [w=country_weight] , vce(robust)
// estimates store best_model_weighted
// coefplot best_model_weighted, keep(e_peedgini e_polcomp e_gdppc fdinetinbopcurrusd) xline(0) title("Best Model (Weighted) - Internet Usage Around The World (1975-2010)")


//Regressions by regions (do this, but for all regions in separate columns):
//Eastern Europe and Central Asia
xtreg internetuse e_peedgini e_polcomp e_gdppc fdinetinbopcurrusd  i.year if e_regionpol==1 , fe vce(robust) 
xtreg internetuse e_peedgini e_polcomp e_gdppc b_fdinetinbopcurrusd  i.year if e_regionpol==1 , fe vce(robust) 
estimates store EEurope_CAsia_model
estimates label EEurope_CAsia_model "E. Europe and C. Asia"
coefplot EEurope_CAsia_model, keep(e_peedgini e_polcomp e_gdppc fdinetinbopcurrusd) xline(0) title("Internet Usage in Eastern Europe and Central Asia (1975-2010)")

//Latin America
xtreg internetuse e_peedgini e_polcomp e_gdppc fdinetinbopcurrusd  i.year if e_regionpol==2 , fe vce(robust) 
xtreg internetuse e_peedgini e_polcomp e_gdppc b_fdinetinbopcurrusd  i.year if e_regionpol==2 , fe vce(robust) 
estimates store LatinAmerica_model
estimates label LatinAmerica_model "Latin America"
coefplot LatinAmerica_model, keep(e_peedgini e_polcomp e_gdppc fdinetinbopcurrusd) xline(0) title("Internet Usage in Latin America (1975-2010)")

//N. Africa and the Middle East
xtreg internetuse e_peedgini e_polcomp e_gdppc fdinetinbopcurrusd  i.year if e_regionpol==3 , fe vce(robust) 
xtreg internetuse e_peedgini e_polcomp e_gdppc b_fdinetinbopcurrusd  i.year if e_regionpol==3 , fe vce(robust) 
estimates store NAfrica_MidEast_model
estimates label NAfrica_MidEast_model "N. Africa and the Middle East"
coefplot NAfrica_MidEast_model, keep(e_peedgini e_polcomp e_gdppc fdinetinbopcurrusd) xline(0) title("Internet Usage in N. Africa and the Middle East (1975-2010)")

//Sub Saharan Africa
xtreg internetuse e_peedgini e_polcomp e_gdppc fdinetinbopcurrusd  i.year if e_regionpol==4 , fe vce(robust) 
xtreg internetuse e_peedgini e_polcomp e_gdppc b_fdinetinbopcurrusd  i.year if e_regionpol==4 , fe vce(robust) 
estimates store SubSaharanAfrica_model
estimates label SubSaharanAfrica_model "Sub Saharan Africa"
coefplot NAfrica_MidEast_model, keep(e_peedgini e_polcomp e_gdppc fdinetinbopcurrusd) xline(0) title("Internet Usage in Sub Saharan Africa (1975-2010)")

//W. Europe and N. America
xtreg internetuse e_peedgini e_polcomp e_gdppc fdinetinbopcurrusd  i.year if e_regionpol==5 , fe vce(robust) 
xtreg internetuse e_peedgini e_polcomp e_gdppc b_fdinetinbopcurrusd  i.year if e_regionpol==5 , fe vce(robust) 
estimates store WEurope_NAmerica_model
estimates label WEurope_NAmerica_model "W. Europe and N. America"
coefplot WEurope_NAmerica_model, keep(e_peedgini e_polcomp e_gdppc fdinetinbopcurrusd) xline(0) title("Internet Usage in W. Europe and N. America (1975-2010)")

//E. Asia
xtreg internetuse e_peedgini e_polcomp e_gdppc fdinetinbopcurrusd  i.year if e_regionpol==6 , fe vce(robust) 
xtreg internetuse e_peedgini e_polcomp e_gdppc b_fdinetinbopcurrusd  i.year if e_regionpol==6 , fe vce(robust) 
estimates store EastAsia_model
estimates label EastAsia_model "East Asia"
coefplot EastAsia_model, keep(e_peedgini e_polcomp e_gdppc fdinetinbopcurrusd) xline(0) title("Internet Usage in E. Asia (1975-2010)")

//South-East Asia
xtreg internetuse e_peedgini e_polcomp e_gdppc fdinetinbopcurrusd  i.year if e_regionpol==7 , fe vce(robust) 
xtreg internetuse e_peedgini e_polcomp e_gdppc b_fdinetinbopcurrusd  i.year if e_regionpol==7 , fe vce(robust) 
estimates store SouthEastAsia_model
estimates label SouthEastAsia_model "South-East Asia"
coefplot SouthEastAsia_model, keep(e_peedgini e_polcomp e_gdppc fdinetinbopcurrusd) xline(0) title("Internet Usage in South-East Asia (1975-2010)")

//S. Asia
xtreg internetuse e_peedgini e_polcomp e_gdppc fdinetinbopcurrusd  i.year if e_regionpol==8 , fe vce(robust) 
xtreg internetuse e_peedgini e_polcomp e_gdppc b_fdinetinbopcurrusd  i.year if e_regionpol==8 , fe vce(robust) 
estimates store SouthAsia_model
estimates label SouthAsia_model "South Asia"
coefplot SouthAsia_model, keep(e_peedgini e_polcomp e_gdppc fdinetinbopcurrusd) xline(0) title("Internet Usage in S. Asia (1975-2010)")

//The Pacific 
//Note: Not enough observations for this region
xtreg internetuse e_peedgini e_polcomp e_gdppc fdinetinbopcurrusd  i.year if e_regionpol==9 , fe vce(robust) 
xtreg internetuse e_peedgini e_polcomp e_gdppc b_fdinetinbopcurrusd  i.year if e_regionpol==9 , fe vce(robust) 
estimates store ThePacific_model
estimates label ThePacific_model "The Pacific"
coefplot ThePacific_model, keep(e_peedgini e_polcomp e_gdppc fdinetinbopcurrusd) xline(0) title("Internet Usage in The Pacific (1975-2010)")

//The Carribean
xtreg internetuse e_peedgini e_polcomp e_gdppc fdinetinbopcurrusd  i.year if e_regionpol==10 , fe vce(robust) 
xtreg internetuse e_peedgini e_polcomp e_gdppc b_fdinetinbopcurrusd  i.year if e_regionpol==10 , fe vce(robust) 
estimates store TheCarribean_model
estimates label TheCarribean_model "The Carribean"
coefplot TheCarribean_model, keep(e_peedgini e_polcomp e_gdppc fdinetinbopcurrusd) xline(0) title("Internet Usage in The Carribean (1975-2010)")

outreg2 [best_model EEurope_CAsia_model LatinAmerica_model NAfrica_MidEast_model SubSaharanAfrica_model WEurope_NAmerica_model EastAsia_model SouthEastAsia_model SouthAsia_model TheCarribean_model] using RegionalResults.xls, replace label

// coef all regions comparison graph by each variable.
//Educational Equality
coefplot best_model EEurope_CAsia_model LatinAmerica_model NAfrica_MidEast_model SubSaharanAfrica_model WEurope_NAmerica_model EastAsia_model SouthEastAsia_model SouthAsia_model ThePacific_model TheCarribean_model, keep(e_peedgini) xline(0) ytitle("Educational Equality") ylabel(none)

//Political Competition
coefplot best_model EEurope_CAsia_model LatinAmerica_model NAfrica_MidEast_model SubSaharanAfrica_model WEurope_NAmerica_model EastAsia_model SouthEastAsia_model SouthAsia_model ThePacific_model TheCarribean_model, keep(e_polcomp) xline(0) ytitle("Political Competition") ylabel(none)

//GDP Per Capita
coefplot best_model EEurope_CAsia_model LatinAmerica_model NAfrica_MidEast_model SubSaharanAfrica_model WEurope_NAmerica_model EastAsia_model SouthEastAsia_model SouthAsia_model ThePacific_model TheCarribean_model, keep(e_gdppc) xline(0) ytitle("GDP Per Capita") ylabel(none)

//Foreign direct investment, net inflows (% of GDP)
coefplot best_model EEurope_CAsia_model LatinAmerica_model NAfrica_MidEast_model SubSaharanAfrica_model WEurope_NAmerica_model EastAsia_model SouthEastAsia_model SouthAsia_model ThePacific_model TheCarribean_model, keep(fdinetinbopcurrusd) xline(0) ytitle("FDI Net Inflow (% of GDP)") ylabel(none)

//Regressions by Decades:
//Note: Results in "No Observations"
//1975-1980
xtreg internetuse e_peedgini e_polcomp e_gdppc fdinetinbopcurrusd i.year if year >= 1975 & year <= 1980, fe vce(robust)

//Note: does not show any data for the years, it instead says omitted
//1981-1990
xtreg internetuse e_peedgini e_polcomp e_gdppc fdinetinbopcurrusd i.year if year >= 1981 & year <= 1990, fe vce(robust)

//1991-2000
xtreg internetuse e_peedgini e_polcomp e_gdppc fdinetinbopcurrusd i.year if year >= 1991 & year <= 2000, fe vce(robust)
xtreg internetuse e_peedgini e_polcomp e_gdppc b_fdinetinbopcurrusd i.year if year >= 1991 & year <= 2000, fe vce(robust)
estimates store nineties_model
estimates label nineties_model "90s Model"

//2001-2010
xtreg internetuse e_peedgini e_polcomp e_gdppc fdinetinbopcurrusd i.year if year >= 2001 & year <= 2010, fe vce(robust)
xtreg internetuse e_peedgini e_polcomp e_gdppc b_fdinetinbopcurrusd i.year if year >= 2001 & year <= 2010, fe vce(robust)
estimates store early_twothousands_model
estimates label early_twothousands_model "Early 2000s Model"

//Robustness Check: time lagged
xtreg internetuse e_peedgini e_polcomp e_gdppc fdinetinbopcurrusd l.internetuse i.year, fe vce(robust)
xtreg internetuse e_peedgini e_polcomp e_gdppc b_fdinetinbopcurrusd l.internetuse i.year, fe vce(robust)
estimates store robust_timelagged
estimates label robust_difference "Time Lagged Internet Use"

//Robustness Check: First and second differences of dependent variables (how difference in internet access of previous and a year previous of that affects the present-year internet access)
xtreg internetuse e_peedgini e_polcomp e_gdppc fdinetinbopcurrusd d.internetuse d2.internetuse i.year, fe vce(robust)
xtreg internetuse e_peedgini e_polcomp e_gdppc b_fdinetinbopcurrusd d.internetuse d2.internetuse i.year, fe vce(robust)
estimates store robust_difference
estimates label robust_difference "Differences of Internet Use" 

outreg2 [best_model robust1 robust2 robust_timelagged robust_difference nineties_model early_twothousands_model] using MainResults.xls, replace label

//generating mean for each year for each
collapse (mean) internetuse e_peedgini e_polcomp e_gdppc fdinetinbopcurrusd, by(year)

//generating line graphs
twoway (line internetuse year) (line e_peedgini year) (line e_polcomp year) (line e_gdppc year) (line fdinetinbopcurrusd year)

twoway (connected internetuse year)

twoway (connected e_peedgini year)

twoway (connected e_polcomp year)

twoway (connected e_gdppc year)

twoway (connected fdinetinbopcurrusd year)

//Line graphs
set scheme stcolor

 
egen internetuse_l_EEurope_CAsia = mean(internetuse) if e_regionpol==1, by(year)
label variable internetuse_l_EEurope_CAsia "E. Europe and C. Asia"

egen internetuse_l_LatinAmerica = mean(internetuse) if e_regionpol==2, by(year)
label variable internetuse_l_LatinAmerica "Latin America"

egen internetuse_l_NAfrica_MidEast = mean(internetuse) if e_regionpol==3, by(year)
label variable internetuse_l_NAfrica_MidEast "N. Africa and Middle East"

egen internetuse_l_SubSaharanAfrica = mean(internetuse) if e_regionpol==4, by(year)
label variable internetuse_l_SubSaharanAfrica "Sub Saharan Africa"

egen internetuse_l_WEurope_NAmerica = mean(internetuse) if e_regionpol==5, by(year)
label variable internetuse_l_WEurope_NAmerica "W. Europe and N. America"

egen internetuse_l_EastAsia = mean(internetuse) if e_regionpol==6, by(year)
label variable internetuse_l_EastAsia "East Asia"

egen internetuse_l_SouthEastAsia = mean(internetuse) if e_regionpol==7, by(year)
label variable internetuse_l_SouthEastAsia "South-East Asia"

egen internetuse_l_SouthAsia = mean(internetuse) if e_regionpol==8, by(year)
label variable internetuse_l_SouthAsia "South Asia"

egen internetuse_l_ThePacific = mean(internetuse) if e_regionpol==9, by(year)
label variable internetuse_l_ThePacific "The Pacific"

egen internetuse_l_TheCarribean = mean(internetuse) if e_regionpol==10, by(year)
label variable internetuse_l_TheCarribean "The Carribean"

egen internetuse_l_avg = mean(internetuse) , by(year)
label variable internetuse_l_avg "Average"

line internetuse_l_avg internetuse_l_EEurope_CAsia year, title("Internet Usage Across Regions") note("Source:  World Bank and VDem Database") name(figure2a, replace) legend(size(small) pos(6) row(2) region(fcolor(gs15)))

//Scatterplot
egen internetuse_avg = mean(internetuse), by(country_name)
egen e_peedgini_avg = mean(e_peedgini), by(country_name)
egen e_polcomp_avg = mean(e_polcomp), by(country_name)
egen e_gdppc_avg = mean(e_gdppc), by(country_name)
egen fdinetinbopcurrusd_avg = mean(b_fdinetinbopcurrusd), by(country_name)
 

scatter internetuse_avg e_peedgini_avg, mlabel (country_name) ytitle("Internet Usage (1975-2010)") xtitle("Educational Inequality, Gini (1975-2010)")
scatter internetuse_avg e_polcomp_avg, mlabel (country_name) ytitle("Internet Usage (1975-2010)") xtitle("Political Competition (1975-2010)")
scatter internetuse_avg e_gdppc_avg, mlabel (country_name) ytitle("Internet Usage (1975-2010)") xtitle("GDP Per Capita (1975-2010)")
scatter internetuse_avg fdinetinbopcurrusd_avg, mlabel (country_name) ytitle("Internet Usage (1975-2010)") xtitle("FDI, net inflows (Billions) (1975-2010)")

