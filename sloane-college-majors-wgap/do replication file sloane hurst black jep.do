/********This is the replication file for College Majors, Occupations, and the Gender Wage Gap by Sloane, Hurst and Black. 
Manuscript: JEP-2021-1219 
ICPSR: openicpsr-149061
August 2021
This do-file:
1. reads in and cleans the raw data (from the 2014-2017 American Community Survey)to create a main analysis file
2. creates all figures from the main text (Figures 1-6)
3. creates all tables from the main text (Tables 1,2)
4. creates all figures from the Online Appendix (Figures A6-A11... Note Figures A1-A5 are just data documentation and do not require replication.)
5. creates all tables from the Online Appendix (Tables A1-A11)

* NOTE: You will need to change the directory to your own working directory.*/

/***********************************************************************************************************
/************************Data Citations/ References*********************************************************************/
IPUMS USA (corresponds to usa_00147.dat and usa_00165.dat):
Steven Ruggles, Sarah Flood, Ronald Goeken, Josiah Grover, Erin Meyer, Jose Pacas, and Matthew Sobek., “IPUMS USA: Version 9.0 [dataset],” Minneapolis, MN: IPUMS, 2019, 10, D010.

Dorn occupation crosswalk (corresponds to occ2005_occ1990dd.dta) accessed from 
www.ddorn.net/data.htm
Dorn, David. "Essays on inequality, spatial interaction, and the demand for skills." PhD diss., Verlag nicht ermittelbar, 2009.
Autor, David H. and Dorn, David, "The growth of low-skill service jobs and the polarization of the US labor market,” American Economic Review, 2013, 103(5), 1553-97.

Some data analysis uses user-written command -egenmore- 
Nicholas J. Cox, 2000. "EGENMORE: Stata modules to extend the generate function," Statistical Software Components S386401, Boston College Department of Economics, revised 24 Jan 2019.

*************************************************************************************************************/


/***********************************************************************************************************/
/***************************** Read in American Community Survey Data from Multiple Years from IPUMS USA (Ruggles et al, 2019) ******************/
/***********************************************************************************************************/
/***********************************************************************************************************/


# delimit cr
log using "C:\Users\cmslo\Box Sync\JEP Replication files\read in data_check.smcl", replace 
clear all 

cd "C:\Users\cmslo\Box Sync\JEP Replication files"

set more off

clear
quietly infix                  ///
  int     year        1-4      ///
  byte    datanum     5-6      ///
  double  serial      7-14     ///
  double  cbserial    15-27    ///
  double  hhwt        28-37    ///
  byte    region      38-39    ///
  byte    statefip    40-41    ///
  byte    gq          42-42    ///
  byte    gqtype      43-43    ///
  int     gqtyped     44-46    ///
  int     pernum      47-50    ///
  double  perwt       51-60    ///
  byte    nchild      61-61    ///
  byte    nchlt5      62-62    ///
  byte    eldch       63-64    ///
  byte    yngch       65-66    ///
  byte    sex         67-67    ///
  int     age         68-70    ///
  byte    marst       71-71    ///
  int     birthyr     72-75    ///
  byte    marrno      76-76    ///
  int     yrmarr      77-80    ///
  byte    fertyr      81-81    ///
  byte    race        82-82    ///
  int     raced       83-85    ///
  byte    hispan      86-86    ///
  int     hispand     87-89    ///
  int     bpl         90-92    ///
  long    bpld        93-97    ///
  byte    citizen     98-98    ///
  byte    educ        99-100   ///
  int     educd       101-103  ///
  byte    degfield    104-105  ///
  int     degfieldd   106-109  ///
  byte    degfield2   110-111  ///
  int     degfield2d  112-115  ///
  byte    empstat     116-116  ///
  byte    empstatd    117-118  ///
  byte    labforce    119-119  ///
  int     occ         120-123  ///
  int     occ1990     124-126  ///
  byte    classwkr    127-127  ///
  byte    classwkrd   128-129  ///
  byte    wkswork2    130-130  ///
  byte    uhrswork    131-132  ///
  long    incwage     133-138  ///
  byte    migrate1    139-139  ///
  byte    migrate1d   140-141  ///
  int     migplac1    142-144  ///
  byte    qage        145-145  ///
  byte    qfertyr     146-146  ///
  byte    qmarrno     147-147  ///
  byte    qmarst      148-148  ///
  byte    qsex        149-149  ///
  byte    qyrmarr     150-150  ///
  byte    qbpl        151-151  ///
  byte    qcitizen    152-152  ///
  byte    qhispan     153-153  ///
  byte    qrace       154-154  ///
  byte    qeduc       155-155  ///
  byte    qdegfield   156-156  ///
  byte    qclasswk    157-157  ///
  byte    qempstat    158-158  ///
  byte    qocc        159-159  ///
  byte    quhrswor    160-160  ///
  byte    qwkswork    161-161  ///
  byte    qincwage    162-162  ///
  byte    qmigplc1    163-163  ///
  byte    qmigrat1    164-164  ///
  using `"usa_00165.dat"'

replace hhwt       = hhwt       / 100
replace perwt      = perwt      / 100

format serial     %8.0g
format cbserial   %13.0g
format hhwt       %10.2f
format perwt      %10.2f

label var year       `"Census year"'
label var datanum    `"Data set number"'
label var serial     `"Household serial number"'
label var cbserial   `"Original Census Bureau household serial number"'
label var hhwt       `"Household weight"'
label var region     `"Census region and division"'
label var statefip   `"State (FIPS code)"'
label var gq         `"Group quarters status"'
label var gqtype     `"Group quarters type [general version]"'
label var gqtyped    `"Group quarters type [detailed version]"'
label var pernum     `"Person number in sample unit"'
label var perwt      `"Person weight"'
label var nchild     `"Number of own children in the household"'
label var nchlt5     `"Number of own children under age 5 in household"'
label var eldch      `"Age of eldest own child in household"'
label var yngch      `"Age of youngest own child in household"'
label var sex        `"Sex"'
label var age        `"Age"'
label var marst      `"Marital status"'
label var birthyr    `"Year of birth"'
label var marrno     `"Times married"'
label var yrmarr     `"Year married"'
label var fertyr     `"Children born within the last year"'
label var race       `"Race [general version]"'
label var raced      `"Race [detailed version]"'
label var hispan     `"Hispanic origin [general version]"'
label var hispand    `"Hispanic origin [detailed version]"'
label var bpl        `"Birthplace [general version]"'
label var bpld       `"Birthplace [detailed version]"'
label var citizen    `"Citizenship status"'
label var educ       `"Educational attainment [general version]"'
label var educd      `"Educational attainment [detailed version]"'
label var degfield   `"Field of degree [general version]"'
label var degfieldd  `"Field of degree [detailed version]"'
label var degfield2  `"Field of degree (2) [general version]"'
label var degfield2d `"Field of degree (2) [detailed version]"'
label var empstat    `"Employment status [general version]"'
label var empstatd   `"Employment status [detailed version]"'
label var labforce   `"Labor force status"'
label var occ        `"Occupation"'
label var occ1990    `"Occupation, 1990 basis"'
label var classwkr   `"Class of worker [general version]"'
label var classwkrd  `"Class of worker [detailed version]"'
label var wkswork2   `"Weeks worked last year, intervalled"'
label var uhrswork   `"Usual hours worked per week"'
label var incwage    `"Wage and salary income"'
label var migrate1   `"Migration status, 1 year [general version]"'
label var migrate1d  `"Migration status, 1 year [detailed version]"'
label var migplac1   `"State or country of residence 1 year ago"'
label var qage       `"Flag for Age"'
label var qfertyr    `"Flag for Fertyr"'
label var qmarrno    `"Flag for Marrno"'
label var qmarst     `"Flag for Marst"'
label var qsex       `"Flag for Sex"'
label var qyrmarr    `"Data quality flag for YRLSTMAR"'
label var qbpl       `"Flag for Bpl, Nativity"'
label var qcitizen   `"Flag for Citizen"'
label var qhispan    `"Flag for Hispan"'
label var qrace      `"Flag for Race, Racamind, Racasian, Racblk, Racpais, Racwht, Racoth, Racnum, Race"'
label var qeduc      `"Flag for Educrec, Higrade, Educ99"'
label var qdegfield  `"Data quality flag for DEGFIELD and DEGFIELD2"'
label var qclasswk   `"Flag for Classwkr"'
label var qempstat   `"Flag for Empstat, Labforce"'
label var qocc       `"Flag for Occ, Occ1950, SEI, Occscore, Occsoc, Labforce"'
label var quhrswor   `"Flag for Uhrswork"'
label var qwkswork   `"Flag for Wkswork1, Wkswork2"'
label var qincwage   `"Flag for Incwage, Inctot, Incearn"'
label var qmigplc1   `"Flag for Migplac1"'
label var qmigrat1   `"Flag for Migrate1"'

label define year_lbl 1850 `"1850"'
label define year_lbl 1860 `"1860"', add
label define year_lbl 1870 `"1870"', add
label define year_lbl 1880 `"1880"', add
label define year_lbl 1900 `"1900"', add
label define year_lbl 1910 `"1910"', add
label define year_lbl 1920 `"1920"', add
label define year_lbl 1930 `"1930"', add
label define year_lbl 1940 `"1940"', add
label define year_lbl 1950 `"1950"', add
label define year_lbl 1960 `"1960"', add
label define year_lbl 1970 `"1970"', add
label define year_lbl 1980 `"1980"', add
label define year_lbl 1990 `"1990"', add
label define year_lbl 2000 `"2000"', add
label define year_lbl 2001 `"2001"', add
label define year_lbl 2002 `"2002"', add
label define year_lbl 2003 `"2003"', add
label define year_lbl 2004 `"2004"', add
label define year_lbl 2005 `"2005"', add
label define year_lbl 2006 `"2006"', add
label define year_lbl 2007 `"2007"', add
label define year_lbl 2008 `"2008"', add
label define year_lbl 2009 `"2009"', add
label define year_lbl 2010 `"2010"', add
label define year_lbl 2011 `"2011"', add
label define year_lbl 2012 `"2012"', add
label define year_lbl 2013 `"2013"', add
label define year_lbl 2014 `"2014"', add
label define year_lbl 2015 `"2015"', add
label define year_lbl 2016 `"2016"', add
label define year_lbl 2017 `"2017"', add
label values year year_lbl

label define region_lbl 11 `"New England Division"'
label define region_lbl 12 `"Middle Atlantic Division"', add
label define region_lbl 13 `"Mixed Northeast Divisions (1970 Metro)"', add
label define region_lbl 21 `"East North Central Div."', add
label define region_lbl 22 `"West North Central Div."', add
label define region_lbl 23 `"Mixed Midwest Divisions (1970 Metro)"', add
label define region_lbl 31 `"South Atlantic Division"', add
label define region_lbl 32 `"East South Central Div."', add
label define region_lbl 33 `"West South Central Div."', add
label define region_lbl 34 `"Mixed Southern Divisions (1970 Metro)"', add
label define region_lbl 41 `"Mountain Division"', add
label define region_lbl 42 `"Pacific Division"', add
label define region_lbl 43 `"Mixed Western Divisions (1970 Metro)"', add
label define region_lbl 91 `"Military/Military reservations"', add
label define region_lbl 92 `"PUMA boundaries cross state lines-1% sample"', add
label define region_lbl 97 `"State not identified"', add
label define region_lbl 99 `"Not identified"', add
label values region region_lbl

label define statefip_lbl 01 `"Alabama"'
label define statefip_lbl 02 `"Alaska"', add
label define statefip_lbl 04 `"Arizona"', add
label define statefip_lbl 05 `"Arkansas"', add
label define statefip_lbl 06 `"California"', add
label define statefip_lbl 08 `"Colorado"', add
label define statefip_lbl 09 `"Connecticut"', add
label define statefip_lbl 10 `"Delaware"', add
label define statefip_lbl 11 `"District of Columbia"', add
label define statefip_lbl 12 `"Florida"', add
label define statefip_lbl 13 `"Georgia"', add
label define statefip_lbl 15 `"Hawaii"', add
label define statefip_lbl 16 `"Idaho"', add
label define statefip_lbl 17 `"Illinois"', add
label define statefip_lbl 18 `"Indiana"', add
label define statefip_lbl 19 `"Iowa"', add
label define statefip_lbl 20 `"Kansas"', add
label define statefip_lbl 21 `"Kentucky"', add
label define statefip_lbl 22 `"Louisiana"', add
label define statefip_lbl 23 `"Maine"', add
label define statefip_lbl 24 `"Maryland"', add
label define statefip_lbl 25 `"Massachusetts"', add
label define statefip_lbl 26 `"Michigan"', add
label define statefip_lbl 27 `"Minnesota"', add
label define statefip_lbl 28 `"Mississippi"', add
label define statefip_lbl 29 `"Missouri"', add
label define statefip_lbl 30 `"Montana"', add
label define statefip_lbl 31 `"Nebraska"', add
label define statefip_lbl 32 `"Nevada"', add
label define statefip_lbl 33 `"New Hampshire"', add
label define statefip_lbl 34 `"New Jersey"', add
label define statefip_lbl 35 `"New Mexico"', add
label define statefip_lbl 36 `"New York"', add
label define statefip_lbl 37 `"North Carolina"', add
label define statefip_lbl 38 `"North Dakota"', add
label define statefip_lbl 39 `"Ohio"', add
label define statefip_lbl 40 `"Oklahoma"', add
label define statefip_lbl 41 `"Oregon"', add
label define statefip_lbl 42 `"Pennsylvania"', add
label define statefip_lbl 44 `"Rhode Island"', add
label define statefip_lbl 45 `"South Carolina"', add
label define statefip_lbl 46 `"South Dakota"', add
label define statefip_lbl 47 `"Tennessee"', add
label define statefip_lbl 48 `"Texas"', add
label define statefip_lbl 49 `"Utah"', add
label define statefip_lbl 50 `"Vermont"', add
label define statefip_lbl 51 `"Virginia"', add
label define statefip_lbl 53 `"Washington"', add
label define statefip_lbl 54 `"West Virginia"', add
label define statefip_lbl 55 `"Wisconsin"', add
label define statefip_lbl 56 `"Wyoming"', add
label define statefip_lbl 61 `"Maine-New Hampshire-Vermont"', add
label define statefip_lbl 62 `"Massachusetts-Rhode Island"', add
label define statefip_lbl 63 `"Minnesota-Iowa-Missouri-Kansas-Nebraska-S.Dakota-N.Dakota"', add
label define statefip_lbl 64 `"Maryland-Delaware"', add
label define statefip_lbl 65 `"Montana-Idaho-Wyoming"', add
label define statefip_lbl 66 `"Utah-Nevada"', add
label define statefip_lbl 67 `"Arizona-New Mexico"', add
label define statefip_lbl 68 `"Alaska-Hawaii"', add
label define statefip_lbl 72 `"Puerto Rico"', add
label define statefip_lbl 97 `"Military/Mil. Reservation"', add
label define statefip_lbl 99 `"State not identified"', add
label values statefip statefip_lbl

label define gq_lbl 0 `"Vacant unit"'
label define gq_lbl 1 `"Households under 1970 definition"', add
label define gq_lbl 2 `"Additional households under 1990 definition"', add
label define gq_lbl 3 `"Group quarters--Institutions"', add
label define gq_lbl 4 `"Other group quarters"', add
label define gq_lbl 5 `"Additional households under 2000 definition"', add
label define gq_lbl 6 `"Fragment"', add
label values gq gq_lbl

label define gqtype_lbl 0 `"NA (non-group quarters households)"'
label define gqtype_lbl 1 `"Institution (1990, 2000, ACS/PRCS)"', add
label define gqtype_lbl 2 `"Correctional institutions"', add
label define gqtype_lbl 3 `"Mental institutions"', add
label define gqtype_lbl 4 `"Institutions for the elderly, handicapped, and poor"', add
label define gqtype_lbl 5 `"Non-institutional GQ"', add
label define gqtype_lbl 6 `"Military"', add
label define gqtype_lbl 7 `"College dormitory"', add
label define gqtype_lbl 8 `"Rooming house"', add
label define gqtype_lbl 9 `"Other non-institutional GQ and unknown"', add
label values gqtype gqtype_lbl

label define gqtyped_lbl 000 `"NA (non-group quarters households)"'
label define gqtyped_lbl 010 `"Family group, someone related to head"', add
label define gqtyped_lbl 020 `"Unrelated individuals, no one related to head"', add
label define gqtyped_lbl 100 `"Institution (1990, 2000, ACS/PRCS)"', add
label define gqtyped_lbl 200 `"Correctional institution"', add
label define gqtyped_lbl 210 `"Federal/state correctional"', add
label define gqtyped_lbl 211 `"Prison"', add
label define gqtyped_lbl 212 `"Penitentiary"', add
label define gqtyped_lbl 213 `"Military prison"', add
label define gqtyped_lbl 220 `"Local correctional"', add
label define gqtyped_lbl 221 `"Jail"', add
label define gqtyped_lbl 230 `"School juvenile delinquents"', add
label define gqtyped_lbl 240 `"Reformatory"', add
label define gqtyped_lbl 250 `"Camp or chain gang"', add
label define gqtyped_lbl 260 `"House of correction"', add
label define gqtyped_lbl 300 `"Mental institutions"', add
label define gqtyped_lbl 400 `"Institutions for the elderly, handicapped, and poor"', add
label define gqtyped_lbl 410 `"Homes for elderly"', add
label define gqtyped_lbl 411 `"Aged, dependent home"', add
label define gqtyped_lbl 412 `"Nursing/convalescent home"', add
label define gqtyped_lbl 413 `"Old soldiers' home"', add
label define gqtyped_lbl 420 `"Other Instits (Not Aged)"', add
label define gqtyped_lbl 421 `"Other Institution nec"', add
label define gqtyped_lbl 430 `"Homes neglected/depend children"', add
label define gqtyped_lbl 431 `"Orphan school"', add
label define gqtyped_lbl 432 `"Orphans' home, asylum"', add
label define gqtyped_lbl 440 `"Other instits for children"', add
label define gqtyped_lbl 441 `"Children's home, asylum"', add
label define gqtyped_lbl 450 `"Homes physically handicapped"', add
label define gqtyped_lbl 451 `"Deaf, blind school"', add
label define gqtyped_lbl 452 `"Deaf, blind, epilepsy"', add
label define gqtyped_lbl 460 `"Mentally handicapped home"', add
label define gqtyped_lbl 461 `"School for feeblemind"', add
label define gqtyped_lbl 470 `"TB and chronic disease hospital"', add
label define gqtyped_lbl 471 `"Chronic hospitals"', add
label define gqtyped_lbl 472 `"Sanatoria"', add
label define gqtyped_lbl 480 `"Poor houses and farms"', add
label define gqtyped_lbl 481 `"Poor house, almshouse"', add
label define gqtyped_lbl 482 `"Poor farm, workhouse"', add
label define gqtyped_lbl 491 `"Maternity homes for unmarried mothers"', add
label define gqtyped_lbl 492 `"Homes for widows, single, fallen women"', add
label define gqtyped_lbl 493 `"Detention homes"', add
label define gqtyped_lbl 494 `"Misc asylums"', add
label define gqtyped_lbl 495 `"Home, other dependent"', add
label define gqtyped_lbl 496 `"Institution combination or unknown"', add
label define gqtyped_lbl 500 `"Non-institutional group quarters"', add
label define gqtyped_lbl 501 `"Family formerly in institutional group quarters"', add
label define gqtyped_lbl 502 `"Unrelated individual residing with family formerly in institutional group quarters"', add
label define gqtyped_lbl 600 `"Military"', add
label define gqtyped_lbl 601 `"U.S. army installation"', add
label define gqtyped_lbl 602 `"Navy, marine installation"', add
label define gqtyped_lbl 603 `"Navy ships"', add
label define gqtyped_lbl 604 `"Air service"', add
label define gqtyped_lbl 700 `"College dormitory"', add
label define gqtyped_lbl 701 `"Military service academies"', add
label define gqtyped_lbl 800 `"Rooming house"', add
label define gqtyped_lbl 801 `"Hotel"', add
label define gqtyped_lbl 802 `"House, lodging apartments"', add
label define gqtyped_lbl 803 `"YMCA, YWCA"', add
label define gqtyped_lbl 804 `"Club"', add
label define gqtyped_lbl 900 `"Other Non-Instit GQ"', add
label define gqtyped_lbl 901 `"Other Non-Instit GQ"', add
label define gqtyped_lbl 910 `"Schools"', add
label define gqtyped_lbl 911 `"Boarding schools"', add
label define gqtyped_lbl 912 `"Academy, institute"', add
label define gqtyped_lbl 913 `"Industrial training"', add
label define gqtyped_lbl 914 `"Indian school"', add
label define gqtyped_lbl 920 `"Hospitals"', add
label define gqtyped_lbl 921 `"Hospital, charity"', add
label define gqtyped_lbl 922 `"Infirmary"', add
label define gqtyped_lbl 923 `"Maternity hospital"', add
label define gqtyped_lbl 924 `"Children's hospital"', add
label define gqtyped_lbl 931 `"Church, Abbey"', add
label define gqtyped_lbl 932 `"Convent"', add
label define gqtyped_lbl 933 `"Monastery"', add
label define gqtyped_lbl 934 `"Mission"', add
label define gqtyped_lbl 935 `"Seminary"', add
label define gqtyped_lbl 936 `"Religious commune"', add
label define gqtyped_lbl 937 `"Other religious"', add
label define gqtyped_lbl 940 `"Work sites"', add
label define gqtyped_lbl 941 `"Construction, except rr"', add
label define gqtyped_lbl 942 `"Lumber"', add
label define gqtyped_lbl 943 `"Mining"', add
label define gqtyped_lbl 944 `"Railroad"', add
label define gqtyped_lbl 945 `"Farms, ranches"', add
label define gqtyped_lbl 946 `"Ships, boats"', add
label define gqtyped_lbl 947 `"Other industrial"', add
label define gqtyped_lbl 948 `"Other worksites"', add
label define gqtyped_lbl 950 `"Nurses home, dorm"', add
label define gqtyped_lbl 955 `"Passenger ships"', add
label define gqtyped_lbl 960 `"Other group quarters"', add
label define gqtyped_lbl 997 `"Unknown"', add
label define gqtyped_lbl 999 `"Fragment (boarders and lodgers, 1900)"', add
label values gqtyped gqtyped_lbl

label define nchild_lbl 0 `"0 children present"'
label define nchild_lbl 1 `"1 child present"', add
label define nchild_lbl 2 `"2"', add
label define nchild_lbl 3 `"3"', add
label define nchild_lbl 4 `"4"', add
label define nchild_lbl 5 `"5"', add
label define nchild_lbl 6 `"6"', add
label define nchild_lbl 7 `"7"', add
label define nchild_lbl 8 `"8"', add
label define nchild_lbl 9 `"9+"', add
label values nchild nchild_lbl

label define nchlt5_lbl 0 `"No children under age 5"'
label define nchlt5_lbl 1 `"1 child under age 5"', add
label define nchlt5_lbl 2 `"2"', add
label define nchlt5_lbl 3 `"3"', add
label define nchlt5_lbl 4 `"4"', add
label define nchlt5_lbl 5 `"5"', add
label define nchlt5_lbl 6 `"6"', add
label define nchlt5_lbl 7 `"7"', add
label define nchlt5_lbl 8 `"8"', add
label define nchlt5_lbl 9 `"9+"', add
label values nchlt5 nchlt5_lbl

label define eldch_lbl 00 `"Less than 1 year old"'
label define eldch_lbl 01 `"1"', add
label define eldch_lbl 02 `"2"', add
label define eldch_lbl 03 `"3"', add
label define eldch_lbl 04 `"4"', add
label define eldch_lbl 05 `"5"', add
label define eldch_lbl 06 `"6"', add
label define eldch_lbl 07 `"7"', add
label define eldch_lbl 08 `"8"', add
label define eldch_lbl 09 `"9"', add
label define eldch_lbl 10 `"10"', add
label define eldch_lbl 11 `"11"', add
label define eldch_lbl 12 `"12"', add
label define eldch_lbl 13 `"13"', add
label define eldch_lbl 14 `"14"', add
label define eldch_lbl 15 `"15"', add
label define eldch_lbl 16 `"16"', add
label define eldch_lbl 17 `"17"', add
label define eldch_lbl 18 `"18"', add
label define eldch_lbl 19 `"19"', add
label define eldch_lbl 20 `"20"', add
label define eldch_lbl 21 `"21"', add
label define eldch_lbl 22 `"22"', add
label define eldch_lbl 23 `"23"', add
label define eldch_lbl 24 `"24"', add
label define eldch_lbl 25 `"25"', add
label define eldch_lbl 26 `"26"', add
label define eldch_lbl 27 `"27"', add
label define eldch_lbl 28 `"28"', add
label define eldch_lbl 29 `"29"', add
label define eldch_lbl 30 `"30"', add
label define eldch_lbl 31 `"31"', add
label define eldch_lbl 32 `"32"', add
label define eldch_lbl 33 `"33"', add
label define eldch_lbl 34 `"34"', add
label define eldch_lbl 35 `"35"', add
label define eldch_lbl 36 `"36"', add
label define eldch_lbl 37 `"37"', add
label define eldch_lbl 38 `"38"', add
label define eldch_lbl 39 `"39"', add
label define eldch_lbl 40 `"40"', add
label define eldch_lbl 41 `"41"', add
label define eldch_lbl 42 `"42"', add
label define eldch_lbl 43 `"43"', add
label define eldch_lbl 44 `"44"', add
label define eldch_lbl 45 `"45"', add
label define eldch_lbl 46 `"46"', add
label define eldch_lbl 47 `"47"', add
label define eldch_lbl 48 `"48"', add
label define eldch_lbl 49 `"49"', add
label define eldch_lbl 50 `"50"', add
label define eldch_lbl 51 `"51"', add
label define eldch_lbl 52 `"52"', add
label define eldch_lbl 53 `"53"', add
label define eldch_lbl 54 `"54"', add
label define eldch_lbl 55 `"55"', add
label define eldch_lbl 56 `"56"', add
label define eldch_lbl 57 `"57"', add
label define eldch_lbl 58 `"58"', add
label define eldch_lbl 59 `"59"', add
label define eldch_lbl 60 `"60"', add
label define eldch_lbl 61 `"61"', add
label define eldch_lbl 62 `"62"', add
label define eldch_lbl 63 `"63"', add
label define eldch_lbl 64 `"64"', add
label define eldch_lbl 65 `"65"', add
label define eldch_lbl 66 `"66"', add
label define eldch_lbl 67 `"67"', add
label define eldch_lbl 68 `"68"', add
label define eldch_lbl 69 `"69"', add
label define eldch_lbl 70 `"70"', add
label define eldch_lbl 71 `"71"', add
label define eldch_lbl 72 `"72"', add
label define eldch_lbl 73 `"73"', add
label define eldch_lbl 74 `"74"', add
label define eldch_lbl 75 `"75"', add
label define eldch_lbl 76 `"76"', add
label define eldch_lbl 77 `"77"', add
label define eldch_lbl 78 `"78"', add
label define eldch_lbl 79 `"79"', add
label define eldch_lbl 80 `"80"', add
label define eldch_lbl 81 `"81"', add
label define eldch_lbl 82 `"82"', add
label define eldch_lbl 83 `"83"', add
label define eldch_lbl 84 `"84"', add
label define eldch_lbl 85 `"85"', add
label define eldch_lbl 86 `"86"', add
label define eldch_lbl 87 `"87"', add
label define eldch_lbl 88 `"88"', add
label define eldch_lbl 89 `"89"', add
label define eldch_lbl 90 `"90"', add
label define eldch_lbl 91 `"91"', add
label define eldch_lbl 92 `"92"', add
label define eldch_lbl 93 `"93"', add
label define eldch_lbl 94 `"94"', add
label define eldch_lbl 95 `"95"', add
label define eldch_lbl 96 `"96"', add
label define eldch_lbl 97 `"97"', add
label define eldch_lbl 98 `"98"', add
label define eldch_lbl 99 `"N/A"', add
label values eldch eldch_lbl

label define yngch_lbl 00 `"Less than 1 year old"'
label define yngch_lbl 01 `"1"', add
label define yngch_lbl 02 `"2"', add
label define yngch_lbl 03 `"3"', add
label define yngch_lbl 04 `"4"', add
label define yngch_lbl 05 `"5"', add
label define yngch_lbl 06 `"6"', add
label define yngch_lbl 07 `"7"', add
label define yngch_lbl 08 `"8"', add
label define yngch_lbl 09 `"9"', add
label define yngch_lbl 10 `"10"', add
label define yngch_lbl 11 `"11"', add
label define yngch_lbl 12 `"12"', add
label define yngch_lbl 13 `"13"', add
label define yngch_lbl 14 `"14"', add
label define yngch_lbl 15 `"15"', add
label define yngch_lbl 16 `"16"', add
label define yngch_lbl 17 `"17"', add
label define yngch_lbl 18 `"18"', add
label define yngch_lbl 19 `"19"', add
label define yngch_lbl 20 `"20"', add
label define yngch_lbl 21 `"21"', add
label define yngch_lbl 22 `"22"', add
label define yngch_lbl 23 `"23"', add
label define yngch_lbl 24 `"24"', add
label define yngch_lbl 25 `"25"', add
label define yngch_lbl 26 `"26"', add
label define yngch_lbl 27 `"27"', add
label define yngch_lbl 28 `"28"', add
label define yngch_lbl 29 `"29"', add
label define yngch_lbl 30 `"30"', add
label define yngch_lbl 31 `"31"', add
label define yngch_lbl 32 `"32"', add
label define yngch_lbl 33 `"33"', add
label define yngch_lbl 34 `"34"', add
label define yngch_lbl 35 `"35"', add
label define yngch_lbl 36 `"36"', add
label define yngch_lbl 37 `"37"', add
label define yngch_lbl 38 `"38"', add
label define yngch_lbl 39 `"39"', add
label define yngch_lbl 40 `"40"', add
label define yngch_lbl 41 `"41"', add
label define yngch_lbl 42 `"42"', add
label define yngch_lbl 43 `"43"', add
label define yngch_lbl 44 `"44"', add
label define yngch_lbl 45 `"45"', add
label define yngch_lbl 46 `"46"', add
label define yngch_lbl 47 `"47"', add
label define yngch_lbl 48 `"48"', add
label define yngch_lbl 49 `"49"', add
label define yngch_lbl 50 `"50"', add
label define yngch_lbl 51 `"51"', add
label define yngch_lbl 52 `"52"', add
label define yngch_lbl 53 `"53"', add
label define yngch_lbl 54 `"54"', add
label define yngch_lbl 55 `"55"', add
label define yngch_lbl 56 `"56"', add
label define yngch_lbl 57 `"57"', add
label define yngch_lbl 58 `"58"', add
label define yngch_lbl 59 `"59"', add
label define yngch_lbl 60 `"60"', add
label define yngch_lbl 61 `"61"', add
label define yngch_lbl 62 `"62"', add
label define yngch_lbl 63 `"63"', add
label define yngch_lbl 64 `"64"', add
label define yngch_lbl 65 `"65"', add
label define yngch_lbl 66 `"66"', add
label define yngch_lbl 67 `"67"', add
label define yngch_lbl 68 `"68"', add
label define yngch_lbl 69 `"69"', add
label define yngch_lbl 70 `"70"', add
label define yngch_lbl 71 `"71"', add
label define yngch_lbl 72 `"72"', add
label define yngch_lbl 73 `"73"', add
label define yngch_lbl 74 `"74"', add
label define yngch_lbl 75 `"75"', add
label define yngch_lbl 76 `"76"', add
label define yngch_lbl 77 `"77"', add
label define yngch_lbl 78 `"78"', add
label define yngch_lbl 79 `"79"', add
label define yngch_lbl 80 `"80"', add
label define yngch_lbl 81 `"81"', add
label define yngch_lbl 82 `"82"', add
label define yngch_lbl 83 `"83"', add
label define yngch_lbl 84 `"84"', add
label define yngch_lbl 85 `"85"', add
label define yngch_lbl 86 `"86"', add
label define yngch_lbl 87 `"87"', add
label define yngch_lbl 88 `"88"', add
label define yngch_lbl 89 `"89"', add
label define yngch_lbl 90 `"90"', add
label define yngch_lbl 91 `"91"', add
label define yngch_lbl 92 `"92"', add
label define yngch_lbl 93 `"93"', add
label define yngch_lbl 94 `"94"', add
label define yngch_lbl 95 `"95"', add
label define yngch_lbl 96 `"96"', add
label define yngch_lbl 97 `"97"', add
label define yngch_lbl 98 `"98"', add
label define yngch_lbl 99 `"N/A"', add
label values yngch yngch_lbl

label define sex_lbl 1 `"Male"'
label define sex_lbl 2 `"Female"', add
label values sex sex_lbl

label define age_lbl 000 `"Less than 1 year old"'
label define age_lbl 001 `"1"', add
label define age_lbl 002 `"2"', add
label define age_lbl 003 `"3"', add
label define age_lbl 004 `"4"', add
label define age_lbl 005 `"5"', add
label define age_lbl 006 `"6"', add
label define age_lbl 007 `"7"', add
label define age_lbl 008 `"8"', add
label define age_lbl 009 `"9"', add
label define age_lbl 010 `"10"', add
label define age_lbl 011 `"11"', add
label define age_lbl 012 `"12"', add
label define age_lbl 013 `"13"', add
label define age_lbl 014 `"14"', add
label define age_lbl 015 `"15"', add
label define age_lbl 016 `"16"', add
label define age_lbl 017 `"17"', add
label define age_lbl 018 `"18"', add
label define age_lbl 019 `"19"', add
label define age_lbl 020 `"20"', add
label define age_lbl 021 `"21"', add
label define age_lbl 022 `"22"', add
label define age_lbl 023 `"23"', add
label define age_lbl 024 `"24"', add
label define age_lbl 025 `"25"', add
label define age_lbl 026 `"26"', add
label define age_lbl 027 `"27"', add
label define age_lbl 028 `"28"', add
label define age_lbl 029 `"29"', add
label define age_lbl 030 `"30"', add
label define age_lbl 031 `"31"', add
label define age_lbl 032 `"32"', add
label define age_lbl 033 `"33"', add
label define age_lbl 034 `"34"', add
label define age_lbl 035 `"35"', add
label define age_lbl 036 `"36"', add
label define age_lbl 037 `"37"', add
label define age_lbl 038 `"38"', add
label define age_lbl 039 `"39"', add
label define age_lbl 040 `"40"', add
label define age_lbl 041 `"41"', add
label define age_lbl 042 `"42"', add
label define age_lbl 043 `"43"', add
label define age_lbl 044 `"44"', add
label define age_lbl 045 `"45"', add
label define age_lbl 046 `"46"', add
label define age_lbl 047 `"47"', add
label define age_lbl 048 `"48"', add
label define age_lbl 049 `"49"', add
label define age_lbl 050 `"50"', add
label define age_lbl 051 `"51"', add
label define age_lbl 052 `"52"', add
label define age_lbl 053 `"53"', add
label define age_lbl 054 `"54"', add
label define age_lbl 055 `"55"', add
label define age_lbl 056 `"56"', add
label define age_lbl 057 `"57"', add
label define age_lbl 058 `"58"', add
label define age_lbl 059 `"59"', add
label define age_lbl 060 `"60"', add
label define age_lbl 061 `"61"', add
label define age_lbl 062 `"62"', add
label define age_lbl 063 `"63"', add
label define age_lbl 064 `"64"', add
label define age_lbl 065 `"65"', add
label define age_lbl 066 `"66"', add
label define age_lbl 067 `"67"', add
label define age_lbl 068 `"68"', add
label define age_lbl 069 `"69"', add
label define age_lbl 070 `"70"', add
label define age_lbl 071 `"71"', add
label define age_lbl 072 `"72"', add
label define age_lbl 073 `"73"', add
label define age_lbl 074 `"74"', add
label define age_lbl 075 `"75"', add
label define age_lbl 076 `"76"', add
label define age_lbl 077 `"77"', add
label define age_lbl 078 `"78"', add
label define age_lbl 079 `"79"', add
label define age_lbl 080 `"80"', add
label define age_lbl 081 `"81"', add
label define age_lbl 082 `"82"', add
label define age_lbl 083 `"83"', add
label define age_lbl 084 `"84"', add
label define age_lbl 085 `"85"', add
label define age_lbl 086 `"86"', add
label define age_lbl 087 `"87"', add
label define age_lbl 088 `"88"', add
label define age_lbl 089 `"89"', add
label define age_lbl 090 `"90 (90+ in 1980 and 1990)"', add
label define age_lbl 091 `"91"', add
label define age_lbl 092 `"92"', add
label define age_lbl 093 `"93"', add
label define age_lbl 094 `"94"', add
label define age_lbl 095 `"95"', add
label define age_lbl 096 `"96"', add
label define age_lbl 097 `"97"', add
label define age_lbl 098 `"98"', add
label define age_lbl 099 `"99"', add
label define age_lbl 100 `"100 (100+ in 1960-1970)"', add
label define age_lbl 101 `"101"', add
label define age_lbl 102 `"102"', add
label define age_lbl 103 `"103"', add
label define age_lbl 104 `"104"', add
label define age_lbl 105 `"105"', add
label define age_lbl 106 `"106"', add
label define age_lbl 107 `"107"', add
label define age_lbl 108 `"108"', add
label define age_lbl 109 `"109"', add
label define age_lbl 110 `"110"', add
label define age_lbl 111 `"111"', add
label define age_lbl 112 `"112 (112+ in the 1980 internal data)"', add
label define age_lbl 113 `"113"', add
label define age_lbl 114 `"114"', add
label define age_lbl 115 `"115 (115+ in the 1990 internal data)"', add
label define age_lbl 116 `"116"', add
label define age_lbl 117 `"117"', add
label define age_lbl 118 `"118"', add
label define age_lbl 119 `"119"', add
label define age_lbl 120 `"120"', add
label define age_lbl 121 `"121"', add
label define age_lbl 122 `"122"', add
label define age_lbl 123 `"123"', add
label define age_lbl 124 `"124"', add
label define age_lbl 125 `"125"', add
label define age_lbl 126 `"126"', add
label define age_lbl 129 `"129"', add
label define age_lbl 130 `"130"', add
label define age_lbl 135 `"135"', add
label values age age_lbl

label define marst_lbl 1 `"Married, spouse present"'
label define marst_lbl 2 `"Married, spouse absent"', add
label define marst_lbl 3 `"Separated"', add
label define marst_lbl 4 `"Divorced"', add
label define marst_lbl 5 `"Widowed"', add
label define marst_lbl 6 `"Never married/single"', add
label values marst marst_lbl

label define marrno_lbl 0 `"Not Applicable"'
label define marrno_lbl 1 `"Married once"', add
label define marrno_lbl 2 `"Married twice (or more)"', add
label define marrno_lbl 3 `"Married thrice (or more)"', add
label define marrno_lbl 4 `"Four times"', add
label define marrno_lbl 5 `"Five times"', add
label define marrno_lbl 6 `"Six times"', add
label define marrno_lbl 7 `"Unknown"', add
label define marrno_lbl 8 `"Illegible"', add
label define marrno_lbl 9 `"Missing"', add
label values marrno marrno_lbl

label define fertyr_lbl 0 `"N/A"'
label define fertyr_lbl 1 `"No"', add
label define fertyr_lbl 2 `"Yes"', add
label define fertyr_lbl 8 `"Suppressed"', add
label values fertyr fertyr_lbl

label define race_lbl 1 `"White"'
label define race_lbl 2 `"Black/African American/Negro"', add
label define race_lbl 3 `"American Indian or Alaska Native"', add
label define race_lbl 4 `"Chinese"', add
label define race_lbl 5 `"Japanese"', add
label define race_lbl 6 `"Other Asian or Pacific Islander"', add
label define race_lbl 7 `"Other race, nec"', add
label define race_lbl 8 `"Two major races"', add
label define race_lbl 9 `"Three or more major races"', add
label values race race_lbl

label define raced_lbl 100 `"White"'
label define raced_lbl 110 `"Spanish write_in"', add
label define raced_lbl 120 `"Blank (white) (1850)"', add
label define raced_lbl 130 `"Portuguese"', add
label define raced_lbl 140 `"Mexican (1930)"', add
label define raced_lbl 150 `"Puerto Rican (1910 Hawaii)"', add
label define raced_lbl 200 `"Black/African American/Negro"', add
label define raced_lbl 210 `"Mulatto"', add
label define raced_lbl 300 `"American Indian/Alaska Native"', add
label define raced_lbl 302 `"Apache"', add
label define raced_lbl 303 `"Blackfoot"', add
label define raced_lbl 304 `"Cherokee"', add
label define raced_lbl 305 `"Cheyenne"', add
label define raced_lbl 306 `"Chickasaw"', add
label define raced_lbl 307 `"Chippewa"', add
label define raced_lbl 308 `"Choctaw"', add
label define raced_lbl 309 `"Comanche"', add
label define raced_lbl 310 `"Creek"', add
label define raced_lbl 311 `"Crow"', add
label define raced_lbl 312 `"Iroquois"', add
label define raced_lbl 313 `"Kiowa"', add
label define raced_lbl 314 `"Lumbee"', add
label define raced_lbl 315 `"Navajo"', add
label define raced_lbl 316 `"Osage"', add
label define raced_lbl 317 `"Paiute"', add
label define raced_lbl 318 `"Pima"', add
label define raced_lbl 319 `"Potawatomi"', add
label define raced_lbl 320 `"Pueblo"', add
label define raced_lbl 321 `"Seminole"', add
label define raced_lbl 322 `"Shoshone"', add
label define raced_lbl 323 `"Sioux"', add
label define raced_lbl 324 `"Tlingit (Tlingit_Haida, 2000/ACS)"', add
label define raced_lbl 325 `"Tohono O Odham"', add
label define raced_lbl 326 `"All other tribes (1990)"', add
label define raced_lbl 328 `"Hopi"', add
label define raced_lbl 329 `"Central American Indian"', add
label define raced_lbl 330 `"Spanish American Indian"', add
label define raced_lbl 350 `"Delaware"', add
label define raced_lbl 351 `"Latin American Indian"', add
label define raced_lbl 352 `"Puget Sound Salish"', add
label define raced_lbl 353 `"Yakama"', add
label define raced_lbl 354 `"Yaqui"', add
label define raced_lbl 355 `"Colville"', add
label define raced_lbl 356 `"Houma"', add
label define raced_lbl 357 `"Menominee"', add
label define raced_lbl 358 `"Yuman"', add
label define raced_lbl 359 `"South American Indian"', add
label define raced_lbl 360 `"Mexican American Indian"', add
label define raced_lbl 361 `"Other Amer. Indian tribe (2000,ACS)"', add
label define raced_lbl 362 `"2+ Amer. Indian tribes (2000,ACS)"', add
label define raced_lbl 370 `"Alaskan Athabaskan"', add
label define raced_lbl 371 `"Aleut"', add
label define raced_lbl 372 `"Eskimo"', add
label define raced_lbl 373 `"Alaskan mixed"', add
label define raced_lbl 374 `"Inupiat"', add
label define raced_lbl 375 `"Yup'ik"', add
label define raced_lbl 379 `"Other Alaska Native tribe(s) (2000,ACS)"', add
label define raced_lbl 398 `"Both Am. Ind. and Alaska Native (2000,ACS)"', add
label define raced_lbl 399 `"Tribe not specified"', add
label define raced_lbl 400 `"Chinese"', add
label define raced_lbl 410 `"Taiwanese"', add
label define raced_lbl 420 `"Chinese and Taiwanese"', add
label define raced_lbl 500 `"Japanese"', add
label define raced_lbl 600 `"Filipino"', add
label define raced_lbl 610 `"Asian Indian (Hindu 1920_1940)"', add
label define raced_lbl 620 `"Korean"', add
label define raced_lbl 630 `"Hawaiian"', add
label define raced_lbl 631 `"Hawaiian and Asian (1900,1920)"', add
label define raced_lbl 632 `"Hawaiian and European (1900,1920)"', add
label define raced_lbl 634 `"Hawaiian mixed"', add
label define raced_lbl 640 `"Vietnamese"', add
label define raced_lbl 641 `"Bhutanese"', add
label define raced_lbl 642 `"Mongolian"', add
label define raced_lbl 643 `"Nepalese"', add
label define raced_lbl 650 `"Other Asian or Pacific Islander (1920,1980)"', add
label define raced_lbl 651 `"Asian only (CPS)"', add
label define raced_lbl 652 `"Pacific Islander only (CPS)"', add
label define raced_lbl 653 `"Asian or Pacific Islander, n.s. (1990 Internal Census files)"', add
label define raced_lbl 660 `"Cambodian"', add
label define raced_lbl 661 `"Hmong"', add
label define raced_lbl 662 `"Laotian"', add
label define raced_lbl 663 `"Thai"', add
label define raced_lbl 664 `"Bangladeshi"', add
label define raced_lbl 665 `"Burmese"', add
label define raced_lbl 666 `"Indonesian"', add
label define raced_lbl 667 `"Malaysian"', add
label define raced_lbl 668 `"Okinawan"', add
label define raced_lbl 669 `"Pakistani"', add
label define raced_lbl 670 `"Sri Lankan"', add
label define raced_lbl 671 `"Other Asian, n.e.c."', add
label define raced_lbl 672 `"Asian, not specified"', add
label define raced_lbl 673 `"Chinese and Japanese"', add
label define raced_lbl 674 `"Chinese and Filipino"', add
label define raced_lbl 675 `"Chinese and Vietnamese"', add
label define raced_lbl 676 `"Chinese and Asian write_in"', add
label define raced_lbl 677 `"Japanese and Filipino"', add
label define raced_lbl 678 `"Asian Indian and Asian write_in"', add
label define raced_lbl 679 `"Other Asian race combinations"', add
label define raced_lbl 680 `"Samoan"', add
label define raced_lbl 681 `"Tahitian"', add
label define raced_lbl 682 `"Tongan"', add
label define raced_lbl 683 `"Other Polynesian (1990)"', add
label define raced_lbl 684 `"1+ other Polynesian races (2000,ACS)"', add
label define raced_lbl 685 `"Guamanian/Chamorro"', add
label define raced_lbl 686 `"Northern Mariana Islander"', add
label define raced_lbl 687 `"Palauan"', add
label define raced_lbl 688 `"Other Micronesian (1990)"', add
label define raced_lbl 689 `"1+ other Micronesian races (2000,ACS)"', add
label define raced_lbl 690 `"Fijian"', add
label define raced_lbl 691 `"Other Melanesian (1990)"', add
label define raced_lbl 692 `"1+ other Melanesian races (2000,ACS)"', add
label define raced_lbl 698 `"2+ PI races from 2+ PI regions"', add
label define raced_lbl 699 `"Pacific Islander, n.s."', add
label define raced_lbl 700 `"Other race, n.e.c."', add
label define raced_lbl 801 `"White and Black"', add
label define raced_lbl 802 `"White and AIAN"', add
label define raced_lbl 810 `"White and Asian"', add
label define raced_lbl 811 `"White and Chinese"', add
label define raced_lbl 812 `"White and Japanese"', add
label define raced_lbl 813 `"White and Filipino"', add
label define raced_lbl 814 `"White and Asian Indian"', add
label define raced_lbl 815 `"White and Korean"', add
label define raced_lbl 816 `"White and Vietnamese"', add
label define raced_lbl 817 `"White and Asian write_in"', add
label define raced_lbl 818 `"White and other Asian race(s)"', add
label define raced_lbl 819 `"White and two or more Asian groups"', add
label define raced_lbl 820 `"White and PI"', add
label define raced_lbl 821 `"White and Native Hawaiian"', add
label define raced_lbl 822 `"White and Samoan"', add
label define raced_lbl 823 `"White and Guamanian"', add
label define raced_lbl 824 `"White and PI write_in"', add
label define raced_lbl 825 `"White and other PI race(s)"', add
label define raced_lbl 826 `"White and other race write_in"', add
label define raced_lbl 827 `"White and other race, n.e.c."', add
label define raced_lbl 830 `"Black and AIAN"', add
label define raced_lbl 831 `"Black and Asian"', add
label define raced_lbl 832 `"Black and Chinese"', add
label define raced_lbl 833 `"Black and Japanese"', add
label define raced_lbl 834 `"Black and Filipino"', add
label define raced_lbl 835 `"Black and Asian Indian"', add
label define raced_lbl 836 `"Black and Korean"', add
label define raced_lbl 837 `"Black and Asian write_in"', add
label define raced_lbl 838 `"Black and other Asian race(s)"', add
label define raced_lbl 840 `"Black and PI"', add
label define raced_lbl 841 `"Black and PI write_in"', add
label define raced_lbl 842 `"Black and other PI race(s)"', add
label define raced_lbl 845 `"Black and other race write_in"', add
label define raced_lbl 850 `"AIAN and Asian"', add
label define raced_lbl 851 `"AIAN and Filipino (2000 1%)"', add
label define raced_lbl 852 `"AIAN and Asian Indian"', add
label define raced_lbl 853 `"AIAN and Asian write_in (2000 1%)"', add
label define raced_lbl 854 `"AIAN and other Asian race(s)"', add
label define raced_lbl 855 `"AIAN and PI"', add
label define raced_lbl 856 `"AIAN and other race write_in"', add
label define raced_lbl 860 `"Asian and PI"', add
label define raced_lbl 861 `"Chinese and Hawaiian"', add
label define raced_lbl 862 `"Chinese, Filipino, Hawaiian (2000 1%)"', add
label define raced_lbl 863 `"Japanese and Hawaiian (2000 1%)"', add
label define raced_lbl 864 `"Filipino and Hawaiian"', add
label define raced_lbl 865 `"Filipino and PI write_in"', add
label define raced_lbl 866 `"Asian Indian and PI write_in (2000 1%)"', add
label define raced_lbl 867 `"Asian write_in and PI write_in"', add
label define raced_lbl 868 `"Other Asian race(s) and PI race(s)"', add
label define raced_lbl 869 `"Japanese and Korean (ACS)"', add
label define raced_lbl 880 `"Asian and other race write_in"', add
label define raced_lbl 881 `"Chinese and other race write_in"', add
label define raced_lbl 882 `"Japanese and other race write_in"', add
label define raced_lbl 883 `"Filipino and other race write_in"', add
label define raced_lbl 884 `"Asian Indian and other race write_in"', add
label define raced_lbl 885 `"Asian write_in and other race write_in"', add
label define raced_lbl 886 `"Other Asian race(s) and other race write_in"', add
label define raced_lbl 887 `"Chinese and Korean"', add
label define raced_lbl 890 `"PI and other race write_in:"', add
label define raced_lbl 891 `"PI write_in and other race write_in"', add
label define raced_lbl 892 `"Other PI race(s) and other race write_in"', add
label define raced_lbl 893 `"Native Hawaiian or PI other race(s)"', add
label define raced_lbl 899 `"API and other race write_in"', add
label define raced_lbl 901 `"White, Black, AIAN"', add
label define raced_lbl 902 `"White, Black, Asian"', add
label define raced_lbl 903 `"White, Black, PI"', add
label define raced_lbl 904 `"White, Black, other race write_in"', add
label define raced_lbl 905 `"White, AIAN, Asian"', add
label define raced_lbl 906 `"White, AIAN, PI"', add
label define raced_lbl 907 `"White, AIAN, other race write_in"', add
label define raced_lbl 910 `"White, Asian, PI"', add
label define raced_lbl 911 `"White, Chinese, Hawaiian"', add
label define raced_lbl 912 `"White, Chinese, Filipino, Hawaiian (2000 1%)"', add
label define raced_lbl 913 `"White, Japanese, Hawaiian (2000 1%)"', add
label define raced_lbl 914 `"White, Filipino, Hawaiian"', add
label define raced_lbl 915 `"Other White, Asian race(s), PI race(s)"', add
label define raced_lbl 916 `"White, AIAN and Filipino"', add
label define raced_lbl 917 `"White, Black, and Filipino"', add
label define raced_lbl 920 `"White, Asian, other race write_in"', add
label define raced_lbl 921 `"White, Filipino, other race write_in (2000 1%)"', add
label define raced_lbl 922 `"White, Asian write_in, other race write_in (2000 1%)"', add
label define raced_lbl 923 `"Other White, Asian race(s), other race write_in (2000 1%)"', add
label define raced_lbl 925 `"White, PI, other race write_in"', add
label define raced_lbl 930 `"Black, AIAN, Asian"', add
label define raced_lbl 931 `"Black, AIAN, PI"', add
label define raced_lbl 932 `"Black, AIAN, other race write_in"', add
label define raced_lbl 933 `"Black, Asian, PI"', add
label define raced_lbl 934 `"Black, Asian, other race write_in"', add
label define raced_lbl 935 `"Black, PI, other race write_in"', add
label define raced_lbl 940 `"AIAN, Asian, PI"', add
label define raced_lbl 941 `"AIAN, Asian, other race write_in"', add
label define raced_lbl 942 `"AIAN, PI, other race write_in"', add
label define raced_lbl 943 `"Asian, PI, other race write_in"', add
label define raced_lbl 944 `"Asian (Chinese, Japanese, Korean, Vietnamese); and Native Hawaiian or PI; and Other"', add
label define raced_lbl 949 `"2 or 3 races (CPS)"', add
label define raced_lbl 950 `"White, Black, AIAN, Asian"', add
label define raced_lbl 951 `"White, Black, AIAN, PI"', add
label define raced_lbl 952 `"White, Black, AIAN, other race write_in"', add
label define raced_lbl 953 `"White, Black, Asian, PI"', add
label define raced_lbl 954 `"White, Black, Asian, other race write_in"', add
label define raced_lbl 955 `"White, Black, PI, other race write_in"', add
label define raced_lbl 960 `"White, AIAN, Asian, PI"', add
label define raced_lbl 961 `"White, AIAN, Asian, other race write_in"', add
label define raced_lbl 962 `"White, AIAN, PI, other race write_in"', add
label define raced_lbl 963 `"White, Asian, PI, other race write_in"', add
label define raced_lbl 964 `"White, Chinese, Japanese, Native Hawaiian"', add
label define raced_lbl 970 `"Black, AIAN, Asian, PI"', add
label define raced_lbl 971 `"Black, AIAN, Asian, other race write_in"', add
label define raced_lbl 972 `"Black, AIAN, PI, other race write_in"', add
label define raced_lbl 973 `"Black, Asian, PI, other race write_in"', add
label define raced_lbl 974 `"AIAN, Asian, PI, other race write_in"', add
label define raced_lbl 975 `"AIAN, Asian, PI, Hawaiian other race write_in"', add
label define raced_lbl 976 `"Two specified Asian  (Chinese and other Asian, Chinese and Japanese, Japanese and other Asian, Korean and other Asian); Native Hawaiian/PI; and Other Race"', add
label define raced_lbl 980 `"White, Black, AIAN, Asian, PI"', add
label define raced_lbl 981 `"White, Black, AIAN, Asian, other race write_in"', add
label define raced_lbl 982 `"White, Black, AIAN, PI, other race write_in"', add
label define raced_lbl 983 `"White, Black, Asian, PI, other race write_in"', add
label define raced_lbl 984 `"White, AIAN, Asian, PI, other race write_in"', add
label define raced_lbl 985 `"Black, AIAN, Asian, PI, other race write_in"', add
label define raced_lbl 986 `"Black, AIAN, Asian, PI, Hawaiian, other race write_in"', add
label define raced_lbl 989 `"4 or 5 races (CPS)"', add
label define raced_lbl 990 `"White, Black, AIAN, Asian, PI, other race write_in"', add
label define raced_lbl 991 `"White race; Some other race; Black or African American race and/or American Indian and Alaska Native race and/or Asian groups and/or Native Hawaiian and Other Pacific Islander groups"', add
label define raced_lbl 996 `"2+ races, n.e.c. (CPS)"', add
label values raced raced_lbl

label define hispan_lbl 0 `"Not Hispanic"'
label define hispan_lbl 1 `"Mexican"', add
label define hispan_lbl 2 `"Puerto Rican"', add
label define hispan_lbl 3 `"Cuban"', add
label define hispan_lbl 4 `"Other"', add
label define hispan_lbl 9 `"Not Reported"', add
label values hispan hispan_lbl

label define hispand_lbl 000 `"Not Hispanic"'
label define hispand_lbl 100 `"Mexican"', add
label define hispand_lbl 102 `"Mexican American"', add
label define hispand_lbl 103 `"Mexicano/Mexicana"', add
label define hispand_lbl 104 `"Chicano/Chicana"', add
label define hispand_lbl 105 `"La Raza"', add
label define hispand_lbl 106 `"Mexican American Indian"', add
label define hispand_lbl 107 `"Mexico"', add
label define hispand_lbl 200 `"Puerto Rican"', add
label define hispand_lbl 300 `"Cuban"', add
label define hispand_lbl 401 `"Central American Indian"', add
label define hispand_lbl 402 `"Canal Zone"', add
label define hispand_lbl 411 `"Costa Rican"', add
label define hispand_lbl 412 `"Guatemalan"', add
label define hispand_lbl 413 `"Honduran"', add
label define hispand_lbl 414 `"Nicaraguan"', add
label define hispand_lbl 415 `"Panamanian"', add
label define hispand_lbl 416 `"Salvadoran"', add
label define hispand_lbl 417 `"Central American, n.e.c."', add
label define hispand_lbl 420 `"Argentinean"', add
label define hispand_lbl 421 `"Bolivian"', add
label define hispand_lbl 422 `"Chilean"', add
label define hispand_lbl 423 `"Colombian"', add
label define hispand_lbl 424 `"Ecuadorian"', add
label define hispand_lbl 425 `"Paraguayan"', add
label define hispand_lbl 426 `"Peruvian"', add
label define hispand_lbl 427 `"Uruguayan"', add
label define hispand_lbl 428 `"Venezuelan"', add
label define hispand_lbl 429 `"South American Indian"', add
label define hispand_lbl 430 `"Criollo"', add
label define hispand_lbl 431 `"South American, n.e.c."', add
label define hispand_lbl 450 `"Spaniard"', add
label define hispand_lbl 451 `"Andalusian"', add
label define hispand_lbl 452 `"Asturian"', add
label define hispand_lbl 453 `"Castillian"', add
label define hispand_lbl 454 `"Catalonian"', add
label define hispand_lbl 455 `"Balearic Islander"', add
label define hispand_lbl 456 `"Gallego"', add
label define hispand_lbl 457 `"Valencian"', add
label define hispand_lbl 458 `"Canarian"', add
label define hispand_lbl 459 `"Spanish Basque"', add
label define hispand_lbl 460 `"Dominican"', add
label define hispand_lbl 465 `"Latin American"', add
label define hispand_lbl 470 `"Hispanic"', add
label define hispand_lbl 480 `"Spanish"', add
label define hispand_lbl 490 `"Californio"', add
label define hispand_lbl 491 `"Tejano"', add
label define hispand_lbl 492 `"Nuevo Mexicano"', add
label define hispand_lbl 493 `"Spanish American"', add
label define hispand_lbl 494 `"Spanish American Indian"', add
label define hispand_lbl 495 `"Meso American Indian"', add
label define hispand_lbl 496 `"Mestizo"', add
label define hispand_lbl 498 `"Other, n.s."', add
label define hispand_lbl 499 `"Other, n.e.c."', add
label define hispand_lbl 900 `"Not Reported"', add
label values hispand hispand_lbl

label define bpl_lbl 001 `"Alabama"'
label define bpl_lbl 002 `"Alaska"', add
label define bpl_lbl 004 `"Arizona"', add
label define bpl_lbl 005 `"Arkansas"', add
label define bpl_lbl 006 `"California"', add
label define bpl_lbl 008 `"Colorado"', add
label define bpl_lbl 009 `"Connecticut"', add
label define bpl_lbl 010 `"Delaware"', add
label define bpl_lbl 011 `"District of Columbia"', add
label define bpl_lbl 012 `"Florida"', add
label define bpl_lbl 013 `"Georgia"', add
label define bpl_lbl 015 `"Hawaii"', add
label define bpl_lbl 016 `"Idaho"', add
label define bpl_lbl 017 `"Illinois"', add
label define bpl_lbl 018 `"Indiana"', add
label define bpl_lbl 019 `"Iowa"', add
label define bpl_lbl 020 `"Kansas"', add
label define bpl_lbl 021 `"Kentucky"', add
label define bpl_lbl 022 `"Louisiana"', add
label define bpl_lbl 023 `"Maine"', add
label define bpl_lbl 024 `"Maryland"', add
label define bpl_lbl 025 `"Massachusetts"', add
label define bpl_lbl 026 `"Michigan"', add
label define bpl_lbl 027 `"Minnesota"', add
label define bpl_lbl 028 `"Mississippi"', add
label define bpl_lbl 029 `"Missouri"', add
label define bpl_lbl 030 `"Montana"', add
label define bpl_lbl 031 `"Nebraska"', add
label define bpl_lbl 032 `"Nevada"', add
label define bpl_lbl 033 `"New Hampshire"', add
label define bpl_lbl 034 `"New Jersey"', add
label define bpl_lbl 035 `"New Mexico"', add
label define bpl_lbl 036 `"New York"', add
label define bpl_lbl 037 `"North Carolina"', add
label define bpl_lbl 038 `"North Dakota"', add
label define bpl_lbl 039 `"Ohio"', add
label define bpl_lbl 040 `"Oklahoma"', add
label define bpl_lbl 041 `"Oregon"', add
label define bpl_lbl 042 `"Pennsylvania"', add
label define bpl_lbl 044 `"Rhode Island"', add
label define bpl_lbl 045 `"South Carolina"', add
label define bpl_lbl 046 `"South Dakota"', add
label define bpl_lbl 047 `"Tennessee"', add
label define bpl_lbl 048 `"Texas"', add
label define bpl_lbl 049 `"Utah"', add
label define bpl_lbl 050 `"Vermont"', add
label define bpl_lbl 051 `"Virginia"', add
label define bpl_lbl 053 `"Washington"', add
label define bpl_lbl 054 `"West Virginia"', add
label define bpl_lbl 055 `"Wisconsin"', add
label define bpl_lbl 056 `"Wyoming"', add
label define bpl_lbl 090 `"Native American"', add
label define bpl_lbl 099 `"United States, ns"', add
label define bpl_lbl 100 `"American Samoa"', add
label define bpl_lbl 105 `"Guam"', add
label define bpl_lbl 110 `"Puerto Rico"', add
label define bpl_lbl 115 `"U.S. Virgin Islands"', add
label define bpl_lbl 120 `"Other US Possessions"', add
label define bpl_lbl 150 `"Canada"', add
label define bpl_lbl 155 `"St. Pierre and Miquelon"', add
label define bpl_lbl 160 `"Atlantic Islands"', add
label define bpl_lbl 199 `"North America, ns"', add
label define bpl_lbl 200 `"Mexico"', add
label define bpl_lbl 210 `"Central America"', add
label define bpl_lbl 250 `"Cuba"', add
label define bpl_lbl 260 `"West Indies"', add
label define bpl_lbl 299 `"Americas, n.s."', add
label define bpl_lbl 300 `"SOUTH AMERICA"', add
label define bpl_lbl 400 `"Denmark"', add
label define bpl_lbl 401 `"Finland"', add
label define bpl_lbl 402 `"Iceland"', add
label define bpl_lbl 403 `"Lapland, n.s."', add
label define bpl_lbl 404 `"Norway"', add
label define bpl_lbl 405 `"Sweden"', add
label define bpl_lbl 410 `"England"', add
label define bpl_lbl 411 `"Scotland"', add
label define bpl_lbl 412 `"Wales"', add
label define bpl_lbl 413 `"United Kingdom, ns"', add
label define bpl_lbl 414 `"Ireland"', add
label define bpl_lbl 419 `"Northern Europe, ns"', add
label define bpl_lbl 420 `"Belgium"', add
label define bpl_lbl 421 `"France"', add
label define bpl_lbl 422 `"Liechtenstein"', add
label define bpl_lbl 423 `"Luxembourg"', add
label define bpl_lbl 424 `"Monaco"', add
label define bpl_lbl 425 `"Netherlands"', add
label define bpl_lbl 426 `"Switzerland"', add
label define bpl_lbl 429 `"Western Europe, ns"', add
label define bpl_lbl 430 `"Albania"', add
label define bpl_lbl 431 `"Andorra"', add
label define bpl_lbl 432 `"Gibraltar"', add
label define bpl_lbl 433 `"Greece"', add
label define bpl_lbl 434 `"Italy"', add
label define bpl_lbl 435 `"Malta"', add
label define bpl_lbl 436 `"Portugal"', add
label define bpl_lbl 437 `"San Marino"', add
label define bpl_lbl 438 `"Spain"', add
label define bpl_lbl 439 `"Vatican City"', add
label define bpl_lbl 440 `"Southern Europe, ns"', add
label define bpl_lbl 450 `"Austria"', add
label define bpl_lbl 451 `"Bulgaria"', add
label define bpl_lbl 452 `"Czechoslovakia"', add
label define bpl_lbl 453 `"Germany"', add
label define bpl_lbl 454 `"Hungary"', add
label define bpl_lbl 455 `"Poland"', add
label define bpl_lbl 456 `"Romania"', add
label define bpl_lbl 457 `"Yugoslavia"', add
label define bpl_lbl 458 `"Central Europe, ns"', add
label define bpl_lbl 459 `"Eastern Europe, ns"', add
label define bpl_lbl 460 `"Estonia"', add
label define bpl_lbl 461 `"Latvia"', add
label define bpl_lbl 462 `"Lithuania"', add
label define bpl_lbl 463 `"Baltic States, ns"', add
label define bpl_lbl 465 `"Other USSR/Russia"', add
label define bpl_lbl 499 `"Europe, ns"', add
label define bpl_lbl 500 `"China"', add
label define bpl_lbl 501 `"Japan"', add
label define bpl_lbl 502 `"Korea"', add
label define bpl_lbl 509 `"East Asia, ns"', add
label define bpl_lbl 510 `"Brunei"', add
label define bpl_lbl 511 `"Cambodia (Kampuchea)"', add
label define bpl_lbl 512 `"Indonesia"', add
label define bpl_lbl 513 `"Laos"', add
label define bpl_lbl 514 `"Malaysia"', add
label define bpl_lbl 515 `"Philippines"', add
label define bpl_lbl 516 `"Singapore"', add
label define bpl_lbl 517 `"Thailand"', add
label define bpl_lbl 518 `"Vietnam"', add
label define bpl_lbl 519 `"Southeast Asia, ns"', add
label define bpl_lbl 520 `"Afghanistan"', add
label define bpl_lbl 521 `"India"', add
label define bpl_lbl 522 `"Iran"', add
label define bpl_lbl 523 `"Maldives"', add
label define bpl_lbl 524 `"Nepal"', add
label define bpl_lbl 530 `"Bahrain"', add
label define bpl_lbl 531 `"Cyprus"', add
label define bpl_lbl 532 `"Iraq"', add
label define bpl_lbl 533 `"Iraq/Saudi Arabia"', add
label define bpl_lbl 534 `"Israel/Palestine"', add
label define bpl_lbl 535 `"Jordan"', add
label define bpl_lbl 536 `"Kuwait"', add
label define bpl_lbl 537 `"Lebanon"', add
label define bpl_lbl 538 `"Oman"', add
label define bpl_lbl 539 `"Qatar"', add
label define bpl_lbl 540 `"Saudi Arabia"', add
label define bpl_lbl 541 `"Syria"', add
label define bpl_lbl 542 `"Turkey"', add
label define bpl_lbl 543 `"United Arab Emirates"', add
label define bpl_lbl 544 `"Yemen Arab Republic (North)"', add
label define bpl_lbl 545 `"Yemen, PDR (South)"', add
label define bpl_lbl 546 `"Persian Gulf States, n.s."', add
label define bpl_lbl 547 `"Middle East, ns"', add
label define bpl_lbl 548 `"Southwest Asia, nec/ns"', add
label define bpl_lbl 549 `"Asia Minor, ns"', add
label define bpl_lbl 550 `"South Asia, nec"', add
label define bpl_lbl 599 `"Asia, nec/ns"', add
label define bpl_lbl 600 `"AFRICA"', add
label define bpl_lbl 700 `"Australia and New Zealand"', add
label define bpl_lbl 710 `"Pacific Islands"', add
label define bpl_lbl 800 `"Antarctica, ns/nec"', add
label define bpl_lbl 900 `"Abroad (unknown) or at sea"', add
label define bpl_lbl 950 `"Other n.e.c."', add
label define bpl_lbl 999 `"Missing/blank"', add
label values bpl bpl_lbl

label define bpld_lbl 00100 `"Alabama"'
label define bpld_lbl 00200 `"Alaska"', add
label define bpld_lbl 00400 `"Arizona"', add
label define bpld_lbl 00500 `"Arkansas"', add
label define bpld_lbl 00600 `"California"', add
label define bpld_lbl 00800 `"Colorado"', add
label define bpld_lbl 00900 `"Connecticut"', add
label define bpld_lbl 01000 `"Delaware"', add
label define bpld_lbl 01100 `"District of Columbia"', add
label define bpld_lbl 01200 `"Florida"', add
label define bpld_lbl 01300 `"Georgia"', add
label define bpld_lbl 01500 `"Hawaii"', add
label define bpld_lbl 01600 `"Idaho"', add
label define bpld_lbl 01610 `"Idaho Territory"', add
label define bpld_lbl 01700 `"Illinois"', add
label define bpld_lbl 01800 `"Indiana"', add
label define bpld_lbl 01900 `"Iowa"', add
label define bpld_lbl 02000 `"Kansas"', add
label define bpld_lbl 02100 `"Kentucky"', add
label define bpld_lbl 02200 `"Louisiana"', add
label define bpld_lbl 02300 `"Maine"', add
label define bpld_lbl 02400 `"Maryland"', add
label define bpld_lbl 02500 `"Massachusetts"', add
label define bpld_lbl 02600 `"Michigan"', add
label define bpld_lbl 02700 `"Minnesota"', add
label define bpld_lbl 02800 `"Mississippi"', add
label define bpld_lbl 02900 `"Missouri"', add
label define bpld_lbl 03000 `"Montana"', add
label define bpld_lbl 03100 `"Nebraska"', add
label define bpld_lbl 03200 `"Nevada"', add
label define bpld_lbl 03300 `"New Hampshire"', add
label define bpld_lbl 03400 `"New Jersey"', add
label define bpld_lbl 03500 `"New Mexico"', add
label define bpld_lbl 03510 `"New Mexico Territory"', add
label define bpld_lbl 03600 `"New York"', add
label define bpld_lbl 03700 `"North Carolina"', add
label define bpld_lbl 03800 `"North Dakota"', add
label define bpld_lbl 03900 `"Ohio"', add
label define bpld_lbl 04000 `"Oklahoma"', add
label define bpld_lbl 04010 `"Indian Territory"', add
label define bpld_lbl 04100 `"Oregon"', add
label define bpld_lbl 04200 `"Pennsylvania"', add
label define bpld_lbl 04400 `"Rhode Island"', add
label define bpld_lbl 04500 `"South Carolina"', add
label define bpld_lbl 04600 `"South Dakota"', add
label define bpld_lbl 04610 `"Dakota Territory"', add
label define bpld_lbl 04700 `"Tennessee"', add
label define bpld_lbl 04800 `"Texas"', add
label define bpld_lbl 04900 `"Utah"', add
label define bpld_lbl 04910 `"Utah Territory"', add
label define bpld_lbl 05000 `"Vermont"', add
label define bpld_lbl 05100 `"Virginia"', add
label define bpld_lbl 05300 `"Washington"', add
label define bpld_lbl 05400 `"West Virginia"', add
label define bpld_lbl 05500 `"Wisconsin"', add
label define bpld_lbl 05600 `"Wyoming"', add
label define bpld_lbl 05610 `"Wyoming Territory"', add
label define bpld_lbl 09000 `"Native American"', add
label define bpld_lbl 09900 `"United States, ns"', add
label define bpld_lbl 10000 `"American Samoa"', add
label define bpld_lbl 10010 `"Samoa, 1940-1950"', add
label define bpld_lbl 10500 `"Guam"', add
label define bpld_lbl 11000 `"Puerto Rico"', add
label define bpld_lbl 11500 `"U.S. Virgin Islands"', add
label define bpld_lbl 11510 `"St. Croix"', add
label define bpld_lbl 11520 `"St. John"', add
label define bpld_lbl 11530 `"St. Thomas"', add
label define bpld_lbl 12000 `"Other US Possessions:"', add
label define bpld_lbl 12010 `"Johnston Atoll"', add
label define bpld_lbl 12020 `"Midway Islands"', add
label define bpld_lbl 12030 `"Wake Island"', add
label define bpld_lbl 12040 `"Other US Caribbean Islands"', add
label define bpld_lbl 12041 `"Navassa Island"', add
label define bpld_lbl 12050 `"Other US Pacific Islands"', add
label define bpld_lbl 12051 `"Baker Island"', add
label define bpld_lbl 12052 `"Howland Island"', add
label define bpld_lbl 12053 `"Jarvis Island"', add
label define bpld_lbl 12054 `"Kingman Reef"', add
label define bpld_lbl 12055 `"Palmyra Atoll"', add
label define bpld_lbl 12056 `"Canton and Enderbury Island"', add
label define bpld_lbl 12090 `"US outlying areas, ns"', add
label define bpld_lbl 12091 `"US possessions, ns"', add
label define bpld_lbl 12092 `"US territory, ns"', add
label define bpld_lbl 15000 `"Canada"', add
label define bpld_lbl 15010 `"English Canada"', add
label define bpld_lbl 15011 `"British Columbia"', add
label define bpld_lbl 15013 `"Alberta"', add
label define bpld_lbl 15015 `"Saskatchewan"', add
label define bpld_lbl 15017 `"Northwest"', add
label define bpld_lbl 15019 `"Ruperts Land"', add
label define bpld_lbl 15020 `"Manitoba"', add
label define bpld_lbl 15021 `"Red River"', add
label define bpld_lbl 15030 `"Ontario/Upper Canada"', add
label define bpld_lbl 15031 `"Upper Canada"', add
label define bpld_lbl 15032 `"Canada West"', add
label define bpld_lbl 15040 `"New Brunswick"', add
label define bpld_lbl 15050 `"Nova Scotia"', add
label define bpld_lbl 15051 `"Cape Breton"', add
label define bpld_lbl 15052 `"Halifax"', add
label define bpld_lbl 15060 `"Prince Edward Island"', add
label define bpld_lbl 15070 `"Newfoundland"', add
label define bpld_lbl 15080 `"French Canada"', add
label define bpld_lbl 15081 `"Quebec"', add
label define bpld_lbl 15082 `"Lower Canada"', add
label define bpld_lbl 15083 `"Canada East"', add
label define bpld_lbl 15500 `"St. Pierre and Miquelon"', add
label define bpld_lbl 16000 `"Atlantic Islands"', add
label define bpld_lbl 16010 `"Bermuda"', add
label define bpld_lbl 16020 `"Cape Verde"', add
label define bpld_lbl 16030 `"Falkland Islands"', add
label define bpld_lbl 16040 `"Greenland"', add
label define bpld_lbl 16050 `"St. Helena and Ascension"', add
label define bpld_lbl 16060 `"Canary Islands"', add
label define bpld_lbl 19900 `"North America, ns"', add
label define bpld_lbl 20000 `"Mexico"', add
label define bpld_lbl 21000 `"Central America"', add
label define bpld_lbl 21010 `"Belize/British Honduras"', add
label define bpld_lbl 21020 `"Costa Rica"', add
label define bpld_lbl 21030 `"El Salvador"', add
label define bpld_lbl 21040 `"Guatemala"', add
label define bpld_lbl 21050 `"Honduras"', add
label define bpld_lbl 21060 `"Nicaragua"', add
label define bpld_lbl 21070 `"Panama"', add
label define bpld_lbl 21071 `"Canal Zone"', add
label define bpld_lbl 21090 `"Central America, ns"', add
label define bpld_lbl 25000 `"Cuba"', add
label define bpld_lbl 26000 `"West Indies"', add
label define bpld_lbl 26010 `"Dominican Republic"', add
label define bpld_lbl 26020 `"Haiti"', add
label define bpld_lbl 26030 `"Jamaica"', add
label define bpld_lbl 26040 `"British West Indies"', add
label define bpld_lbl 26041 `"Anguilla"', add
label define bpld_lbl 26042 `"Antigua-Barbuda"', add
label define bpld_lbl 26043 `"Bahamas"', add
label define bpld_lbl 26044 `"Barbados"', add
label define bpld_lbl 26045 `"British Virgin Islands"', add
label define bpld_lbl 26046 `"Anegada"', add
label define bpld_lbl 26047 `"Cooper"', add
label define bpld_lbl 26048 `"Jost Van Dyke"', add
label define bpld_lbl 26049 `"Peter"', add
label define bpld_lbl 26050 `"Tortola"', add
label define bpld_lbl 26051 `"Virgin Gorda"', add
label define bpld_lbl 26052 `"Br. Virgin Islands, ns"', add
label define bpld_lbl 26053 `"Cayman Islands"', add
label define bpld_lbl 26054 `"Dominica"', add
label define bpld_lbl 26055 `"Grenada"', add
label define bpld_lbl 26056 `"Montserrat"', add
label define bpld_lbl 26057 `"St. Kitts-Nevis"', add
label define bpld_lbl 26058 `"St. Lucia"', add
label define bpld_lbl 26059 `"St. Vincent"', add
label define bpld_lbl 26060 `"Trinidad and Tobago"', add
label define bpld_lbl 26061 `"Turks and Caicos"', add
label define bpld_lbl 26069 `"Br. Virgin Islands, ns"', add
label define bpld_lbl 26070 `"Other West Indies"', add
label define bpld_lbl 26071 `"Aruba"', add
label define bpld_lbl 26072 `"Netherlands Antilles"', add
label define bpld_lbl 26073 `"Bonaire"', add
label define bpld_lbl 26074 `"Curacao"', add
label define bpld_lbl 26075 `"Dutch St. Maarten"', add
label define bpld_lbl 26076 `"Saba"', add
label define bpld_lbl 26077 `"St. Eustatius"', add
label define bpld_lbl 26079 `"Dutch Caribbean, ns"', add
label define bpld_lbl 26080 `"French St. Maarten"', add
label define bpld_lbl 26081 `"Guadeloupe"', add
label define bpld_lbl 26082 `"Martinique"', add
label define bpld_lbl 26083 `"St. Barthelemy"', add
label define bpld_lbl 26089 `"French Caribbean, ns"', add
label define bpld_lbl 26090 `"Antilles, ns"', add
label define bpld_lbl 26091 `"Caribbean, ns"', add
label define bpld_lbl 26092 `"Latin America, ns"', add
label define bpld_lbl 26093 `"Leeward Islands, ns"', add
label define bpld_lbl 26094 `"West Indies, ns"', add
label define bpld_lbl 26095 `"Windward Islands, ns"', add
label define bpld_lbl 29900 `"Americas, ns"', add
label define bpld_lbl 30000 `"South America"', add
label define bpld_lbl 30005 `"Argentina"', add
label define bpld_lbl 30010 `"Bolivia"', add
label define bpld_lbl 30015 `"Brazil"', add
label define bpld_lbl 30020 `"Chile"', add
label define bpld_lbl 30025 `"Colombia"', add
label define bpld_lbl 30030 `"Ecuador"', add
label define bpld_lbl 30035 `"French Guiana"', add
label define bpld_lbl 30040 `"Guyana/British Guiana"', add
label define bpld_lbl 30045 `"Paraguay"', add
label define bpld_lbl 30050 `"Peru"', add
label define bpld_lbl 30055 `"Suriname"', add
label define bpld_lbl 30060 `"Uruguay"', add
label define bpld_lbl 30065 `"Venezuela"', add
label define bpld_lbl 30090 `"South America, ns"', add
label define bpld_lbl 30091 `"South and Central America, n.s."', add
label define bpld_lbl 40000 `"Denmark"', add
label define bpld_lbl 40010 `"Faeroe Islands"', add
label define bpld_lbl 40100 `"Finland"', add
label define bpld_lbl 40200 `"Iceland"', add
label define bpld_lbl 40300 `"Lapland, ns"', add
label define bpld_lbl 40400 `"Norway"', add
label define bpld_lbl 40410 `"Svalbard and Jan Meyen"', add
label define bpld_lbl 40411 `"Svalbard"', add
label define bpld_lbl 40412 `"Jan Meyen"', add
label define bpld_lbl 40500 `"Sweden"', add
label define bpld_lbl 41000 `"England"', add
label define bpld_lbl 41010 `"Channel Islands"', add
label define bpld_lbl 41011 `"Guernsey"', add
label define bpld_lbl 41012 `"Jersey"', add
label define bpld_lbl 41020 `"Isle of Man"', add
label define bpld_lbl 41100 `"Scotland"', add
label define bpld_lbl 41200 `"Wales"', add
label define bpld_lbl 41300 `"United Kingdom, ns"', add
label define bpld_lbl 41400 `"Ireland"', add
label define bpld_lbl 41410 `"Northern Ireland"', add
label define bpld_lbl 41900 `"Northern Europe, ns"', add
label define bpld_lbl 42000 `"Belgium"', add
label define bpld_lbl 42100 `"France"', add
label define bpld_lbl 42110 `"Alsace-Lorraine"', add
label define bpld_lbl 42111 `"Alsace"', add
label define bpld_lbl 42112 `"Lorraine"', add
label define bpld_lbl 42200 `"Liechtenstein"', add
label define bpld_lbl 42300 `"Luxembourg"', add
label define bpld_lbl 42400 `"Monaco"', add
label define bpld_lbl 42500 `"Netherlands"', add
label define bpld_lbl 42600 `"Switzerland"', add
label define bpld_lbl 42900 `"Western Europe, ns"', add
label define bpld_lbl 43000 `"Albania"', add
label define bpld_lbl 43100 `"Andorra"', add
label define bpld_lbl 43200 `"Gibraltar"', add
label define bpld_lbl 43300 `"Greece"', add
label define bpld_lbl 43310 `"Dodecanese Islands"', add
label define bpld_lbl 43320 `"Turkey Greece"', add
label define bpld_lbl 43330 `"Macedonia"', add
label define bpld_lbl 43400 `"Italy"', add
label define bpld_lbl 43500 `"Malta"', add
label define bpld_lbl 43600 `"Portugal"', add
label define bpld_lbl 43610 `"Azores"', add
label define bpld_lbl 43620 `"Madeira Islands"', add
label define bpld_lbl 43630 `"Cape Verde Islands"', add
label define bpld_lbl 43640 `"St. Miguel"', add
label define bpld_lbl 43700 `"San Marino"', add
label define bpld_lbl 43800 `"Spain"', add
label define bpld_lbl 43900 `"Vatican City"', add
label define bpld_lbl 44000 `"Southern Europe, ns"', add
label define bpld_lbl 45000 `"Austria"', add
label define bpld_lbl 45010 `"Austria-Hungary"', add
label define bpld_lbl 45020 `"Austria-Graz"', add
label define bpld_lbl 45030 `"Austria-Linz"', add
label define bpld_lbl 45040 `"Austria-Salzburg"', add
label define bpld_lbl 45050 `"Austria-Tyrol"', add
label define bpld_lbl 45060 `"Austria-Vienna"', add
label define bpld_lbl 45070 `"Austria-Kaernsten"', add
label define bpld_lbl 45080 `"Austria-Neustadt"', add
label define bpld_lbl 45100 `"Bulgaria"', add
label define bpld_lbl 45200 `"Czechoslovakia"', add
label define bpld_lbl 45210 `"Bohemia"', add
label define bpld_lbl 45211 `"Bohemia-Moravia"', add
label define bpld_lbl 45212 `"Slovakia"', add
label define bpld_lbl 45213 `"Czech Republic"', add
label define bpld_lbl 45300 `"Germany"', add
label define bpld_lbl 45301 `"Berlin"', add
label define bpld_lbl 45302 `"West Berlin"', add
label define bpld_lbl 45303 `"East Berlin"', add
label define bpld_lbl 45310 `"West Germany"', add
label define bpld_lbl 45311 `"Baden"', add
label define bpld_lbl 45312 `"Bavaria"', add
label define bpld_lbl 45313 `"Braunschweig"', add
label define bpld_lbl 45314 `"Bremen"', add
label define bpld_lbl 45315 `"Hamburg"', add
label define bpld_lbl 45316 `"Hanover"', add
label define bpld_lbl 45317 `"Hessen"', add
label define bpld_lbl 45318 `"Hesse-Nassau"', add
label define bpld_lbl 45319 `"Lippe"', add
label define bpld_lbl 45320 `"Lubeck"', add
label define bpld_lbl 45321 `"Oldenburg"', add
label define bpld_lbl 45322 `"Rheinland"', add
label define bpld_lbl 45323 `"Schaumburg-Lippe"', add
label define bpld_lbl 45324 `"Schleswig"', add
label define bpld_lbl 45325 `"Sigmaringen"', add
label define bpld_lbl 45326 `"Schwarzburg"', add
label define bpld_lbl 45327 `"Westphalia"', add
label define bpld_lbl 45328 `"Wurttemberg"', add
label define bpld_lbl 45329 `"Waldeck"', add
label define bpld_lbl 45330 `"Wittenberg"', add
label define bpld_lbl 45331 `"Frankfurt"', add
label define bpld_lbl 45332 `"Saarland"', add
label define bpld_lbl 45333 `"Nordrhein-Westfalen"', add
label define bpld_lbl 45340 `"East Germany"', add
label define bpld_lbl 45341 `"Anhalt"', add
label define bpld_lbl 45342 `"Brandenburg"', add
label define bpld_lbl 45344 `"Kingdom of Saxony"', add
label define bpld_lbl 45345 `"Mecklenburg"', add
label define bpld_lbl 45346 `"Saxony"', add
label define bpld_lbl 45347 `"Thuringian States"', add
label define bpld_lbl 45348 `"Sachsen-Meiningen"', add
label define bpld_lbl 45349 `"Sachsen-Weimar-Eisenach"', add
label define bpld_lbl 45350 `"Probable Saxony"', add
label define bpld_lbl 45351 `"Schwerin"', add
label define bpld_lbl 45352 `"Strelitz"', add
label define bpld_lbl 45353 `"Probably Thuringian States"', add
label define bpld_lbl 45360 `"Prussia, nec"', add
label define bpld_lbl 45361 `"Hohenzollern"', add
label define bpld_lbl 45362 `"Niedersachsen"', add
label define bpld_lbl 45400 `"Hungary"', add
label define bpld_lbl 45500 `"Poland"', add
label define bpld_lbl 45510 `"Austrian Poland"', add
label define bpld_lbl 45511 `"Galicia"', add
label define bpld_lbl 45520 `"German Poland"', add
label define bpld_lbl 45521 `"East Prussia"', add
label define bpld_lbl 45522 `"Pomerania"', add
label define bpld_lbl 45523 `"Posen"', add
label define bpld_lbl 45524 `"Prussian Poland"', add
label define bpld_lbl 45525 `"Silesia"', add
label define bpld_lbl 45526 `"West Prussia"', add
label define bpld_lbl 45530 `"Russian Poland"', add
label define bpld_lbl 45600 `"Romania"', add
label define bpld_lbl 45610 `"Transylvania"', add
label define bpld_lbl 45700 `"Yugoslavia"', add
label define bpld_lbl 45710 `"Croatia"', add
label define bpld_lbl 45720 `"Montenegro"', add
label define bpld_lbl 45730 `"Serbia"', add
label define bpld_lbl 45740 `"Bosnia"', add
label define bpld_lbl 45750 `"Dalmatia"', add
label define bpld_lbl 45760 `"Slovonia"', add
label define bpld_lbl 45770 `"Carniola"', add
label define bpld_lbl 45780 `"Slovenia"', add
label define bpld_lbl 45790 `"Kosovo"', add
label define bpld_lbl 45800 `"Central Europe, ns"', add
label define bpld_lbl 45900 `"Eastern Europe, ns"', add
label define bpld_lbl 46000 `"Estonia"', add
label define bpld_lbl 46100 `"Latvia"', add
label define bpld_lbl 46200 `"Lithuania"', add
label define bpld_lbl 46300 `"Baltic States, ns"', add
label define bpld_lbl 46500 `"Other USSR/Russia"', add
label define bpld_lbl 46510 `"Byelorussia"', add
label define bpld_lbl 46520 `"Moldavia"', add
label define bpld_lbl 46521 `"Bessarabia"', add
label define bpld_lbl 46530 `"Ukraine"', add
label define bpld_lbl 46540 `"Armenia"', add
label define bpld_lbl 46541 `"Azerbaijan"', add
label define bpld_lbl 46542 `"Republic of Georgia"', add
label define bpld_lbl 46543 `"Kazakhstan"', add
label define bpld_lbl 46544 `"Kirghizia"', add
label define bpld_lbl 46545 `"Tadzhik"', add
label define bpld_lbl 46546 `"Turkmenistan"', add
label define bpld_lbl 46547 `"Uzbekistan"', add
label define bpld_lbl 46548 `"Siberia"', add
label define bpld_lbl 46590 `"USSR, ns"', add
label define bpld_lbl 49900 `"Europe, ns."', add
label define bpld_lbl 50000 `"China"', add
label define bpld_lbl 50010 `"Hong Kong"', add
label define bpld_lbl 50020 `"Macau"', add
label define bpld_lbl 50030 `"Mongolia"', add
label define bpld_lbl 50040 `"Taiwan"', add
label define bpld_lbl 50100 `"Japan"', add
label define bpld_lbl 50200 `"Korea"', add
label define bpld_lbl 50210 `"North Korea"', add
label define bpld_lbl 50220 `"South Korea"', add
label define bpld_lbl 50900 `"East Asia, ns"', add
label define bpld_lbl 51000 `"Brunei"', add
label define bpld_lbl 51100 `"Cambodia (Kampuchea)"', add
label define bpld_lbl 51200 `"Indonesia"', add
label define bpld_lbl 51210 `"East Indies"', add
label define bpld_lbl 51220 `"East Timor"', add
label define bpld_lbl 51300 `"Laos"', add
label define bpld_lbl 51400 `"Malaysia"', add
label define bpld_lbl 51500 `"Philippines"', add
label define bpld_lbl 51600 `"Singapore"', add
label define bpld_lbl 51700 `"Thailand"', add
label define bpld_lbl 51800 `"Vietnam"', add
label define bpld_lbl 51900 `"Southeast Asia, ns"', add
label define bpld_lbl 51910 `"Indochina, ns"', add
label define bpld_lbl 52000 `"Afghanistan"', add
label define bpld_lbl 52100 `"India"', add
label define bpld_lbl 52110 `"Bangladesh"', add
label define bpld_lbl 52120 `"Bhutan"', add
label define bpld_lbl 52130 `"Burma (Myanmar)"', add
label define bpld_lbl 52140 `"Pakistan"', add
label define bpld_lbl 52150 `"Sri Lanka (Ceylon)"', add
label define bpld_lbl 52200 `"Iran"', add
label define bpld_lbl 52300 `"Maldives"', add
label define bpld_lbl 52400 `"Nepal"', add
label define bpld_lbl 53000 `"Bahrain"', add
label define bpld_lbl 53100 `"Cyprus"', add
label define bpld_lbl 53200 `"Iraq"', add
label define bpld_lbl 53210 `"Mesopotamia"', add
label define bpld_lbl 53300 `"Iraq/Saudi Arabia"', add
label define bpld_lbl 53400 `"Israel/Palestine"', add
label define bpld_lbl 53410 `"Gaza Strip"', add
label define bpld_lbl 53420 `"Palestine"', add
label define bpld_lbl 53430 `"West Bank"', add
label define bpld_lbl 53440 `"Israel"', add
label define bpld_lbl 53500 `"Jordan"', add
label define bpld_lbl 53600 `"Kuwait"', add
label define bpld_lbl 53700 `"Lebanon"', add
label define bpld_lbl 53800 `"Oman"', add
label define bpld_lbl 53900 `"Qatar"', add
label define bpld_lbl 54000 `"Saudi Arabia"', add
label define bpld_lbl 54100 `"Syria"', add
label define bpld_lbl 54200 `"Turkey"', add
label define bpld_lbl 54210 `"European Turkey"', add
label define bpld_lbl 54220 `"Asian Turkey"', add
label define bpld_lbl 54300 `"United Arab Emirates"', add
label define bpld_lbl 54400 `"Yemen Arab Republic (North)"', add
label define bpld_lbl 54500 `"Yemen, PDR (South)"', add
label define bpld_lbl 54600 `"Persian Gulf States, ns"', add
label define bpld_lbl 54700 `"Middle East, ns"', add
label define bpld_lbl 54800 `"Southwest Asia, nec/ns"', add
label define bpld_lbl 54900 `"Asia Minor, ns"', add
label define bpld_lbl 55000 `"South Asia, nec"', add
label define bpld_lbl 59900 `"Asia, nec/ns"', add
label define bpld_lbl 60000 `"Africa"', add
label define bpld_lbl 60010 `"Northern Africa"', add
label define bpld_lbl 60011 `"Algeria"', add
label define bpld_lbl 60012 `"Egypt/United Arab Rep."', add
label define bpld_lbl 60013 `"Libya"', add
label define bpld_lbl 60014 `"Morocco"', add
label define bpld_lbl 60015 `"Sudan"', add
label define bpld_lbl 60016 `"Tunisia"', add
label define bpld_lbl 60017 `"Western Sahara"', add
label define bpld_lbl 60019 `"North Africa, ns"', add
label define bpld_lbl 60020 `"Benin"', add
label define bpld_lbl 60021 `"Burkina Faso"', add
label define bpld_lbl 60022 `"Gambia"', add
label define bpld_lbl 60023 `"Ghana"', add
label define bpld_lbl 60024 `"Guinea"', add
label define bpld_lbl 60025 `"Guinea-Bissau"', add
label define bpld_lbl 60026 `"Ivory Coast"', add
label define bpld_lbl 60027 `"Liberia"', add
label define bpld_lbl 60028 `"Mali"', add
label define bpld_lbl 60029 `"Mauritania"', add
label define bpld_lbl 60030 `"Niger"', add
label define bpld_lbl 60031 `"Nigeria"', add
label define bpld_lbl 60032 `"Senegal"', add
label define bpld_lbl 60033 `"Sierra Leone"', add
label define bpld_lbl 60034 `"Togo"', add
label define bpld_lbl 60038 `"Western Africa, ns"', add
label define bpld_lbl 60039 `"French West Africa, ns"', add
label define bpld_lbl 60040 `"British Indian Ocean Territory"', add
label define bpld_lbl 60041 `"Burundi"', add
label define bpld_lbl 60042 `"Comoros"', add
label define bpld_lbl 60043 `"Djibouti"', add
label define bpld_lbl 60044 `"Ethiopia"', add
label define bpld_lbl 60045 `"Kenya"', add
label define bpld_lbl 60046 `"Madagascar"', add
label define bpld_lbl 60047 `"Malawi"', add
label define bpld_lbl 60048 `"Mauritius"', add
label define bpld_lbl 60049 `"Mozambique"', add
label define bpld_lbl 60050 `"Reunion"', add
label define bpld_lbl 60051 `"Rwanda"', add
label define bpld_lbl 60052 `"Seychelles"', add
label define bpld_lbl 60053 `"Somalia"', add
label define bpld_lbl 60054 `"Tanzania"', add
label define bpld_lbl 60055 `"Uganda"', add
label define bpld_lbl 60056 `"Zambia"', add
label define bpld_lbl 60057 `"Zimbabwe"', add
label define bpld_lbl 60058 `"Bassas de India"', add
label define bpld_lbl 60059 `"Europa"', add
label define bpld_lbl 60060 `"Gloriosos"', add
label define bpld_lbl 60061 `"Juan de Nova"', add
label define bpld_lbl 60062 `"Mayotte"', add
label define bpld_lbl 60063 `"Tromelin"', add
label define bpld_lbl 60064 `"Eastern Africa, nec/ns"', add
label define bpld_lbl 60065 `"Eritrea"', add
label define bpld_lbl 60066 `"South Sudan"', add
label define bpld_lbl 60070 `"Central Africa"', add
label define bpld_lbl 60071 `"Angola"', add
label define bpld_lbl 60072 `"Cameroon"', add
label define bpld_lbl 60073 `"Central African Republic"', add
label define bpld_lbl 60074 `"Chad"', add
label define bpld_lbl 60075 `"Congo"', add
label define bpld_lbl 60076 `"Equatorial Guinea"', add
label define bpld_lbl 60077 `"Gabon"', add
label define bpld_lbl 60078 `"Sao Tome and Principe"', add
label define bpld_lbl 60079 `"Zaire"', add
label define bpld_lbl 60080 `"Central Africa, ns"', add
label define bpld_lbl 60081 `"Equatorial Africa, ns"', add
label define bpld_lbl 60082 `"French Equatorial Africa, ns"', add
label define bpld_lbl 60090 `"Southern Africa"', add
label define bpld_lbl 60091 `"Botswana"', add
label define bpld_lbl 60092 `"Lesotho"', add
label define bpld_lbl 60093 `"Namibia"', add
label define bpld_lbl 60094 `"South Africa (Union of)"', add
label define bpld_lbl 60095 `"Swaziland"', add
label define bpld_lbl 60096 `"Southern Africa, ns"', add
label define bpld_lbl 60099 `"Africa, ns/nec"', add
label define bpld_lbl 70000 `"Australia and New Zealand"', add
label define bpld_lbl 70010 `"Australia"', add
label define bpld_lbl 70011 `"Ashmore and Cartier Islands"', add
label define bpld_lbl 70012 `"Coral Sea Islands Territory"', add
label define bpld_lbl 70013 `"Christmas Island"', add
label define bpld_lbl 70014 `"Cocos Islands"', add
label define bpld_lbl 70020 `"New Zealand"', add
label define bpld_lbl 71000 `"Pacific Islands"', add
label define bpld_lbl 71010 `"New Caledonia"', add
label define bpld_lbl 71012 `"Papua New Guinea"', add
label define bpld_lbl 71013 `"Solomon Islands"', add
label define bpld_lbl 71014 `"Vanuatu (New Hebrides)"', add
label define bpld_lbl 71015 `"Fiji"', add
label define bpld_lbl 71016 `"Melanesia, ns"', add
label define bpld_lbl 71017 `"Norfolk Islands"', add
label define bpld_lbl 71018 `"Niue"', add
label define bpld_lbl 71020 `"Cook Islands"', add
label define bpld_lbl 71022 `"French Polynesia"', add
label define bpld_lbl 71023 `"Tonga"', add
label define bpld_lbl 71024 `"Wallis and Futuna Islands"', add
label define bpld_lbl 71025 `"Western Samoa"', add
label define bpld_lbl 71026 `"Pitcairn Island"', add
label define bpld_lbl 71027 `"Tokelau"', add
label define bpld_lbl 71028 `"Tuvalu"', add
label define bpld_lbl 71029 `"Polynesia, ns"', add
label define bpld_lbl 71032 `"Kiribati"', add
label define bpld_lbl 71033 `"Canton and Enderbury"', add
label define bpld_lbl 71034 `"Nauru"', add
label define bpld_lbl 71039 `"Micronesia, ns"', add
label define bpld_lbl 71040 `"US Pacific Trust Territories"', add
label define bpld_lbl 71041 `"Marshall Islands"', add
label define bpld_lbl 71042 `"Micronesia"', add
label define bpld_lbl 71043 `"Kosrae"', add
label define bpld_lbl 71044 `"Pohnpei"', add
label define bpld_lbl 71045 `"Truk"', add
label define bpld_lbl 71046 `"Yap"', add
label define bpld_lbl 71047 `"Northern Mariana Islands"', add
label define bpld_lbl 71048 `"Palau"', add
label define bpld_lbl 71049 `"Pacific Trust Terr, ns"', add
label define bpld_lbl 71050 `"Clipperton Island"', add
label define bpld_lbl 71090 `"Oceania, ns/nec"', add
label define bpld_lbl 80000 `"Antarctica, ns/nec"', add
label define bpld_lbl 80010 `"Bouvet Islands"', add
label define bpld_lbl 80020 `"British Antarctic Terr."', add
label define bpld_lbl 80030 `"Dronning Maud Land"', add
label define bpld_lbl 80040 `"French Southern and Antarctic Lands"', add
label define bpld_lbl 80050 `"Heard and McDonald Islands"', add
label define bpld_lbl 90000 `"Abroad (unknown) or at sea"', add
label define bpld_lbl 90010 `"Abroad, ns"', add
label define bpld_lbl 90011 `"Abroad (US citizen)"', add
label define bpld_lbl 90020 `"At sea"', add
label define bpld_lbl 90021 `"At sea (US citizen)"', add
label define bpld_lbl 90022 `"At sea or abroad (U.S. citizen)"', add
label define bpld_lbl 95000 `"Other n.e.c."', add
label define bpld_lbl 99900 `"Missing/blank"', add
label values bpld bpld_lbl

label define citizen_lbl 0 `"N/A"'
label define citizen_lbl 1 `"Born abroad of American parents"', add
label define citizen_lbl 2 `"Naturalized citizen"', add
label define citizen_lbl 3 `"Not a citizen"', add
label define citizen_lbl 4 `"Not a citizen, but has received first papers"', add
label define citizen_lbl 5 `"Foreign born, citizenship status not reported"', add
label values citizen citizen_lbl

label define educ_lbl 00 `"N/A or no schooling"'
label define educ_lbl 01 `"Nursery school to grade 4"', add
label define educ_lbl 02 `"Grade 5, 6, 7, or 8"', add
label define educ_lbl 03 `"Grade 9"', add
label define educ_lbl 04 `"Grade 10"', add
label define educ_lbl 05 `"Grade 11"', add
label define educ_lbl 06 `"Grade 12"', add
label define educ_lbl 07 `"1 year of college"', add
label define educ_lbl 08 `"2 years of college"', add
label define educ_lbl 09 `"3 years of college"', add
label define educ_lbl 10 `"4 years of college"', add
label define educ_lbl 11 `"5+ years of college"', add
label values educ educ_lbl

label define educd_lbl 000 `"N/A or no schooling"'
label define educd_lbl 001 `"N/A"', add
label define educd_lbl 002 `"No schooling completed"', add
label define educd_lbl 010 `"Nursery school to grade 4"', add
label define educd_lbl 011 `"Nursery school, preschool"', add
label define educd_lbl 012 `"Kindergarten"', add
label define educd_lbl 013 `"Grade 1, 2, 3, or 4"', add
label define educd_lbl 014 `"Grade 1"', add
label define educd_lbl 015 `"Grade 2"', add
label define educd_lbl 016 `"Grade 3"', add
label define educd_lbl 017 `"Grade 4"', add
label define educd_lbl 020 `"Grade 5, 6, 7, or 8"', add
label define educd_lbl 021 `"Grade 5 or 6"', add
label define educd_lbl 022 `"Grade 5"', add
label define educd_lbl 023 `"Grade 6"', add
label define educd_lbl 024 `"Grade 7 or 8"', add
label define educd_lbl 025 `"Grade 7"', add
label define educd_lbl 026 `"Grade 8"', add
label define educd_lbl 030 `"Grade 9"', add
label define educd_lbl 040 `"Grade 10"', add
label define educd_lbl 050 `"Grade 11"', add
label define educd_lbl 060 `"Grade 12"', add
label define educd_lbl 061 `"12th grade, no diploma"', add
label define educd_lbl 062 `"High school graduate or GED"', add
label define educd_lbl 063 `"Regular high school diploma"', add
label define educd_lbl 064 `"GED or alternative credential"', add
label define educd_lbl 065 `"Some college, but less than 1 year"', add
label define educd_lbl 070 `"1 year of college"', add
label define educd_lbl 071 `"1 or more years of college credit, no degree"', add
label define educd_lbl 080 `"2 years of college"', add
label define educd_lbl 081 `"Associate's degree, type not specified"', add
label define educd_lbl 082 `"Associate's degree, occupational program"', add
label define educd_lbl 083 `"Associate's degree, academic program"', add
label define educd_lbl 090 `"3 years of college"', add
label define educd_lbl 100 `"4 years of college"', add
label define educd_lbl 101 `"Bachelor's degree"', add
label define educd_lbl 110 `"5+ years of college"', add
label define educd_lbl 111 `"6 years of college (6+ in 1960-1970)"', add
label define educd_lbl 112 `"7 years of college"', add
label define educd_lbl 113 `"8+ years of college"', add
label define educd_lbl 114 `"Master's degree"', add
label define educd_lbl 115 `"Professional degree beyond a bachelor's degree"', add
label define educd_lbl 116 `"Doctoral degree"', add
label define educd_lbl 999 `"Missing"', add
label values educd educd_lbl

label define degfield_lbl 00 `"N/A"'
label define degfield_lbl 11 `"Agriculture"', add
label define degfield_lbl 13 `"Environment and Natural Resources"', add
label define degfield_lbl 14 `"Architecture"', add
label define degfield_lbl 15 `"Area, Ethnic, and Civilization Studies"', add
label define degfield_lbl 19 `"Communications"', add
label define degfield_lbl 20 `"Communication Technologies"', add
label define degfield_lbl 21 `"Computer and Information Sciences"', add
label define degfield_lbl 22 `"Cosmetology Services and Culinary Arts"', add
label define degfield_lbl 23 `"Education Administration and Teaching"', add
label define degfield_lbl 24 `"Engineering"', add
label define degfield_lbl 25 `"Engineering Technologies"', add
label define degfield_lbl 26 `"Linguistics and Foreign Languages"', add
label define degfield_lbl 29 `"Family and Consumer Sciences"', add
label define degfield_lbl 32 `"Law"', add
label define degfield_lbl 33 `"English Language, Literature, and Composition"', add
label define degfield_lbl 34 `"Liberal Arts and Humanities"', add
label define degfield_lbl 35 `"Library Science"', add
label define degfield_lbl 36 `"Biology and Life Sciences"', add
label define degfield_lbl 37 `"Mathematics and Statistics"', add
label define degfield_lbl 38 `"Military Technologies"', add
label define degfield_lbl 40 `"Interdisciplinary and Multi-Disciplinary Studies (General)"', add
label define degfield_lbl 41 `"Physical Fitness, Parks, Recreation, and Leisure"', add
label define degfield_lbl 48 `"Philosophy and Religious Studies"', add
label define degfield_lbl 49 `"Theology and Religious Vocations"', add
label define degfield_lbl 50 `"Physical Sciences"', add
label define degfield_lbl 51 `"Nuclear, Industrial Radiology, and Biological Technologies"', add
label define degfield_lbl 52 `"Psychology"', add
label define degfield_lbl 53 `"Criminal Justice and Fire Protection"', add
label define degfield_lbl 54 `"Public Affairs, Policy, and Social Work"', add
label define degfield_lbl 55 `"Social Sciences"', add
label define degfield_lbl 56 `"Construction Services"', add
label define degfield_lbl 57 `"Electrical and Mechanic Repairs and Technologies"', add
label define degfield_lbl 58 `"Precision Production and Industrial Arts"', add
label define degfield_lbl 59 `"Transportation Sciences and Technologies"', add
label define degfield_lbl 60 `"Fine Arts"', add
label define degfield_lbl 61 `"Medical and Health Sciences and Services"', add
label define degfield_lbl 62 `"Business"', add
label define degfield_lbl 64 `"History"', add
label values degfield degfield_lbl

label define degfieldd_lbl 0000 `"N/A"'
label define degfieldd_lbl 1100 `"General Agriculture"', add
label define degfieldd_lbl 1101 `"Agriculture Production and Management"', add
label define degfieldd_lbl 1102 `"Agricultural Economics"', add
label define degfieldd_lbl 1103 `"Animal Sciences"', add
label define degfieldd_lbl 1104 `"Food Science"', add
label define degfieldd_lbl 1105 `"Plant Science and Agronomy"', add
label define degfieldd_lbl 1106 `"Soil Science"', add
label define degfieldd_lbl 1199 `"Miscellaneous Agriculture"', add
label define degfieldd_lbl 1300 `"Environment and Natural Resources"', add
label define degfieldd_lbl 1301 `"Environmental Science"', add
label define degfieldd_lbl 1302 `"Forestry"', add
label define degfieldd_lbl 1303 `"Natural Resources Management"', add
label define degfieldd_lbl 1401 `"Architecture"', add
label define degfieldd_lbl 1501 `"Area, Ethnic, and Civilization Studies"', add
label define degfieldd_lbl 1900 `"Communications"', add
label define degfieldd_lbl 1901 `"Communications"', add
label define degfieldd_lbl 1902 `"Journalism"', add
label define degfieldd_lbl 1903 `"Mass Media"', add
label define degfieldd_lbl 1904 `"Advertising and Public Relations"', add
label define degfieldd_lbl 2001 `"Communication Technologies"', add
label define degfieldd_lbl 2100 `"Computer and Information Systems"', add
label define degfieldd_lbl 2101 `"Computer Programming and Data Processing"', add
label define degfieldd_lbl 2102 `"Computer Science"', add
label define degfieldd_lbl 2105 `"Information Sciences"', add
label define degfieldd_lbl 2106 `"Computer Information Management and Security"', add
label define degfieldd_lbl 2107 `"Computer Networking and Telecommunications"', add
label define degfieldd_lbl 2201 `"Cosmetology Services and Culinary Arts"', add
label define degfieldd_lbl 2300 `"General Education"', add
label define degfieldd_lbl 2301 `"Educational Administration and Supervision"', add
label define degfieldd_lbl 2303 `"School Student Counseling"', add
label define degfieldd_lbl 2304 `"Elementary Education"', add
label define degfieldd_lbl 2305 `"Mathematics Teacher Education"', add
label define degfieldd_lbl 2306 `"Physical and Health Education Teaching"', add
label define degfieldd_lbl 2307 `"Early Childhood Education"', add
label define degfieldd_lbl 2308 `"Science  and Computer Teacher Education"', add
label define degfieldd_lbl 2309 `"Secondary Teacher Education"', add
label define degfieldd_lbl 2310 `"Special Needs Education"', add
label define degfieldd_lbl 2311 `"Social Science or History Teacher Education"', add
label define degfieldd_lbl 2312 `"Teacher Education:  Multiple Levels"', add
label define degfieldd_lbl 2313 `"Language and Drama Education"', add
label define degfieldd_lbl 2314 `"Art and Music Education"', add
label define degfieldd_lbl 2399 `"Miscellaneous Education"', add
label define degfieldd_lbl 2400 `"General Engineering"', add
label define degfieldd_lbl 2401 `"Aerospace Engineering"', add
label define degfieldd_lbl 2402 `"Biological Engineering"', add
label define degfieldd_lbl 2403 `"Architectural Engineering"', add
label define degfieldd_lbl 2404 `"Biomedical Engineering"', add
label define degfieldd_lbl 2405 `"Chemical Engineering"', add
label define degfieldd_lbl 2406 `"Civil Engineering"', add
label define degfieldd_lbl 2407 `"Computer Engineering"', add
label define degfieldd_lbl 2408 `"Electrical Engineering"', add
label define degfieldd_lbl 2409 `"Engineering Mechanics, Physics, and Science"', add
label define degfieldd_lbl 2410 `"Environmental Engineering"', add
label define degfieldd_lbl 2411 `"Geological and Geophysical Engineering"', add
label define degfieldd_lbl 2412 `"Industrial and Manufacturing Engineering"', add
label define degfieldd_lbl 2413 `"Materials Engineering and Materials Science"', add
label define degfieldd_lbl 2414 `"Mechanical Engineering"', add
label define degfieldd_lbl 2415 `"Metallurgical Engineering"', add
label define degfieldd_lbl 2416 `"Mining and Mineral Engineering"', add
label define degfieldd_lbl 2417 `"Naval Architecture and Marine Engineering"', add
label define degfieldd_lbl 2418 `"Nuclear Engineering"', add
label define degfieldd_lbl 2419 `"Petroleum Engineering"', add
label define degfieldd_lbl 2499 `"Miscellaneous Engineering"', add
label define degfieldd_lbl 2500 `"Engineering Technologies"', add
label define degfieldd_lbl 2501 `"Engineering and Industrial Management"', add
label define degfieldd_lbl 2502 `"Electrical Engineering Technology"', add
label define degfieldd_lbl 2503 `"Industrial Production Technologies"', add
label define degfieldd_lbl 2504 `"Mechanical Engineering Related Technologies"', add
label define degfieldd_lbl 2599 `"Miscellaneous Engineering Technologies"', add
label define degfieldd_lbl 2600 `"Linguistics and Foreign Languages"', add
label define degfieldd_lbl 2601 `"Linguistics and Comparative Language and Literature"', add
label define degfieldd_lbl 2602 `"French, German, Latin and Other Common Foreign Language Studies"', add
label define degfieldd_lbl 2603 `"Other Foreign Languages"', add
label define degfieldd_lbl 2901 `"Family and Consumer Sciences"', add
label define degfieldd_lbl 3200 `"Law"', add
label define degfieldd_lbl 3201 `"Court Reporting"', add
label define degfieldd_lbl 3202 `"Pre-Law and Legal Studies"', add
label define degfieldd_lbl 3300 `"English Language, Literature, and Composition"', add
label define degfieldd_lbl 3301 `"English Language and Literature"', add
label define degfieldd_lbl 3302 `"Composition and Speech"', add
label define degfieldd_lbl 3400 `"Liberal Arts and Humanities"', add
label define degfieldd_lbl 3401 `"Liberal Arts"', add
label define degfieldd_lbl 3402 `"Humanities"', add
label define degfieldd_lbl 3501 `"Library Science"', add
label define degfieldd_lbl 3600 `"Biology"', add
label define degfieldd_lbl 3601 `"Biochemical Sciences"', add
label define degfieldd_lbl 3602 `"Botany"', add
label define degfieldd_lbl 3603 `"Molecular Biology"', add
label define degfieldd_lbl 3604 `"Ecology"', add
label define degfieldd_lbl 3605 `"Genetics"', add
label define degfieldd_lbl 3606 `"Microbiology"', add
label define degfieldd_lbl 3607 `"Pharmacology"', add
label define degfieldd_lbl 3608 `"Physiology"', add
label define degfieldd_lbl 3609 `"Zoology"', add
label define degfieldd_lbl 3611 `"Neuroscience"', add
label define degfieldd_lbl 3699 `"Miscellaneous Biology"', add
label define degfieldd_lbl 3700 `"Mathematics"', add
label define degfieldd_lbl 3701 `"Applied Mathematics"', add
label define degfieldd_lbl 3702 `"Statistics and Decision Science"', add
label define degfieldd_lbl 3801 `"Military Technologies"', add
label define degfieldd_lbl 4000 `"Interdisciplinary and Multi-Disciplinary Studies (General)"', add
label define degfieldd_lbl 4001 `"Intercultural and International Studies"', add
label define degfieldd_lbl 4002 `"Nutrition Sciences"', add
label define degfieldd_lbl 4003 `"Neuroscience"', add
label define degfieldd_lbl 4005 `"Mathematics and Computer Science"', add
label define degfieldd_lbl 4006 `"Cognitive Science and Biopsychology"', add
label define degfieldd_lbl 4007 `"Interdisciplinary Social Sciences"', add
label define degfieldd_lbl 4008 `"Multi-disciplinary or General Science"', add
label define degfieldd_lbl 4101 `"Physical Fitness, Parks, Recreation, and Leisure"', add
label define degfieldd_lbl 4801 `"Philosophy and Religious Studies"', add
label define degfieldd_lbl 4901 `"Theology and Religious Vocations"', add
label define degfieldd_lbl 5000 `"Physical Sciences"', add
label define degfieldd_lbl 5001 `"Astronomy and Astrophysics"', add
label define degfieldd_lbl 5002 `"Atmospheric Sciences and Meteorology"', add
label define degfieldd_lbl 5003 `"Chemistry"', add
label define degfieldd_lbl 5004 `"Geology and Earth Science"', add
label define degfieldd_lbl 5005 `"Geosciences"', add
label define degfieldd_lbl 5006 `"Oceanography"', add
label define degfieldd_lbl 5007 `"Physics"', add
label define degfieldd_lbl 5008 `"Materials Science"', add
label define degfieldd_lbl 5098 `"Multi-disciplinary or General Science"', add
label define degfieldd_lbl 5102 `"Nuclear, Industrial Radiology, and Biological Technologies"', add
label define degfieldd_lbl 5200 `"Psychology"', add
label define degfieldd_lbl 5201 `"Educational Psychology"', add
label define degfieldd_lbl 5202 `"Clinical Psychology"', add
label define degfieldd_lbl 5203 `"Counseling Psychology"', add
label define degfieldd_lbl 5205 `"Industrial and Organizational Psychology"', add
label define degfieldd_lbl 5206 `"Social Psychology"', add
label define degfieldd_lbl 5299 `"Miscellaneous Psychology"', add
label define degfieldd_lbl 5301 `"Criminal Justice and Fire Protection"', add
label define degfieldd_lbl 5400 `"Public Affairs, Policy, and Social Work"', add
label define degfieldd_lbl 5401 `"Public Administration"', add
label define degfieldd_lbl 5402 `"Public Policy"', add
label define degfieldd_lbl 5403 `"Human Services and Community Organization"', add
label define degfieldd_lbl 5404 `"Social Work"', add
label define degfieldd_lbl 5500 `"General Social Sciences"', add
label define degfieldd_lbl 5501 `"Economics"', add
label define degfieldd_lbl 5502 `"Anthropology and Archeology"', add
label define degfieldd_lbl 5503 `"Criminology"', add
label define degfieldd_lbl 5504 `"Geography"', add
label define degfieldd_lbl 5505 `"International Relations"', add
label define degfieldd_lbl 5506 `"Political Science and Government"', add
label define degfieldd_lbl 5507 `"Sociology"', add
label define degfieldd_lbl 5599 `"Miscellaneous Social Sciences"', add
label define degfieldd_lbl 5601 `"Construction Services"', add
label define degfieldd_lbl 5701 `"Electrical and Mechanic Repairs and Technologies"', add
label define degfieldd_lbl 5801 `"Precision Production and Industrial Arts"', add
label define degfieldd_lbl 5901 `"Transportation Sciences and Technologies"', add
label define degfieldd_lbl 6000 `"Fine Arts"', add
label define degfieldd_lbl 6001 `"Drama and Theater Arts"', add
label define degfieldd_lbl 6002 `"Music"', add
label define degfieldd_lbl 6003 `"Visual and Performing Arts"', add
label define degfieldd_lbl 6004 `"Commercial Art and Graphic Design"', add
label define degfieldd_lbl 6005 `"Film, Video and Photographic Arts"', add
label define degfieldd_lbl 6006 `"Art History and Criticism"', add
label define degfieldd_lbl 6007 `"Studio Arts"', add
label define degfieldd_lbl 6099 `"Miscellaneous Fine Arts"', add
label define degfieldd_lbl 6100 `"General Medical and Health Services"', add
label define degfieldd_lbl 6102 `"Communication Disorders Sciences and Services"', add
label define degfieldd_lbl 6103 `"Health and Medical Administrative Services"', add
label define degfieldd_lbl 6104 `"Medical Assisting Services"', add
label define degfieldd_lbl 6105 `"Medical Technologies Technicians"', add
label define degfieldd_lbl 6106 `"Health and Medical Preparatory Programs"', add
label define degfieldd_lbl 6107 `"Nursing"', add
label define degfieldd_lbl 6108 `"Pharmacy, Pharmaceutical Sciences, and Administration"', add
label define degfieldd_lbl 6109 `"Treatment Therapy Professions"', add
label define degfieldd_lbl 6110 `"Community and Public Health"', add
label define degfieldd_lbl 6199 `"Miscellaneous Health Medical Professions"', add
label define degfieldd_lbl 6200 `"General Business"', add
label define degfieldd_lbl 6201 `"Accounting"', add
label define degfieldd_lbl 6202 `"Actuarial Science"', add
label define degfieldd_lbl 6203 `"Business Management and Administration"', add
label define degfieldd_lbl 6204 `"Operations, Logistics and E-Commerce"', add
label define degfieldd_lbl 6205 `"Business Economics"', add
label define degfieldd_lbl 6206 `"Marketing and Marketing Research"', add
label define degfieldd_lbl 6207 `"Finance"', add
label define degfieldd_lbl 6209 `"Human Resources and Personnel Management"', add
label define degfieldd_lbl 6210 `"International Business"', add
label define degfieldd_lbl 6211 `"Hospitality Management"', add
label define degfieldd_lbl 6212 `"Management Information Systems and Statistics"', add
label define degfieldd_lbl 6299 `"Miscellaneous Business and Medical Administration"', add
label define degfieldd_lbl 6402 `"History"', add
label define degfieldd_lbl 6403 `"United States History"', add
label values degfieldd degfieldd_lbl

label define degfield2_lbl 00 `"N/A"'
label define degfield2_lbl 11 `"Agriculture"', add
label define degfield2_lbl 13 `"Environment and Natural Resources"', add
label define degfield2_lbl 14 `"Architecture"', add
label define degfield2_lbl 15 `"Area, Ethnic, and Civilization Studies"', add
label define degfield2_lbl 19 `"Communications"', add
label define degfield2_lbl 20 `"Communication Technologies"', add
label define degfield2_lbl 21 `"Computer and Information Sciences"', add
label define degfield2_lbl 22 `"Cosmetology Services and Culinary Arts"', add
label define degfield2_lbl 23 `"Education Administration and Teaching"', add
label define degfield2_lbl 24 `"Engineering"', add
label define degfield2_lbl 25 `"Engineering Technologies"', add
label define degfield2_lbl 26 `"Linguistics and Foreign Languages"', add
label define degfield2_lbl 29 `"Family and Consumer Sciences"', add
label define degfield2_lbl 32 `"Law"', add
label define degfield2_lbl 33 `"English Language, Literature, and Composition"', add
label define degfield2_lbl 34 `"Liberal Arts and Humanities"', add
label define degfield2_lbl 35 `"Library Science"', add
label define degfield2_lbl 36 `"Biology and Life Sciences"', add
label define degfield2_lbl 37 `"Mathematics and Statistics"', add
label define degfield2_lbl 38 `"Military Technologies"', add
label define degfield2_lbl 40 `"Interdisciplinary and Multi-Disciplinary Studies (General)"', add
label define degfield2_lbl 41 `"Physical Fitness, Parks, Recreation, and Leisure"', add
label define degfield2_lbl 48 `"Philosophy and Religious Studies"', add
label define degfield2_lbl 49 `"Theology and Religious Vocations"', add
label define degfield2_lbl 50 `"Physical Sciences"', add
label define degfield2_lbl 51 `"Nuclear, Industrial Radiology, and Biological Technologies"', add
label define degfield2_lbl 52 `"Psychology"', add
label define degfield2_lbl 53 `"Criminal Justice and Fire Protection"', add
label define degfield2_lbl 54 `"Public Affairs, Policy, and Social Work"', add
label define degfield2_lbl 55 `"Social Sciences"', add
label define degfield2_lbl 56 `"Construction Services"', add
label define degfield2_lbl 57 `"Electrical and Mechanic Repairs and Technologies"', add
label define degfield2_lbl 58 `"Precision Production and Industrial Arts"', add
label define degfield2_lbl 59 `"Transportation Sciences and Technologies"', add
label define degfield2_lbl 60 `"Fine Arts"', add
label define degfield2_lbl 61 `"Medical and Health Sciences and Services"', add
label define degfield2_lbl 62 `"Business"', add
label define degfield2_lbl 64 `"History"', add
label values degfield2 degfield2_lbl

label define degfield2d_lbl 0000 `"N/A"'
label define degfield2d_lbl 1100 `"General Agriculture"', add
label define degfield2d_lbl 1101 `"Agriculture Production and Management"', add
label define degfield2d_lbl 1102 `"Agricultural Economics"', add
label define degfield2d_lbl 1103 `"Animal Sciences"', add
label define degfield2d_lbl 1104 `"Food Science"', add
label define degfield2d_lbl 1105 `"Plant Science and Agronomy"', add
label define degfield2d_lbl 1106 `"Soil Science"', add
label define degfield2d_lbl 1199 `"Miscellaneous Agriculture"', add
label define degfield2d_lbl 1300 `"Environment and Natural Resources"', add
label define degfield2d_lbl 1301 `"Environmental Science"', add
label define degfield2d_lbl 1302 `"Forestry"', add
label define degfield2d_lbl 1303 `"Natural Resources Management"', add
label define degfield2d_lbl 1401 `"Architecture"', add
label define degfield2d_lbl 1501 `"Area, Ethnic, and Civilization Studies"', add
label define degfield2d_lbl 1900 `"Communications"', add
label define degfield2d_lbl 1901 `"Communications"', add
label define degfield2d_lbl 1902 `"Journalism"', add
label define degfield2d_lbl 1903 `"Mass Media"', add
label define degfield2d_lbl 1904 `"Advertising and Public Relations"', add
label define degfield2d_lbl 2001 `"Communication Technologies"', add
label define degfield2d_lbl 2100 `"Computer and Information Systems"', add
label define degfield2d_lbl 2101 `"Computer Programming and Data Processing"', add
label define degfield2d_lbl 2102 `"Computer Science"', add
label define degfield2d_lbl 2105 `"Information Sciences"', add
label define degfield2d_lbl 2106 `"Computer Information Management and Security"', add
label define degfield2d_lbl 2107 `"Computer Networking and Telecommunications"', add
label define degfield2d_lbl 2201 `"Cosmetology Services and Culinary Arts"', add
label define degfield2d_lbl 2300 `"General Education"', add
label define degfield2d_lbl 2301 `"Educational Administration and Supervision"', add
label define degfield2d_lbl 2303 `"School Student Counseling"', add
label define degfield2d_lbl 2304 `"Elementary Education"', add
label define degfield2d_lbl 2305 `"Mathematics Teacher Education"', add
label define degfield2d_lbl 2306 `"Physical and Health Education Teaching"', add
label define degfield2d_lbl 2307 `"Early Childhood Education"', add
label define degfield2d_lbl 2308 `"Science  and Computer Teacher Education"', add
label define degfield2d_lbl 2309 `"Secondary Teacher Education"', add
label define degfield2d_lbl 2310 `"Special Needs Education"', add
label define degfield2d_lbl 2311 `"Social Science or History Teacher Education"', add
label define degfield2d_lbl 2312 `"Teacher Education:  Multiple Levels"', add
label define degfield2d_lbl 2313 `"Language and Drama Education"', add
label define degfield2d_lbl 2314 `"Art and Music Education"', add
label define degfield2d_lbl 2399 `"Miscellaneous Education"', add
label define degfield2d_lbl 2400 `"General Engineering"', add
label define degfield2d_lbl 2401 `"Aerospace Engineering"', add
label define degfield2d_lbl 2402 `"Biological Engineering"', add
label define degfield2d_lbl 2403 `"Architectural Engineering"', add
label define degfield2d_lbl 2404 `"Biomedical Engineering"', add
label define degfield2d_lbl 2405 `"Chemical Engineering"', add
label define degfield2d_lbl 2406 `"Civil Engineering"', add
label define degfield2d_lbl 2407 `"Computer Engineering"', add
label define degfield2d_lbl 2408 `"Electrical Engineering"', add
label define degfield2d_lbl 2409 `"Engineering Mechanics, Physics, and Science"', add
label define degfield2d_lbl 2410 `"Environmental Engineering"', add
label define degfield2d_lbl 2411 `"Geological and Geophysical Engineering"', add
label define degfield2d_lbl 2412 `"Industrial and Manufacturing Engineering"', add
label define degfield2d_lbl 2413 `"Materials Engineering and Materials Science"', add
label define degfield2d_lbl 2414 `"Mechanical Engineering"', add
label define degfield2d_lbl 2415 `"Metallurgical Engineering"', add
label define degfield2d_lbl 2416 `"Mining and Mineral Engineering"', add
label define degfield2d_lbl 2417 `"Naval Architecture and Marine Engineering"', add
label define degfield2d_lbl 2418 `"Nuclear Engineering"', add
label define degfield2d_lbl 2419 `"Petroleum Engineering"', add
label define degfield2d_lbl 2499 `"Miscellaneous Engineering"', add
label define degfield2d_lbl 2500 `"Engineering Technologies"', add
label define degfield2d_lbl 2501 `"Engineering and Industrial Management"', add
label define degfield2d_lbl 2502 `"Electrical Engineering Technology"', add
label define degfield2d_lbl 2503 `"Industrial Production Technologies"', add
label define degfield2d_lbl 2504 `"Mechanical Engineering Related Technologies"', add
label define degfield2d_lbl 2599 `"Miscellaneous Engineering Technologies"', add
label define degfield2d_lbl 2600 `"Linguistics and Foreign Languages"', add
label define degfield2d_lbl 2601 `"Linguistics and Comparative Language and Literature"', add
label define degfield2d_lbl 2602 `"French, German, Latin and Other Common Foreign Language Studies"', add
label define degfield2d_lbl 2603 `"Other Foreign Languages"', add
label define degfield2d_lbl 2901 `"Family and Consumer Sciences"', add
label define degfield2d_lbl 3200 `"Law"', add
label define degfield2d_lbl 3201 `"Court Reporting"', add
label define degfield2d_lbl 3202 `"Pre-Law and Legal Studies"', add
label define degfield2d_lbl 3300 `"English Language, Literature, and Composition"', add
label define degfield2d_lbl 3301 `"English Language and Literature"', add
label define degfield2d_lbl 3302 `"Composition and Speech"', add
label define degfield2d_lbl 3400 `"Liberal Arts and Humanities"', add
label define degfield2d_lbl 3401 `"Liberal Arts"', add
label define degfield2d_lbl 3402 `"Humanities"', add
label define degfield2d_lbl 3501 `"Library Science"', add
label define degfield2d_lbl 3600 `"Biology"', add
label define degfield2d_lbl 3601 `"Biochemical Sciences"', add
label define degfield2d_lbl 3602 `"Botany"', add
label define degfield2d_lbl 3603 `"Molecular Biology"', add
label define degfield2d_lbl 3604 `"Ecology"', add
label define degfield2d_lbl 3605 `"Genetics"', add
label define degfield2d_lbl 3606 `"Microbiology"', add
label define degfield2d_lbl 3607 `"Pharmacology"', add
label define degfield2d_lbl 3608 `"Physiology"', add
label define degfield2d_lbl 3609 `"Zoology"', add
label define degfield2d_lbl 3611 `"Neuroscience"', add
label define degfield2d_lbl 3699 `"Miscellaneous Biology"', add
label define degfield2d_lbl 3700 `"Mathematics"', add
label define degfield2d_lbl 3701 `"Applied Mathematics"', add
label define degfield2d_lbl 3702 `"Statistics and Decision Science"', add
label define degfield2d_lbl 3801 `"Military Technologies"', add
label define degfield2d_lbl 4000 `"Interdisciplinary and Multi-Disciplinary Studies (General)"', add
label define degfield2d_lbl 4001 `"Intercultural and International Studies"', add
label define degfield2d_lbl 4002 `"Nutrition Sciences"', add
label define degfield2d_lbl 4003 `"Neuroscience"', add
label define degfield2d_lbl 4004 `"Accounting and Computer Science"', add
label define degfield2d_lbl 4005 `"Mathematics and Computer Science"', add
label define degfield2d_lbl 4006 `"Cognitive Science and Biopsychology"', add
label define degfield2d_lbl 4007 `"Interdisciplinary Social Sciences"', add
label define degfield2d_lbl 4008 `"Multi-disciplinary or General Science"', add
label define degfield2d_lbl 4101 `"Physical Fitness, Parks, Recreation, and Leisure"', add
label define degfield2d_lbl 4801 `"Philosophy and Religious Studies"', add
label define degfield2d_lbl 4901 `"Theology and Religious Vocations"', add
label define degfield2d_lbl 5000 `"Physical Sciences"', add
label define degfield2d_lbl 5001 `"Astronomy and Astrophysics"', add
label define degfield2d_lbl 5002 `"Atmospheric Sciences and Meteorology"', add
label define degfield2d_lbl 5003 `"Chemistry"', add
label define degfield2d_lbl 5004 `"Geology and Earth Science"', add
label define degfield2d_lbl 5005 `"Geosciences"', add
label define degfield2d_lbl 5006 `"Oceanography"', add
label define degfield2d_lbl 5007 `"Physics"', add
label define degfield2d_lbl 5008 `"Materials Science"', add
label define degfield2d_lbl 5098 `"Multi-disciplinary or General Science"', add
label define degfield2d_lbl 5102 `"Nuclear, Industrial Radiology, and Biological Technologies"', add
label define degfield2d_lbl 5200 `"Psychology"', add
label define degfield2d_lbl 5201 `"Educational Psychology"', add
label define degfield2d_lbl 5202 `"Clinical Psychology"', add
label define degfield2d_lbl 5203 `"Counseling Psychology"', add
label define degfield2d_lbl 5205 `"Industrial and Organizational Psychology"', add
label define degfield2d_lbl 5206 `"Social Psychology"', add
label define degfield2d_lbl 5299 `"Miscellaneous Psychology"', add
label define degfield2d_lbl 5301 `"Criminal Justice and Fire Protection"', add
label define degfield2d_lbl 5400 `"Public Affairs, Policy, and Social Work"', add
label define degfield2d_lbl 5401 `"Public Administration"', add
label define degfield2d_lbl 5402 `"Public Policy"', add
label define degfield2d_lbl 5403 `"Human Services and Community Organization"', add
label define degfield2d_lbl 5404 `"Social Work"', add
label define degfield2d_lbl 5500 `"General Social Sciences"', add
label define degfield2d_lbl 5501 `"Economics"', add
label define degfield2d_lbl 5502 `"Anthropology and Archeology"', add
label define degfield2d_lbl 5503 `"Criminology"', add
label define degfield2d_lbl 5504 `"Geography"', add
label define degfield2d_lbl 5505 `"International Relations"', add
label define degfield2d_lbl 5506 `"Political Science and Government"', add
label define degfield2d_lbl 5507 `"Sociology"', add
label define degfield2d_lbl 5599 `"Miscellaneous Social Sciences"', add
label define degfield2d_lbl 5601 `"Construction Services"', add
label define degfield2d_lbl 5701 `"Electrical and Mechanic Repairs and Technologies"', add
label define degfield2d_lbl 5801 `"Precision Production and Industrial Arts"', add
label define degfield2d_lbl 5901 `"Transportation Sciences and Technologies"', add
label define degfield2d_lbl 6000 `"Fine Arts"', add
label define degfield2d_lbl 6001 `"Drama and Theater Arts"', add
label define degfield2d_lbl 6002 `"Music"', add
label define degfield2d_lbl 6003 `"Visual and Performing Arts"', add
label define degfield2d_lbl 6004 `"Commercial Art and Graphic Design"', add
label define degfield2d_lbl 6005 `"Film, Video and Photographic Arts"', add
label define degfield2d_lbl 6006 `"Art History and Criticism"', add
label define degfield2d_lbl 6007 `"Studio Arts"', add
label define degfield2d_lbl 6008 `"Video Game Design and Development"', add
label define degfield2d_lbl 6099 `"Miscellaneous Fine Arts"', add
label define degfield2d_lbl 6100 `"General Medical and Health Services"', add
label define degfield2d_lbl 6102 `"Communication Disorders Sciences and Services"', add
label define degfield2d_lbl 6103 `"Health and Medical Administrative Services"', add
label define degfield2d_lbl 6104 `"Medical Assisting Services"', add
label define degfield2d_lbl 6105 `"Medical Technologies Technicians"', add
label define degfield2d_lbl 6106 `"Health and Medical Preparatory Programs"', add
label define degfield2d_lbl 6107 `"Nursing"', add
label define degfield2d_lbl 6108 `"Pharmacy, Pharmaceutical Sciences, and Administration"', add
label define degfield2d_lbl 6109 `"Treatment Therapy Professions"', add
label define degfield2d_lbl 6110 `"Community and Public Health"', add
label define degfield2d_lbl 6199 `"Miscellaneous Health Medical Professions"', add
label define degfield2d_lbl 6200 `"General Business"', add
label define degfield2d_lbl 6201 `"Accounting"', add
label define degfield2d_lbl 6202 `"Actuarial Science"', add
label define degfield2d_lbl 6203 `"Business Management and Administration"', add
label define degfield2d_lbl 6204 `"Operations, Logistics and E-Commerce"', add
label define degfield2d_lbl 6205 `"Business Economics"', add
label define degfield2d_lbl 6206 `"Marketing and Marketing Research"', add
label define degfield2d_lbl 6207 `"Finance"', add
label define degfield2d_lbl 6209 `"Human Resources and Personnel Management"', add
label define degfield2d_lbl 6210 `"International Business"', add
label define degfield2d_lbl 6211 `"Hospitality Management"', add
label define degfield2d_lbl 6212 `"Management Information Systems and Statistics"', add
label define degfield2d_lbl 6299 `"Miscellaneous Business and Medical Administration"', add
label define degfield2d_lbl 6402 `"History"', add
label define degfield2d_lbl 6403 `"United States History"', add
label values degfield2d degfield2d_lbl

label define empstat_lbl 0 `"N/A"'
label define empstat_lbl 1 `"Employed"', add
label define empstat_lbl 2 `"Unemployed"', add
label define empstat_lbl 3 `"Not in labor force"', add
label values empstat empstat_lbl

label define empstatd_lbl 00 `"N/A"'
label define empstatd_lbl 10 `"At work"', add
label define empstatd_lbl 11 `"At work, public emerg"', add
label define empstatd_lbl 12 `"Has job, not working"', add
label define empstatd_lbl 13 `"Armed forces"', add
label define empstatd_lbl 14 `"Armed forces--at work"', add
label define empstatd_lbl 15 `"Armed forces--not at work but with job"', add
label define empstatd_lbl 20 `"Unemployed"', add
label define empstatd_lbl 21 `"Unemp, exper worker"', add
label define empstatd_lbl 22 `"Unemp, new worker"', add
label define empstatd_lbl 30 `"Not in Labor Force"', add
label define empstatd_lbl 31 `"NILF, housework"', add
label define empstatd_lbl 32 `"NILF, unable to work"', add
label define empstatd_lbl 33 `"NILF, school"', add
label define empstatd_lbl 34 `"NILF, other"', add
label values empstatd empstatd_lbl

label define labforce_lbl 0 `"N/A"'
label define labforce_lbl 1 `"No, not in the labor force"', add
label define labforce_lbl 2 `"Yes, in the labor force"', add
label values labforce labforce_lbl

label define occ1990_lbl 003 `"Legislators"'
label define occ1990_lbl 004 `"Chief executives and public administrators"', add
label define occ1990_lbl 007 `"Financial managers"', add
label define occ1990_lbl 008 `"Human resources and labor relations managers"', add
label define occ1990_lbl 013 `"Managers and specialists in marketing, advertising, and public relations"', add
label define occ1990_lbl 014 `"Managers in education and related fields"', add
label define occ1990_lbl 015 `"Managers of medicine and health occupations"', add
label define occ1990_lbl 016 `"Postmasters and mail superintendents"', add
label define occ1990_lbl 017 `"Managers of food-serving and lodging establishments"', add
label define occ1990_lbl 018 `"Managers of properties and real estate"', add
label define occ1990_lbl 019 `"Funeral directors"', add
label define occ1990_lbl 021 `"Managers of service organizations, n.e.c."', add
label define occ1990_lbl 022 `"Managers and administrators, n.e.c."', add
label define occ1990_lbl 023 `"Accountants and auditors"', add
label define occ1990_lbl 024 `"Insurance underwriters"', add
label define occ1990_lbl 025 `"Other financial specialists"', add
label define occ1990_lbl 026 `"Management analysts"', add
label define occ1990_lbl 027 `"Personnel, HR, training, and labor relations specialists"', add
label define occ1990_lbl 028 `"Purchasing agents and buyers, of farm products"', add
label define occ1990_lbl 029 `"Buyers, wholesale and retail trade"', add
label define occ1990_lbl 033 `"Purchasing managers, agents and buyers, n.e.c."', add
label define occ1990_lbl 034 `"Business and promotion agents"', add
label define occ1990_lbl 035 `"Construction inspectors"', add
label define occ1990_lbl 036 `"Inspectors and compliance officers, outside construction"', add
label define occ1990_lbl 037 `"Management support occupations"', add
label define occ1990_lbl 043 `"Architects"', add
label define occ1990_lbl 044 `"Aerospace engineer"', add
label define occ1990_lbl 045 `"Metallurgical and materials engineers, variously phrased"', add
label define occ1990_lbl 047 `"Petroleum, mining, and geological engineers"', add
label define occ1990_lbl 048 `"Chemical engineers"', add
label define occ1990_lbl 053 `"Civil engineers"', add
label define occ1990_lbl 055 `"Electrical engineer"', add
label define occ1990_lbl 056 `"Industrial engineers"', add
label define occ1990_lbl 057 `"Mechanical engineers"', add
label define occ1990_lbl 059 `"Not-elsewhere-classified engineers"', add
label define occ1990_lbl 064 `"Computer systems analysts and computer scientists"', add
label define occ1990_lbl 065 `"Operations and systems researchers and analysts"', add
label define occ1990_lbl 066 `"Actuaries"', add
label define occ1990_lbl 067 `"Statisticians"', add
label define occ1990_lbl 068 `"Mathematicians and mathematical scientists"', add
label define occ1990_lbl 069 `"Physicists and astronomers"', add
label define occ1990_lbl 073 `"Chemists"', add
label define occ1990_lbl 074 `"Atmospheric and space scientists"', add
label define occ1990_lbl 075 `"Geologists"', add
label define occ1990_lbl 076 `"Physical scientists, n.e.c."', add
label define occ1990_lbl 077 `"Agricultural and food scientists"', add
label define occ1990_lbl 078 `"Biological scientists"', add
label define occ1990_lbl 079 `"Foresters and conservation scientists"', add
label define occ1990_lbl 083 `"Medical scientists"', add
label define occ1990_lbl 084 `"Physicians"', add
label define occ1990_lbl 085 `"Dentists"', add
label define occ1990_lbl 086 `"Veterinarians"', add
label define occ1990_lbl 087 `"Optometrists"', add
label define occ1990_lbl 088 `"Podiatrists"', add
label define occ1990_lbl 089 `"Other health and therapy"', add
label define occ1990_lbl 095 `"Registered nurses"', add
label define occ1990_lbl 096 `"Pharmacists"', add
label define occ1990_lbl 097 `"Dietitians and nutritionists"', add
label define occ1990_lbl 098 `"Respiratory therapists"', add
label define occ1990_lbl 099 `"Occupational therapists"', add
label define occ1990_lbl 103 `"Physical therapists"', add
label define occ1990_lbl 104 `"Speech therapists"', add
label define occ1990_lbl 105 `"Therapists, n.e.c."', add
label define occ1990_lbl 106 `"Physicians' assistants"', add
label define occ1990_lbl 113 `"Earth, environmental, and marine science instructors"', add
label define occ1990_lbl 114 `"Biological science instructors"', add
label define occ1990_lbl 115 `"Chemistry instructors"', add
label define occ1990_lbl 116 `"Physics instructors"', add
label define occ1990_lbl 118 `"Psychology instructors"', add
label define occ1990_lbl 119 `"Economics instructors"', add
label define occ1990_lbl 123 `"History instructors"', add
label define occ1990_lbl 125 `"Sociology instructors"', add
label define occ1990_lbl 127 `"Engineering instructors"', add
label define occ1990_lbl 128 `"Math instructors"', add
label define occ1990_lbl 139 `"Education instructors"', add
label define occ1990_lbl 145 `"Law instructors"', add
label define occ1990_lbl 147 `"Theology instructors"', add
label define occ1990_lbl 149 `"Home economics instructors"', add
label define occ1990_lbl 150 `"Humanities profs/instructors, college, nec"', add
label define occ1990_lbl 154 `"Subject instructors (HS/college)"', add
label define occ1990_lbl 155 `"Kindergarten and earlier school teachers"', add
label define occ1990_lbl 156 `"Primary school teachers"', add
label define occ1990_lbl 157 `"Secondary school teachers"', add
label define occ1990_lbl 158 `"Special education teachers"', add
label define occ1990_lbl 159 `"Teachers , n.e.c."', add
label define occ1990_lbl 163 `"Vocational and educational counselors"', add
label define occ1990_lbl 164 `"Librarians"', add
label define occ1990_lbl 165 `"Archivists and curators"', add
label define occ1990_lbl 166 `"Economists, market researchers, and survey researchers"', add
label define occ1990_lbl 167 `"Psychologists"', add
label define occ1990_lbl 168 `"Sociologists"', add
label define occ1990_lbl 169 `"Social scientists, n.e.c."', add
label define occ1990_lbl 173 `"Urban and regional planners"', add
label define occ1990_lbl 174 `"Social workers"', add
label define occ1990_lbl 175 `"Recreation workers"', add
label define occ1990_lbl 176 `"Clergy and religious workers"', add
label define occ1990_lbl 178 `"Lawyers"', add
label define occ1990_lbl 179 `"Judges"', add
label define occ1990_lbl 183 `"Writers and authors"', add
label define occ1990_lbl 184 `"Technical writers"', add
label define occ1990_lbl 185 `"Designers"', add
label define occ1990_lbl 186 `"Musician or composer"', add
label define occ1990_lbl 187 `"Actors, directors, producers"', add
label define occ1990_lbl 188 `"Art makers: painters, sculptors, craft-artists, and print-makers"', add
label define occ1990_lbl 189 `"Photographers"', add
label define occ1990_lbl 193 `"Dancers"', add
label define occ1990_lbl 194 `"Art/entertainment performers and related"', add
label define occ1990_lbl 195 `"Editors and reporters"', add
label define occ1990_lbl 198 `"Announcers"', add
label define occ1990_lbl 199 `"Athletes, sports instructors, and officials"', add
label define occ1990_lbl 200 `"Professionals, n.e.c."', add
label define occ1990_lbl 203 `"Clinical laboratory technologies and technicians"', add
label define occ1990_lbl 204 `"Dental hygenists"', add
label define occ1990_lbl 205 `"Health record tech specialists"', add
label define occ1990_lbl 206 `"Radiologic tech specialists"', add
label define occ1990_lbl 207 `"Licensed practical nurses"', add
label define occ1990_lbl 208 `"Health technologists and technicians, n.e.c."', add
label define occ1990_lbl 213 `"Electrical and electronic (engineering) technicians"', add
label define occ1990_lbl 214 `"Engineering technicians, n.e.c."', add
label define occ1990_lbl 215 `"Mechanical engineering technicians"', add
label define occ1990_lbl 217 `"Drafters"', add
label define occ1990_lbl 218 `"Surveyors, cartographers, mapping scientists and technicians"', add
label define occ1990_lbl 223 `"Biological technicians"', add
label define occ1990_lbl 224 `"Chemical technicians"', add
label define occ1990_lbl 225 `"Other science technicians"', add
label define occ1990_lbl 226 `"Airplane pilots and navigators"', add
label define occ1990_lbl 227 `"Air traffic controllers"', add
label define occ1990_lbl 228 `"Broadcast equipment operators"', add
label define occ1990_lbl 229 `"Computer software developers"', add
label define occ1990_lbl 233 `"Programmers of numerically controlled machine tools"', add
label define occ1990_lbl 234 `"Legal assistants, paralegals, legal support, etc"', add
label define occ1990_lbl 235 `"Technicians, n.e.c."', add
label define occ1990_lbl 243 `"Supervisors and proprietors of sales jobs"', add
label define occ1990_lbl 253 `"Insurance sales occupations"', add
label define occ1990_lbl 254 `"Real estate sales occupations"', add
label define occ1990_lbl 255 `"Financial services sales occupations"', add
label define occ1990_lbl 256 `"Advertising and related sales jobs"', add
label define occ1990_lbl 258 `"Sales engineers"', add
label define occ1990_lbl 274 `"Salespersons, n.e.c."', add
label define occ1990_lbl 275 `"Retail sales clerks"', add
label define occ1990_lbl 276 `"Cashiers"', add
label define occ1990_lbl 277 `"Door-to-door sales, street sales, and news vendors"', add
label define occ1990_lbl 283 `"Sales demonstrators / promoters / models"', add
label define occ1990_lbl 303 `"Office supervisors"', add
label define occ1990_lbl 308 `"Computer and peripheral equipment operators"', add
label define occ1990_lbl 313 `"Secretaries"', add
label define occ1990_lbl 314 `"Stenographers"', add
label define occ1990_lbl 315 `"Typists"', add
label define occ1990_lbl 316 `"Interviewers, enumerators, and surveyors"', add
label define occ1990_lbl 317 `"Hotel clerks"', add
label define occ1990_lbl 318 `"Transportation ticket and reservation agents"', add
label define occ1990_lbl 319 `"Receptionists"', add
label define occ1990_lbl 323 `"Information clerks, nec"', add
label define occ1990_lbl 326 `"Correspondence and order clerks"', add
label define occ1990_lbl 328 `"Human resources clerks, except payroll and timekeeping"', add
label define occ1990_lbl 329 `"Library assistants"', add
label define occ1990_lbl 335 `"File clerks"', add
label define occ1990_lbl 336 `"Records clerks"', add
label define occ1990_lbl 337 `"Bookkeepers and accounting and auditing clerks"', add
label define occ1990_lbl 338 `"Payroll and timekeeping clerks"', add
label define occ1990_lbl 343 `"Cost and rate clerks (financial records processing)"', add
label define occ1990_lbl 344 `"Billing clerks and related financial records processing"', add
label define occ1990_lbl 345 `"Duplication machine operators / office machine operators"', add
label define occ1990_lbl 346 `"Mail and paper handlers"', add
label define occ1990_lbl 347 `"Office machine operators, n.e.c."', add
label define occ1990_lbl 348 `"Telephone operators"', add
label define occ1990_lbl 349 `"Other telecom operators"', add
label define occ1990_lbl 354 `"Postal clerks, excluding mail carriers"', add
label define occ1990_lbl 355 `"Mail carriers for postal service"', add
label define occ1990_lbl 356 `"Mail clerks, outside of post office"', add
label define occ1990_lbl 357 `"Messengers"', add
label define occ1990_lbl 359 `"Dispatchers"', add
label define occ1990_lbl 361 `"Inspectors, n.e.c."', add
label define occ1990_lbl 364 `"Shipping and receiving clerks"', add
label define occ1990_lbl 365 `"Stock and inventory clerks"', add
label define occ1990_lbl 366 `"Meter readers"', add
label define occ1990_lbl 368 `"Weighers, measurers, and checkers"', add
label define occ1990_lbl 373 `"Material recording, scheduling, production, planning, and expediting clerks"', add
label define occ1990_lbl 375 `"Insurance adjusters, examiners, and investigators"', add
label define occ1990_lbl 376 `"Customer service reps, investigators and adjusters, except insurance"', add
label define occ1990_lbl 377 `"Eligibility clerks for government programs; social welfare"', add
label define occ1990_lbl 378 `"Bill and account collectors"', add
label define occ1990_lbl 379 `"General office clerks"', add
label define occ1990_lbl 383 `"Bank tellers"', add
label define occ1990_lbl 384 `"Proofreaders"', add
label define occ1990_lbl 385 `"Data entry keyers"', add
label define occ1990_lbl 386 `"Statistical clerks"', add
label define occ1990_lbl 387 `"Teacher's aides"', add
label define occ1990_lbl 389 `"Administrative support jobs, n.e.c."', add
label define occ1990_lbl 405 `"Housekeepers, maids, butlers, stewards, and lodging quarters cleaners"', add
label define occ1990_lbl 407 `"Private household cleaners and servants"', add
label define occ1990_lbl 415 `"Supervisors of guards"', add
label define occ1990_lbl 417 `"Fire fighting, prevention, and inspection"', add
label define occ1990_lbl 418 `"Police, detectives, and private investigators"', add
label define occ1990_lbl 423 `"Other law enforcement: sheriffs, bailiffs, correctional institution officers"', add
label define occ1990_lbl 425 `"Crossing guards and bridge tenders"', add
label define occ1990_lbl 426 `"Guards, watchmen, doorkeepers"', add
label define occ1990_lbl 427 `"Protective services, n.e.c."', add
label define occ1990_lbl 434 `"Bartenders"', add
label define occ1990_lbl 435 `"Waiter/waitress"', add
label define occ1990_lbl 436 `"Cooks, variously defined"', add
label define occ1990_lbl 438 `"Food counter and fountain workers"', add
label define occ1990_lbl 439 `"Kitchen workers"', add
label define occ1990_lbl 443 `"Waiter's assistant"', add
label define occ1990_lbl 444 `"Misc food prep workers"', add
label define occ1990_lbl 445 `"Dental assistants"', add
label define occ1990_lbl 446 `"Health aides, except nursing"', add
label define occ1990_lbl 447 `"Nursing aides, orderlies, and attendants"', add
label define occ1990_lbl 448 `"Supervisors of cleaning and building service"', add
label define occ1990_lbl 453 `"Janitors"', add
label define occ1990_lbl 454 `"Elevator operators"', add
label define occ1990_lbl 455 `"Pest control occupations"', add
label define occ1990_lbl 456 `"Supervisors of personal service jobs, n.e.c."', add
label define occ1990_lbl 457 `"Barbers"', add
label define occ1990_lbl 458 `"Hairdressers and cosmetologists"', add
label define occ1990_lbl 459 `"Recreation facility attendants"', add
label define occ1990_lbl 461 `"Guides"', add
label define occ1990_lbl 462 `"Ushers"', add
label define occ1990_lbl 463 `"Public transportation attendants and inspectors"', add
label define occ1990_lbl 464 `"Baggage porters"', add
label define occ1990_lbl 465 `"Welfare service aides"', add
label define occ1990_lbl 468 `"Child care workers"', add
label define occ1990_lbl 469 `"Personal service occupations, nec"', add
label define occ1990_lbl 473 `"Farmers (owners and tenants)"', add
label define occ1990_lbl 474 `"Horticultural specialty farmers"', add
label define occ1990_lbl 475 `"Farm managers, except for horticultural farms"', add
label define occ1990_lbl 476 `"Managers of horticultural specialty farms"', add
label define occ1990_lbl 479 `"Farm workers"', add
label define occ1990_lbl 483 `"Marine life cultivation workers"', add
label define occ1990_lbl 484 `"Nursery farming workers"', add
label define occ1990_lbl 485 `"Supervisors of agricultural occupations"', add
label define occ1990_lbl 486 `"Gardeners and groundskeepers"', add
label define occ1990_lbl 487 `"Animal caretakers except on farms"', add
label define occ1990_lbl 488 `"Graders and sorters of agricultural products"', add
label define occ1990_lbl 489 `"Inspectors of agricultural products"', add
label define occ1990_lbl 496 `"Timber, logging, and forestry workers"', add
label define occ1990_lbl 498 `"Fishers, hunters, and kindred"', add
label define occ1990_lbl 503 `"Supervisors of mechanics and repairers"', add
label define occ1990_lbl 505 `"Automobile mechanics"', add
label define occ1990_lbl 507 `"Bus, truck, and stationary engine mechanics"', add
label define occ1990_lbl 508 `"Aircraft mechanics"', add
label define occ1990_lbl 509 `"Small engine repairers"', add
label define occ1990_lbl 514 `"Auto body repairers"', add
label define occ1990_lbl 516 `"Heavy equipment and farm equipment mechanics"', add
label define occ1990_lbl 518 `"Industrial machinery repairers"', add
label define occ1990_lbl 519 `"Machinery maintenance occupations"', add
label define occ1990_lbl 523 `"Repairers of industrial electrical equipment"', add
label define occ1990_lbl 525 `"Repairers of data processing equipment"', add
label define occ1990_lbl 526 `"Repairers of household appliances and power tools"', add
label define occ1990_lbl 527 `"Telecom and line installers and repairers"', add
label define occ1990_lbl 533 `"Repairers of electrical equipment, n.e.c."', add
label define occ1990_lbl 534 `"Heating, air conditioning, and refigeration mechanics"', add
label define occ1990_lbl 535 `"Precision makers, repairers, and smiths"', add
label define occ1990_lbl 536 `"Locksmiths and safe repairers"', add
label define occ1990_lbl 538 `"Office machine repairers and mechanics"', add
label define occ1990_lbl 539 `"Repairers of mechanical controls and valves"', add
label define occ1990_lbl 543 `"Elevator installers and repairers"', add
label define occ1990_lbl 544 `"Millwrights"', add
label define occ1990_lbl 549 `"Mechanics and repairers, n.e.c."', add
label define occ1990_lbl 558 `"Supervisors of construction work"', add
label define occ1990_lbl 563 `"Masons, tilers, and carpet installers"', add
label define occ1990_lbl 567 `"Carpenters"', add
label define occ1990_lbl 573 `"Drywall installers"', add
label define occ1990_lbl 575 `"Electricians"', add
label define occ1990_lbl 577 `"Electric power installers and repairers"', add
label define occ1990_lbl 579 `"Painters, construction and maintenance"', add
label define occ1990_lbl 583 `"Paperhangers"', add
label define occ1990_lbl 584 `"Plasterers"', add
label define occ1990_lbl 585 `"Plumbers, pipe fitters, and steamfitters"', add
label define occ1990_lbl 588 `"Concrete and cement workers"', add
label define occ1990_lbl 589 `"Glaziers"', add
label define occ1990_lbl 593 `"Insulation workers"', add
label define occ1990_lbl 594 `"Paving, surfacing, and tamping equipment operators"', add
label define occ1990_lbl 595 `"Roofers and slaters"', add
label define occ1990_lbl 596 `"Sheet metal duct installers"', add
label define occ1990_lbl 597 `"Structural metal workers"', add
label define occ1990_lbl 598 `"Drillers of earth"', add
label define occ1990_lbl 599 `"Construction trades, n.e.c."', add
label define occ1990_lbl 614 `"Drillers of oil wells"', add
label define occ1990_lbl 615 `"Explosives workers"', add
label define occ1990_lbl 616 `"Miners"', add
label define occ1990_lbl 617 `"Other mining occupations"', add
label define occ1990_lbl 628 `"Production supervisors or foremen"', add
label define occ1990_lbl 634 `"Tool and die makers and die setters"', add
label define occ1990_lbl 637 `"Machinists"', add
label define occ1990_lbl 643 `"Boilermakers"', add
label define occ1990_lbl 644 `"Precision grinders and filers"', add
label define occ1990_lbl 645 `"Patternmakers and model makers"', add
label define occ1990_lbl 646 `"Lay-out workers"', add
label define occ1990_lbl 649 `"Engravers"', add
label define occ1990_lbl 653 `"Tinsmiths, coppersmiths, and sheet metal workers"', add
label define occ1990_lbl 657 `"Cabinetmakers and bench carpenters"', add
label define occ1990_lbl 658 `"Furniture and wood finishers"', add
label define occ1990_lbl 659 `"Other precision woodworkers"', add
label define occ1990_lbl 666 `"Dressmakers and seamstresses"', add
label define occ1990_lbl 667 `"Tailors"', add
label define occ1990_lbl 668 `"Upholsterers"', add
label define occ1990_lbl 669 `"Shoe repairers"', add
label define occ1990_lbl 674 `"Other precision apparel and fabric workers"', add
label define occ1990_lbl 675 `"Hand molders and shapers, except jewelers"', add
label define occ1990_lbl 677 `"Optical goods workers"', add
label define occ1990_lbl 678 `"Dental laboratory and medical appliance technicians"', add
label define occ1990_lbl 679 `"Bookbinders"', add
label define occ1990_lbl 684 `"Other precision and craft workers"', add
label define occ1990_lbl 686 `"Butchers and meat cutters"', add
label define occ1990_lbl 687 `"Bakers"', add
label define occ1990_lbl 688 `"Batch food makers"', add
label define occ1990_lbl 693 `"Adjusters and calibrators"', add
label define occ1990_lbl 694 `"Water and sewage treatment plant operators"', add
label define occ1990_lbl 695 `"Power plant operators"', add
label define occ1990_lbl 696 `"Plant and system operators, stationary engineers"', add
label define occ1990_lbl 699 `"Other plant and system operators"', add
label define occ1990_lbl 703 `"Lathe, milling, and turning machine operatives"', add
label define occ1990_lbl 706 `"Punching and stamping press operatives"', add
label define occ1990_lbl 707 `"Rollers, roll hands, and finishers of metal"', add
label define occ1990_lbl 708 `"Drilling and boring machine operators"', add
label define occ1990_lbl 709 `"Grinding, abrading, buffing, and polishing workers"', add
label define occ1990_lbl 713 `"Forge and hammer operators"', add
label define occ1990_lbl 717 `"Fabricating machine operators, n.e.c."', add
label define occ1990_lbl 719 `"Molders, and casting machine operators"', add
label define occ1990_lbl 723 `"Metal platers"', add
label define occ1990_lbl 724 `"Heat treating equipment operators"', add
label define occ1990_lbl 726 `"Wood lathe, routing, and planing machine operators"', add
label define occ1990_lbl 727 `"Sawing machine operators and sawyers"', add
label define occ1990_lbl 728 `"Shaping and joining machine operator (woodworking)"', add
label define occ1990_lbl 729 `"Nail and tacking machine operators  (woodworking)"', add
label define occ1990_lbl 733 `"Other woodworking machine operators"', add
label define occ1990_lbl 734 `"Printing machine operators, n.e.c."', add
label define occ1990_lbl 735 `"Photoengravers and lithographers"', add
label define occ1990_lbl 736 `"Typesetters and compositors"', add
label define occ1990_lbl 738 `"Winding and twisting textile/apparel operatives"', add
label define occ1990_lbl 739 `"Knitters, loopers, and toppers textile operatives"', add
label define occ1990_lbl 743 `"Textile cutting machine operators"', add
label define occ1990_lbl 744 `"Textile sewing machine operators"', add
label define occ1990_lbl 745 `"Shoemaking machine operators"', add
label define occ1990_lbl 747 `"Pressing machine operators (clothing)"', add
label define occ1990_lbl 748 `"Laundry workers"', add
label define occ1990_lbl 749 `"Misc textile machine operators"', add
label define occ1990_lbl 753 `"Cementing and gluing maching operators"', add
label define occ1990_lbl 754 `"Packers, fillers, and wrappers"', add
label define occ1990_lbl 755 `"Extruding and forming machine operators"', add
label define occ1990_lbl 756 `"Mixing and blending machine operatives"', add
label define occ1990_lbl 757 `"Separating, filtering, and clarifying machine operators"', add
label define occ1990_lbl 759 `"Painting machine operators"', add
label define occ1990_lbl 763 `"Roasting and baking machine operators (food)"', add
label define occ1990_lbl 764 `"Washing, cleaning, and pickling machine operators"', add
label define occ1990_lbl 765 `"Paper folding machine operators"', add
label define occ1990_lbl 766 `"Furnace, kiln, and oven operators, apart from food"', add
label define occ1990_lbl 768 `"Crushing and grinding machine operators"', add
label define occ1990_lbl 769 `"Slicing and cutting machine operators"', add
label define occ1990_lbl 773 `"Motion picture projectionists"', add
label define occ1990_lbl 774 `"Photographic process workers"', add
label define occ1990_lbl 779 `"Machine operators, n.e.c."', add
label define occ1990_lbl 783 `"Welders and metal cutters"', add
label define occ1990_lbl 784 `"Solderers"', add
label define occ1990_lbl 785 `"Assemblers of electrical equipment"', add
label define occ1990_lbl 789 `"Hand painting, coating, and decorating occupations"', add
label define occ1990_lbl 796 `"Production checkers and inspectors"', add
label define occ1990_lbl 799 `"Graders and sorters in manufacturing"', add
label define occ1990_lbl 803 `"Supervisors of motor vehicle transportation"', add
label define occ1990_lbl 804 `"Truck, delivery, and tractor drivers"', add
label define occ1990_lbl 808 `"Bus drivers"', add
label define occ1990_lbl 809 `"Taxi cab drivers and chauffeurs"', add
label define occ1990_lbl 813 `"Parking lot attendants"', add
label define occ1990_lbl 823 `"Railroad conductors and yardmasters"', add
label define occ1990_lbl 824 `"Locomotive operators (engineers and firemen)"', add
label define occ1990_lbl 825 `"Railroad brake, coupler, and switch operators"', add
label define occ1990_lbl 829 `"Ship crews and marine engineers"', add
label define occ1990_lbl 834 `"Water transport infrastructure tenders and crossing guards"', add
label define occ1990_lbl 844 `"Operating engineers of construction equipment"', add
label define occ1990_lbl 848 `"Crane, derrick, winch, and hoist operators"', add
label define occ1990_lbl 853 `"Excavating and loading machine operators"', add
label define occ1990_lbl 859 `"Misc material moving occupations"', add
label define occ1990_lbl 865 `"Helpers, constructions"', add
label define occ1990_lbl 866 `"Helpers, surveyors"', add
label define occ1990_lbl 869 `"Construction laborers"', add
label define occ1990_lbl 874 `"Production helpers"', add
label define occ1990_lbl 875 `"Garbage and recyclable material collectors"', add
label define occ1990_lbl 876 `"Materials movers: stevedores and longshore workers"', add
label define occ1990_lbl 877 `"Stock handlers"', add
label define occ1990_lbl 878 `"Machine feeders and offbearers"', add
label define occ1990_lbl 883 `"Freight, stock, and materials handlers"', add
label define occ1990_lbl 885 `"Garage and service station related occupations"', add
label define occ1990_lbl 887 `"Vehicle washers and equipment cleaners"', add
label define occ1990_lbl 888 `"Packers and packagers by hand"', add
label define occ1990_lbl 889 `"Laborers outside construction"', add
label define occ1990_lbl 905 `"Military"', add
label define occ1990_lbl 991 `"Unemployed"', add
label define occ1990_lbl 999 `"Unknown"', add
label values occ1990 occ1990_lbl

label define classwkr_lbl 0 `"N/A"'
label define classwkr_lbl 1 `"Self-employed"', add
label define classwkr_lbl 2 `"Works for wages"', add
label values classwkr classwkr_lbl

label define classwkrd_lbl 00 `"N/A"'
label define classwkrd_lbl 10 `"Self-employed"', add
label define classwkrd_lbl 11 `"Employer"', add
label define classwkrd_lbl 12 `"Working on own account"', add
label define classwkrd_lbl 13 `"Self-employed, not incorporated"', add
label define classwkrd_lbl 14 `"Self-employed, incorporated"', add
label define classwkrd_lbl 20 `"Works for wages"', add
label define classwkrd_lbl 21 `"Works on salary (1920)"', add
label define classwkrd_lbl 22 `"Wage/salary, private"', add
label define classwkrd_lbl 23 `"Wage/salary at non-profit"', add
label define classwkrd_lbl 24 `"Wage/salary, government"', add
label define classwkrd_lbl 25 `"Federal govt employee"', add
label define classwkrd_lbl 26 `"Armed forces"', add
label define classwkrd_lbl 27 `"State govt employee"', add
label define classwkrd_lbl 28 `"Local govt employee"', add
label define classwkrd_lbl 29 `"Unpaid family worker"', add
label values classwkrd classwkrd_lbl

label define wkswork2_lbl 0 `"N/A"'
label define wkswork2_lbl 1 `"1-13 weeks"', add
label define wkswork2_lbl 2 `"14-26 weeks"', add
label define wkswork2_lbl 3 `"27-39 weeks"', add
label define wkswork2_lbl 4 `"40-47 weeks"', add
label define wkswork2_lbl 5 `"48-49 weeks"', add
label define wkswork2_lbl 6 `"50-52 weeks"', add
label values wkswork2 wkswork2_lbl

label define uhrswork_lbl 00 `"N/A"'
label define uhrswork_lbl 01 `"1"', add
label define uhrswork_lbl 02 `"2"', add
label define uhrswork_lbl 03 `"3"', add
label define uhrswork_lbl 04 `"4"', add
label define uhrswork_lbl 05 `"5"', add
label define uhrswork_lbl 06 `"6"', add
label define uhrswork_lbl 07 `"7"', add
label define uhrswork_lbl 08 `"8"', add
label define uhrswork_lbl 09 `"9"', add
label define uhrswork_lbl 10 `"10"', add
label define uhrswork_lbl 11 `"11"', add
label define uhrswork_lbl 12 `"12"', add
label define uhrswork_lbl 13 `"13"', add
label define uhrswork_lbl 14 `"14"', add
label define uhrswork_lbl 15 `"15"', add
label define uhrswork_lbl 16 `"16"', add
label define uhrswork_lbl 17 `"17"', add
label define uhrswork_lbl 18 `"18"', add
label define uhrswork_lbl 19 `"19"', add
label define uhrswork_lbl 20 `"20"', add
label define uhrswork_lbl 21 `"21"', add
label define uhrswork_lbl 22 `"22"', add
label define uhrswork_lbl 23 `"23"', add
label define uhrswork_lbl 24 `"24"', add
label define uhrswork_lbl 25 `"25"', add
label define uhrswork_lbl 26 `"26"', add
label define uhrswork_lbl 27 `"27"', add
label define uhrswork_lbl 28 `"28"', add
label define uhrswork_lbl 29 `"29"', add
label define uhrswork_lbl 30 `"30"', add
label define uhrswork_lbl 31 `"31"', add
label define uhrswork_lbl 32 `"32"', add
label define uhrswork_lbl 33 `"33"', add
label define uhrswork_lbl 34 `"34"', add
label define uhrswork_lbl 35 `"35"', add
label define uhrswork_lbl 36 `"36"', add
label define uhrswork_lbl 37 `"37"', add
label define uhrswork_lbl 38 `"38"', add
label define uhrswork_lbl 39 `"39"', add
label define uhrswork_lbl 40 `"40"', add
label define uhrswork_lbl 41 `"41"', add
label define uhrswork_lbl 42 `"42"', add
label define uhrswork_lbl 43 `"43"', add
label define uhrswork_lbl 44 `"44"', add
label define uhrswork_lbl 45 `"45"', add
label define uhrswork_lbl 46 `"46"', add
label define uhrswork_lbl 47 `"47"', add
label define uhrswork_lbl 48 `"48"', add
label define uhrswork_lbl 49 `"49"', add
label define uhrswork_lbl 50 `"50"', add
label define uhrswork_lbl 51 `"51"', add
label define uhrswork_lbl 52 `"52"', add
label define uhrswork_lbl 53 `"53"', add
label define uhrswork_lbl 54 `"54"', add
label define uhrswork_lbl 55 `"55"', add
label define uhrswork_lbl 56 `"56"', add
label define uhrswork_lbl 57 `"57"', add
label define uhrswork_lbl 58 `"58"', add
label define uhrswork_lbl 59 `"59"', add
label define uhrswork_lbl 60 `"60"', add
label define uhrswork_lbl 61 `"61"', add
label define uhrswork_lbl 62 `"62"', add
label define uhrswork_lbl 63 `"63"', add
label define uhrswork_lbl 64 `"64"', add
label define uhrswork_lbl 65 `"65"', add
label define uhrswork_lbl 66 `"66"', add
label define uhrswork_lbl 67 `"67"', add
label define uhrswork_lbl 68 `"68"', add
label define uhrswork_lbl 69 `"69"', add
label define uhrswork_lbl 70 `"70"', add
label define uhrswork_lbl 71 `"71"', add
label define uhrswork_lbl 72 `"72"', add
label define uhrswork_lbl 73 `"73"', add
label define uhrswork_lbl 74 `"74"', add
label define uhrswork_lbl 75 `"75"', add
label define uhrswork_lbl 76 `"76"', add
label define uhrswork_lbl 77 `"77"', add
label define uhrswork_lbl 78 `"78"', add
label define uhrswork_lbl 79 `"79"', add
label define uhrswork_lbl 80 `"80"', add
label define uhrswork_lbl 81 `"81"', add
label define uhrswork_lbl 82 `"82"', add
label define uhrswork_lbl 83 `"83"', add
label define uhrswork_lbl 84 `"84"', add
label define uhrswork_lbl 85 `"85"', add
label define uhrswork_lbl 86 `"86"', add
label define uhrswork_lbl 87 `"87"', add
label define uhrswork_lbl 88 `"88"', add
label define uhrswork_lbl 89 `"89"', add
label define uhrswork_lbl 90 `"90"', add
label define uhrswork_lbl 91 `"91"', add
label define uhrswork_lbl 92 `"92"', add
label define uhrswork_lbl 93 `"93"', add
label define uhrswork_lbl 94 `"94"', add
label define uhrswork_lbl 95 `"95"', add
label define uhrswork_lbl 96 `"96"', add
label define uhrswork_lbl 97 `"97"', add
label define uhrswork_lbl 98 `"98"', add
label define uhrswork_lbl 99 `"99 (Topcode)"', add
label values uhrswork uhrswork_lbl

label define migrate1_lbl 0 `"N/A"'
label define migrate1_lbl 1 `"Same house"', add
label define migrate1_lbl 2 `"Moved within state"', add
label define migrate1_lbl 3 `"Moved between states"', add
label define migrate1_lbl 4 `"Abroad one year ago"', add
label define migrate1_lbl 9 `"Unknown"', add
label values migrate1 migrate1_lbl

label define migrate1d_lbl 00 `"N/A"'
label define migrate1d_lbl 10 `"Same house"', add
label define migrate1d_lbl 20 `"Same state (migration status within state unknown)"', add
label define migrate1d_lbl 21 `"Different house, moved within county"', add
label define migrate1d_lbl 22 `"Different house, moved within state, between counties"', add
label define migrate1d_lbl 23 `"Different house, moved within state, within PUMA"', add
label define migrate1d_lbl 24 `"Different house, moved within state, between PUMAs"', add
label define migrate1d_lbl 25 `"Different house, unknown within state"', add
label define migrate1d_lbl 30 `"Different state (general)"', add
label define migrate1d_lbl 31 `"Moved between contigious states"', add
label define migrate1d_lbl 32 `"Moved between non-contiguous states"', add
label define migrate1d_lbl 40 `"Abroad one year ago"', add
label define migrate1d_lbl 90 `"Unknown"', add
label values migrate1d migrate1d_lbl

label define migplac1_lbl 000 `"N/A"'
label define migplac1_lbl 001 `"Alabama"', add
label define migplac1_lbl 002 `"Alaska"', add
label define migplac1_lbl 004 `"Arizona"', add
label define migplac1_lbl 005 `"Arkansas"', add
label define migplac1_lbl 006 `"California"', add
label define migplac1_lbl 008 `"Colorado"', add
label define migplac1_lbl 009 `"Connecticut"', add
label define migplac1_lbl 010 `"Delaware"', add
label define migplac1_lbl 011 `"District of Columbia"', add
label define migplac1_lbl 012 `"Florida"', add
label define migplac1_lbl 013 `"Georgia"', add
label define migplac1_lbl 015 `"Hawaii"', add
label define migplac1_lbl 016 `"Idaho"', add
label define migplac1_lbl 017 `"Illinois"', add
label define migplac1_lbl 018 `"Indiana"', add
label define migplac1_lbl 019 `"Iowa"', add
label define migplac1_lbl 020 `"Kansas"', add
label define migplac1_lbl 021 `"Kentucky"', add
label define migplac1_lbl 022 `"Louisiana"', add
label define migplac1_lbl 023 `"Maine"', add
label define migplac1_lbl 024 `"Maryland"', add
label define migplac1_lbl 025 `"Massachusetts"', add
label define migplac1_lbl 026 `"Michigan"', add
label define migplac1_lbl 027 `"Minnesota"', add
label define migplac1_lbl 028 `"Mississippi"', add
label define migplac1_lbl 029 `"Missouri"', add
label define migplac1_lbl 030 `"Montana"', add
label define migplac1_lbl 031 `"Nebraska"', add
label define migplac1_lbl 032 `"Nevada"', add
label define migplac1_lbl 033 `"New Hampshire"', add
label define migplac1_lbl 034 `"New Jersey"', add
label define migplac1_lbl 035 `"New Mexico"', add
label define migplac1_lbl 036 `"New York"', add
label define migplac1_lbl 037 `"North Carolina"', add
label define migplac1_lbl 038 `"North Dakota"', add
label define migplac1_lbl 039 `"Ohio"', add
label define migplac1_lbl 040 `"Oklahoma"', add
label define migplac1_lbl 041 `"Oregon"', add
label define migplac1_lbl 042 `"Pennsylvania"', add
label define migplac1_lbl 044 `"Rhode Island"', add
label define migplac1_lbl 045 `"South Carolina"', add
label define migplac1_lbl 046 `"South Dakota"', add
label define migplac1_lbl 047 `"Tennessee"', add
label define migplac1_lbl 048 `"Texas"', add
label define migplac1_lbl 049 `"Utah"', add
label define migplac1_lbl 050 `"Vermont"', add
label define migplac1_lbl 051 `"Virginia"', add
label define migplac1_lbl 053 `"Washington"', add
label define migplac1_lbl 054 `"West Virginia"', add
label define migplac1_lbl 055 `"Wisconsin"', add
label define migplac1_lbl 056 `"Wyoming"', add
label define migplac1_lbl 099 `"United States, ns"', add
label define migplac1_lbl 100 `"Samoa, 1950"', add
label define migplac1_lbl 105 `"Guam"', add
label define migplac1_lbl 110 `"Puerto Rico"', add
label define migplac1_lbl 115 `"Virgin Islands"', add
label define migplac1_lbl 120 `"Other US Possessions"', add
label define migplac1_lbl 150 `"Canada"', add
label define migplac1_lbl 151 `"English Canada"', add
label define migplac1_lbl 152 `"French Canada"', add
label define migplac1_lbl 160 `"Atlantic Islands"', add
label define migplac1_lbl 200 `"Mexico"', add
label define migplac1_lbl 211 `"Belize/British Honduras"', add
label define migplac1_lbl 212 `"Costa Rica"', add
label define migplac1_lbl 213 `"El Salvador"', add
label define migplac1_lbl 214 `"Guatemala"', add
label define migplac1_lbl 215 `"Honduras"', add
label define migplac1_lbl 216 `"Nicaragua"', add
label define migplac1_lbl 217 `"Panama"', add
label define migplac1_lbl 218 `"Canal Zone"', add
label define migplac1_lbl 219 `"Central America, nec"', add
label define migplac1_lbl 250 `"Cuba"', add
label define migplac1_lbl 261 `"Dominican Republic"', add
label define migplac1_lbl 262 `"Haita"', add
label define migplac1_lbl 263 `"Jamaica"', add
label define migplac1_lbl 264 `"British West Indies"', add
label define migplac1_lbl 267 `"Other West Indies"', add
label define migplac1_lbl 290 `"Other Caribbean and North America"', add
label define migplac1_lbl 305 `"Argentina"', add
label define migplac1_lbl 310 `"Bolivia"', add
label define migplac1_lbl 315 `"Brazil"', add
label define migplac1_lbl 320 `"Chile"', add
label define migplac1_lbl 325 `"Colombia"', add
label define migplac1_lbl 330 `"Ecuador"', add
label define migplac1_lbl 345 `"Paraguay"', add
label define migplac1_lbl 350 `"Peru"', add
label define migplac1_lbl 360 `"Uruguay"', add
label define migplac1_lbl 365 `"Venezuela"', add
label define migplac1_lbl 390 `"South America, nec"', add
label define migplac1_lbl 400 `"Denmark"', add
label define migplac1_lbl 401 `"Finland"', add
label define migplac1_lbl 402 `"Iceland"', add
label define migplac1_lbl 404 `"Norway"', add
label define migplac1_lbl 405 `"Sweden"', add
label define migplac1_lbl 410 `"England"', add
label define migplac1_lbl 411 `"Scotland"', add
label define migplac1_lbl 412 `"Wales"', add
label define migplac1_lbl 413 `"United Kingdom (excluding England: 2005ACS)"', add
label define migplac1_lbl 414 `"Ireland"', add
label define migplac1_lbl 415 `"Northern Ireland"', add
label define migplac1_lbl 419 `"Other Northern Europe"', add
label define migplac1_lbl 420 `"Belgium"', add
label define migplac1_lbl 421 `"France"', add
label define migplac1_lbl 422 `"Luxembourg"', add
label define migplac1_lbl 425 `"Netherlands"', add
label define migplac1_lbl 426 `"Switzerland"', add
label define migplac1_lbl 429 `"Other Western Europe"', add
label define migplac1_lbl 430 `"Albania"', add
label define migplac1_lbl 433 `"Greece"', add
label define migplac1_lbl 434 `"Dodecanese Islands"', add
label define migplac1_lbl 435 `"Italy"', add
label define migplac1_lbl 436 `"Portugal"', add
label define migplac1_lbl 437 `"Azores"', add
label define migplac1_lbl 438 `"Spain"', add
label define migplac1_lbl 450 `"Austria"', add
label define migplac1_lbl 451 `"Bulgaria"', add
label define migplac1_lbl 452 `"Czechoslovakia"', add
label define migplac1_lbl 453 `"Germany"', add
label define migplac1_lbl 454 `"Hungary"', add
label define migplac1_lbl 455 `"Poland"', add
label define migplac1_lbl 456 `"Romania"', add
label define migplac1_lbl 457 `"Yugoslavia"', add
label define migplac1_lbl 458 `"Bosnia and Herzegovinia"', add
label define migplac1_lbl 459 `"Other Eastern Europe"', add
label define migplac1_lbl 460 `"Estonia"', add
label define migplac1_lbl 461 `"Latvia"', add
label define migplac1_lbl 462 `"Lithuania"', add
label define migplac1_lbl 463 `"Other Northern or Eastern Europe"', add
label define migplac1_lbl 465 `"USSR"', add
label define migplac1_lbl 498 `"Ukraine"', add
label define migplac1_lbl 499 `"Europe, ns"', add
label define migplac1_lbl 500 `"China"', add
label define migplac1_lbl 501 `"Japan"', add
label define migplac1_lbl 502 `"Korea"', add
label define migplac1_lbl 503 `"Taiwan"', add
label define migplac1_lbl 515 `"Philippines"', add
label define migplac1_lbl 517 `"Thailand"', add
label define migplac1_lbl 518 `"Vietnam"', add
label define migplac1_lbl 519 `"Other South East Asia"', add
label define migplac1_lbl 520 `"Nepal"', add
label define migplac1_lbl 521 `"India"', add
label define migplac1_lbl 522 `"Iran"', add
label define migplac1_lbl 523 `"Iraq"', add
label define migplac1_lbl 525 `"Pakistan"', add
label define migplac1_lbl 534 `"Israel/Palestine"', add
label define migplac1_lbl 535 `"Jordan"', add
label define migplac1_lbl 537 `"Lebanon"', add
label define migplac1_lbl 539 `"United Arab Emirates"', add
label define migplac1_lbl 540 `"Saudi Arabia"', add
label define migplac1_lbl 541 `"Syria"', add
label define migplac1_lbl 542 `"Turkey"', add
label define migplac1_lbl 543 `"Afghanistan"', add
label define migplac1_lbl 551 `"Other Western Asia"', add
label define migplac1_lbl 599 `"Asia, nec"', add
label define migplac1_lbl 600 `"Africa"', add
label define migplac1_lbl 610 `"Northern Africa"', add
label define migplac1_lbl 611 `"Egypt"', add
label define migplac1_lbl 619 `"Nigeria"', add
label define migplac1_lbl 620 `"Western Africa"', add
label define migplac1_lbl 621 `"Eastern Africa"', add
label define migplac1_lbl 622 `"Ethiopia"', add
label define migplac1_lbl 623 `"Kenya"', add
label define migplac1_lbl 694 `"South Africa (Union of)"', add
label define migplac1_lbl 699 `"Africa, nec"', add
label define migplac1_lbl 701 `"Australia"', add
label define migplac1_lbl 702 `"New Zealand"', add
label define migplac1_lbl 710 `"Pacific Islands (Australia and New Zealand Subregions, not specified, Oceania and at Sea: ACS)"', add
label define migplac1_lbl 900 `"Abroad (unknown) or at sea"', add
label define migplac1_lbl 997 `"Unknown value"', add
label define migplac1_lbl 999 `"Missing"', add
label values migplac1 migplac1_lbl

label define qage_lbl 0 `"Entered as written"'
label define qage_lbl 1 `"Failed edit"', add
label define qage_lbl 2 `"Illegible"', add
label define qage_lbl 3 `"Missing"', add
label define qage_lbl 4 `"Allocated"', add
label define qage_lbl 5 `"Illegible"', add
label define qage_lbl 6 `"Missing"', add
label define qage_lbl 7 `"Original entry illegible"', add
label define qage_lbl 8 `"Original entry missing or failed edit"', add
label values qage qage_lbl

label define qfertyr_lbl 0 `"Not allocated"'
label define qfertyr_lbl 4 `"Allocated"', add
label values qfertyr qfertyr_lbl

label define qmarrno_lbl 0 `"Original entry or Inapplicable (not in universe)"'
label define qmarrno_lbl 1 `"Failed edit"', add
label define qmarrno_lbl 2 `"Illegible"', add
label define qmarrno_lbl 3 `"Missing"', add
label define qmarrno_lbl 4 `"Allocated"', add
label define qmarrno_lbl 5 `"Illegible"', add
label define qmarrno_lbl 6 `"Missing"', add
label define qmarrno_lbl 7 `"Original entry illegible"', add
label define qmarrno_lbl 8 `"Original entry missing or failed edit"', add
label values qmarrno qmarrno_lbl

label define qmarst_lbl 0 `"Entered as written"'
label define qmarst_lbl 1 `"Failed edit"', add
label define qmarst_lbl 2 `"Illegible"', add
label define qmarst_lbl 3 `"Missing"', add
label define qmarst_lbl 4 `"Allocated"', add
label define qmarst_lbl 5 `"Illegible"', add
label define qmarst_lbl 6 `"Missing"', add
label define qmarst_lbl 7 `"Original entry illegible"', add
label define qmarst_lbl 8 `"Original entry missing or failed edit"', add
label values qmarst qmarst_lbl

label define qsex_lbl 0 `"Entered as written"'
label define qsex_lbl 1 `"Failed edit"', add
label define qsex_lbl 2 `"Illegible"', add
label define qsex_lbl 3 `"Missing"', add
label define qsex_lbl 4 `"Allocated"', add
label define qsex_lbl 5 `"Illegible"', add
label define qsex_lbl 6 `"Missing"', add
label define qsex_lbl 7 `"Original entry illegible"', add
label define qsex_lbl 8 `"Original entry missing or failed edit"', add
label values qsex qsex_lbl

label define qyrmarr_lbl 0 `"Not allocated"'
label define qyrmarr_lbl 4 `"Allocated"', add
label values qyrmarr qyrmarr_lbl

label define qbpl_lbl 0 `"Entered as written"'
label define qbpl_lbl 1 `"Specific U.S. state or foreign country of birth pre-edited or not reported (1980 Puerto Rico)"', add
label define qbpl_lbl 2 `"Failed edit/illegible"', add
label define qbpl_lbl 3 `"Consistency edit"', add
label define qbpl_lbl 4 `"Allocated"', add
label define qbpl_lbl 5 `"Both general and specific response allocated (1980 Puerto Rico)"', add
label define qbpl_lbl 6 `"Failed edit/missing"', add
label define qbpl_lbl 7 `"Illegible"', add
label define qbpl_lbl 8 `"Illegible/missing or failed edit"', add
label values qbpl qbpl_lbl

label define qcitizen_lbl 0 `"Original entry or Inapplicable (not in universe)"'
label define qcitizen_lbl 1 `"Failed edit"', add
label define qcitizen_lbl 2 `"Illegible"', add
label define qcitizen_lbl 3 `"Missing"', add
label define qcitizen_lbl 4 `"Allocated"', add
label define qcitizen_lbl 5 `"Illegible"', add
label define qcitizen_lbl 6 `"Missing"', add
label define qcitizen_lbl 7 `"Original entry illegible"', add
label define qcitizen_lbl 8 `"Original entry missing or failed edit"', add
label values qcitizen qcitizen_lbl

label define qhispan_lbl 0 `"Not allocated"'
label define qhispan_lbl 1 `"Allocated from information for this person or from relative, this household"', add
label define qhispan_lbl 2 `"Allocated from nonrelative, this household"', add
label define qhispan_lbl 4 `"Allocated"', add
label values qhispan qhispan_lbl

label define qrace_lbl 0 `"Entered as written"'
label define qrace_lbl 1 `"Failed edit"', add
label define qrace_lbl 2 `"Illegible"', add
label define qrace_lbl 3 `"Missing"', add
label define qrace_lbl 4 `"Allocated"', add
label define qrace_lbl 5 `"Allocated, hot deck"', add
label define qrace_lbl 6 `"Missing"', add
label define qrace_lbl 7 `"Original entry illegible"', add
label define qrace_lbl 8 `"Original entry missing or failed edit"', add
label values qrace qrace_lbl

label define qeduc_lbl 0 `"Original entry or Inapplicable (not in universe)"'
label define qeduc_lbl 1 `"Failed edit"', add
label define qeduc_lbl 2 `"Failed edit/illegible"', add
label define qeduc_lbl 3 `"Failed edit/missing"', add
label define qeduc_lbl 4 `"Consistency edit"', add
label define qeduc_lbl 5 `"Consistency edit/allocated, hot deck"', add
label define qeduc_lbl 6 `"Failed edit/missing"', add
label define qeduc_lbl 7 `"Illegible"', add
label define qeduc_lbl 8 `"Illegible/missing or failed edit"', add
label values qeduc qeduc_lbl

label define qdegfield_lbl 0 `"Not allocated"'
label define qdegfield_lbl 4 `"Allocated"', add
label values qdegfield qdegfield_lbl

label define qclasswk_lbl 0 `"Original entry or Inapplicable (not in universe)"'
label define qclasswk_lbl 1 `"Failed edit"', add
label define qclasswk_lbl 2 `"Illegible"', add
label define qclasswk_lbl 3 `"Missing"', add
label define qclasswk_lbl 4 `"Allocated"', add
label define qclasswk_lbl 5 `"Illegible"', add
label define qclasswk_lbl 6 `"Missing"', add
label define qclasswk_lbl 7 `"Original entry illegible"', add
label define qclasswk_lbl 8 `"Original entry missing or failed edit"', add
label values qclasswk qclasswk_lbl

label define qempstat_lbl 0 `"Original entry or Inapplicable (not in universe)"'
label define qempstat_lbl 1 `"Failed edit"', add
label define qempstat_lbl 2 `"Illegible"', add
label define qempstat_lbl 3 `"Missing"', add
label define qempstat_lbl 4 `"Allocated"', add
label define qempstat_lbl 5 `"Illegible"', add
label define qempstat_lbl 6 `"Missing"', add
label define qempstat_lbl 7 `"Original entry illegible"', add
label define qempstat_lbl 8 `"Original entry missing or failed edit"', add
label values qempstat qempstat_lbl

label define qocc_lbl 0 `"Entered as written"'
label define qocc_lbl 1 `"Failed edit"', add
label define qocc_lbl 2 `"Illegible"', add
label define qocc_lbl 3 `"Missing"', add
label define qocc_lbl 4 `"Allocated"', add
label define qocc_lbl 5 `"Illegible"', add
label define qocc_lbl 6 `"Missing"', add
label define qocc_lbl 7 `"Original entry illegible"', add
label define qocc_lbl 8 `"Original entry missing or failed edit"', add
label values qocc qocc_lbl

label define quhrswor_lbl 0 `"Not allocated"'
label define quhrswor_lbl 3 `"Allocated, direct"', add
label define quhrswor_lbl 4 `"Allocated"', add
label define quhrswor_lbl 5 `"Allocated, indirect"', add
label define quhrswor_lbl 9 `"Allocated, direct/indirect"', add
label values quhrswor quhrswor_lbl

label define qwkswork_lbl 0 `"Original entry or Inapplicable (not in universe)"'
label define qwkswork_lbl 1 `"Failed edit"', add
label define qwkswork_lbl 2 `"Illegible"', add
label define qwkswork_lbl 3 `"Missing"', add
label define qwkswork_lbl 4 `"Allocated, pre-edit"', add
label define qwkswork_lbl 5 `"Allocated, hot deck"', add
label define qwkswork_lbl 6 `"Missing"', add
label define qwkswork_lbl 7 `"Original entry illegible"', add
label define qwkswork_lbl 8 `"Original entry missing or failed edit"', add
label values qwkswork qwkswork_lbl

label define qincwage_lbl 0 `"Original entry or Inapplicable (not in universe)"'
label define qincwage_lbl 1 `"Failed edit"', add
label define qincwage_lbl 2 `"Illegible"', add
label define qincwage_lbl 3 `"Missing"', add
label define qincwage_lbl 4 `"Allocated"', add
label define qincwage_lbl 5 `"Illegible"', add
label define qincwage_lbl 6 `"Missing"', add
label define qincwage_lbl 7 `"Original entry illegible"', add
label define qincwage_lbl 8 `"Original entry missing or failed edit"', add
label values qincwage qincwage_lbl

label define qmigplc1_lbl 0 `"Not allocated"'
label define qmigplc1_lbl 1 `"Failed edit"', add
label define qmigplc1_lbl 2 `"Failed edit/illegible"', add
label define qmigplc1_lbl 3 `"Failed edit/missing"', add
label define qmigplc1_lbl 4 `"Failed edit"', add
label define qmigplc1_lbl 5 `"Illegible"', add
label define qmigplc1_lbl 6 `"Failed edit/missing"', add
label define qmigplc1_lbl 7 `"Illegible"', add
label define qmigplc1_lbl 8 `"Illegible/missing or failed edit"', add
label values qmigplc1 qmigplc1_lbl

label define qmigrat1_lbl 0 `"Not allocated"'
label define qmigrat1_lbl 1 `"Failed edit"', add
label define qmigrat1_lbl 2 `"Illegible"', add
label define qmigrat1_lbl 3 `"Missing"', add
label define qmigrat1_lbl 4 `"Allocated"', add
label define qmigrat1_lbl 5 `"Illegible"', add
label define qmigrat1_lbl 6 `"Missing"', add
label define qmigrat1_lbl 7 `"Original entry illegible"', add
label define qmigrat1_lbl 8 `"Original entry missing or failed edit"', add
label values qmigrat1 qmigrat1_lbl


/****If you do not already have egenmore installed, you will need to uncomment the command below and install egenmore. We will use it later in the program.**/

/*ssc install egenmore */

/****We begin by using inverse probability weighting (IPW) to correct for non-response. In doing so, we preserve the age, sex race, and state of birth joint distribution.*/
gen imputed_flag = 0
foreach var of varlist qage qsex qbpl qeduc qrace qdegfield	 {
replace imputed_flag = 1 if `var' == 4 
}
egen trq = group(age sex bpl educ race)
egen num = sum(imputed_flag*perwt), by(trq)
egen den = sum(perwt), by(trq)
gen phat = num/den
drop if imputed_flag == 1
gen wt = perwt/(1-phat)


/*Pooling the data from the American Community Survey for 2014-2017. This has the effect of increasing our sample and smoothing annual fluctuations.*/

keep if year >= 2014 & year <= 2017 

/***Sample restrictions:
Our base sample includes roughly 1.7 million observations of individuals aged 23 to 67 with a bachelor's degree who reported their undergraduate major. The sample is restricted to include those who are not living in institutional group quarters, were born in one of the 50 U.S. states, have attained at least four years of college completion, and are age 23 to 67. We construct 5-year birth cohorts centered around the reported birth cohort. For example, the 1965 birth cohort includes those born between 1963 and 1967 (inclusive).*/

/*Drop institutional (group quarters) population */

keep if gqtype == 0

/*Drop if U.S. state of residence is missing */

keep if statefip >= 1 & statefip <= 56 

/*drop if not born in USA*/

drop if bpl > 56

keep if age >= 23 & age <=67

/*identify people with Bachelors+ attainment*/

gen bachelors = 0 
replace bachelors = 1 if educd >= 101 & educd <999

/*Keep college-educated */

keep if bachelors == 1

/*create masters and doctorate indicator variables */

gen masters = 0 
replace masters = 1 if educd == 114 | educd == 115

gen doctorate = 0 
replace doctorate = 1 if educd == 116

/*Assign individuals to a 5-year birth cohort.*/

gen a25 = 0 
replace a25 = 1 if age >= 23 & age <= 27

gen a30 = 0 
replace a30 = 1 if age >= 28 & age <= 32

gen a35 = 0 
replace a35 = 1 if age >= 33 & age <= 37

gen a40 = 0 
replace a40 = 1 if age >= 38 & age <= 42

gen a45 = 0 
replace a45 = 1 if age >= 43 & age <= 47

gen a50 = 0 
replace a50 = 1 if age >= 48 & age <= 52

gen a55 = 0 
replace a55 = 1 if age >= 53 & age <= 57

gen a60 = 0 
replace a60 = 1 if age >= 58 & age <= 62

gen a65 = 0 
replace a65 = 1 if age >= 63 & age <= 67

gen a45_55 = 0
replace a45_55 = 1 if age>=43 & age <=57


/*************make some family variables to use as controls in our later gender wage & employment gap regression analysis**************/


/*Let's create an alternative geography (super_state). The 12th largest states get assigned their state. The rest get assigned
to their census division.

****************************************************************************************************************************************/
# delimit cr

gen super_state = 0
replace super_state = 32 if statefip == 1
replace super_state = 42 if statefip == 2
replace super_state = 41 if statefip == 4
replace super_state = 33 if statefip == 5
replace super_state =  1 if statefip == 6
replace super_state = 41 if statefip == 8
replace super_state = 81 if statefip == 9
replace super_state = 31 if statefip == 10
replace super_state = 31 if statefip == 11
replace super_state =  3 if statefip == 12
replace super_state =  8 if statefip == 13
replace super_state = 42 if statefip == 15
replace super_state = 41 if statefip == 16
replace super_state =  6 if statefip == 17
replace super_state = 21 if statefip == 18
replace super_state = 22 if statefip == 19
replace super_state = 22 if statefip == 20
replace super_state = 32 if statefip == 21
replace super_state = 33 if statefip == 22
replace super_state = 81 if statefip == 23
replace super_state = 31 if statefip == 24
replace super_state = 81 if statefip == 25
replace super_state = 10 if statefip == 26
replace super_state = 22 if statefip == 27
replace super_state = 32 if statefip == 28
replace super_state = 22 if statefip == 29
replace super_state = 41 if statefip == 30
replace super_state = 22 if statefip == 31
replace super_state = 41 if statefip == 32
replace super_state = 81 if statefip == 33
replace super_state = 11 if statefip == 34
replace super_state = 41 if statefip == 35
replace super_state =  4 if statefip == 36
replace super_state =  9 if statefip == 37
replace super_state = 22 if statefip == 38
replace super_state =  7 if statefip == 39
replace super_state = 33 if statefip == 40
replace super_state = 42 if statefip == 41
replace super_state =  5 if statefip == 42
replace super_state = 81 if statefip == 44
replace super_state = 31 if statefip == 45
replace super_state = 22 if statefip == 46
replace super_state = 32 if statefip == 47
replace super_state =  2 if statefip == 48
replace super_state = 41 if statefip == 49
replace super_state = 81 if statefip == 50
replace super_state = 12 if statefip == 51
replace super_state = 42 if statefip == 53
replace super_state = 31 if statefip == 54
replace super_state = 31 if statefip == 55
replace super_state = 21 if statefip == 56
assert super_state > 0
lab def ss 1 "CA" 2 "TX" 3 "FL" 4 "NY" 5 "PA" 6 "IL" 7 "OH" 8 "GA" 9 "NC" 10 "MI" 11 "NJ" 12 "VA" 21 "East North Central" 22 "West North Central" /*
*/ 31 "South Atlantic" 32 "East South Central" 33 "West South Central" 41 "Mountain" 42 "Pacific" 81 "New England"
lab val super_state ss

/*let's identify people who are never married */

gen never_married = 0
replace never_married = 1 if marst == 6

/*let's identify people with kids at home. We only do this for age groups a27 and a35*/

gen kids_at_home = nchild if a25 == 1 | a30 == 1 | a35 == 1
replace kids_at_home = . if age >37
label var kids_at_home      `"Number of kids at home if in a27 or a35 age group"'


gen young_kids = 0
replace young_kids =1  if nchlt5 > 0
replace young_kids = . if age > 37
label var young_kids      `"Do you have young kids at home? if in a25, a30 or a35 age group"'
label define young_kids_lbl 0 `"no young kids"'
label define young_kids_lbl 1 `"have young kids at home"', add
label values young_kids young_kids_lbl

/*generate indicator variable to identify non-self-employed */

gen non_selfemp = 1
replace non_selfemp = 0 if classwkr == 1

/*generate indicator variable to identify employed */

gen employed = 0 
replace employed = 1 if empstat == 1

 /*generate male & female indicator variables */.

gen male = 0 
replace male = 1 if sex == 1


gen female = 0 
replace female = 1 if sex == 2
label var female      `"female indicator variable"'
label define female_lbl 1 `"female"'
label define female_lbl 0 `"male"', add
label values female female_lbl

/*generate indicator variables for race*/

gen white = 0
replace white = 1 if race == 1

gen black_white = .
replace black_white = 1 if race == 1
replace black_white = 2 if race == 2
label var black_white     `"black white variable"'
label define black_white_lbl 1 `"white"'
label define black_white_lbl 2 `"black"', add
label values black_white black_white_lbl


/* Identify strongly attached: if work at least 30 hours (for ACS years, it is an intervalled variable, so it is really 27 week min), 30 hrs */
gen strong_attach = 0
replace strong_attach = 1 if  uhrswork >= 30 & wkswork2 >= 3

/*generate non-categorical weeks worked variable*/

gen weeks = .
replace weeks = 7 if wkswork2 == 1
replace weeks = 20 if wkswork2 == 2
replace weeks = 33 if wkswork2 == 3
replace weeks = 43.5 if wkswork2 == 4
replace weeks = 48.5 if wkswork2 == 5
replace weeks = 51 if wkswork2 == 6

gen hours = .
replace hours = uhrswork * weeks if uhrswork > 0

/* create a categorical variables for hours worked per week*/

gen hours_cat = .
replace hours_cat = 1 if employed == 1 & (uhrswork >0 & uhrswork <=29)
replace hours_cat = 2 if employed == 1 & (uhrswork >=30 & uhrswork <=39)
replace hours_cat = 3 if employed == 1 & uhrswork == 40
replace hours_cat = 4 if employed == 1 & (uhrswork >=41 & uhrswork <=45)
replace hours_cat = 5 if employed == 1 & (uhrswork >= 46 & uhrswork <=50)
replace hours_cat = 6 if employed == 1 & (uhrswork >= 51 & uhrswork <=99)

label var hours_cat      `"Categorical hours worked"'
label define hours_cat_lbl 1 `"0 to 29 hours"'
label define hours_cat_lbl 2 `"30 to 39 hours"', add
label define hours_cat_lbl 3 `"40 hours"', add
label define hours_cat_lbl 4 `"41 to 45 hours"', add
label define hours_cat_lbl 5 `"46 to 50 hours"', add
label define hours_cat_lbl 6 `"over 50 hours"', add
label values hours_cat hours_cat_lbl

/*Identify missing labor earnings data (missing values for incwage) */

replace incwage = . if incwage >= 999998
gen non_miss_inc = 1
replace non_miss_inc = 0 if incwage == . | incwage == 0 

/*Convert nominal to real values. Let's put everything in 2018 $*/

replace incwage = incwage * 1.08 if year == 2014
replace incwage = incwage * 1.06 if year == 2015
replace incwage = incwage * 1.06 if year == 2016
replace incwage = incwage * 1.04 if year == 2017

/*generate log earnings variable by dividing our annual labor earnings variable by computed annual hours worked */
gen wage = incwage / hours
replace incwage = 1 if incwage == 0
replace wage = 1 if wage == 0
gen ln_earnings = ln(incwage) 
gen ln_wage = ln(wage)
drop wage

/* create a indicator variable to identify sample in which we want to calculate "potential wages": men age 43-57, not self-employed, strong attachment to the labor market, non-missing income */

gen male_sample = a45_55 * male * non_selfemp * employed * non_miss_inc * strong_attach * white
gen earnings_sample = non_selfemp * employed * non_miss_inc 
gen main_sample = non_selfemp * employed * non_miss_inc * strong_attach 
gen earnings = .
replace earnings = ln_earnings if male_sample == 1
gen wage = .
replace wage = ln_wage if male_sample == 1
gen ln_hours = .
replace ln_hours = ln(hours) if male_sample == 1
gen all_earnings = .
replace all_earnings = ln_earnings if earnings_sample == 1
gen all_wage = .
replace all_wage = ln_wage if earnings_sample == 1
gen actual_earnings = .
replace actual_earnings = ln_earnings if main_sample == 1
gen actual_wage = .
replace actual_wage = ln_wage if main_sample == 1

drop incwage ln_wage

 /*we drop people with missing field for 1st major */
 
 drop if degfieldd == 0000 
 
/*clean and harmonize occupation codes*/
tab occ 

# delimit ;

sort occ year ;

gen occ_long = . ;
replace occ_long = occ ;
replace occ = occ_long / 10 ;

# delimit ;

replace occ =	13	if occ_long ==	135	;
replace occ =	13	if occ_long ==	136	;
replace occ =	13	if occ_long ==	137	;
replace occ =	20	if occ_long ==	205	;
replace occ =	73	if occ_long ==	425	;
replace occ =	56	if occ_long ==	565	;
replace occ =	72	if occ_long ==	725	;
replace occ =	496	if occ_long ==	726	;
replace occ =	73	if occ_long ==	735	;
replace occ =	100	if occ_long ==	1005	;
replace occ =	100	if occ_long ==	1006	;
replace occ =	111	if occ_long ==	1007	;
replace occ =	110	if occ_long ==	1105	;
replace occ =	100	if occ_long ==	1106	;
replace occ =	100	if occ_long ==	1107	;
replace occ =	196	if occ_long ==	1965	;
replace occ =	202	if occ_long ==	2015	;
replace occ =	202	if occ_long ==	2016	;
replace occ =	202	if occ_long ==	2025	;
replace occ =	210	if occ_long ==	2105	;
replace occ =	215	if occ_long ==	2145	;
replace occ =	282	if occ_long ==	2825	;
replace occ =	324	if occ_long ==	3245	;
replace occ =	313	if occ_long ==	3255	;
replace occ =	313	if occ_long ==	3256	;
replace occ =	313	if occ_long ==	3258	;
replace occ =	353	if occ_long ==	3535	;
replace occ =	365	if occ_long ==	3645	;
replace occ =	365	if occ_long ==	3646	;
replace occ =	365	if occ_long ==	3647	;
replace occ =	365	if occ_long ==	3648	;
replace occ =	365	if occ_long ==	3649	;
replace occ =	365	if occ_long ==	3655	;
replace occ =	392	if occ_long ==	3945	;
replace occ =	395	if occ_long ==	3955	;
replace occ =	32	if occ_long ==	4465	;
replace occ =	496	if occ_long ==	4965	;
replace occ =	593	if occ_long ==	5165	;
replace occ =	600	if occ_long ==	6005	;
replace occ =	635	if occ_long ==	6355	;
replace occ =	651	if occ_long ==	6515	;
replace occ =	676	if occ_long ==	6765	;
replace occ =	731	if occ_long ==	7315	;
replace occ =	896	if occ_long ==	7855	;
replace occ =	824	if occ_long ==	8255	;
replace occ =	824	if occ_long ==	8256	;
replace occ =	896	if occ_long ==	8965	;
replace occ =	455	if occ_long ==	9415	;
replace occ =   455 if occ_long == 9050 ;
replace occ = 62 if occ_long == 630 ;
replace occ = 62 if occ_long == 640 ;
replace occ = 62 if occ_long == 650 ;
replace occ = 73 if occ_long == 740 ;
replace occ = 111 if occ_long == 1030 ;
replace occ = 104 if occ_long == 1050 ;
replace occ = 215 if occ_long == 2160 ;
replace occ = 353 if occ_long == 3420 ;
replace occ = 593 if occ_long == 5940 ;
replace occ = 762 if occ_long == 7630 ;

/*harmonizing occupation codes using David Dorn's (Dorn, 2009)harmonized occupation codes. here, we merge in Dorn's data. crosswalk file is from: https://www.ddorn.net/data.htm*/

joinby occ using "occ2005_occ1990dd" ;

/*here, we combine some occupations*/

/* recoding actuaries as mathematicians*/
replace occ1990dd = 68 if occ1990dd == 66;

/*recoding dentists, vets, podiatrists as physians */
replace occ1990dd = 84 if occ1990dd == 85 | occ1990dd == 86 | occ1990dd == 87 | occ1990dd == 88 ;

/*recoding occupational therapists and speech therapists as misc therapists */
replace occ1990dd = 105 if occ1990dd == 99 | occ1990dd == 104 ;

/*recoding economists as misc social scientists */
replace occ1990dd = 169 if occ1990dd == 166 ;

/*recoding urban and regional planners as civil engineers */

replace occ1990dd = 53 if occ1990dd == 173 ;

/*recoding dancers as performing artists */

replace occ1990dd = 194 if occ1990dd == 193 ;

/*recoding farm owners as farm managers */

replace occ1990dd = 475 if occ1990dd == 473 ;

/*recoding bookbinders, boilermakers, engravers as other precision craftworkers */

replace occ1990dd = 684 if occ1990dd == 679 | occ1990dd == 643 | occ1990dd == 649 | occ1990dd == 658 | occ1990dd == 668 | occ1990dd == 669 ;

/*recoding print machine operators as misc machine operators */

replace occ1990dd = 779 if occ1990dd == 734 ;

/*recode paperhangers, drywall installers, plasterers, concrete and cement workers, glaziers as misc construction */
replace occ1990dd = 599 if occ1990dd == 583 | occ1990dd == 573 | occ1990dd == 584 | occ1990dd == 588 | occ1990dd == 589 | occ1990dd == 594 | occ1990dd == 595 | occ1990dd == 597 | occ1990dd == 598;

/*recode precision grinders and fitters and patternmakers as other metal and plastic workers */
replace occ1990dd = 653 if occ1990dd == 644 | occ1990dd == 645;

/*recode lathe machine operators, drilling/boring machine operators, grinding and polishing operators as other woodworking machine operators */

replace occ1990dd = 733 if occ1990dd == 703 | occ1990dd == 708 | occ1990dd == 709 | occ1990dd == 723 | occ1990dd == 724 | occ1990dd == 727 | occ1990dd == 729;

/*create a textile manufacturing occupation */

replace occ1990dd = 749 if occ1990dd == 744 | occ1990dd == 745 | occ1990dd == 738 | occ1990dd == 739 | occ1990dd == 743 | occ1990dd == 747 | occ1990dd == 749  ;

/*recoding washing/pickling machine operators as misc machine operators */

replace occ1990dd = 779 if occ1990dd == 764 | occ1990dd == 763 | occ1990dd == 756 | occ1990dd == 755 | occ1990dd == 754 | occ1990dd == 753 | occ1990dd == 765 | occ1990dd == 766 | occ1990dd == 769 | occ1990dd == 774;

/*create a misc transportation occ that includes railroad conductors, locomotive operators, railroad brake operators and misc trans */
replace occ1990dd = 834 if occ1990dd == 823 | occ1990dd == 824 | occ1990dd == 825;

/*recode other telecom  operators as telephone operators*/

replace occ1990dd = 348 if occ1990dd == 349 ;

/*recode meter readers as parking attendants */

replace occ1990dd = 813 if occ1990dd == 366 ;

/*recode barbers and hairstylists */

replace occ1990dd = 458 if occ1990dd == 457 ;

/*recode motion picture projectionists as recreation facility attendants */

replace occ1990dd = 459 if occ1990dd == 467 ;

/*recode agriculture graders as inspectors of agricultural products */

replace occ1990dd = 489 if occ1990dd == 488 ;

/*recode small engine repairers, auto body repairers, machinery maintenance, elevator repairers, milwrights occupations as repairers nec  */

replace occ1990dd = 549 if occ1990dd == 509 | occ1990dd == 514 | occ1990dd == 519 | occ1990dd == 526 | occ1990dd == 539 | occ1990dd == 543 | occ1990dd == 544;

/*create one mining occupation code  */

replace occ1990dd = 616 if occ1990dd == 614 | occ1990dd == 615 | occ1990dd == 617;

/*create cabinet makers/ wood work occupation  */

replace occ1990dd = 657 if occ1990dd == 658 ;

/*create one forging and casting occupation  */

replace occ1990dd = 719 if occ1990dd == 713 ;

/*create one heavy construction machinery operator occupation */
replace occ1990dd = 844 if occ1990dd == 848| occ1990dd == 853 | occ1990dd == 859 ;

/*combine construction helpers, production helpers  with construction laborers*/
replace occ1990dd = 869 if occ1990dd == 865 | occ1990dd == 873;

/*create one recycling/ garbage occ*/
replace occ1990dd = 875 if occ1990dd == 878 | occ1990dd == 885  ;

/*create one cross guards and other guards occ*/
replace occ1990dd = 426 if occ1990dd == 425 ;

/*****************Now, we do the same thing to construct broader occupation categories*************/
#delimit cr
generate occ_broad = .
replace occ_broad = 1 if occ1990dd >= 4 & occ1990dd <= 22
replace occ_broad = 2 if occ1990dd >= 23 & occ1990dd <=25
replace occ_broad = 3 if occ1990dd >= 26 & occ1990dd <=37
replace occ_broad = 4 if (occ1990dd >= 44 & occ1990dd <= 48) | (occ1990dd >= 55 & occ1990dd <= 59)
replace occ_broad = 5 if occ1990dd == 43 | occ1990dd == 53 | occ1990dd == 173 | occ1990dd == 185
replace occ_broad = 6 if occ1990dd >= 64 & occ1990dd <= 83
replace occ_broad = 7 if occ1990dd >= 84 & occ1990dd <= 88
replace occ_broad = 8 if occ1990dd >= 89 & occ1990dd <= 106
replace occ_broad = 9 if occ1990dd == 154 
replace occ_broad = 10 if occ1990dd >= 155 & occ1990dd <= 163
replace occ_broad = 11 if occ1990dd >= 164 & occ1990dd <= 165
replace occ_broad = 12 if occ1990dd == 166 | occ1990dd == 169 
replace occ_broad = 13 if occ1990dd == 167 |(occ1990dd >= 174 & occ1990dd <= 177)
replace occ_broad = 14 if occ1990dd == 178
replace occ_broad = 15 if (occ1990dd >= 183 & occ1990dd <= 184) | occ1990dd == 195 | occ1990dd == 198
replace occ_broad = 16 if (occ1990dd >= 186 & occ1990dd <= 189) | occ1990dd == 194
replace occ_broad = 17 if occ1990dd == 193 | occ1990dd == 199
replace occ_broad = 18 if occ1990dd >=203 & occ1990dd <=208
replace occ_broad = 19 if occ1990dd >=214 & occ1990dd <=235
replace occ_broad = 20 if occ1990dd >=243 & occ1990dd <=283
replace occ_broad = 21 if occ1990dd >= 303 & occ1990dd <=389
replace occ_broad = 22 if occ1990dd >= 405 & occ1990dd <=408
replace occ_broad = 23 if occ1990dd >= 415 & occ1990dd <= 427
replace occ_broad = 24 if occ1990dd >= 433 & occ1990dd <=444
replace occ_broad = 25 if occ1990dd >= 448 & occ1990dd <=455
replace occ_broad = 26 if occ1990dd >= 457 & occ1990dd <=458
replace occ_broad = 27 if occ1990dd >= 459 & occ1990dd <=467
replace occ_broad = 28 if occ1990dd == 468
replace occ_broad = 29 if occ1990dd >= 469 & occ1990dd <=472
replace occ_broad = 30 if occ1990dd >= 473 & occ1990dd <= 475
replace occ_broad = 31 if occ1990dd >= 479 & occ1990dd <= 498
replace occ_broad = 32 if occ1990dd >= 503 & occ1990dd <=549
replace occ_broad = 33 if occ1990dd >= 558 & occ1990dd <=599
replace occ_broad = 34 if occ1990dd >= 614 & occ1990dd <= 617
replace occ_broad = 35 if occ1990dd >= 628 & occ1990dd <=699
replace occ_broad = 36 if occ1990dd >= 703 & occ1990dd <=799
replace occ_broad = 37 if occ1990dd >= 803 & occ1990dd <=834
replace occ_broad = 38 if occ1990dd >= 844 & occ1990dd <=889
#delimit ;
lab def ob 1 "Executive, Managerial, Administrative" 2 "Accountants, Insurance, Other Financial" 3 "Management Related" 4 "Engineers" 5 "Architects, Civil Engineers, Urban Planners, Designers" 6 "Scientists, Actuaries, Mathematicians" 7 "Physicians" 8 "Nurses and Other Health" 9 "Professors" 
10 "Teachers" 11 "Librarians and Archivists" 12 "Economists and Social Scientists" 13 "Psychologists Social Workers and Other Therapists" 14 "Lawyers and Judges" 15 "Writers editors announcers"
16 "Creatives" 17 "Dancers and athletes" 18 "Health Technicians" 19 "Other Technicians" 20 "Sales" 21 "Administrative Support" 22 "Housekeeping" 23 "Protective Service" 24 "Food Prep and Service"
25 "Buildings maintenance and keeping" 26 "Personal Appearance" 27 "Recreation and Hospitality" 28 "Child care" 29 "Misc personal care and service" 30 "Farm operators and Managers" 
31 "Other Agric." 32 "Mechanics and repairers" 33 "Construction" 34 "Extractive" 35 "Precision Production" 36 "Machine operators, assemblers, inspectors" 37 "Transportation" 38 "Helpers and Laborers" ;
lab val occ_broad ob ;

/********************MAJORS*****************/

#delimit ;
/*Here we clean the degree field vars */
/*in 2009 only, some fields were coded differently*/
replace degfieldd = 3611 if degfieldd == 4003  ; /*neuroscience*/
replace degfield2d = 3611 if degfield2d == 4003  ; /*neuroscience*/

/*make one interdisciplinary/ multidisc var. NOte: this combines Interdisc social science and general science majors*/
replace degfieldd = 4000 if degfieldd == 5098 | degfieldd == 4007 | degfieldd == 4008  | degfieldd == 3501 ;
replace degfield2d = 4000 if degfield2d == 5098 | degfield2d == 4007 | degfield2d == 4008 | degfield2d == 3501 ;

/*label pharmacology, botany, genetics and neuroscience majors as biology majors*/
replace degfieldd = 3600 if degfieldd == 3607 | degfieldd == 3611 | degfieldd == 3605 | degfieldd == 3602; 
replace degfield2d = 3600 if degfield2d == 3607 | degfield2d == 3611 | degfield2d == 3605 | degfield2d == 3602; 


/*make one materials science/ materials engineering major */
replace degfieldd = 2413 if degfieldd == 5008 ;
replace degfield2d = 2413 if degfield2d == 5008 ;

/*move the industrial arts major (2009) into the Industrial Production Technologies major */
replace degfieldd = 2503 if degfieldd == 5801 ;
replace degfield2d = 2503 if degfield2d == 5801 ;

/*move court reporting into pre-law */
replace degfieldd = 3202 if degfieldd == 3201 ;
replace degfield2d = 3202 if degfield2d == 3201 ;

/*move social psychology and cognitive science and biopsychology into the psychology major */
replace degfieldd = 5200 if degfieldd == 5206 | degfieldd == 4006 ;
replace degfield2d = 5200 if degfield2d == 5206 | degfield2d == 4006  ;

/*move soil science and misc agric into general agriculture major */
replace degfieldd = 1100 if degfieldd == 1106 |  degfieldd == 1199;
replace degfield2d = 1100 if degfield2d == 1106 | degfield2d == 1199 ;

/*move agriculture and business economics into economics */
replace degfieldd = 5501 if degfieldd == 1102 | degfieldd == 6205;
replace degfield2d = 5501 if degfield2d == 1102 | degfield2d == 6205;

/*move school counseling and education administration into general education */
replace degfieldd = 2300 if degfieldd == 2303 | degfieldd == 2301;
replace degfield2d = 2300 if degfield2d == 2303 | degfield2d == 2301 ;

/*move actuarial science and mathematics and computer science into Mathematics major */
replace degfieldd = 3700 if degfieldd == 6202 | degfieldd == 4005;
replace degfield2d = 3700 if degfield2d == 6202 | degfield2d == 4005 ;

/*make one electrical engineering category */
replace degfieldd = 2408 if degfieldd == 2502 | degfieldd == 5701 ;
replace degfield2d = 2408 if degfield2d == 2502 | degfield2d == 5701 ;

/*move one architectural engineering into civil engineering */
replace degfieldd = 2406 if degfieldd == 2403 ;
replace degfield2d = 2406 if degfield2d == 2403 ;

/*move military technologies, geological and geophysical engineering, mining engineering, petroleum engineering, biomedical engineering and metallurgical engineering into General Engineering major */
replace degfieldd = 2400 if degfieldd == 3801 | degfieldd == 2415 | degfieldd == 2404 | degfieldd == 2411 | degfieldd == 2415 | degfieldd == 2416 | degfieldd == 2417 | degfieldd == 2418  | degfieldd == 2419 ;
replace degfield2d = 2400 if degfield2d == 3801 | degfield2d == 2415 | degfield2d == 2404 | degfield2d == 2411 | degfield2d == 2415| degfield2d == 2416 | degfield2d == 2417 | degfield2d == 2418 | degfield2d == 2419 ;

/*move astronomy, nuclear, industrial radiology and biological technologies & geosciences majors to physical sciences */
replace degfieldd = 5000 if degfieldd == 5001 | degfieldd == 5005 | degfieldd == 5102 ;
replace degfield2d = 5000 if degfield2d == 5001 | degfield2d == 5005 | degfield2d == 5102 ;

/*combine studio based fine arts */
replace degfieldd = 6000 if  degfieldd == 6004 | degfieldd == 6005 | degfieldd == 6007 | degfieldd == 6099;
replace degfield2d = 6000 if  degfield2d == 6004 | degfield2d == 6005 | degfield2d == 6007 | degfield2d == 6099;

/*combine performance arts */
replace degfieldd = 6001 if degfieldd == 6002 | degfieldd == 6003 ;
replace degfield2d = 6001 if degfield2d == 6002 | degfield2d == 6003 ;

/*recode major field as missing if major is listed as one of the missing major fields*/
foreach num of numlist 1300 1900 2600 3200 3300 3400 5400 { ;
replace degfieldd = . if degfieldd == `num' ;
} ;

/*recode secondary major field as missing if major is listed as one of the missing major fields*/
foreach num of numlist 0000 1300 1900 2600 3200 3300 3400 4004  5400 6008 { ;
replace degfield2d = . if degfield2d == `num' ;
} ;

/*Here, to properly assign the major that is most predictive of an individual's employment when they have double-majored, we assign the highest earnings major as their primary major*/
# delimit ;

sort degfieldd ;
by degfieldd: egen degfieldmax = max (ln_earnings) ;
# delimit ;
sort degfield2d ;
by degfield2d: egen degfield2max = max (ln_earnings) ;

# delimit ;
gen nosecond = 1  ;
replace nosecond = 0 if degfield2d  != . ;

# delimit ;
gen max1st = 0 ;
replace max1st = 1 if (degfieldmax > degfield2max) & nosecond == 0 ;

# delimit ;
gen max2nd = 0 ;
replace max2nd = 1 if (degfieldmax < degfield2max) & nosecond == 0 ;

/*There are several majors where the 1st and 2nd major have the same earnings max. For these, we call the major the one the respondent listed as first */
# delimit ;
replace max1st = 1 if (degfieldmax == degfield2max) & nosecond == 0 ;

# delimit ;
gen major = . ;
replace major = degfieldd if nosecond == 1| max1st == 1 ;
replace major = degfield2d if max2nd == 1 ;

/*********Here, we do the same thing with broader major fields ****************/

#delimit ;

/*move nuclear science into physical sciences*/
replace degfield = 50 if degfield == 51  ;
replace degfield2 = 50 if degfield2 == 51  ;

/*combine precision production, electrical and mechanical repairs into construction*/
replace degfield = 56 if degfield == 58 | degfield == 57 ;
replace degfield2 = 56 if degfield2 == 58 | degfield2 == 57 ;

/*combine engineering and engineering, military and communication technologies*/
replace degfield = 24 if degfield == 25  |  degfield == 20 | degfield == 38 ;
replace degfield2 = 24 if degfield2 == 25 | degfield2 == 20 | degfield2 == 38 ;

/*combine philosophy and relgious studies with theology and religious studies*/
replace degfield = 48 if degfield == 49;
replace degfield2 = 48 if degfield2 == 49 ;

/*combine library science with education*/
replace degfield = 23 if degfield == 35  ;
replace degfield2 = 23 if degfield2 == 35 ;

/*combine cosmetology and physical fitness, parks, rec, leisure*/
replace degfield = 22 if degfield == 41  ;
replace degfield2 = 22 if degfield2 == 41 ;


/*Here, to properly assign the broad major category that is most predictive of an individual's employment when they have double-majored, we assign the broad major category based on the highest earnings detailed major as their primary major*/

# delimit ;
gen major_broad = . ;
replace major_broad = degfield if nosecond == 1| max1st == 1 ;
replace major_broad = degfield2 if max2nd == 1 ;

#delimit cr
/*Our sample is going to focus on civilians. Here, we recode military and unemployed as having missing occ codes*/
replace occ1990dd = . if occ1990dd > 889 

/*Here, we calculate "potential wages" for each category: detailed major, broad major, detailed occupation, broad occupation*/

sort major
egen med_earn_nat = median(earnings), by(major) 
egen wt_med_earn_nat = wpctile(earnings), p(50) weights(wt) by(major) 

sort major_broad
egen med_broad_earn_nat = median(earnings), by(major_broad) 
egen wt_med_broad_earn_nat = wpctile(earnings), p(50) weights(wt) by(major_broad) 


sort major
egen med_wage_nat = median(wage), by(major) 
egen wt_med_wage_nat = wpctile(wage), p(50) weights(wt) by(major) 
egen wt_med_hours_nat = wpctile(ln_hours), p(50) weights(wt) by(major)

sort major_broad
egen med_broad_wage_nat = median(wage), by(major_broad) 
egen wt_med_broad_wage_nat = wpctile(wage), p(50) weights(wt) by(major_broad) 



sort occ1990dd
egen occ_earn_nat = median(earnings), by(occ1990dd) 
egen wt_occ_earn_nat = wpctile(earnings), p(50) weights(wt) by(occ1990dd) 
replace wt_occ_earn_nat = . if occ1990dd >905

sort occ_broad
egen occ_broad_earn_nat = median(earnings), by(occ_broad) 
egen wt_occ_broad_earn_nat = wpctile(earnings), p(50) weights(wt) by(occ_broad) 
replace wt_occ_earn_nat = . if occ_broad == .



sort occ1990dd
egen occ_wage_nat = median(wage), by(occ1990dd) 
egen wt_occ_wage_nat = wpctile(wage), p(50) weights(wt) by(occ1990dd) 
replace wt_occ_wage_nat = . if occ1990dd >905
egen wt_occ_hours_nat = wpctile(ln_hours), p(50) weights(wt) by(occ1990dd) 
replace wt_occ_hours_nat = . if occ1990dd >905

sort occ_broad
egen occ_broad_wage_nat = median(wage), by(occ_broad) 
egen wt_occ_broad_wage_nat = wpctile(wage), p(50) weights(wt) by(occ_broad) 
replace wt_occ_broad_wage_nat = . if occ_broad == .

/*generate some interaction terms which we will use in our regression analysis*/

gen fem_a25 = female * a25
gen fem_a30 = female * a30
gen fem_a35 = female * a35
gen fem_a40 = female * a40
gen fem_a60 = female * a60
gen fem_a65 = female * a65
gen fem_a4555 = female * a45_55

save "main_analysis_file", replace 

/*here, we merge in data on the size of the major (generated from the same sample: ACS 2014-2017)*/
sort major
joinby major using "major_size"

save "main_analysis_file", replace 

# delimit cr
clear all 

cd "C:\Users\cmslo\Box Sync\JEP Replication files"

use "main_analysis_file"

/*here, we make a categorical birth cohort variable*/
gen age_group = 0
replace age_group = 25 if a25 == 1
replace age_group = 30 if a30 == 1
replace age_group = 35 if a35 == 1
replace age_group = 40 if a40 == 1
replace age_group = 45 if a45 == 1
replace age_group = 50 if a50 == 1
replace age_group = 55 if a55 == 1
replace age_group = 60 if a60 == 1
replace age_group = 65 if a65 == 1

/*save our main data analysis file*/
save "main_analysis_file", replace
log close 

*/
/***********************************************************************************************************************************************************************************/
/***********************************************************************************************************************************************************************************/
/*****************************************************Main Figures & Tables *******************************************************************************************************/

/********************************************FIGURES**************************************************************************************************************************/

/************Figure 1: Gender Differences in Selected Majors by Birth Cohort:
The data for these graphs is generated in  this program and is exported to Excel to make into graphs.
x-axis for Figure 1: five-year birth cohort
y-axis for Figure 1: female share/ male share = the count of women in a broad major category / the count of men in a broad major category 
Panel A: male-dominated majors of Biology/Life Sciences, Business, History, Physical Sciences, Engineering
Panel B: female-dominated majors Nursing/ Pharmacy, Education, Psychology, Foreign Language, Fine Arts
Note: the variable major_broad identifies our broad major categories, the variable age_group identifies our 5-year birth cohorts, the variable wt is our weight variable
*/

# delimit ;
clear all ;

cd "C:\Users\cmslo\Box Sync\JEP Replication files" ;
log using "C:\Users\cmslo\Box Sync\JEP Replication files\replication Figure 1_check.smcl", replace ;
use "main_analysis_file" ;
/*we begin by making some indicator variables to identify the broad major categories we will use to make Panels A&B of Figure 1*/
gen engineering = 0 ;

replace engineering = 1 if major_broad == 24 ;

gen biology = 0 ;
replace biology = 1 if major_broad == 36 ;

gen physical_sciences = 0 ;
replace physical_sciences = 1 if major_broad == 50 ;

gen business = 0 ;
replace business = 1 if major_broad == 62 ;

gen history = 0 ;
replace history = 1 if major_broad == 64 ;

gen education = 0 ;
replace education = 1 if major_broad == 23 ;

gen psychology = 0 ;
replace psychology = 1 if major_broad == 52 ;

gen fine_arts = 0 ;
replace fine_arts = 1 if major_broad == 60 ;

gen medical = 0 ; /*This is our Nursing/Pharmacy major*/
replace medical = 1 if major_broad == 61 ;

gen languages = 0 ; /*This is our Foreign Languages major*/
replace languages = 1 if major_broad == 26 ;

keep if major != . ;

#delimit cr
gen major_cat = .
replace major_cat = 1 if engineering == 1 
replace major_cat = 2 if biology == 1
replace major_cat = 3 if physical_sciences == 1
replace major_cat = 4 if business == 1
replace major_cat = 5 if history == 1
replace major_cat = 6 if education == 1
replace major_cat = 7 if psychology == 1
replace major_cat = 8 if fine_arts == 1
replace major_cat = 9 if medical == 1 
replace major_cat = 10 if languages == 1

/*Panel A: we export these counts to Excel and divide female / male to get our Y-axis for Panel A*/
sort age_group
by age_group: tab male if engineering == 1 [aw=wt]
by age_group: tab male if biology == 1 [aw=wt]
by age_group: tab male if physical_sciences == 1 [aw=wt]
by age_group: tab male if business == 1 [aw=wt]
by age_group: tab male if history == 1 [aw=wt]

/*Panel B: we export these counts to Excel and divide female / male to get our Y-axis for Panel B*/
sort age_group
by age_group: tab male if education == 1 [aw=wt]
by age_group: tab male if psychology == 1 [aw=wt]
by age_group: tab male if fine_arts == 1 [aw=wt]
by age_group: tab male if medical == 1 [aw=wt] /*This is our Nursing/Pharmacy major*/
by age_group: tab male if languages== 1 [aw=wt]

log close 

/***************************************************************************************************************************************************************/
/************Figure 2: Gender Similarity in Major and Occupation by Cohort:
The data for these graphs is generated in  this program and is exported to Excel to make into graphs.
x-axis for Figure 2: five-year birth cohort
y-axis for Figure 2: Inverse Duncan-Duncan Index for detailed major (solid line), detailed occupation (dashed line)

Note: the variable major identifies our detailed major categories, the variable occ1990dd identifies our detailed occupation categories
the variable age_group identifies our 5-year birth cohorts, the variable wt is our weight variable, 
the variable dd_index_age is our Classic Duncan-Duncan index for detailed majors, the variable dd_index_age_occ is our Classic Duncan-Duncan index for detailed occupations
the variable dd_inverse_age is our inverse Duncan-Duncan index for detailed majors, the variable dd_inverse_age_occ is our inverse Duncan-Duncan index for detailed occupations
*/


/* We begin by calculating the classic Duncan-Duncan indices for each of our five-year birth cohorts:
The classic Duncan-Duncan index for majors (or occupations) is computed by: 1) calculating the absolute within-major (or within-occupation) difference between the share of the relevant male sample in a major (or occupation) and the share of the relevant female sample in a major (or occupation); 2) summing up absolute differences over all majors (or occupations); and 3) scaling by one-half to account for the comparison of two distributions. The classic Duncan-Duncan index values range from 0 to 1. If there are no differences across majors (occupations), the index would be zero. If there is complete segregation across majors (occupations), the index would be 1.
 
For our discussion, we renormalize these classic Duncan-Duncan indices by subtracting them from one. This step allows the reader to make easy visual comparisons with the indices introduced later in the paper: an increasing slope of any index in this paper represents a movement toward gender parity.*/

/**Calculating Classic Duncan-Duncan Indices for Detailed Majors*/

/*First, we calculate male shares within each detailed major category for each five-year birth cohort*/
# delimit cr
clear all 

cd "C:\Users\cmslo\Box Sync\JEP Replication files" 
log using "C:\Users\cmslo\Box Sync\JEP Replication files\replication Figure 2_check.smcl", replace 
use "main_analysis_file"

#delimit ;
gen major_male = major * male ;

gen count_age_male_ = 1;
						
format count_age_male_              %18.4f;

# delimit ;
collapse (sum) count_age_male_  [pw=wt], by (age_group major_male) ;

reshape wide count_age_male_  , i(age_group) j(major_male) ;

foreach num of numlist 
		
1100	2407	5002	6106
1101	2408	5003	6107
1103	2409	5004	6108
1104	2410	5006	6109
1105	2412	5007	6110
1301	2413	5200	6199
1302	2414	5201	6200
1303	2499	5202	6201
1401	2500	5203	6203
1501	2501	5205	6204
1901	2503	5299	6206
1902	2504	5301	6207
1903	2599	5401	6209
1904	2601	5402	6210
2001	2602	5403	6211
2100	2603	5404	6212
2101	2901	5500	6299
2102	3202	5501	6402
2105	3301	5502	6403
2106	3302	5503	
2107	3401	5504	
2201	3402	5505	
2300	3600	5506	
2304	3601	5507	
2305	3603	5599	
2306	3604	5601	
2307	3606	5901	
2308	3608	6000	
2309	3609	6001	
2310	3699		
2311	3700		
2312	3701		
2313	3702		
2314	4000	6006	
2399	4001		
2400	4002	6100	
2401	4101	6102	
2402	4801	6103	
2405	4901	6104	
2406	5000	6105	

	
{;
egen count_age_male_`num'_total = sum(count_age_male_`num') ;
format count_age_male_`num'_total              %18.4f;
} ;


# delimit ;

egen malemajor_age = rowtotal(
count_age_male_1100	count_age_male_2407	count_age_male_5002	count_age_male_6106
count_age_male_1101	count_age_male_2408	count_age_male_5003	count_age_male_6107
count_age_male_1103	count_age_male_2409	count_age_male_5004	count_age_male_6108
count_age_male_1104	count_age_male_2410	count_age_male_5006	count_age_male_6109
count_age_male_1105	count_age_male_2412	count_age_male_5007	count_age_male_6110
count_age_male_1301	count_age_male_2413	count_age_male_5200	count_age_male_6199
count_age_male_1302	count_age_male_2414	count_age_male_5201	count_age_male_6200
count_age_male_1303	count_age_male_2499	count_age_male_5202	count_age_male_6201
count_age_male_1401	count_age_male_2500	count_age_male_5203	count_age_male_6203
count_age_male_1501	count_age_male_2501	count_age_male_5205	count_age_male_6204
count_age_male_1901	count_age_male_2503	count_age_male_5299	count_age_male_6206
count_age_male_1902	count_age_male_2504	count_age_male_5301	count_age_male_6207
count_age_male_1903	count_age_male_2599	count_age_male_5401	count_age_male_6209
count_age_male_1904	count_age_male_2601	count_age_male_5402	count_age_male_6210
count_age_male_2001	count_age_male_2602	count_age_male_5403	count_age_male_6211
count_age_male_2100	count_age_male_2603	count_age_male_5404	count_age_male_6212
count_age_male_2101	count_age_male_2901	count_age_male_5500	count_age_male_6299
count_age_male_2102	count_age_male_3202	count_age_male_5501	count_age_male_6402
count_age_male_2105	count_age_male_3301	count_age_male_5502	count_age_male_6403
count_age_male_2106	count_age_male_3302	count_age_male_5503		
count_age_male_2107	count_age_male_3401	count_age_male_5504		
count_age_male_2201	count_age_male_3402	count_age_male_5505		
count_age_male_2300	count_age_male_3600	count_age_male_5506		
count_age_male_2304	count_age_male_3601	count_age_male_5507		
count_age_male_2305	count_age_male_3603	count_age_male_5599		
count_age_male_2306	count_age_male_3604	count_age_male_5601		
count_age_male_2307	count_age_male_3606	count_age_male_5901		
count_age_male_2308	count_age_male_3608	count_age_male_6000		
count_age_male_2309	count_age_male_3609	count_age_male_6001		
count_age_male_2310	count_age_male_3699		
count_age_male_2311	count_age_male_3700			
count_age_male_2312	count_age_male_3701		
count_age_male_2313	count_age_male_3702		
count_age_male_2314	count_age_male_4000	count_age_male_6006		
count_age_male_2399	count_age_male_4001			
count_age_male_2400	count_age_male_4002	count_age_male_6100		
count_age_male_2401	count_age_male_4101	count_age_male_6102		
count_age_male_2402	count_age_male_4801	count_age_male_6103		
count_age_male_2405	count_age_male_4901	count_age_male_6104		
count_age_male_2406	count_age_male_5000	count_age_male_6105		

) ;
format malemajor_age              %18.4f;


/*compute major shares for men*/
# delimit ;
foreach num of numlist 
1100	2407	5002	6106
1101	2408	5003	6107
1103	2409	5004	6108
1104	2410	5006	6109
1105	2412	5007	6110
1301	2413	5200	6199
1302	2414	5201	6200
1303	2499	5202	6201
1401	2500	5203	6203
1501	2501	5205	6204
1901	2503	5299	6206
1902	2504	5301	6207
1903	2599	5401	6209
1904	2601	5402	6210
2001	2602	5403	6211
2100	2603	5404	6212
2101	2901	5500	6299
2102	3202	5501	6402
2105	3301	5502	6403
2106	3302	5503	
2107	3401	5504	
2201	3402	5505	
2300	3600	5506	
2304	3601	5507	
2305	3603	5599	
2306	3604	5601	
2307	3606	5901	
2308	3608	6000	
2309	3609	6001	
2310	3699		
2311	3700		
2312	3701		
2313	3702		
2314	4000	6006	
2399	4001		
2400	4002	6100	
2401	4101	6102	
2402	4801	6103	
2405	4901	6104	
2406	5000	6105	


	{;
gen male_share_age_`num' = count_age_male_`num'/malemajor_age  ;
format male_share_age_`num'             %18.4f;
} ;

save "male_counts_age", replace ;


/*Now, we calculate female shares within each detailed major category for each five-year birth cohort*/
# delimit cr
clear all 

cd "C:\Users\cmslo\Box Sync\JEP Replication files" 

use "main_analysis_file"

#delimit ;
gen major_female = major * female ;

gen count_age_female_ = 1;
						
format count_age_female_              %18.4f;

# delimit ;
collapse (sum) count_age_female_  [pw=wt], by (age_group major_female) ;

reshape wide count_age_female_  , i(age_group) j(major_female) ;

foreach num of numlist 
		
1100	2407	5002	6106
1101	2408	5003	6107
1103	2409	5004	6108
1104	2410	5006	6109
1105	2412	5007	6110
1301	2413	5200	6199
1302	2414	5201	6200
1303	2499	5202	6201
1401	2500	5203	6203
1501	2501	5205	6204
1901	2503	5299	6206
1902	2504	5301	6207
1903	2599	5401	6209
1904	2601	5402	6210
2001	2602	5403	6211
2100	2603	5404	6212
2101	2901	5500	6299
2102	3202	5501	6402
2105	3301	5502	6403
2106	3302	5503	
2107	3401	5504	
2201	3402	5505	
2300	3600	5506	
2304	3601	5507	
2305	3603	5599	
2306	3604	5601	
2307	3606	5901	
2308	3608	6000	
2309	3609	6001	
2310	3699		
2311	3700		
2312	3701		
2313	3702		
2314	4000	6006	
2399	4001		
2400	4002	6100	
2401	4101	6102	
2402	4801	6103	
2405	4901	6104	
2406	5000	6105	
	
	
{;
egen count_age_female_`num'_total = sum(count_age_female_`num') ;
format count_age_female_`num'_total              %18.4f;
} ;


# delimit ;

egen femalemajor_age = rowtotal(
count_age_female_1100	count_age_female_2407	count_age_female_5002	count_age_female_6106
count_age_female_1101	count_age_female_2408	count_age_female_5003	count_age_female_6107
count_age_female_1103	count_age_female_2409	count_age_female_5004	count_age_female_6108
count_age_female_1104	count_age_female_2410	count_age_female_5006	count_age_female_6109
count_age_female_1105	count_age_female_2412	count_age_female_5007	count_age_female_6110
count_age_female_1301	count_age_female_2413	count_age_female_5200	count_age_female_6199
count_age_female_1302	count_age_female_2414	count_age_female_5201	count_age_female_6200
count_age_female_1303	count_age_female_2499	count_age_female_5202	count_age_female_6201
count_age_female_1401	count_age_female_2500	count_age_female_5203	count_age_female_6203
count_age_female_1501	count_age_female_2501	count_age_female_5205	count_age_female_6204
count_age_female_1901	count_age_female_2503	count_age_female_5299	count_age_female_6206
count_age_female_1902	count_age_female_2504	count_age_female_5301	count_age_female_6207
count_age_female_1903	count_age_female_2599	count_age_female_5401	count_age_female_6209
count_age_female_1904	count_age_female_2601	count_age_female_5402	count_age_female_6210
count_age_female_2001	count_age_female_2602	count_age_female_5403	count_age_female_6211
count_age_female_2100	count_age_female_2603	count_age_female_5404	count_age_female_6212
count_age_female_2101	count_age_female_2901	count_age_female_5500	count_age_female_6299
count_age_female_2102	count_age_female_3202	count_age_female_5501	count_age_female_6402
count_age_female_2105	count_age_female_3301	count_age_female_5502	count_age_female_6403
count_age_female_2106	count_age_female_3302	count_age_female_5503		
count_age_female_2107	count_age_female_3401	count_age_female_5504		
count_age_female_2201	count_age_female_3402	count_age_female_5505		
count_age_female_2300	count_age_female_3600	count_age_female_5506		
count_age_female_2304	count_age_female_3601	count_age_female_5507		
count_age_female_2305	count_age_female_3603	count_age_female_5599		
count_age_female_2306	count_age_female_3604	count_age_female_5601		
count_age_female_2307	count_age_female_3606	count_age_female_5901		
count_age_female_2308	count_age_female_3608	count_age_female_6000		
count_age_female_2309	count_age_female_3609	count_age_female_6001		
count_age_female_2310	count_age_female_3699			
count_age_female_2311	count_age_female_3700			
count_age_female_2312	count_age_female_3701			
count_age_female_2313	count_age_female_3702			
count_age_female_2314	count_age_female_4000	count_age_female_6006		
count_age_female_2399	count_age_female_4001	
count_age_female_2400	count_age_female_4002	count_age_female_6100		
count_age_female_2401	count_age_female_4101	count_age_female_6102		
count_age_female_2402	count_age_female_4801	count_age_female_6103		
count_age_female_2405	count_age_female_4901	count_age_female_6104		
count_age_female_2406	count_age_female_5000	count_age_female_6105		
		
) ;
format femalemajor_age              %18.4f;


/*compute major shares for women*/
# delimit ;
foreach num of numlist 
1100	2407	5002	6106
1101	2408	5003	6107
1103	2409	5004	6108
1104	2410	5006	6109
1105	2412	5007	6110
1301	2413	5200	6199
1302	2414	5201	6200
1303	2499	5202	6201
1401	2500	5203	6203
1501	2501	5205	6204
1901	2503	5299	6206
1902	2504	5301	6207
1903	2599	5401	6209
1904	2601	5402	6210
2001	2602	5403	6211
2100	2603	5404	6212
2101	2901	5500	6299
2102	3202	5501	6402
2105	3301	5502	6403
2106	3302	5503	
2107	3401	5504	
2201	3402	5505	
2300	3600	5506	
2304	3601	5507	
2305	3603	5599	
2306	3604	5601	
2307	3606	5901	
2308	3608	6000	
2309	3609	6001	
2310	3699		
2311	3700	
2312	3701		
2313	3702		
2314	4000	6006	
2399	4001		
2400	4002	6100	
2401	4101	6102	
2402	4801	6103	
2405	4901	6104	
2406	5000	6105	


	{;
gen female_share_age_`num' = count_age_female_`num'/femalemajor_age  ;
format female_share_age_`num'             %18.4f;
} ;

save "female_counts_age", replace ;


/*Now, we calculate the Classic Duncan-Duncan index in detailed majors for each five-year birth cohort*/
# delimit ;

clear all;

set more off ;
/*set maxvar 32000 ;*/
cd "C:\Users\cmslo\Box Sync\JEP Replication files" ;
use "female_counts_age" ;

sort age_group ;

merge 1:1 age_group using "male_counts_age" ;

tab _merge ;

gen male_share_age_ = . ;

gen female_share_age_ = . ;

foreach num of numlist
1100	2407	5002	6106
1101	2408	5003	6107
1103	2409	5004	6108
1104	2410	5006	6109
1105	2412	5007	6110
1301	2413	5200	6199
1302	2414	5201	6200
1303	2499	5202	6201
1401	2500	5203	6203
1501	2501	5205	6204
1901	2503	5299	6206
1902	2504	5301	6207
1903	2599	5401	6209
1904	2601	5402	6210
2001	2602	5403	6211
2100	2603	5404	6212
2101	2901	5500	6299
2102	3202	5501	6402
2105	3301	5502	6403
2106	3302	5503	
2107	3401	5504	
2201	3402	5505	
2300	3600	5506	
2304	3601	5507	
2305	3603	5599	
2306	3604	5601	
2307	3606	5901	
2308	3608	6000	
2309	3609	6001	
2310	3699		
2311	3700		
2312	3701		
2313	3702		
2314	4000	6006	
2399	4001		
2400	4002	6100	
2401	4101	6102	
2402	4801	6103	
2405	4901	6104	
2406	5000	6105	
	
{ ;

gen d_share_`num' = abs(male_share_age_`num' - female_share_age_`num') ;
format d_share_`num'            %18.4f;
} ;

egen dd_index_age = rowtotal(
d_share_1100	d_share_2407	d_share_5002	d_share_6106
d_share_1101	d_share_2408	d_share_5003	d_share_6107
d_share_1103	d_share_2409	d_share_5004	d_share_6108
d_share_1104	d_share_2410	d_share_5006	d_share_6109
d_share_1105	d_share_2412	d_share_5007	d_share_6110
d_share_1301	d_share_2413	d_share_5200	d_share_6199
d_share_1302	d_share_2414	d_share_5201	d_share_6200
d_share_1303	d_share_2499	d_share_5202	d_share_6201
d_share_1401	d_share_2500	d_share_5203	d_share_6203
d_share_1501	d_share_2501	d_share_5205	d_share_6204
d_share_1901	d_share_2503	d_share_5299	d_share_6206
d_share_1902	d_share_2504	d_share_5301	d_share_6207
d_share_1903	d_share_2599	d_share_5401	d_share_6209
d_share_1904	d_share_2601	d_share_5402	d_share_6210
d_share_2001	d_share_2602	d_share_5403	d_share_6211
d_share_2100	d_share_2603	d_share_5404	d_share_6212
d_share_2101	d_share_2901	d_share_5500	d_share_6299
d_share_2102	d_share_3202	d_share_5501	d_share_6402
d_share_2105	d_share_3301	d_share_5502	d_share_6403
d_share_2106	d_share_3302	d_share_5503		
d_share_2107	d_share_3401	d_share_5504		
d_share_2201	d_share_3402	d_share_5505		
d_share_2300	d_share_3600	d_share_5506		
d_share_2304	d_share_3601	d_share_5507		
d_share_2305	d_share_3603	d_share_5599		
d_share_2306	d_share_3604	d_share_5601		
d_share_2307	d_share_3606	d_share_5901		
d_share_2308	d_share_3608	d_share_6000		
d_share_2309	d_share_3609	d_share_6001		
d_share_2310	d_share_3699		
d_share_2311	d_share_3700			
d_share_2312	d_share_3701			
d_share_2313	d_share_3702			
d_share_2314	d_share_4000	d_share_6006		
d_share_2399	d_share_4001			
d_share_2400	d_share_4002	d_share_6100		
d_share_2401	d_share_4101	d_share_6102		
d_share_2402	d_share_4801	d_share_6103		
d_share_2405	d_share_4901	d_share_6104		
d_share_2406	d_share_5000	d_share_6105		
	
) ;

format dd_index_age            %18.4f;

replace dd_index_age = 0.5* dd_index_age ;

keep dd_* age_group ;

gen dd_inverse_age = 1 - dd_index_age ;

/*we now go to browse mode to we can easily copy and paste this data to Excel to make our detailed major series for the inverse Duncan-Duncan: this is the solid line*/
browse ;
save "age_group_duncan_duncan", replace ;

/**Calculating Classic Duncan-Duncan Indices for Occupations*/

/*First, we calculate male shares within each detailed occupation category for each five-year birth cohort*/
# delimit cr
clear all 

cd "C:\Users\cmslo\Box Sync\JEP Replication files" 

use "main_analysis_file"

drop if occ1990dd == . 

#delimit ;
gen occ_male = occ1990dd * male ;

gen count_age_male_ = 1;
						
format count_age_male_              %18.4f;

# delimit ;
collapse (sum) count_age_male_  [pw=wt], by (age_group occ_male) ;

reshape wide count_age_male_  , i(age_group) j(occ_male) ;


foreach num of numlist 
		
4	78	205	336	444	567	809
7	79	206	337	445	575	813
8	83	207	338	447	577	829
13	84	208	344	448	579	834
14	89	214	346	450	585	844
15	95	217	347	451	593	866
18	96	218	348	453	599	869
19	97	223	354	455	616	875
22	98	224	355	458	628	887
23	103	225	356	459	634	888
24	105	226	357	461	637	889
25	106	227	359	462	653	
26	154	228	364	464	657	
27	155	229	365	466	666	
28	156	233	368	468	675	
29	157	234	373	469	677	
33	158	235	375	470	678	
34	159	243	376	471	684	
35	163	253	377	472	686	
36	164	254	378	475	687	
37	165	255	379	479	688	
43	167	256	383	489	694	
44	169	258	384	496	695	
45	174	274	385	498	696	
47	176	275	386	503	699	
48	177	276	387	505	706	
53	178	277	389	507	707	
55	183	283	405	508	719	
56	184	303	408	516	733	
57	185	308	415	518	736	
59	186	313	417	523	749	
64	187	315	418	525	757	
65	188	316	423	527	779	
68	189	317	426	533	783	
69	194	318	427	534	785	
73	195	319	433	535	789	
74	198	326	434	536	799	
75	199	328	435	549	803	
76	203	329	436	558	804	
77	204	335	439	563	808	
	
	
{;
egen count_age_male_`num'_total = sum(count_age_male_`num') ;
format count_age_male_`num'_total              %18.4f;
} ;


# delimit ;

egen maleocc_age = rowtotal(
count_age_male_4	count_age_male_78	count_age_male_205	count_age_male_336	count_age_male_444	count_age_male_567	count_age_male_809
count_age_male_7	count_age_male_79	count_age_male_206	count_age_male_337	count_age_male_445	count_age_male_575	count_age_male_813
count_age_male_8	count_age_male_83	count_age_male_207	count_age_male_338	count_age_male_447	count_age_male_577	count_age_male_829
count_age_male_13	count_age_male_84	count_age_male_208	count_age_male_344	count_age_male_448	count_age_male_579	count_age_male_834
count_age_male_14	count_age_male_89	count_age_male_214	count_age_male_346	count_age_male_450	count_age_male_585	count_age_male_844
count_age_male_15	count_age_male_95	count_age_male_217	count_age_male_347	count_age_male_451	count_age_male_593	count_age_male_866
count_age_male_18	count_age_male_96	count_age_male_218	count_age_male_348	count_age_male_453	count_age_male_599	count_age_male_869
count_age_male_19	count_age_male_97	count_age_male_223	count_age_male_354	count_age_male_455	count_age_male_616	count_age_male_875
count_age_male_22	count_age_male_98	count_age_male_224	count_age_male_355	count_age_male_458	count_age_male_628	count_age_male_887
count_age_male_23	count_age_male_103	count_age_male_225	count_age_male_356	count_age_male_459	count_age_male_634	count_age_male_888
count_age_male_24	count_age_male_105	count_age_male_226	count_age_male_357	count_age_male_461	count_age_male_637	count_age_male_889
count_age_male_25	count_age_male_106	count_age_male_227	count_age_male_359	count_age_male_462	count_age_male_653		
count_age_male_26	count_age_male_154	count_age_male_228	count_age_male_364	count_age_male_464	count_age_male_657		
count_age_male_27	count_age_male_155	count_age_male_229	count_age_male_365	count_age_male_466	count_age_male_666		
count_age_male_28	count_age_male_156	count_age_male_233	count_age_male_368	count_age_male_468	count_age_male_675		
count_age_male_29	count_age_male_157	count_age_male_234	count_age_male_373	count_age_male_469	count_age_male_677		
count_age_male_33	count_age_male_158	count_age_male_235	count_age_male_375	count_age_male_470	count_age_male_678		
count_age_male_34	count_age_male_159	count_age_male_243	count_age_male_376	count_age_male_471	count_age_male_684		
count_age_male_35	count_age_male_163	count_age_male_253	count_age_male_377	count_age_male_472	count_age_male_686		
count_age_male_36	count_age_male_164	count_age_male_254	count_age_male_378	count_age_male_475	count_age_male_687		
count_age_male_37	count_age_male_165	count_age_male_255	count_age_male_379	count_age_male_479	count_age_male_688		
count_age_male_43	count_age_male_167	count_age_male_256	count_age_male_383	count_age_male_489	count_age_male_694		
count_age_male_44	count_age_male_169	count_age_male_258	count_age_male_384	count_age_male_496	count_age_male_695		
count_age_male_45	count_age_male_174	count_age_male_274	count_age_male_385	count_age_male_498	count_age_male_696		
count_age_male_47	count_age_male_176	count_age_male_275	count_age_male_386	count_age_male_503	count_age_male_699		
count_age_male_48	count_age_male_177	count_age_male_276	count_age_male_387	count_age_male_505	count_age_male_706		
count_age_male_53	count_age_male_178	count_age_male_277	count_age_male_389	count_age_male_507	count_age_male_707		
count_age_male_55	count_age_male_183	count_age_male_283	count_age_male_405	count_age_male_508	count_age_male_719		
count_age_male_56	count_age_male_184	count_age_male_303	count_age_male_408	count_age_male_516	count_age_male_733		
count_age_male_57	count_age_male_185	count_age_male_308	count_age_male_415	count_age_male_518	count_age_male_736		
count_age_male_59	count_age_male_186	count_age_male_313	count_age_male_417	count_age_male_523	count_age_male_749		
count_age_male_64	count_age_male_187	count_age_male_315	count_age_male_418	count_age_male_525	count_age_male_757		
count_age_male_65	count_age_male_188	count_age_male_316	count_age_male_423	count_age_male_527	count_age_male_779		
count_age_male_68	count_age_male_189	count_age_male_317	count_age_male_426	count_age_male_533	count_age_male_783		
count_age_male_69	count_age_male_194	count_age_male_318	count_age_male_427	count_age_male_534	count_age_male_785		
count_age_male_73	count_age_male_195	count_age_male_319	count_age_male_433	count_age_male_535	count_age_male_789		
count_age_male_74	count_age_male_198	count_age_male_326	count_age_male_434	count_age_male_536	count_age_male_799		
count_age_male_75	count_age_male_199	count_age_male_328	count_age_male_435	count_age_male_549	count_age_male_803		
count_age_male_76	count_age_male_203	count_age_male_329	count_age_male_436	count_age_male_558	count_age_male_804		
count_age_male_77	count_age_male_204	count_age_male_335	count_age_male_439	count_age_male_563	count_age_male_808		

) ;
format maleocc_age              %18.4f;


/*compute occ shares*/
# delimit ;
foreach num of numlist 
4	78	205	336	444	567	809
7	79	206	337	445	575	813
8	83	207	338	447	577	829
13	84	208	344	448	579	834
14	89	214	346	450	585	844
15	95	217	347	451	593	866
18	96	218	348	453	599	869
19	97	223	354	455	616	875
22	98	224	355	458	628	887
23	103	225	356	459	634	888
24	105	226	357	461	637	889
25	106	227	359	462	653	
26	154	228	364	464	657	
27	155	229	365	466	666	
28	156	233	368	468	675	
29	157	234	373	469	677	
33	158	235	375	470	678	
34	159	243	376	471	684	
35	163	253	377	472	686	
36	164	254	378	475	687	
37	165	255	379	479	688	
43	167	256	383	489	694	
44	169	258	384	496	695	
45	174	274	385	498	696	
47	176	275	386	503	699	
48	177	276	387	505	706	
53	178	277	389	507	707	
55	183	283	405	508	719	
56	184	303	408	516	733	
57	185	308	415	518	736	
59	186	313	417	523	749	
64	187	315	418	525	757	
65	188	316	423	527	779	
68	189	317	426	533	783	
69	194	318	427	534	785	
73	195	319	433	535	789	
74	198	326	434	536	799	
75	199	328	435	549	803	
76	203	329	436	558	804	
77	204	335	439	563	808	
	

	{;
gen male_share_age_`num' = count_age_male_`num'/maleocc_age  ;
format male_share_age_`num'             %18.4f;
} ;

save "male_counts_age_occ", replace ;


/*Now, we calculate female shares within each detailed occupation category for each five-year birth cohort*/
# delimit cr
clear all 

cd "C:\Users\cmslo\Box Sync\JEP Replication files" 

use "main_analysis_file"

drop if occ1990dd == . 

#delimit ;
gen occ_female = occ1990dd * female ;

gen count_age_female_ = 1;
						
format count_age_female_              %18.4f;

# delimit ;
collapse (sum) count_age_female_  [pw=wt], by (age_group occ_female) ;

reshape wide count_age_female_  , i(age_group) j(occ_female) ;


foreach num of numlist 
		
4	78	205	336	444	567	809
7	79	206	337	445	575	813
8	83	207	338	447	577	829
13	84	208	344	448	579	834
14	89	214	346	450	585	844
15	95	217	347	451	593	866
18	96	218	348	453	599	869
19	97	223	354	455	616	875
22	98	224	355	458	628	887
23	103	225	356	459	634	888
24	105	226	357	461	637	889
25	106	227	359	462	653	
26	154	228	364	464	657	
27	155	229	365	466	666	
28	156	233	368	468	675	
29	157	234	373	469	677	
33	158	235	375	470	678	
34	159	243	376	471	684	
35	163	253	377	472	686	
36	164	254	378	475	687	
37	165	255	379	479	688	
43	167	256	383	489	694	
44	169	258	384	496	695	
45	174	274	385	498	696	
47	176	275	386	503	699	
48	177	276	387	505	706	
53	178	277	389	507	707	
55	183	283	405	508	719	
56	184	303	408	516	733	
57	185	308	415	518	736	
59	186	313	417	523	749	
64	187	315	418	525	757	
65	188	316	423	527	779	
68	189	317	426	533	783	
69	194	318	427	534	785	
73	195	319	433	535	789	
74	198	326	434	536	799	
75	199	328	435	549	803	
76	203	329	436	558	804	
77	204	335	439	563	808	
	
	
{;
egen count_age_female_`num'_total = sum(count_age_female_`num') ;
format count_age_female_`num'_total              %18.4f;
} ;



# delimit ;

egen femaleocc_age = rowtotal(
count_age_female_4	count_age_female_78	count_age_female_205	count_age_female_336	count_age_female_444	count_age_female_567	count_age_female_809
count_age_female_7	count_age_female_79	count_age_female_206	count_age_female_337	count_age_female_445	count_age_female_575	count_age_female_813
count_age_female_8	count_age_female_83	count_age_female_207	count_age_female_338	count_age_female_447	count_age_female_577	count_age_female_829
count_age_female_13	count_age_female_84	count_age_female_208	count_age_female_344	count_age_female_448	count_age_female_579	count_age_female_834
count_age_female_14	count_age_female_89	count_age_female_214	count_age_female_346	count_age_female_450	count_age_female_585	count_age_female_844
count_age_female_15	count_age_female_95	count_age_female_217	count_age_female_347	count_age_female_451	count_age_female_593	count_age_female_866
count_age_female_18	count_age_female_96	count_age_female_218	count_age_female_348	count_age_female_453	count_age_female_599	count_age_female_869
count_age_female_19	count_age_female_97	count_age_female_223	count_age_female_354	count_age_female_455	count_age_female_616	count_age_female_875
count_age_female_22	count_age_female_98	count_age_female_224	count_age_female_355	count_age_female_458	count_age_female_628	count_age_female_887
count_age_female_23	count_age_female_103	count_age_female_225	count_age_female_356	count_age_female_459	count_age_female_634	count_age_female_888
count_age_female_24	count_age_female_105	count_age_female_226	count_age_female_357	count_age_female_461	count_age_female_637	count_age_female_889
count_age_female_25	count_age_female_106	count_age_female_227	count_age_female_359	count_age_female_462	count_age_female_653		
count_age_female_26	count_age_female_154	count_age_female_228	count_age_female_364	count_age_female_464	count_age_female_657		
count_age_female_27	count_age_female_155	count_age_female_229	count_age_female_365	count_age_female_466	count_age_female_666		
count_age_female_28	count_age_female_156	count_age_female_233	count_age_female_368	count_age_female_468	count_age_female_675		
count_age_female_29	count_age_female_157	count_age_female_234	count_age_female_373	count_age_female_469	count_age_female_677		
count_age_female_33	count_age_female_158	count_age_female_235	count_age_female_375	count_age_female_470	count_age_female_678		
count_age_female_34	count_age_female_159	count_age_female_243	count_age_female_376	count_age_female_471	count_age_female_684		
count_age_female_35	count_age_female_163	count_age_female_253	count_age_female_377	count_age_female_472	count_age_female_686		
count_age_female_36	count_age_female_164	count_age_female_254	count_age_female_378	count_age_female_475	count_age_female_687		
count_age_female_37	count_age_female_165	count_age_female_255	count_age_female_379	count_age_female_479	count_age_female_688		
count_age_female_43	count_age_female_167	count_age_female_256	count_age_female_383	count_age_female_489	count_age_female_694		
count_age_female_44	count_age_female_169	count_age_female_258	count_age_female_384	count_age_female_496	count_age_female_695		
count_age_female_45	count_age_female_174	count_age_female_274	count_age_female_385	count_age_female_498	count_age_female_696		
count_age_female_47	count_age_female_176	count_age_female_275	count_age_female_386	count_age_female_503	count_age_female_699		
count_age_female_48	count_age_female_177	count_age_female_276	count_age_female_387	count_age_female_505	count_age_female_706		
count_age_female_53	count_age_female_178	count_age_female_277	count_age_female_389	count_age_female_507	count_age_female_707		
count_age_female_55	count_age_female_183	count_age_female_283	count_age_female_405	count_age_female_508	count_age_female_719		
count_age_female_56	count_age_female_184	count_age_female_303	count_age_female_408	count_age_female_516	count_age_female_733		
count_age_female_57	count_age_female_185	count_age_female_308	count_age_female_415	count_age_female_518	count_age_female_736		
count_age_female_59	count_age_female_186	count_age_female_313	count_age_female_417	count_age_female_523	count_age_female_749		
count_age_female_64	count_age_female_187	count_age_female_315	count_age_female_418	count_age_female_525	count_age_female_757		
count_age_female_65	count_age_female_188	count_age_female_316	count_age_female_423	count_age_female_527	count_age_female_779		
count_age_female_68	count_age_female_189	count_age_female_317	count_age_female_426	count_age_female_533	count_age_female_783		
count_age_female_69	count_age_female_194	count_age_female_318	count_age_female_427	count_age_female_534	count_age_female_785		
count_age_female_73	count_age_female_195	count_age_female_319	count_age_female_433	count_age_female_535	count_age_female_789		
count_age_female_74	count_age_female_198	count_age_female_326	count_age_female_434	count_age_female_536	count_age_female_799		
count_age_female_75	count_age_female_199	count_age_female_328	count_age_female_435	count_age_female_549	count_age_female_803		
count_age_female_76	count_age_female_203	count_age_female_329	count_age_female_436	count_age_female_558	count_age_female_804		
count_age_female_77	count_age_female_204	count_age_female_335	count_age_female_439	count_age_female_563	count_age_female_808		
	
) ;
format femaleocc_age              %18.4f;


/*compute occ shares*/
# delimit ;
foreach num of numlist 
4	78	205	336	444	567	809
7	79	206	337	445	575	813
8	83	207	338	447	577	829
13	84	208	344	448	579	834
14	89	214	346	450	585	844
15	95	217	347	451	593	866
18	96	218	348	453	599	869
19	97	223	354	455	616	875
22	98	224	355	458	628	887
23	103	225	356	459	634	888
24	105	226	357	461	637	889
25	106	227	359	462	653	
26	154	228	364	464	657	
27	155	229	365	466	666	
28	156	233	368	468	675	
29	157	234	373	469	677	
33	158	235	375	470	678	
34	159	243	376	471	684	
35	163	253	377	472	686	
36	164	254	378	475	687	
37	165	255	379	479	688	
43	167	256	383	489	694	
44	169	258	384	496	695	
45	174	274	385	498	696	
47	176	275	386	503	699	
48	177	276	387	505	706	
53	178	277	389	507	707	
55	183	283	405	508	719	
56	184	303	408	516	733	
57	185	308	415	518	736	
59	186	313	417	523	749	
64	187	315	418	525	757	
65	188	316	423	527	779	
68	189	317	426	533	783	
69	194	318	427	534	785	
73	195	319	433	535	789	
74	198	326	434	536	799	
75	199	328	435	549	803	
76	203	329	436	558	804	
77	204	335	439	563	808	
	

	{;
gen female_share_age_`num' = count_age_female_`num'/femaleocc_age  ;
format female_share_age_`num'             %18.4f;
} ;

save "female_counts_age_occ", replace ;


/*Now, we calculate the Classic Duncan-Duncan index in detailed occupations for each five-year birth cohort*/
# delimit ;

clear all;

set more off ;
/*set maxvar 32000 ;*/
cd "C:\Users\cmslo\Box Sync\JEP Replication files" ;

use "female_counts_age_occ" ;

sort age_group ;

merge 1:1 age_group using "male_counts_age_occ" ;

tab _merge ;

gen male_share_age_ = . ;

gen female_share_age_ = . ;

foreach num of numlist
4	78	205	336	444	567	809
7	79	206	337	445	575	813
8	83	207	338	447	577	829
13	84	208	344	448	579	834
14	89	214	346	450	585	844
15	95	217	347	451	593	866
18	96	218	348	453	599	869
19	97	223	354	455	616	875
22	98	224	355	458	628	887
23	103	225	356	459	634	888
24	105	226	357	461	637	889
25	106	227	359	462	653	
26	154	228	364	464	657	
27	155	229	365	466	666	
28	156	233	368	468	675	
29	157	234	373	469	677	
33	158	235	375	470	678	
34	159	243	376	471	684	
35	163	253	377	472	686	
36	164	254	378	475	687	
37	165	255	379	479	688	
43	167	256	383	489	694	
44	169	258	384	496	695	
45	174	274	385	498	696	
47	176	275	386	503	699	
48	177	276	387	505	706	
53	178	277	389	507	707	
55	183	283	405	508	719	
56	184	303	408	516	733	
57	185	308	415	518	736	
59	186	313	417	523	749	
64	187	315	418	525	757	
65	188	316	423	527	779	
68	189	317	426	533	783	
69	194	318	427	534	785	
73	195	319	433	535	789	
74	198	326	434	536	799	
75	199	328	435	549	803	
76	203	329	436	558	804	
77	204	335	439	563	808	

{ ;

gen d_share_`num' = abs(male_share_age_`num' - female_share_age_`num') ;
format d_share_`num'            %18.4f;
} ;

egen dd_index_age_occ = rowtotal(
d_share_4	d_share_78	d_share_205	d_share_336	d_share_444	d_share_567	d_share_809
d_share_7	d_share_79	d_share_206	d_share_337	d_share_445	d_share_575	d_share_813
d_share_8	d_share_83	d_share_207	d_share_338	d_share_447	d_share_577	d_share_829
d_share_13	d_share_84	d_share_208	d_share_344	d_share_448	d_share_579	d_share_834
d_share_14	d_share_89	d_share_214	d_share_346	d_share_450	d_share_585	d_share_844
d_share_15	d_share_95	d_share_217	d_share_347	d_share_451	d_share_593	d_share_866
d_share_18	d_share_96	d_share_218	d_share_348	d_share_453	d_share_599	d_share_869
d_share_19	d_share_97	d_share_223	d_share_354	d_share_455	d_share_616	d_share_875
d_share_22	d_share_98	d_share_224	d_share_355	d_share_458	d_share_628	d_share_887
d_share_23	d_share_103	d_share_225	d_share_356	d_share_459	d_share_634	d_share_888
d_share_24	d_share_105	d_share_226	d_share_357	d_share_461	d_share_637	d_share_889
d_share_25	d_share_106	d_share_227	d_share_359	d_share_462	d_share_653		
d_share_26	d_share_154	d_share_228	d_share_364	d_share_464	d_share_657		
d_share_27	d_share_155	d_share_229	d_share_365	d_share_466	d_share_666		
d_share_28	d_share_156	d_share_233	d_share_368	d_share_468	d_share_675		
d_share_29	d_share_157	d_share_234	d_share_373	d_share_469	d_share_677		
d_share_33	d_share_158	d_share_235	d_share_375	d_share_470	d_share_678		
d_share_34	d_share_159	d_share_243	d_share_376	d_share_471	d_share_684		
d_share_35	d_share_163	d_share_253	d_share_377	d_share_472	d_share_686		
d_share_36	d_share_164	d_share_254	d_share_378	d_share_475	d_share_687		
d_share_37	d_share_165	d_share_255	d_share_379	d_share_479	d_share_688		
d_share_43	d_share_167	d_share_256	d_share_383	d_share_489	d_share_694		
d_share_44	d_share_169	d_share_258	d_share_384	d_share_496	d_share_695		
d_share_45	d_share_174	d_share_274	d_share_385	d_share_498	d_share_696		
d_share_47	d_share_176	d_share_275	d_share_386	d_share_503	d_share_699		
d_share_48	d_share_177	d_share_276	d_share_387	d_share_505	d_share_706		
d_share_53	d_share_178	d_share_277	d_share_389	d_share_507	d_share_707		
d_share_55	d_share_183	d_share_283	d_share_405	d_share_508	d_share_719		
d_share_56	d_share_184	d_share_303	d_share_408	d_share_516	d_share_733		
d_share_57	d_share_185	d_share_308	d_share_415	d_share_518	d_share_736		
d_share_59	d_share_186	d_share_313	d_share_417	d_share_523	d_share_749		
d_share_64	d_share_187	d_share_315	d_share_418	d_share_525	d_share_757		
d_share_65	d_share_188	d_share_316	d_share_423	d_share_527	d_share_779		
d_share_68	d_share_189	d_share_317	d_share_426	d_share_533	d_share_783		
d_share_69	d_share_194	d_share_318	d_share_427	d_share_534	d_share_785		
d_share_73	d_share_195	d_share_319	d_share_433	d_share_535	d_share_789		
d_share_74	d_share_198	d_share_326	d_share_434	d_share_536	d_share_799		
d_share_75	d_share_199	d_share_328	d_share_435	d_share_549	d_share_803		
d_share_76	d_share_203	d_share_329	d_share_436	d_share_558	d_share_804		
d_share_77	d_share_204	d_share_335	d_share_439	d_share_563	d_share_808		
		
) ;

format dd_index_age_occ            %18.4f;

replace dd_index_age_occ = 0.5* dd_index_age_occ ;

keep dd_* age_group ;

gen dd_inverse_age_occ = 1 - dd_index_age_occ ;

/*we now go to browse mode to we can easily copy and paste this data to Excel to make our detailed major series for the inverse Duncan-Duncan: this is the dashed line*/
browse ;
save "age_group_occ_duncan_duncan", replace ;

log close ;


/************Figure 3: Gender Differences in Selected Occupations by Birth Cohort:
The data for these graphs is generated in  this program and is exported to Excel to make into graphs.
x-axis for Figure 3: five-year birth cohort
y-axis for Figure 3: female share/ male share = the count of women in a broad occupation category / the count of men in a broad occupation category 
Panel A: male-dominated occupations of Executives/Managers, Engineers, Sales, Lawyers/Judges, Physicians
Panel B: female-dominated occupations Psychologists, Nurses, Teachers, Health Technicians, Administrative Support
Note: the variable occ_broad identifies our broad occupation categories, the variable age_group identifies our 5-year birth cohorts, the variable wt is our weight variable
*/

# delimit ;
clear all ;

cd "C:\Users\cmslo\Box Sync\JEP Replication files" ;
log using "C:\Users\cmslo\Box Sync\JEP Replication files\replication Figure 3_check.smcl", replace ;
use "main_analysis_file" ;
/*we begin by making some indicator variables to identify the broad occ categories we will use to make Panels A&B of Figure 3*/
gen executives = 0 ;

replace executives = 1 if occ_broad == 1 ;

gen engineers = 0 ;
replace engineers = 1 if occ_broad == 4 ;

gen sales = 0 ;
replace sales = 1 if occ_broad == 20;

gen lawyers = 0 ;
replace lawyers = 1 if occ_broad == 14 ;

gen physicians = 0 ;
replace physicians = 1 if occ_broad == 7 ;

gen psychologists = 0 ;
replace psychologists = 1 if occ_broad == 13 ;

gen nurses = 0 ;
replace nurses = 1 if occ_broad == 8 ;

gen teachers = 0 ;
replace teachers = 1 if occ_broad == 10 ;

gen health_tech = 0 ; 
replace health_tech = 1 if occ_broad == 18 ;

gen admin_support = 0 ; 
replace admin_support = 1 if occ_broad == 21 ;

/*we restrict sample to those with non-missing occupation information*/
keep if occ_broad != . ;

#delimit cr
gen occ_cat = .
replace occ_cat = 1 if executives == 1 
replace occ_cat = 2 if engineers == 1
replace occ_cat = 3 if sales  == 1
replace occ_cat = 4 if lawyers == 1
replace occ_cat = 5 if physicians == 1
replace occ_cat = 6 if psychologists == 1
replace occ_cat = 7 if nurses  == 1
replace occ_cat = 8 if teachers == 1
replace occ_cat = 9 if health_tech == 1 
replace occ_cat = 10 if admin_support== 1

/*Our youngest birth cohort in this series is the 1985 birth cohort, so we start by dropping the 1990 birth cohort (age_group == 25)*/

drop if age_group == 25

/*Panel A: we export these counts to Excel and divide female / male to get our Y-axis for Panel A*/
sort age_group
by age_group: tab male if executives == 1 [aw=wt]
by age_group: tab male if engineers == 1 [aw=wt]
by age_group: tab male if sales  == 1 [aw=wt]
by age_group: tab male if lawyers == 1 [aw=wt]
by age_group: tab male if physicians == 1 [aw=wt]

/*Panel B: we export these counts to Excel and divide female / male to get our Y-axis for Panel B*/
sort age_group
by age_group: tab male if psychologists == 1 [aw=wt]
by age_group: tab male if nurses  == 1 [aw=wt]
by age_group: tab male if teachers  == 1 [aw=wt]
by age_group: tab male if health_tech == 1 [aw=wt] 
by age_group: tab male if admin_support== 1 [aw=wt]

log close


/************Figure 4: Potential Wage Index in Major and Occupation by Cohort:
The data for these graphs is generated in  this program and is exported to Excel to make into graphs.
x-axis for Figure 4: five-year birth cohort
y-axis for Figure 4: potential wage indices for detailed major  (solid line), detailed occupation (dashed line)
Note: 
the variable age_group identifies our 5-year birth cohorts, the variable wt is our weight variable, 
the variable wt_med_wage_nat is our potential wage for majors 
the variable wt_occ_wage_nat  is our potential wage for occupations
the variable potential_major_* is our potential wage index for majors, birth cohort (this is what is graphed on y axis)
the variable wt_occ_wage_nat  is our potential wage for occupations
he variable potential_occ_* is our potential wage index for occupations, birth cohort (this is what is graphed on y axis)


We define our potential wage index as: 


I^{Major}_{c} = \frac{\sum_{m=1}^{M} s^m_{female,c}\bar{Y}^m_{male}}{\sum_{m=1}^{M} s^m_{male,c}  \bar{Y}^m_{male}} -1


In practice, we compute this index by running the following regression locally within 5-year birth cohort $c$:

\bar{Y}^m_{male_{i}} = \alpha + \beta Female_{i} + \Gamma X_{i} + \epsilon_{i}


where $Female_{i}$ is a dummy variable indicating whether the respondent $i$  has self-reported as female and $X_{i}$ is a vector of demographic characteristics: race, state of birth, masters attainment, doctorate attainment, and marital status. Our potential wage index, $I^{Major}_{c}$, is defined as $\beta$ from each local regression by 5-year birth cohort and therefore, measures the differential ``potential'' wage of women of cohort $c$ given that the female distribution of  majors in a given cohort may differ from males in their cohort. The units of this index are differential potential log wage based on major. In computing the comparable index for occupation, we substitute detailed occupation code, $o$, for detailed major code, $m$.

*/

# delimit ;
clear all ;

cd "C:\Users\cmslo\Box Sync\JEP Replication files" ;
log using "C:\Users\cmslo\Box Sync\JEP Replication files\replication Figure 4_check.smcl", replace ;
use "main_analysis_file" ;

/*Potential Wages from Human Capital Specialization*/
#delimit cr

reg  wt_med_wage_nat female i.race i.super_state  i.marst  masters doctorate [aw=wt] if main_sample == 1 & a25 == 1, cluster(super_state) 

gen potential_major_1990	= _b[female] 

reg  wt_med_wage_nat female i.race i.super_state  i.marst  masters doctorate [aw=wt] if main_sample == 1 & a30 == 1, cluster(super_state) 

gen potential_major_1985	= _b[female] 

reg  wt_med_wage_nat female i.race i.super_state  i.marst  masters doctorate  [aw=wt] if main_sample == 1 & a35 == 1, cluster(super_state) 

gen potential_major_1980	= _b[female] 

reg  wt_med_wage_nat female i.race i.super_state  i.marst  masters doctorate  [aw=wt] if main_sample == 1 & a40 == 1, cluster(super_state) 

gen potential_major_1975	= _b[female] 

reg  wt_med_wage_nat female i.race i.super_state  i.marst  masters doctorate [aw=wt] if main_sample == 1 & a45 == 1, cluster(super_state) 

gen potential_major_1970	= _b[female] 

reg  wt_med_wage_nat female i.race i.super_state  i.marst  masters doctorate  [aw=wt] if main_sample == 1 & a50 == 1, cluster(super_state) 

gen potential_major_1965	= _b[female] 

reg  wt_med_wage_nat female i.race i.super_state  i.marst  masters doctorate [aw=wt] if main_sample == 1 & a55 == 1, cluster(super_state) 

gen potential_major_1960	= _b[female] 

reg  wt_med_wage_nat female i.race i.super_state  i.marst  masters doctorate [aw=wt] if main_sample == 1 & a60 == 1, cluster(super_state) 

gen potential_major_1955	= _b[female] 

reg  wt_med_wage_nat female i.race i.super_state  i.marst  masters doctorate  [aw=wt] if main_sample == 1 & a65 == 1, cluster(super_state) 

gen potential_major_1950	= _b[female] 


/*Potential Wages from Occupational Specialization*/


reg  wt_occ_wage_nat female i.race i.super_state  i.marst  masters doctorate [aw=wt] if main_sample == 1 & a25 == 1, cluster(super_state) 

gen potential_occ_1990	= _b[female] 

reg  wt_occ_wage_nat female i.race i.super_state  i.marst  masters doctorate [aw=wt] if main_sample == 1 & a30 == 1, cluster(super_state) 

gen potential_occ_1985	= _b[female] 

reg  wt_occ_wage_nat female i.race i.super_state  i.marst  masters doctorate  [aw=wt] if main_sample == 1 & a35 == 1, cluster(super_state) 

gen potential_occ_1980	= _b[female] 

reg  wt_occ_wage_nat female i.race i.super_state  i.marst  masters doctorate  [aw=wt] if main_sample == 1 & a40 == 1, cluster(super_state) 

gen potential_occ_1975	= _b[female] 

reg  wt_occ_wage_nat female i.race i.super_state  i.marst  masters doctorate [aw=wt] if main_sample == 1 & a45 == 1, cluster(super_state) 

gen potential_occ_1970	= _b[female] 

reg  wt_occ_wage_nat female i.race i.super_state  i.marst  masters doctorate  [aw=wt] if main_sample == 1 & a50 == 1, cluster(super_state) 

gen potential_occ_1965	= _b[female] 

reg  wt_occ_wage_nat female i.race i.super_state  i.marst  masters doctorate [aw=wt] if main_sample == 1 & a55 == 1, cluster(super_state) 

gen potential_occ_1960	= _b[female] 

reg  wt_occ_wage_nat female i.race i.super_state  i.marst  masters doctorate [aw=wt] if main_sample == 1 & a60 == 1, cluster(super_state) 

gen potential_occ_1955	= _b[female] 

reg  wt_occ_wage_nat female i.race i.super_state  i.marst  masters doctorate  [aw=wt] if main_sample == 1 & a65 == 1, cluster(super_state) 

gen potential_occ_1950	= _b[female] 

/*here, we just collapse so we have an easy file with just our potential wage indices to copy and paste into Excel-- it reads wide */
gen sample = 1 
collapse (mean) potential* [aw=wt], by(sample)

/*here, we go to browse mode so we can easily copy and paste to Excel*/
browse
log close 

/***************************************************************************************************************************************************************/
/************Figure 5: Cross-Major Variation in Within-Major Gender Differences in Occupational Concentration, 1968-1977 Birth Cohort:

Panel A: Gender Composition of the Majors
Panel B: Potential Income of the Major

the variable herf_index_major  is our Herfindahl-Hirschman Index 
*/


/* We begin by calculating the Herfindahl-Hirschman Index in all of our detailed major categories 
We calculate this index by: (1) calculating the share employed in an occupation of the relevant gender-major-cohort group, (2) squaring those shares, and (3) summing up over all occupations. 
Then, we graph Panel A and Panel B
*/


/****************This part generates the Herfindahl Indices of Occupational Concentrations in Majors for the 1968-1977 Birth cohort**************************************************/


/*Men*/
# delimit cr
clear all 

cd "C:\Users\cmslo\Box Sync\JEP Replication files" 
log using "C:\Users\cmslo\Box Sync\JEP Replication files\replication Figure 5_check.smcl", replace 
use "main_analysis_file"
keep if wt_med_broad_wage_nat != . & wt_occ_broad_wage_nat != .

#delimit ;
drop if male == 0 ;
keep if a45 == 1 | a40 == 1 ;
gen count_major_occ_ = 1;
						
format count_major_occ_              %18.4f;

# delimit ;
collapse (sum) count_major_occ_  [pw=wt], by (major occ_broad) ;

reshape wide count_major_occ_  , i(major) j(occ_broad) ;

save "major_occ_counts_male_1968_1977", replace ;

# delimit cr
clear all 

cd "C:\Users\cmslo\Box Sync\JEP Replication files" 

use "main_analysis_file"
keep if wt_med_broad_wage_nat != . & wt_occ_broad_wage_nat != .

#delimit ;
drop if male == 0 ;
keep if a45 == 1 | a40 == 1 ;
gen count_major = 1;
						
format count_major             %18.4f;

# delimit ;
collapse (sum) count_major [pw=wt], by (major ) ;

save "major_counts_male_1968_1977", replace ;

# delimit cr
clear all 

cd "C:\Users\cmslo\Box Sync\JEP Replication files" 

use "major_occ_counts_male_1968_1977"

sort major

merge 1:1 major using "major_counts_male_1968_1977"
drop _merge

/*compute major shares*/
# delimit ;
foreach num of numlist 
1	16	31
2	17	32
3	18	33
4	19	34
5	20	35
6	21	36
7	22	37
8	23	38
9	24	
10	25	
11	26	
12	27	
13	28	
14	29	
15	30	


	{;
gen occ_share_`num' =  	(count_major_occ_`num'/count_major) ;
gen occ_share_major_`num' = occ_share_`num' ^2  ;
format occ_share_major_`num'             %18.4f;
} ;


egen herf_index_major = rowtotal(
	
occ_share_major_1	occ_share_major_16	occ_share_major_31
occ_share_major_2	occ_share_major_17	occ_share_major_32
occ_share_major_3	occ_share_major_18	occ_share_major_33
occ_share_major_4	occ_share_major_19	occ_share_major_34
occ_share_major_5	occ_share_major_20	occ_share_major_35
occ_share_major_6	occ_share_major_21	occ_share_major_36
occ_share_major_7	occ_share_major_22	occ_share_major_37
occ_share_major_8	occ_share_major_23	occ_share_major_38
occ_share_major_9	occ_share_major_24		
occ_share_major_10	occ_share_major_25		
occ_share_major_11	occ_share_major_26		
occ_share_major_12	occ_share_major_27		
occ_share_major_13	occ_share_major_28		
occ_share_major_14	occ_share_major_29		
occ_share_major_15	occ_share_major_30		

) ;

format herf_index_major            %18.4f;

keep major herf_index_major  ;
gen sex = 1;
save "male_herfindahl_index_broad_occ_1968_1977", replace ;

/*Women*/
# delimit cr
clear all 

cd "C:\Users\cmslo\Box Sync\JEP Replication files" 

use "main_analysis_file"
keep if wt_med_broad_wage_nat != . & wt_occ_broad_wage_nat != .

#delimit ;
drop if male == 1 ;
keep if a45 == 1 | a40 == 1;
gen count_major_occ_ = 1;
						
format count_major_occ_              %18.4f;

# delimit ;
collapse (sum) count_major_occ_  [pw=wt], by (major occ_broad) ;

reshape wide count_major_occ_  , i(major) j(occ_broad) ;

save "major_occ_counts_female_1968_1977", replace ;

# delimit cr
clear all 

cd "C:\Users\cmslo\Box Sync\JEP Replication files" 

use "main_analysis_file"
keep if wt_med_broad_wage_nat != . & wt_occ_broad_wage_nat != .

#delimit ;
drop if male == 1 ;
keep if a45 == 1 | a40 == 1;
gen count_major = 1;
						
format count_major             %18.4f;

# delimit ;
collapse (sum) count_major [pw=wt], by (major ) ;

save "major_counts_female_1968_1977", replace ;

# delimit cr
clear all 

cd "C:\Users\cmslo\Box Sync\JEP Replication files" 

use "major_occ_counts_female_1968_1977"

sort major

merge 1:1 major using "major_counts_female_1968_1977"
drop _merge

/*compute major shares*/
# delimit ;
foreach num of numlist 
1	16	31
2	17	32
3	18	33
4	19	34
5	20	35
6	21	36
7	22	37
8	23	38
9	24	
10	25	
11	26	
12	27	
13	28	
14	29	
15	30	

	{;
gen occ_share_`num' =  	(count_major_occ_`num'/count_major) ;
gen occ_share_major_`num' = occ_share_`num' ^2  ;
format occ_share_major_`num'             %18.4f;
} ;


egen herf_index_major = rowtotal(
	
occ_share_major_1	occ_share_major_16	occ_share_major_31
occ_share_major_2	occ_share_major_17	occ_share_major_32
occ_share_major_3	occ_share_major_18	occ_share_major_33
occ_share_major_4	occ_share_major_19	occ_share_major_34
occ_share_major_5	occ_share_major_20	occ_share_major_35
occ_share_major_6	occ_share_major_21	occ_share_major_36
occ_share_major_7	occ_share_major_22	occ_share_major_37
occ_share_major_8	occ_share_major_23	occ_share_major_38
occ_share_major_9	occ_share_major_24		
occ_share_major_10	occ_share_major_25		
occ_share_major_11	occ_share_major_26		
occ_share_major_12	occ_share_major_27		
occ_share_major_13	occ_share_major_28		
occ_share_major_14	occ_share_major_29		
occ_share_major_15	occ_share_major_30		

) ;

format herf_index_major            %18.4f;
keep major herf_index_major  ;
gen sex = 2 ;

save "female_herfindahl_index_broad_occ_1968_1977", replace ;

# delimit cr
clear all 

cd "C:\Users\cmslo\Box Sync\JEP Replication files" 

use "male_herfindahl_index_broad_occ_1968_1977"

append using "female_herfindahl_index_broad_occ_1968_1977"


save "herfindahl_indices_1968_1977" , replace

/****************Now, we graph Panel A******************************************/


#delimit ;
clear all ;
cd "C:\Users\cmslo\Box Sync\JEP Replication files" ;
use "main_analysis_file"  ;

keep if wt_occ_wage_nat != . &  wt_med_wage_nat != . ;
keep if a45 == 1 | a40 == 1 ;
drop if major == 6104 ;
gen size = 1 ;
collapse (mean) wt_med_wage_nat wt_occ_wage_nat (sum)size [aw=wt], by (sex major) ; 

sort major sex;

merge m:m major sex using "herfindahl_indices_1968_1977" ;
drop if _merge != 3 ;
drop _merge ;


reshape wide wt_med_wage_nat wt_occ_wage_nat size herf_index_major, i(major) j(sex) ;

gen herf_diff = herf_index_major2 - herf_index_major1 ;
drop if herf_diff == . ;
rename wt_med_wage_nat1 potential_wage_major ;

gen size = size1 + size2 ;
drop if size == . ;
gen msize_ratio = size1/size ;
format msize_ratio %6.4f ;
gen fsize_ratio = size2/size ;
format fsize_ratio %6.4f ;
gen share_diff =  fsize_ratio  - msize_ratio ;
format share_diff %6.4f ;



# delimit cr 
reg herf_diff share_diff [aw=size]
egen sd_x1 = sd(share_diff)
egen sd_y1 = sd(herf_diff)
gen scale1 = sd_x1/sd_y1
local b1 = string(_b[share_diff], "%6.4f") 
local s1 = string(_se[share_diff], "%6.4f") 
gen standard1 = scale1*`b1'
local x1 = string(standard1, "%6.4f")
#delimit ;
gen large_majors = 0 ;
foreach num of numlist
23 24 34 36 52 55 56 61 62{;
replace large_majors = 1 if major == `num' ;
} ;

# delimit ;
twoway ///
(lfit herf_diff share_diff [aw=size], lcolor(maroon) lwidth(thick))
(scatter herf_diff share_diff [aw=size], msymbol(circle) mlcolor(blue%50) mfcolor(none))
,legend(off)  xtitle(Female - Male Share Major) ytitle(Female - Male HHI Occupation)
graphregion(color(white) margin(medlarge)) plotregion(fcolor(white) style(none)) ;
	  
graph export "HHI_major_female_dominated.pdf", replace ; 

/****************Now, we graph Panel B******************************************/


#delimit ;
clear all ;
cd "C:\Users\cmslo\Box Sync\JEP Replication files"  ;
use "main_analysis_file"  ;

keep if wt_occ_wage_nat != . &  wt_med_wage_nat != . ;
keep if a45 == 1 | a40 == 1 ;
drop if major == 6104 ;
gen size = 1 ;
collapse (mean) wt_med_wage_nat wt_occ_wage_nat (sum)size [aw=wt], by (sex major) ; 

sort major sex;

merge m:m major sex using "herfindahl_indices_1968_1977" ;
drop if _merge != 3 ;
drop _merge ;


reshape wide wt_med_wage_nat wt_occ_wage_nat size herf_index_major, i(major) j(sex) ;

gen herf_diff = herf_index_major2 - herf_index_major1 ;
drop if herf_diff == . ;
rename wt_med_wage_nat1 potential_wage_major ;

gen size = size1 + size2 ;
drop if size == . ;

/*Male - Female Differences in Potential  on Potential Wage based on Major*/

# delimit cr 
reg herf_diff potential_wage_major [aw=size]
egen sd_x1 = sd(potential_wage_major)
egen sd_y1 = sd(herf_diff)
gen scale1 = sd_x1/sd_y1
local b1 = string(_b[potential_wage_major], "%6.4f") 
local s1 = string(_se[potential_wage_major], "%6.4f") 
gen standard1 = scale1*`b1'
local x1 = string(standard1, "%6.4f")
#delimit ;
gen large_majors = 0 ;
foreach num of numlist
23 24 34 36 52 55 56 61 62{;
replace large_majors = 1 if major == `num' ;
} ;

# delimit ;
twoway ///
(lfit herf_diff potential_wage_major [aw=size], lcolor(maroon) lwidth(thick))
(scatter herf_diff potential_wage_major [aw=size], msymbol(circle) mlcolor(blue%50) mfcolor(none))
,legend(off)  xtitle(Potential Wage Based on Major) ytitle(Female - Male HHI Occupation)
  graphregion(color(white) margin(medlarge)) plotregion(fcolor(white) style(none)) ;
	  
graph export "HHI_major_income.pdf", replace ; 
log close ;

/***************************************************************************************************************************************************************/
/************Figure 6: Within-Major Gender Differences in Potential Wage by Occupation, by Gender and Cohort:



The data for these graphs is generated in  this program and is exported to Excel to make into graphs.
x-axis for Figure 6: five-year birth cohort
y-axis for Figure 6: female - male mean potential occupational wage
Panel A: male-dominated majors of Biology/Life Sciences, Business, History, Physical Sciences, Engineering
Panel B: female-dominated majors Nursing/ Pharmacy, Education, Psychology, Foreign Language, Fine Arts
Note: the variable major_broad identifies our broad major categories, the variable age_group identifies our 5-year birth cohorts, the variable wt is our weight variable
wt_occ_wage_nat is our potential occupational wage variable

****************/

#delimit ;
clear all ;

cd "C:\Users\cmslo\Box Sync\JEP Replication files" ;
log using "C:\Users\cmslo\Box Sync\JEP Replication files\replication Figure 6_check.smcl", replace ;
use "main_analysis_file" ;

gen engineering = 0 ;

replace engineering = 1 if major_broad == 24 ;

gen biology = 0 ;
replace biology = 1 if major_broad == 36 ;

gen physical_sciences = 0 ;
replace physical_sciences = 1 if major_broad == 50 ;

gen business = 0 ;
replace business = 1 if major_broad == 62 ;

gen history = 0 ;
replace history = 1 if major_broad == 64 ;

gen education = 0 ;
replace education = 1 if major_broad == 23 ;

gen psychology = 0 ;
replace psychology = 1 if major_broad == 52 ;

gen fine_arts = 0 ;
replace fine_arts = 1 if major_broad == 60 ;

gen medical = 0 ;
replace medical = 1 if major_broad == 61 ;

gen languages = 0 ;
replace languages = 1 if major_broad == 26 ;

keep if major != . ;

#delimit cr
gen major_cat = .
replace major_cat = 1 if engineering == 1 
replace major_cat = 2 if biology == 1
replace major_cat = 3 if physical_sciences == 1
replace major_cat = 4 if business == 1
replace major_cat = 5 if history == 1
replace major_cat = 6 if education == 1
replace major_cat = 7 if psychology == 1
replace major_cat = 8 if fine_arts == 1
replace major_cat = 9 if medical == 1 
replace major_cat = 10 if languages == 1

label var major_cat      `"major name"'
label define major_cat_lbl 1 `"engineering"'
label define major_cat_lbl 2 `"biology"', add
label define major_cat_lbl 3 `"physical sciences"', add
label define major_cat_lbl 4 `"business"', add
label define major_cat_lbl 5 `"history"', add
label define major_cat_lbl 6 `"education"', add
label define major_cat_lbl 7 `"psychology"', add
label define major_cat_lbl 8 `"fine arts"', add
label define major_cat_lbl 9 `"medical"', add
label define major_cat_lbl 10 `"languages"', add
label values major_cat major_cat_lbl


#delimit ;
collapse (mean ) wt_occ_wage_nat [pw=wt], by(age_group sex major_cat) ;

drop if major_cat == . ;

/*now, we go to browse mode so we can easily copy and paste data to Excel to make the graphs*/

browse ;

/*Note: In excel, we subtract female- male values of wt_occ_wage_nat to get our y-axis */

log close ;


/***********************************************************************************************************************************************************************************/
/********************************************TABLES********************************************************************************************************************************/

/************Table 1:  Gender Differences in Occupation, Selected Majors, 1968-1977 Birth Cohort:

Values are calculated here for the table and then copy and pasted into our Overleaf table.
We begin with Columns 1-4
Then, we calculate broad HHI values for the 1968-1977 birth cohort for each gender-- this is our Column 5

****************/
/*******************************************************COLUMNS 1-4*********************************/
# delimit ;
clear all ;

cd "C:\Users\cmslo\Box Sync\JEP Replication files" ;
log using "C:\Users\cmslo\Box Sync\JEP Replication files\replication Table 1_check.smcl", replace ;
use "main_analysis_file" ;
/*we begin by making some indicator variables to identify the broad occ categories*/

gen teachers = 0 ;
replace teachers = 1 if occ_broad == 10 ;

gen executives = 0 ;
replace executives = 1 if occ_broad == 1 ;

gen sales = 0 ;
replace sales = 1 if occ_broad == 20;

gen admin_support = 0 ; 
replace admin_support = 1 if occ_broad == 21 ;

gen nurses = 0 ;
replace nurses = 1 if occ_broad == 8 ;

gen health_tech = 0 ; 
replace health_tech = 1 if occ_broad == 18 ;

gen lawyers = 0 ;
replace lawyers = 1 if occ_broad == 14 ;

gen accountants = 0 ;
replace accountants = 1 if occ_broad == 2 ;

gen other_tech = 0 ; 
replace other_tech = 1 if occ_broad == 19 ;

gen engineers = 0 ;
replace engineers = 1 if occ_broad == 4 ;

gen architect = 0 ; 
replace architect  = 1 if occ_broad == 5 ;

gen scientists = 0 ;
replace scientists = 1 if occ_broad == 6 ;

gen physicians = 0 ;
replace physicians = 1 if occ_broad == 7 ;


gen psychologists = 0 ;
replace psychologists = 1 if occ_broad == 13 ;



/*we restrict sample to those with non-missing occupation information*/
keep if occ_broad != . ;

#delimit cr
gen occ_cat = .
replace occ_cat = 1 if teachers == 1 
replace occ_cat = 2 if executives == 1
replace occ_cat = 3 if sales  == 1
replace occ_cat = 4 if admin_support == 1
replace occ_cat = 5 if nurses == 1
replace occ_cat = 6 if health_tech == 1
replace occ_cat = 7 if lawyers  == 1
replace occ_cat = 8 if accountants == 1
replace occ_cat = 9 if other_tech == 1 
replace occ_cat = 10 if engineers == 1
replace occ_cat = 11 if architect  == 1
replace occ_cat = 12 if scientists  == 1
replace occ_cat = 13 if physicians == 1 
replace occ_cat = 14 if psychologists == 1

label var occ_cat      `"occ name"'
label define occ_cat_lbl 1 `"teachers"'
label define occ_cat_lbl 2 `"executives"', add
label define occ_cat_lbl 3 `"sales"', add
label define occ_cat_lbl 4 `"admin_support"', add
label define occ_cat_lbl 5 `"nurses"', add
label define occ_cat_lbl 6 `"health_tech"', add
label define occ_cat_lbl 7 `"lawyers"', add
label define occ_cat_lbl 8 `"accountants"', add
label define occ_cat_lbl 9 `"other_tech"', add
label define occ_cat_lbl 10 `"engineers"', add
label define occ_cat_lbl 11 `"architect"', add
label define occ_cat_lbl 12 `"scientists"', add
label define occ_cat_lbl 13 `"physicians"', add
label define occ_cat_lbl 14 `"psychologists"', add
label values occ_cat occ_cat_lbl

/*we now make some indicator variables to identify the broad major categories */
#delimit ;
gen education = 0 ;
replace education = 1 if major_broad == 23 ;

gen medical = 0 ; /*This is our Nursing/Pharmacy major*/
replace medical = 1 if major_broad == 61 ;

gen social_sciences = 0 ; 
replace social_sciences = 1 if major_broad == 55 ;

gen business = 0 ;
replace business = 1 if major_broad == 62 ;

gen engineering = 0 ;
replace engineering = 1 if major_broad == 24 ;

gen biology = 0 ;
replace biology = 1 if major_broad == 36 ;

gen physical_sciences = 0 ;
replace physical_sciences = 1 if major_broad == 50 ;


gen psychology = 0 ;
replace psychology = 1 if major_broad == 52 ;


keep if major != . ;

#delimit cr
gen major_cat = .
replace major_cat = 1 if education == 1 
replace major_cat = 2 if medical == 1
replace major_cat = 3 if social_science == 1
replace major_cat = 4 if business == 1
replace major_cat = 5 if engineering == 1
replace major_cat = 6 if biology == 1
replace major_cat = 7 if physical_sciences == 1
replace major_cat = 8 if psychology == 1

label var major_cat      `"major name"'
label define major_cat_lbl 1 `"education"'
label define major_cat_lbl 2 `"nursing/pharm"', add
label define major_cat_lbl 3 `"social sciences"', add
label define major_cat_lbl 4 `"business"', add
label define major_cat_lbl 5 `"engineering"', add
label define major_cat_lbl 6 `"biology"', add
label define major_cat_lbl 7 `"physical_sciences"', add
label define major_cat_lbl 8 `"psychology"', add

label values major_cat major_cat_lbl

/*This table only uses data for the 10-year birth cohort from 1968-1977*/

keep if a45 == 1 | a40 == 1 

/***********Here, we summarize the information for Columns 1-4 of Table 1. The "Percent" column for each gender gets pasted into our Overleaf table */

/*Panel A: Columns 1-4*/
sort male
by male: tab occ_cat if education == 1 [aw=wt], m /*we pull the "percent" data here for: teachers (column 1), executives (column 2), sales (column 3). admin_support (column 4)*/

/*Panel B: Columns 1-4*/
sort male
by male: tab occ_cat if medical == 1 [aw=wt], m /*we pull the "percent" data here for: nurses (column 1), executives (column 2), sales (column 3), health_tech (column 4)*/

/*Panel C: Columns 1-4*/
sort male
by male: tab occ_cat if social_sciences == 1 [aw=wt], m /*we pull the "percent" data here for: executives(column 1), sales (column 2), lawyers (column 3), admin_support (column 4)*/

/*Panel D: Columns 1-4*/
sort male
by male: tab occ_cat if business== 1 [aw=wt], m /*we pull the "percent" data here for: executives(column 1), sales (column 2), accountants (column 3), admin_support (column 4)*/

/*Panel E: Columns 1-4*/
sort male
by male: tab occ_cat if engineering == 1  [aw=wt], m /*we pull the "percent" data here for: executives(column 1), engineers (column 2), other_tech (column 3), architect (column 4)*/

/*Panel F: Columns 1-4*/
sort male
by male: tab occ_cat if biology == 1  [aw=wt], m /*we pull the "percent" data here for: physicians (column 1), executives (column 2), scientists (column 3), sales (column 4)*/

/*Panel G: Columns 1-4*/
sort male
by male: tab occ_cat if physical_sciences == 1 [aw=wt], m /*we pull the "percent" data here for: executives (column 1), scientists (column 2), physicians (column 3), sales (column 4)*/


/*Panel H: Columns 1-4*/
sort male
by male: tab occ_cat if psychology == 1 [aw=wt], m /*we pull the "percent" data here for: executives (column 1), teachers (column 2), sales (column 3), psychologists (column 4)*/

/************************************COLUMN 5********************************************************/

/***************Now, we calculate the HHI broad indices for each gender for the 1968-1977 BC************/

/*Men*/
# delimit cr
clear all 

cd "C:\Users\cmslo\Box Sync\JEP Replication files"

use "main_analysis_file"
keep if wt_med_broad_wage_nat != . & wt_occ_broad_wage_nat != .

#delimit ;
drop if male == 0 ;
keep if a45 == 1 | a40 == 1 ;
gen count_major_broad_occ_ = 1;
						
format count_major_broad_occ_              %18.4f;

# delimit ;
collapse (sum) count_major_broad_occ_  [pw=wt], by (major_broad occ_broad) ;

reshape wide count_major_broad_occ_  , i(major_broad) j(occ_broad) ;

save "major_broad_occ_counts_male_1968_1977", replace ;

# delimit cr
clear all 

cd "C:\Users\cmslo\Box Sync\JEP Replication files"

use "main_analysis_file"
keep if wt_med_broad_wage_nat != . & wt_occ_broad_wage_nat != .

#delimit ;
drop if male == 0 ;
keep if a45 == 1 | a40 == 1 ;
gen count_major_broad = 1;
						
format count_major_broad             %18.4f;

# delimit ;
collapse (sum) count_major_broad [pw=wt], by (major_broad ) ;

save "major_broad_counts_male_1968_1977", replace ;

# delimit cr
clear all 

cd "C:\Users\cmslo\Box Sync\JEP Replication files"

use "major_broad_occ_counts_male_1968_1977"

sort major_broad

merge 1:1 major_broad using "major_broad_counts_male_1968_1977"
drop _merge

/*compute major_broad shares*/
# delimit ;
foreach num of numlist 
1	16	31
2	17	32
3	18	33
4	19	34
5	20	35
6	21	36
7	22	37
8	23	38
9	24	
10	25	
11	26	
12	27	
13	28	
14	29	
15	30	


	{;
gen occ_share_`num' =  	(count_major_broad_occ_`num'/count_major_broad) ;
gen occ_share_major_broad_`num' = occ_share_`num' ^2  ;
format occ_share_major_broad_`num'             %18.4f;
} ;


egen herf_index_major_broad = rowtotal(
	
occ_share_major_broad_1	occ_share_major_broad_16	occ_share_major_broad_31
occ_share_major_broad_2	occ_share_major_broad_17	occ_share_major_broad_32
occ_share_major_broad_3	occ_share_major_broad_18	occ_share_major_broad_33
occ_share_major_broad_4	occ_share_major_broad_19	occ_share_major_broad_34
occ_share_major_broad_5	occ_share_major_broad_20	occ_share_major_broad_35
occ_share_major_broad_6	occ_share_major_broad_21	occ_share_major_broad_36
occ_share_major_broad_7	occ_share_major_broad_22	occ_share_major_broad_37
occ_share_major_broad_8	occ_share_major_broad_23	occ_share_major_broad_38
occ_share_major_broad_9	occ_share_major_broad_24		
occ_share_major_broad_10	occ_share_major_broad_25		
occ_share_major_broad_11	occ_share_major_broad_26		
occ_share_major_broad_12	occ_share_major_broad_27		
occ_share_major_broad_13	occ_share_major_broad_28		
occ_share_major_broad_14	occ_share_major_broad_29		
occ_share_major_broad_15	occ_share_major_broad_30		

) ;

format herf_index_major_broad            %18.4f;

gen sex = 1 ;
save "male_broad_herfindahl_index_1968_1977", replace ;

/*Women*/
# delimit cr
clear all 

cd "C:\Users\cmslo\Box Sync\JEP Replication files"

use "main_analysis_file"
keep if wt_med_broad_wage_nat != . & wt_occ_broad_wage_nat != .

#delimit ;
drop if male == 1 ;
keep if a45 == 1 | a40 == 1;
gen count_major_broad_occ_ = 1;
						
format count_major_broad_occ_              %18.4f;

# delimit ;
collapse (sum) count_major_broad_occ_  [pw=wt], by (major_broad occ_broad) ;

reshape wide count_major_broad_occ_  , i(major_broad) j(occ_broad) ;

save "major_broad_occ_counts_female_1968_1977", replace ;

# delimit cr
clear all 

cd "C:\Users\cmslo\Box Sync\JEP Replication files"

use "main_analysis_file"
keep if wt_med_broad_wage_nat != . & wt_occ_broad_wage_nat != .

#delimit ;
drop if male == 1 ;
keep if a45 == 1 | a40 == 1;
gen count_major_broad = 1;
						
format count_major_broad             %18.4f;

# delimit ;
collapse (sum) count_major_broad [pw=wt], by (major_broad ) ;

save "major_broad_counts_female_1968_1977", replace ;

# delimit cr
clear all 

cd "C:\Users\cmslo\Box Sync\JEP Replication files"

use "major_broad_occ_counts_female_1968_1977"

sort major_broad

merge 1:1 major_broad using "major_broad_counts_female_1968_1977"
drop _merge

/*compute major_broad shares*/
# delimit ;
foreach num of numlist 
1	16	31
2	17	32
3	18	33
4	19	34
5	20	35
6	21	36
7	22	37
8	23	38
9	24	
10	25	
11	26	
12	27	
13	28	
14	29	
15	30	

	{;
gen occ_share_`num' =  	(count_major_broad_occ_`num'/count_major_broad) ;
gen occ_share_major_broad_`num' = occ_share_`num' ^2  ;
format occ_share_major_broad_`num'             %18.4f;
} ;


egen herf_index_major_broad = rowtotal(
	
occ_share_major_broad_1	occ_share_major_broad_16	occ_share_major_broad_31
occ_share_major_broad_2	occ_share_major_broad_17	occ_share_major_broad_32
occ_share_major_broad_3	occ_share_major_broad_18	occ_share_major_broad_33
occ_share_major_broad_4	occ_share_major_broad_19	occ_share_major_broad_34
occ_share_major_broad_5	occ_share_major_broad_20	occ_share_major_broad_35
occ_share_major_broad_6	occ_share_major_broad_21	occ_share_major_broad_36
occ_share_major_broad_7	occ_share_major_broad_22	occ_share_major_broad_37
occ_share_major_broad_8	occ_share_major_broad_23	occ_share_major_broad_38
occ_share_major_broad_9	occ_share_major_broad_24		
occ_share_major_broad_10	occ_share_major_broad_25		
occ_share_major_broad_11	occ_share_major_broad_26		
occ_share_major_broad_12	occ_share_major_broad_27		
occ_share_major_broad_13	occ_share_major_broad_28		
occ_share_major_broad_14	occ_share_major_broad_29		
occ_share_major_broad_15	occ_share_major_broad_30		

) ;

format herf_index_major_broad            %18.4f;

gen sex = 2;
save "female_broad_herfindahl_index_1968_1977", replace ;

# delimit cr
clear all 

cd "C:\Users\cmslo\Box Sync\JEP Replication files" 

use "male_broad_herfindahl_index_1968_1977"

append using "female_broad_herfindahl_index_1968_1977"

/*we now make some indicator variables to identify the broad major categories */
#delimit ;
gen education = 0 ;
replace education = 1 if major_broad == 23 ;

gen medical = 0 ; /*This is our Nursing/Pharmacy major*/
replace medical = 1 if major_broad == 61 ;

gen social_sciences = 0 ; 
replace social_sciences = 1 if major_broad == 55 ;

gen business = 0 ;
replace business = 1 if major_broad == 62 ;

gen engineering = 0 ;
replace engineering = 1 if major_broad == 24 ;

gen biology = 0 ;
replace biology = 1 if major_broad == 36 ;

gen physical_sciences = 0 ;
replace physical_sciences = 1 if major_broad == 50 ;


gen psychology = 0 ;
replace psychology = 1 if major_broad == 52 ;


keep if major != . ;

#delimit cr
gen major_cat = .
replace major_cat = 1 if education == 1 
replace major_cat = 2 if medical == 1
replace major_cat = 3 if social_science == 1
replace major_cat = 4 if business == 1
replace major_cat = 5 if engineering == 1
replace major_cat = 6 if biology == 1
replace major_cat = 7 if physical_sciences == 1
replace major_cat = 8 if psychology == 1

label var major_cat      `"major name"'
label define major_cat_lbl 1 `"education"'
label define major_cat_lbl 2 `"nursing/pharm"', add
label define major_cat_lbl 3 `"social sciences"', add
label define major_cat_lbl 4 `"business"', add
label define major_cat_lbl 5 `"engineering"', add
label define major_cat_lbl 6 `"biology"', add
label define major_cat_lbl 7 `"physical_sciences"', add
label define major_cat_lbl 8 `"psychology"', add

label values major_cat major_cat_lbl

/*Here, we report the HHI indices by gender. These become Column 5 of Table 1 and are pasted into our Overleaf document
****Note**** all male values (sex == 1) are reported first for each major and then all female values (sex == 2) are reported for each major */
sort sex major_cat 

by sex major_cat: sum herf_index_major_broad if major_cat != .

save "herfindahl_indices_broad_1968_1977" , replace

log close


/************Table 2:  Gender Differences in Major, Occupation and Gender Gaps in Wages :

This table reports our OLS regressions.

Specifically, we estimate regressions of the following form:


ln(Wage)_{i} = \alpha + \beta Female_{i} + \delta_m Major_{i} + \delta_o Occ_{i} + \Gamma X_{i} + \epsilon_{i}


where $ln(Wage)_{i}$ is a measure of individual {i}'s log wage and $Female_{i}$ is a dummy variable equal to 1 if the individual is female. Our estimated variable of interest is $\beta$ that measures the gender gap in log wages. $Major_{i}$ and $Occ_{i}$ are summary measures of the individual's chosen undergraduate major and observed occupation. We summarize an individual's major and occupation choice with the potential log wage variables $\bar{Y}^m_{i}$ and  $\bar{Y}^o_{i}$.  In all specifications, we include a vector of demographic controls summarized in the vector $X_{i}$. Specifically, we control for five-year birth cohort, race, state of residence, educational attainment beyond bachelor's, survey year, and marital status. Standard errors are clustered by state of residence.

Note: wt_med_wage_nat is our potential wage based on major variable, wt_occ_wage_nat is our potential wage based on occupation variable
wt is our weight variable
a* are five-year birth cohort indicator variables
masters and doctorate are indicator variables indicating attainment of a masters (doctorate) degree

****************/
/**********************************************PANEL A*********************************/

# delimit cr
clear all 

cd "C:\Users\cmslo\Box Sync\JEP Replication files" 
log using "C:\Users\cmslo\Box Sync\JEP Replication files\replication Table 2_check.smcl", replace 
use "main_analysis_file"

/*Panel A: Columns 1-4*/

/*Column 1 (Demographic Controls Only)*/

reg actual_wage female i.race i.super_state a25 a30 a35 a40  a50 a55 a60 a65 i.marst masters doctorate i.year [aw=wt] if wt_med_wage_nat != . & wt_occ_wage_nat != . , cluster(super_state)

/*Column 2 (Demographic Controls & Major)*/

reg actual_wage female i.race i.super_state a25 a30 a35 a40  a50 a55 a60 a65 i.marst masters doctorate i.year wt_med_wage_nat [aw=wt] if wt_med_wage_nat != . & wt_occ_wage_nat != . , cluster(super_state)

/*Column 3 (Demographic Controls & Occupation)*/

reg actual_wage female i.race i.super_state a25 a30 a35 a40  a50 a55 a60 a65 i.marst masters doctorate i.year wt_occ_wage_nat [aw=wt] if wt_med_wage_nat != . & wt_occ_wage_nat != . , cluster(super_state)

/*Column 4 (Demographic Controls & Major & Occupation)*/

reg actual_wage female i.race i.super_state a25 a30 a35 a40  a50 a55 a60 a65 i.marst masters doctorate i.year wt_med_wage_nat wt_occ_wage_nat [aw=wt] if wt_med_wage_nat != . & wt_occ_wage_nat != . , cluster(super_state)

/**********************************************PANEL B*********************************/

/*Columns 1-3 1958-1967 Birth Cohorts*/
#delimit cr
clear all
cd "C:\Users\cmslo\Box Sync\JEP Replication files" 
use "main_analysis_file"
keep if a55 == 1 | a50 == 1

/*Column 1 (Demographic Controls Only)*/

reg actual_wage female i.age i.race i.super_state  i.marst masters doctorate i.year [aw=wt] if wt_med_wage_nat != . & wt_occ_wage_nat != . , cluster(super_state)

/*Column 2 (Demographic Controls & Occupation)*/

reg actual_wage female i.age i.race i.super_state  i.marst masters doctorate i.year wt_occ_wage_nat [aw=wt] if wt_med_wage_nat != . & wt_occ_wage_nat != . , cluster(super_state)

/*Column 3 (Demographic Controls & Major & Occupation)*/

reg actual_wage female i.age i.race i.super_state i.marst masters doctorate i.year wt_med_wage_nat wt_occ_wage_nat [aw=wt] if wt_med_wage_nat != . & wt_occ_wage_nat != . , cluster(super_state)

/*Columns 4-6 1978-1987 Birth Cohorts*/
#delimit cr
clear all
cd "C:\Users\cmslo\Box Sync\JEP Replication files" 
use "main_analysis_file"
keep if a35 == 1 | a30 == 1

/*Column 4 (Demographic Controls Only)*/

reg actual_wage female i.age i.race i.super_state  i.marst masters doctorate i.year [aw=wt] if wt_med_wage_nat != . & wt_occ_wage_nat != . , cluster(super_state)

/*Column 5 (Demographic Controls & Occupation)*/

reg actual_wage female i.age i.race i.super_state  i.marst masters doctorate i.year wt_occ_wage_nat [aw=wt] if wt_med_wage_nat != . & wt_occ_wage_nat != . , cluster(super_state)

/*Column 6 (Demographic Controls & Major & Occupation)*/

reg actual_wage female i.age i.race i.super_state i.marst masters doctorate i.year wt_med_wage_nat wt_occ_wage_nat [aw=wt] if wt_med_wage_nat != . & wt_occ_wage_nat != . , cluster(super_state)

log close

/**************************************************************************************************************************************************************************************************/
/**************************************************************************************************************************************************************************************************/
/**************************************************************************************************************************************************************************************************/
/*******************************************************************ONLINE APPENDIX****************************************************************************************************************/
/**************************************************************************************************************************************************************************************************/
/**************************************************************************************************************************************************************************************************/

/*************************************************************************FIGURES*****************************************************************************************************************/
/**************************************************************************************************************************************************************************************************/

/*NOTE: Figures A1-A5 Simply provide a taxonomic crosswalk between our detailed and broad major categories. This just comes from documentation in IPUMS and no data replication is need for these figures.*/


/************Figure A6: Gender Similarity in Major Choice and Occupation by Cohort, Strongly Attached Sample

/***************************PANEL A**********************************/

The data for this graph is generated in  this program and is exported to Excel to make into graphs.
x-axis for Figure A6 Panel A: five-year birth cohort
y-axis for Figure A6 Panel A: Inverse Duncan-Duncan Index for detailed major (solid line), detailed occupation (dashed line) for the strongly attached sample

Note: the variable major identifies our detailed major categories, the variable occ1990dd identifies our detailed occupation categories
the variable age_group identifies our 5-year birth cohorts, the variable wt is our weight variable, 
the variable dd_index_age is our Classic Duncan-Duncan index for detailed majors, the variable dd_index_age_occ is our Classic Duncan-Duncan index for detailed occupations
the variable dd_inverse_age is our inverse Duncan-Duncan index for detailed majors, the variable dd_inverse_age_occ is our inverse Duncan-Duncan index for detailed occupations
the variable strong_attach is an indicator variable for the strongly attached sample
*/


/* Again, we begin by calculating the classic Duncan-Duncan indices for each of our five-year birth cohorts:
The classic Duncan-Duncan index for majors (or occupations) is computed by: 1) calculating the absolute within-major (or within-occupation) difference between the share of the relevant male sample in a major (or occupation) and the share of the relevant female sample in a major (or occupation); 2) summing up absolute differences over all majors (or occupations); and 3) scaling by one-half to account for the comparison of two distributions. The classic Duncan-Duncan index values range from 0 to 1. If there are no differences across majors (occupations), the index would be zero. If there is complete segregation across majors (occupations), the index would be 1.
 
For our discussion, we renormalize these classic Duncan-Duncan indices by subtracting them from one. This step allows the reader to make easy visual comparisons with the indices introduced later in the paper: an increasing slope of any index in this paper represents a movement toward gender parity.*/

/**Calculating Classic Duncan-Duncan Indices for Detailed Majors*/

/*First, we calculate male shares within each detailed major category for each five-year birth cohort*/
# delimit cr
clear all 

cd "C:\Users\cmslo\Box Sync\JEP Replication files" 
log using "C:\Users\cmslo\Box Sync\JEP Replication files\replication Figure A6_check.smcl", replace 
use "main_analysis_file"

#delimit ;
keep if strong_attach == 1 ;
gen major_male = major * male ;

gen count_age_male_ = 1;
						
format count_age_male_              %18.4f;

# delimit ;
collapse (sum) count_age_male_  [pw=wt], by (age_group major_male) ;

reshape wide count_age_male_  , i(age_group) j(major_male) ;

foreach num of numlist 
		
1100	2407	5002	6106
1101	2408	5003	6107
1103	2409	5004	6108
1104	2410	5006	6109
1105	2412	5007	6110
1301	2413	5200	6199
1302	2414	5201	6200
1303	2499	5202	6201
1401	2500	5203	6203
1501	2501	5205	6204
1901	2503	5299	6206
1902	2504	5301	6207
1903	2599	5401	6209
1904	2601	5402	6210
2001	2602	5403	6211
2100	2603	5404	6212
2101	2901	5500	6299
2102	3202	5501	6402
2105	3301	5502	6403
2106	3302	5503	
2107	3401	5504	
2201	3402	5505	
2300	3600	5506	
2304	3601	5507	
2305	3603	5599	
2306	3604	5601	
2307	3606	5901	
2308	3608	6000	
2309	3609	6001	
2310	3699		
2311	3700		
2312	3701		
2313	3702		
2314	4000	6006	
2399	4001		
2400	4002	6100	
2401	4101	6102	
2402	4801	6103	
2405	4901	6104	
2406	5000	6105	

	
{;
egen count_age_male_`num'_total = sum(count_age_male_`num') ;
format count_age_male_`num'_total              %18.4f;
} ;


# delimit ;

egen malemajor_age = rowtotal(
count_age_male_1100	count_age_male_2407	count_age_male_5002	count_age_male_6106
count_age_male_1101	count_age_male_2408	count_age_male_5003	count_age_male_6107
count_age_male_1103	count_age_male_2409	count_age_male_5004	count_age_male_6108
count_age_male_1104	count_age_male_2410	count_age_male_5006	count_age_male_6109
count_age_male_1105	count_age_male_2412	count_age_male_5007	count_age_male_6110
count_age_male_1301	count_age_male_2413	count_age_male_5200	count_age_male_6199
count_age_male_1302	count_age_male_2414	count_age_male_5201	count_age_male_6200
count_age_male_1303	count_age_male_2499	count_age_male_5202	count_age_male_6201
count_age_male_1401	count_age_male_2500	count_age_male_5203	count_age_male_6203
count_age_male_1501	count_age_male_2501	count_age_male_5205	count_age_male_6204
count_age_male_1901	count_age_male_2503	count_age_male_5299	count_age_male_6206
count_age_male_1902	count_age_male_2504	count_age_male_5301	count_age_male_6207
count_age_male_1903	count_age_male_2599	count_age_male_5401	count_age_male_6209
count_age_male_1904	count_age_male_2601	count_age_male_5402	count_age_male_6210
count_age_male_2001	count_age_male_2602	count_age_male_5403	count_age_male_6211
count_age_male_2100	count_age_male_2603	count_age_male_5404	count_age_male_6212
count_age_male_2101	count_age_male_2901	count_age_male_5500	count_age_male_6299
count_age_male_2102	count_age_male_3202	count_age_male_5501	count_age_male_6402
count_age_male_2105	count_age_male_3301	count_age_male_5502	count_age_male_6403
count_age_male_2106	count_age_male_3302	count_age_male_5503		
count_age_male_2107	count_age_male_3401	count_age_male_5504		
count_age_male_2201	count_age_male_3402	count_age_male_5505		
count_age_male_2300	count_age_male_3600	count_age_male_5506		
count_age_male_2304	count_age_male_3601	count_age_male_5507		
count_age_male_2305	count_age_male_3603	count_age_male_5599		
count_age_male_2306	count_age_male_3604	count_age_male_5601		
count_age_male_2307	count_age_male_3606	count_age_male_5901		
count_age_male_2308	count_age_male_3608	count_age_male_6000		
count_age_male_2309	count_age_male_3609	count_age_male_6001		
count_age_male_2310	count_age_male_3699		
count_age_male_2311	count_age_male_3700			
count_age_male_2312	count_age_male_3701		
count_age_male_2313	count_age_male_3702		
count_age_male_2314	count_age_male_4000	count_age_male_6006		
count_age_male_2399	count_age_male_4001			
count_age_male_2400	count_age_male_4002	count_age_male_6100		
count_age_male_2401	count_age_male_4101	count_age_male_6102		
count_age_male_2402	count_age_male_4801	count_age_male_6103		
count_age_male_2405	count_age_male_4901	count_age_male_6104		
count_age_male_2406	count_age_male_5000	count_age_male_6105		

) ;
format malemajor_age              %18.4f;


/*compute major shares for men*/
# delimit ;
foreach num of numlist 
1100	2407	5002	6106
1101	2408	5003	6107
1103	2409	5004	6108
1104	2410	5006	6109
1105	2412	5007	6110
1301	2413	5200	6199
1302	2414	5201	6200
1303	2499	5202	6201
1401	2500	5203	6203
1501	2501	5205	6204
1901	2503	5299	6206
1902	2504	5301	6207
1903	2599	5401	6209
1904	2601	5402	6210
2001	2602	5403	6211
2100	2603	5404	6212
2101	2901	5500	6299
2102	3202	5501	6402
2105	3301	5502	6403
2106	3302	5503	
2107	3401	5504	
2201	3402	5505	
2300	3600	5506	
2304	3601	5507	
2305	3603	5599	
2306	3604	5601	
2307	3606	5901	
2308	3608	6000	
2309	3609	6001	
2310	3699		
2311	3700		
2312	3701		
2313	3702		
2314	4000	6006	
2399	4001		
2400	4002	6100	
2401	4101	6102	
2402	4801	6103	
2405	4901	6104	
2406	5000	6105	


	{;
gen male_share_age_`num' = count_age_male_`num'/malemajor_age  ;
format male_share_age_`num'             %18.4f;
} ;

save "male_counts_age_strong", replace ;


/*Now, we calculate female shares within each detailed major category for each five-year birth cohort*/
# delimit cr
clear all 

cd "C:\Users\cmslo\Box Sync\JEP Replication files" 

use "main_analysis_file"

#delimit ;
keep if strong_attach == 1 ;
gen major_female = major * female ;

gen count_age_female_ = 1;
						
format count_age_female_              %18.4f;

# delimit ;
collapse (sum) count_age_female_  [pw=wt], by (age_group major_female) ;

reshape wide count_age_female_  , i(age_group) j(major_female) ;

foreach num of numlist 
		
1100	2407	5002	6106
1101	2408	5003	6107
1103	2409	5004	6108
1104	2410	5006	6109
1105	2412	5007	6110
1301	2413	5200	6199
1302	2414	5201	6200
1303	2499	5202	6201
1401	2500	5203	6203
1501	2501	5205	6204
1901	2503	5299	6206
1902	2504	5301	6207
1903	2599	5401	6209
1904	2601	5402	6210
2001	2602	5403	6211
2100	2603	5404	6212
2101	2901	5500	6299
2102	3202	5501	6402
2105	3301	5502	6403
2106	3302	5503	
2107	3401	5504	
2201	3402	5505	
2300	3600	5506	
2304	3601	5507	
2305	3603	5599	
2306	3604	5601	
2307	3606	5901	
2308	3608	6000	
2309	3609	6001	
2310	3699		
2311	3700		
2312	3701		
2313	3702		
2314	4000	6006	
2399	4001		
2400	4002	6100	
2401	4101	6102	
2402	4801	6103	
2405	4901	6104	
2406	5000	6105	
	
	
{;
egen count_age_female_`num'_total = sum(count_age_female_`num') ;
format count_age_female_`num'_total              %18.4f;
} ;


# delimit ;

egen femalemajor_age = rowtotal(
count_age_female_1100	count_age_female_2407	count_age_female_5002	count_age_female_6106
count_age_female_1101	count_age_female_2408	count_age_female_5003	count_age_female_6107
count_age_female_1103	count_age_female_2409	count_age_female_5004	count_age_female_6108
count_age_female_1104	count_age_female_2410	count_age_female_5006	count_age_female_6109
count_age_female_1105	count_age_female_2412	count_age_female_5007	count_age_female_6110
count_age_female_1301	count_age_female_2413	count_age_female_5200	count_age_female_6199
count_age_female_1302	count_age_female_2414	count_age_female_5201	count_age_female_6200
count_age_female_1303	count_age_female_2499	count_age_female_5202	count_age_female_6201
count_age_female_1401	count_age_female_2500	count_age_female_5203	count_age_female_6203
count_age_female_1501	count_age_female_2501	count_age_female_5205	count_age_female_6204
count_age_female_1901	count_age_female_2503	count_age_female_5299	count_age_female_6206
count_age_female_1902	count_age_female_2504	count_age_female_5301	count_age_female_6207
count_age_female_1903	count_age_female_2599	count_age_female_5401	count_age_female_6209
count_age_female_1904	count_age_female_2601	count_age_female_5402	count_age_female_6210
count_age_female_2001	count_age_female_2602	count_age_female_5403	count_age_female_6211
count_age_female_2100	count_age_female_2603	count_age_female_5404	count_age_female_6212
count_age_female_2101	count_age_female_2901	count_age_female_5500	count_age_female_6299
count_age_female_2102	count_age_female_3202	count_age_female_5501	count_age_female_6402
count_age_female_2105	count_age_female_3301	count_age_female_5502	count_age_female_6403
count_age_female_2106	count_age_female_3302	count_age_female_5503		
count_age_female_2107	count_age_female_3401	count_age_female_5504		
count_age_female_2201	count_age_female_3402	count_age_female_5505		
count_age_female_2300	count_age_female_3600	count_age_female_5506		
count_age_female_2304	count_age_female_3601	count_age_female_5507		
count_age_female_2305	count_age_female_3603	count_age_female_5599		
count_age_female_2306	count_age_female_3604	count_age_female_5601		
count_age_female_2307	count_age_female_3606	count_age_female_5901		
count_age_female_2308	count_age_female_3608	count_age_female_6000		
count_age_female_2309	count_age_female_3609	count_age_female_6001		
count_age_female_2310	count_age_female_3699			
count_age_female_2311	count_age_female_3700			
count_age_female_2312	count_age_female_3701			
count_age_female_2313	count_age_female_3702			
count_age_female_2314	count_age_female_4000	count_age_female_6006		
count_age_female_2399	count_age_female_4001	
count_age_female_2400	count_age_female_4002	count_age_female_6100		
count_age_female_2401	count_age_female_4101	count_age_female_6102		
count_age_female_2402	count_age_female_4801	count_age_female_6103		
count_age_female_2405	count_age_female_4901	count_age_female_6104		
count_age_female_2406	count_age_female_5000	count_age_female_6105		
		
) ;
format femalemajor_age              %18.4f;


/*compute major shares for women*/
# delimit ;
foreach num of numlist 
1100	2407	5002	6106
1101	2408	5003	6107
1103	2409	5004	6108
1104	2410	5006	6109
1105	2412	5007	6110
1301	2413	5200	6199
1302	2414	5201	6200
1303	2499	5202	6201
1401	2500	5203	6203
1501	2501	5205	6204
1901	2503	5299	6206
1902	2504	5301	6207
1903	2599	5401	6209
1904	2601	5402	6210
2001	2602	5403	6211
2100	2603	5404	6212
2101	2901	5500	6299
2102	3202	5501	6402
2105	3301	5502	6403
2106	3302	5503	
2107	3401	5504	
2201	3402	5505	
2300	3600	5506	
2304	3601	5507	
2305	3603	5599	
2306	3604	5601	
2307	3606	5901	
2308	3608	6000	
2309	3609	6001	
2310	3699		
2311	3700	
2312	3701		
2313	3702		
2314	4000	6006	
2399	4001		
2400	4002	6100	
2401	4101	6102	
2402	4801	6103	
2405	4901	6104	
2406	5000	6105	


	{;
gen female_share_age_`num' = count_age_female_`num'/femalemajor_age  ;
format female_share_age_`num'             %18.4f;
} ;

save "female_counts_age_strong", replace ;


/*Now, we calculate the Classic Duncan-Duncan index in detailed majors for each five-year birth cohort*/
# delimit ;

clear all;

set more off ;
/*set maxvar 32000 ;*/
cd "C:\Users\cmslo\Box Sync\JEP Replication files" ;
use "female_counts_age_strong" ;

sort age_group ;

merge 1:1 age_group using "male_counts_age_strong" ;

tab _merge ;

gen male_share_age_ = . ;

gen female_share_age_ = . ;

foreach num of numlist
1100	2407	5002	6106
1101	2408	5003	6107
1103	2409	5004	6108
1104	2410	5006	6109
1105	2412	5007	6110
1301	2413	5200	6199
1302	2414	5201	6200
1303	2499	5202	6201
1401	2500	5203	6203
1501	2501	5205	6204
1901	2503	5299	6206
1902	2504	5301	6207
1903	2599	5401	6209
1904	2601	5402	6210
2001	2602	5403	6211
2100	2603	5404	6212
2101	2901	5500	6299
2102	3202	5501	6402
2105	3301	5502	6403
2106	3302	5503	
2107	3401	5504	
2201	3402	5505	
2300	3600	5506	
2304	3601	5507	
2305	3603	5599	
2306	3604	5601	
2307	3606	5901	
2308	3608	6000	
2309	3609	6001	
2310	3699		
2311	3700		
2312	3701		
2313	3702		
2314	4000	6006	
2399	4001		
2400	4002	6100	
2401	4101	6102	
2402	4801	6103	
2405	4901	6104	
2406	5000	6105	
	
{ ;

gen d_share_`num' = abs(male_share_age_`num' - female_share_age_`num') ;
format d_share_`num'            %18.4f;
} ;

egen dd_index_age = rowtotal(
d_share_1100	d_share_2407	d_share_5002	d_share_6106
d_share_1101	d_share_2408	d_share_5003	d_share_6107
d_share_1103	d_share_2409	d_share_5004	d_share_6108
d_share_1104	d_share_2410	d_share_5006	d_share_6109
d_share_1105	d_share_2412	d_share_5007	d_share_6110
d_share_1301	d_share_2413	d_share_5200	d_share_6199
d_share_1302	d_share_2414	d_share_5201	d_share_6200
d_share_1303	d_share_2499	d_share_5202	d_share_6201
d_share_1401	d_share_2500	d_share_5203	d_share_6203
d_share_1501	d_share_2501	d_share_5205	d_share_6204
d_share_1901	d_share_2503	d_share_5299	d_share_6206
d_share_1902	d_share_2504	d_share_5301	d_share_6207
d_share_1903	d_share_2599	d_share_5401	d_share_6209
d_share_1904	d_share_2601	d_share_5402	d_share_6210
d_share_2001	d_share_2602	d_share_5403	d_share_6211
d_share_2100	d_share_2603	d_share_5404	d_share_6212
d_share_2101	d_share_2901	d_share_5500	d_share_6299
d_share_2102	d_share_3202	d_share_5501	d_share_6402
d_share_2105	d_share_3301	d_share_5502	d_share_6403
d_share_2106	d_share_3302	d_share_5503		
d_share_2107	d_share_3401	d_share_5504		
d_share_2201	d_share_3402	d_share_5505		
d_share_2300	d_share_3600	d_share_5506		
d_share_2304	d_share_3601	d_share_5507		
d_share_2305	d_share_3603	d_share_5599		
d_share_2306	d_share_3604	d_share_5601		
d_share_2307	d_share_3606	d_share_5901		
d_share_2308	d_share_3608	d_share_6000		
d_share_2309	d_share_3609	d_share_6001		
d_share_2310	d_share_3699		
d_share_2311	d_share_3700			
d_share_2312	d_share_3701			
d_share_2313	d_share_3702			
d_share_2314	d_share_4000	d_share_6006		
d_share_2399	d_share_4001			
d_share_2400	d_share_4002	d_share_6100		
d_share_2401	d_share_4101	d_share_6102		
d_share_2402	d_share_4801	d_share_6103		
d_share_2405	d_share_4901	d_share_6104		
d_share_2406	d_share_5000	d_share_6105		
	
) ;

format dd_index_age            %18.4f;

replace dd_index_age = 0.5* dd_index_age ;

keep dd_* age_group ;

gen dd_inverse_age = 1 - dd_index_age ;

/*we now go to browse mode to we can easily copy and paste this data to Excel to make our detailed major series for the inverse Duncan-Duncan: this is the solid line*/
browse ;
save "age_group_duncan_duncan_strong", replace ;

/**Calculating Classic Duncan-Duncan Indices for Occupations*/

/*First, we calculate male shares within each detailed occupation category for each five-year birth cohort*/
# delimit cr
clear all 

cd "C:\Users\cmslo\Box Sync\JEP Replication files" 

use "main_analysis_file"
keep if strong_attach == 1 
drop if occ1990dd == . 

#delimit ;
gen occ_male = occ1990dd * male ;

gen count_age_male_ = 1;
						
format count_age_male_              %18.4f;

# delimit ;
collapse (sum) count_age_male_  [pw=wt], by (age_group occ_male) ;

reshape wide count_age_male_  , i(age_group) j(occ_male) ;


foreach num of numlist 
		
4	78	205	336	444	567	809
7	79	206	337	445	575	813
8	83	207	338	447	577	829
13	84	208	344	448	579	834
14	89	214	346	450	585	844
15	95	217	347	451	593	866
18	96	218	348	453	599	869
19	97	223	354	455	616	875
22	98	224	355	458	628	887
23	103	225	356	459	634	888
24	105	226	357	461	637	889
25	106	227	359	462	653	
26	154	228	364	464	657	
27	155	229	365	466	666	
28	156	233	368	468	675	
29	157	234	373	469	677	
33	158	235	375	470	678	
34	159	243	376	471	684	
35	163	253	377	472	686	
36	164	254	378	475	687	
37	165	255	379	479	688	
43	167	256	383	489	694	
44	169	258	384	496	695	
45	174	274	385	498	696	
47	176	275	386	503	699	
48	177	276	387	505	706	
53	178	277	389	507	707	
55	183	283	405	508	719	
56	184	303	408	516	733	
57	185	308	415	518	736	
59	186	313	417	523	749	
64	187	315	418	525	757	
65	188	316	423	527	779	
68	189	317	426	533	783	
69	194	318	427	534	785	
73	195	319	433	535	789	
74	198	326	434	536	799	
75	199	328	435	549	803	
76	203	329	436	558	804	
77	204	335	439	563	808	
	
	
{;
egen count_age_male_`num'_total = sum(count_age_male_`num') ;
format count_age_male_`num'_total              %18.4f;
} ;


# delimit ;

egen maleocc_age = rowtotal(
count_age_male_4	count_age_male_78	count_age_male_205	count_age_male_336	count_age_male_444	count_age_male_567	count_age_male_809
count_age_male_7	count_age_male_79	count_age_male_206	count_age_male_337	count_age_male_445	count_age_male_575	count_age_male_813
count_age_male_8	count_age_male_83	count_age_male_207	count_age_male_338	count_age_male_447	count_age_male_577	count_age_male_829
count_age_male_13	count_age_male_84	count_age_male_208	count_age_male_344	count_age_male_448	count_age_male_579	count_age_male_834
count_age_male_14	count_age_male_89	count_age_male_214	count_age_male_346	count_age_male_450	count_age_male_585	count_age_male_844
count_age_male_15	count_age_male_95	count_age_male_217	count_age_male_347	count_age_male_451	count_age_male_593	count_age_male_866
count_age_male_18	count_age_male_96	count_age_male_218	count_age_male_348	count_age_male_453	count_age_male_599	count_age_male_869
count_age_male_19	count_age_male_97	count_age_male_223	count_age_male_354	count_age_male_455	count_age_male_616	count_age_male_875
count_age_male_22	count_age_male_98	count_age_male_224	count_age_male_355	count_age_male_458	count_age_male_628	count_age_male_887
count_age_male_23	count_age_male_103	count_age_male_225	count_age_male_356	count_age_male_459	count_age_male_634	count_age_male_888
count_age_male_24	count_age_male_105	count_age_male_226	count_age_male_357	count_age_male_461	count_age_male_637	count_age_male_889
count_age_male_25	count_age_male_106	count_age_male_227	count_age_male_359	count_age_male_462	count_age_male_653		
count_age_male_26	count_age_male_154	count_age_male_228	count_age_male_364	count_age_male_464	count_age_male_657		
count_age_male_27	count_age_male_155	count_age_male_229	count_age_male_365	count_age_male_466	count_age_male_666		
count_age_male_28	count_age_male_156	count_age_male_233	count_age_male_368	count_age_male_468	count_age_male_675		
count_age_male_29	count_age_male_157	count_age_male_234	count_age_male_373	count_age_male_469	count_age_male_677		
count_age_male_33	count_age_male_158	count_age_male_235	count_age_male_375	count_age_male_470	count_age_male_678		
count_age_male_34	count_age_male_159	count_age_male_243	count_age_male_376	count_age_male_471	count_age_male_684		
count_age_male_35	count_age_male_163	count_age_male_253	count_age_male_377	count_age_male_472	count_age_male_686		
count_age_male_36	count_age_male_164	count_age_male_254	count_age_male_378	count_age_male_475	count_age_male_687		
count_age_male_37	count_age_male_165	count_age_male_255	count_age_male_379	count_age_male_479	count_age_male_688		
count_age_male_43	count_age_male_167	count_age_male_256	count_age_male_383	count_age_male_489	count_age_male_694		
count_age_male_44	count_age_male_169	count_age_male_258	count_age_male_384	count_age_male_496	count_age_male_695		
count_age_male_45	count_age_male_174	count_age_male_274	count_age_male_385	count_age_male_498	count_age_male_696		
count_age_male_47	count_age_male_176	count_age_male_275	count_age_male_386	count_age_male_503	count_age_male_699		
count_age_male_48	count_age_male_177	count_age_male_276	count_age_male_387	count_age_male_505	count_age_male_706		
count_age_male_53	count_age_male_178	count_age_male_277	count_age_male_389	count_age_male_507	count_age_male_707		
count_age_male_55	count_age_male_183	count_age_male_283	count_age_male_405	count_age_male_508	count_age_male_719		
count_age_male_56	count_age_male_184	count_age_male_303	count_age_male_408	count_age_male_516	count_age_male_733		
count_age_male_57	count_age_male_185	count_age_male_308	count_age_male_415	count_age_male_518	count_age_male_736		
count_age_male_59	count_age_male_186	count_age_male_313	count_age_male_417	count_age_male_523	count_age_male_749		
count_age_male_64	count_age_male_187	count_age_male_315	count_age_male_418	count_age_male_525	count_age_male_757		
count_age_male_65	count_age_male_188	count_age_male_316	count_age_male_423	count_age_male_527	count_age_male_779		
count_age_male_68	count_age_male_189	count_age_male_317	count_age_male_426	count_age_male_533	count_age_male_783		
count_age_male_69	count_age_male_194	count_age_male_318	count_age_male_427	count_age_male_534	count_age_male_785		
count_age_male_73	count_age_male_195	count_age_male_319	count_age_male_433	count_age_male_535	count_age_male_789		
count_age_male_74	count_age_male_198	count_age_male_326	count_age_male_434	count_age_male_536	count_age_male_799		
count_age_male_75	count_age_male_199	count_age_male_328	count_age_male_435	count_age_male_549	count_age_male_803		
count_age_male_76	count_age_male_203	count_age_male_329	count_age_male_436	count_age_male_558	count_age_male_804		
count_age_male_77	count_age_male_204	count_age_male_335	count_age_male_439	count_age_male_563	count_age_male_808		

) ;
format maleocc_age              %18.4f;


/*compute occ shares*/
# delimit ;
foreach num of numlist 
4	78	205	336	444	567	809
7	79	206	337	445	575	813
8	83	207	338	447	577	829
13	84	208	344	448	579	834
14	89	214	346	450	585	844
15	95	217	347	451	593	866
18	96	218	348	453	599	869
19	97	223	354	455	616	875
22	98	224	355	458	628	887
23	103	225	356	459	634	888
24	105	226	357	461	637	889
25	106	227	359	462	653	
26	154	228	364	464	657	
27	155	229	365	466	666	
28	156	233	368	468	675	
29	157	234	373	469	677	
33	158	235	375	470	678	
34	159	243	376	471	684	
35	163	253	377	472	686	
36	164	254	378	475	687	
37	165	255	379	479	688	
43	167	256	383	489	694	
44	169	258	384	496	695	
45	174	274	385	498	696	
47	176	275	386	503	699	
48	177	276	387	505	706	
53	178	277	389	507	707	
55	183	283	405	508	719	
56	184	303	408	516	733	
57	185	308	415	518	736	
59	186	313	417	523	749	
64	187	315	418	525	757	
65	188	316	423	527	779	
68	189	317	426	533	783	
69	194	318	427	534	785	
73	195	319	433	535	789	
74	198	326	434	536	799	
75	199	328	435	549	803	
76	203	329	436	558	804	
77	204	335	439	563	808	
	

	{;
gen male_share_age_`num' = count_age_male_`num'/maleocc_age  ;
format male_share_age_`num'             %18.4f;
} ;

save "male_counts_age_occ_strong", replace ;


/*Now, we calculate female shares within each detailed occupation category for each five-year birth cohort*/
# delimit cr
clear all 

cd "C:\Users\cmslo\Box Sync\JEP Replication files" 

use "main_analysis_file"
keep if strong_attach == 1 
drop if occ1990dd == . 

#delimit ;
gen occ_female = occ1990dd * female ;

gen count_age_female_ = 1;
						
format count_age_female_              %18.4f;

# delimit ;
collapse (sum) count_age_female_  [pw=wt], by (age_group occ_female) ;

reshape wide count_age_female_  , i(age_group) j(occ_female) ;


foreach num of numlist 
		
4	78	205	336	444	567	809
7	79	206	337	445	575	813
8	83	207	338	447	577	829
13	84	208	344	448	579	834
14	89	214	346	450	585	844
15	95	217	347	451	593	866
18	96	218	348	453	599	869
19	97	223	354	455	616	875
22	98	224	355	458	628	887
23	103	225	356	459	634	888
24	105	226	357	461	637	889
25	106	227	359	462	653	
26	154	228	364	464	657	
27	155	229	365	466	666	
28	156	233	368	468	675	
29	157	234	373	469	677	
33	158	235	375	470	678	
34	159	243	376	471	684	
35	163	253	377	472	686	
36	164	254	378	475	687	
37	165	255	379	479	688	
43	167	256	383	489	694	
44	169	258	384	496	695	
45	174	274	385	498	696	
47	176	275	386	503	699	
48	177	276	387	505	706	
53	178	277	389	507	707	
55	183	283	405	508	719	
56	184	303	408	516	733	
57	185	308	415	518	736	
59	186	313	417	523	749	
64	187	315	418	525	757	
65	188	316	423	527	779	
68	189	317	426	533	783	
69	194	318	427	534	785	
73	195	319	433	535	789	
74	198	326	434	536	799	
75	199	328	435	549	803	
76	203	329	436	558	804	
77	204	335	439	563	808	
	
	
{;
egen count_age_female_`num'_total = sum(count_age_female_`num') ;
format count_age_female_`num'_total              %18.4f;
} ;



# delimit ;

egen femaleocc_age = rowtotal(
count_age_female_4	count_age_female_78	count_age_female_205	count_age_female_336	count_age_female_444	count_age_female_567	count_age_female_809
count_age_female_7	count_age_female_79	count_age_female_206	count_age_female_337	count_age_female_445	count_age_female_575	count_age_female_813
count_age_female_8	count_age_female_83	count_age_female_207	count_age_female_338	count_age_female_447	count_age_female_577	count_age_female_829
count_age_female_13	count_age_female_84	count_age_female_208	count_age_female_344	count_age_female_448	count_age_female_579	count_age_female_834
count_age_female_14	count_age_female_89	count_age_female_214	count_age_female_346	count_age_female_450	count_age_female_585	count_age_female_844
count_age_female_15	count_age_female_95	count_age_female_217	count_age_female_347	count_age_female_451	count_age_female_593	count_age_female_866
count_age_female_18	count_age_female_96	count_age_female_218	count_age_female_348	count_age_female_453	count_age_female_599	count_age_female_869
count_age_female_19	count_age_female_97	count_age_female_223	count_age_female_354	count_age_female_455	count_age_female_616	count_age_female_875
count_age_female_22	count_age_female_98	count_age_female_224	count_age_female_355	count_age_female_458	count_age_female_628	count_age_female_887
count_age_female_23	count_age_female_103	count_age_female_225	count_age_female_356	count_age_female_459	count_age_female_634	count_age_female_888
count_age_female_24	count_age_female_105	count_age_female_226	count_age_female_357	count_age_female_461	count_age_female_637	count_age_female_889
count_age_female_25	count_age_female_106	count_age_female_227	count_age_female_359	count_age_female_462	count_age_female_653		
count_age_female_26	count_age_female_154	count_age_female_228	count_age_female_364	count_age_female_464	count_age_female_657		
count_age_female_27	count_age_female_155	count_age_female_229	count_age_female_365	count_age_female_466	count_age_female_666		
count_age_female_28	count_age_female_156	count_age_female_233	count_age_female_368	count_age_female_468	count_age_female_675		
count_age_female_29	count_age_female_157	count_age_female_234	count_age_female_373	count_age_female_469	count_age_female_677		
count_age_female_33	count_age_female_158	count_age_female_235	count_age_female_375	count_age_female_470	count_age_female_678		
count_age_female_34	count_age_female_159	count_age_female_243	count_age_female_376	count_age_female_471	count_age_female_684		
count_age_female_35	count_age_female_163	count_age_female_253	count_age_female_377	count_age_female_472	count_age_female_686		
count_age_female_36	count_age_female_164	count_age_female_254	count_age_female_378	count_age_female_475	count_age_female_687		
count_age_female_37	count_age_female_165	count_age_female_255	count_age_female_379	count_age_female_479	count_age_female_688		
count_age_female_43	count_age_female_167	count_age_female_256	count_age_female_383	count_age_female_489	count_age_female_694		
count_age_female_44	count_age_female_169	count_age_female_258	count_age_female_384	count_age_female_496	count_age_female_695		
count_age_female_45	count_age_female_174	count_age_female_274	count_age_female_385	count_age_female_498	count_age_female_696		
count_age_female_47	count_age_female_176	count_age_female_275	count_age_female_386	count_age_female_503	count_age_female_699		
count_age_female_48	count_age_female_177	count_age_female_276	count_age_female_387	count_age_female_505	count_age_female_706		
count_age_female_53	count_age_female_178	count_age_female_277	count_age_female_389	count_age_female_507	count_age_female_707		
count_age_female_55	count_age_female_183	count_age_female_283	count_age_female_405	count_age_female_508	count_age_female_719		
count_age_female_56	count_age_female_184	count_age_female_303	count_age_female_408	count_age_female_516	count_age_female_733		
count_age_female_57	count_age_female_185	count_age_female_308	count_age_female_415	count_age_female_518	count_age_female_736		
count_age_female_59	count_age_female_186	count_age_female_313	count_age_female_417	count_age_female_523	count_age_female_749		
count_age_female_64	count_age_female_187	count_age_female_315	count_age_female_418	count_age_female_525	count_age_female_757		
count_age_female_65	count_age_female_188	count_age_female_316	count_age_female_423	count_age_female_527	count_age_female_779		
count_age_female_68	count_age_female_189	count_age_female_317	count_age_female_426	count_age_female_533	count_age_female_783		
count_age_female_69	count_age_female_194	count_age_female_318	count_age_female_427	count_age_female_534	count_age_female_785		
count_age_female_73	count_age_female_195	count_age_female_319	count_age_female_433	count_age_female_535	count_age_female_789		
count_age_female_74	count_age_female_198	count_age_female_326	count_age_female_434	count_age_female_536	count_age_female_799		
count_age_female_75	count_age_female_199	count_age_female_328	count_age_female_435	count_age_female_549	count_age_female_803		
count_age_female_76	count_age_female_203	count_age_female_329	count_age_female_436	count_age_female_558	count_age_female_804		
count_age_female_77	count_age_female_204	count_age_female_335	count_age_female_439	count_age_female_563	count_age_female_808		
	
) ;
format femaleocc_age              %18.4f;


/*compute occ shares*/
# delimit ;
foreach num of numlist 
4	78	205	336	444	567	809
7	79	206	337	445	575	813
8	83	207	338	447	577	829
13	84	208	344	448	579	834
14	89	214	346	450	585	844
15	95	217	347	451	593	866
18	96	218	348	453	599	869
19	97	223	354	455	616	875
22	98	224	355	458	628	887
23	103	225	356	459	634	888
24	105	226	357	461	637	889
25	106	227	359	462	653	
26	154	228	364	464	657	
27	155	229	365	466	666	
28	156	233	368	468	675	
29	157	234	373	469	677	
33	158	235	375	470	678	
34	159	243	376	471	684	
35	163	253	377	472	686	
36	164	254	378	475	687	
37	165	255	379	479	688	
43	167	256	383	489	694	
44	169	258	384	496	695	
45	174	274	385	498	696	
47	176	275	386	503	699	
48	177	276	387	505	706	
53	178	277	389	507	707	
55	183	283	405	508	719	
56	184	303	408	516	733	
57	185	308	415	518	736	
59	186	313	417	523	749	
64	187	315	418	525	757	
65	188	316	423	527	779	
68	189	317	426	533	783	
69	194	318	427	534	785	
73	195	319	433	535	789	
74	198	326	434	536	799	
75	199	328	435	549	803	
76	203	329	436	558	804	
77	204	335	439	563	808	
	

	{;
gen female_share_age_`num' = count_age_female_`num'/femaleocc_age  ;
format female_share_age_`num'             %18.4f;
} ;

save "female_counts_age_occ_strong", replace ;


/*Now, we calculate the Classic Duncan-Duncan index in detailed occupations for each five-year birth cohort*/
# delimit ;

clear all;

set more off ;
/*set maxvar 32000 ;*/
cd "C:\Users\cmslo\Box Sync\JEP Replication files" ;

use "female_counts_age_occ_strong" ;

sort age_group ;

merge 1:1 age_group using "male_counts_age_occ_strong" ;

tab _merge ;

gen male_share_age_ = . ;

gen female_share_age_ = . ;

foreach num of numlist
4	78	205	336	444	567	809
7	79	206	337	445	575	813
8	83	207	338	447	577	829
13	84	208	344	448	579	834
14	89	214	346	450	585	844
15	95	217	347	451	593	866
18	96	218	348	453	599	869
19	97	223	354	455	616	875
22	98	224	355	458	628	887
23	103	225	356	459	634	888
24	105	226	357	461	637	889
25	106	227	359	462	653	
26	154	228	364	464	657	
27	155	229	365	466	666	
28	156	233	368	468	675	
29	157	234	373	469	677	
33	158	235	375	470	678	
34	159	243	376	471	684	
35	163	253	377	472	686	
36	164	254	378	475	687	
37	165	255	379	479	688	
43	167	256	383	489	694	
44	169	258	384	496	695	
45	174	274	385	498	696	
47	176	275	386	503	699	
48	177	276	387	505	706	
53	178	277	389	507	707	
55	183	283	405	508	719	
56	184	303	408	516	733	
57	185	308	415	518	736	
59	186	313	417	523	749	
64	187	315	418	525	757	
65	188	316	423	527	779	
68	189	317	426	533	783	
69	194	318	427	534	785	
73	195	319	433	535	789	
74	198	326	434	536	799	
75	199	328	435	549	803	
76	203	329	436	558	804	
77	204	335	439	563	808	

{ ;

gen d_share_`num' = abs(male_share_age_`num' - female_share_age_`num') ;
format d_share_`num'            %18.4f;
} ;

egen dd_index_age_occ = rowtotal(
d_share_4	d_share_78	d_share_205	d_share_336	d_share_444	d_share_567	d_share_809
d_share_7	d_share_79	d_share_206	d_share_337	d_share_445	d_share_575	d_share_813
d_share_8	d_share_83	d_share_207	d_share_338	d_share_447	d_share_577	d_share_829
d_share_13	d_share_84	d_share_208	d_share_344	d_share_448	d_share_579	d_share_834
d_share_14	d_share_89	d_share_214	d_share_346	d_share_450	d_share_585	d_share_844
d_share_15	d_share_95	d_share_217	d_share_347	d_share_451	d_share_593	d_share_866
d_share_18	d_share_96	d_share_218	d_share_348	d_share_453	d_share_599	d_share_869
d_share_19	d_share_97	d_share_223	d_share_354	d_share_455	d_share_616	d_share_875
d_share_22	d_share_98	d_share_224	d_share_355	d_share_458	d_share_628	d_share_887
d_share_23	d_share_103	d_share_225	d_share_356	d_share_459	d_share_634	d_share_888
d_share_24	d_share_105	d_share_226	d_share_357	d_share_461	d_share_637	d_share_889
d_share_25	d_share_106	d_share_227	d_share_359	d_share_462	d_share_653		
d_share_26	d_share_154	d_share_228	d_share_364	d_share_464	d_share_657		
d_share_27	d_share_155	d_share_229	d_share_365	d_share_466	d_share_666		
d_share_28	d_share_156	d_share_233	d_share_368	d_share_468	d_share_675		
d_share_29	d_share_157	d_share_234	d_share_373	d_share_469	d_share_677		
d_share_33	d_share_158	d_share_235	d_share_375	d_share_470	d_share_678		
d_share_34	d_share_159	d_share_243	d_share_376	d_share_471	d_share_684		
d_share_35	d_share_163	d_share_253	d_share_377	d_share_472	d_share_686		
d_share_36	d_share_164	d_share_254	d_share_378	d_share_475	d_share_687		
d_share_37	d_share_165	d_share_255	d_share_379	d_share_479	d_share_688		
d_share_43	d_share_167	d_share_256	d_share_383	d_share_489	d_share_694		
d_share_44	d_share_169	d_share_258	d_share_384	d_share_496	d_share_695		
d_share_45	d_share_174	d_share_274	d_share_385	d_share_498	d_share_696		
d_share_47	d_share_176	d_share_275	d_share_386	d_share_503	d_share_699		
d_share_48	d_share_177	d_share_276	d_share_387	d_share_505	d_share_706		
d_share_53	d_share_178	d_share_277	d_share_389	d_share_507	d_share_707		
d_share_55	d_share_183	d_share_283	d_share_405	d_share_508	d_share_719		
d_share_56	d_share_184	d_share_303	d_share_408	d_share_516	d_share_733		
d_share_57	d_share_185	d_share_308	d_share_415	d_share_518	d_share_736		
d_share_59	d_share_186	d_share_313	d_share_417	d_share_523	d_share_749		
d_share_64	d_share_187	d_share_315	d_share_418	d_share_525	d_share_757		
d_share_65	d_share_188	d_share_316	d_share_423	d_share_527	d_share_779		
d_share_68	d_share_189	d_share_317	d_share_426	d_share_533	d_share_783		
d_share_69	d_share_194	d_share_318	d_share_427	d_share_534	d_share_785		
d_share_73	d_share_195	d_share_319	d_share_433	d_share_535	d_share_789		
d_share_74	d_share_198	d_share_326	d_share_434	d_share_536	d_share_799		
d_share_75	d_share_199	d_share_328	d_share_435	d_share_549	d_share_803		
d_share_76	d_share_203	d_share_329	d_share_436	d_share_558	d_share_804		
d_share_77	d_share_204	d_share_335	d_share_439	d_share_563	d_share_808		
		
) ;

format dd_index_age_occ            %18.4f;

replace dd_index_age_occ = 0.5* dd_index_age_occ ;

keep dd_* age_group ;

gen dd_inverse_age_occ = 1 - dd_index_age_occ ;

/*we now go to browse mode to we can easily copy and paste this data to Excel to make our detailed major series for the inverse Duncan-Duncan: this is the dashed line*/
browse ;
save "age_group_occ_duncan_duncan_strong", replace ;

/***************************PANEL B**********************************/
/*The data for this graph is generated in  this program and is exported to Excel to make into graphs.
x-axis for Figure A7 Panel B: five-year birth cohort
y-axis for Figure A7 Panel B: potential wage indices for detailed major (solid line), detailed occupation (dashed line) for the strongly attached
Note: 
the variable age_group identifies our 5-year birth cohorts, the variable wt is our weight variable, 
the variable wt_med_wage_nat is our potential wage for majors 
the variable wt_occ_wage_nat  is our potential wage for occupations
the variable potential_major_* is our potential wage index for majors, birth cohort (this is what is graphed on y axis)
the variable wt_occ_wage_nat  is our potential wage for occupations
he variable potential_occ_* is our potential wage index for occupations, birth cohort (this is what is graphed on y axis)
the variable strong_attach is an indicator variable indicating the strongly attached sample 

Again, we define our potential wage index as: 


I^{Major}_{c} = \frac{\sum_{m=1}^{M} s^m_{female,c}\bar{Y}^m_{male}}{\sum_{m=1}^{M} s^m_{male,c}  \bar{Y}^m_{male}} -1


In practice, we compute this index by running the following regression locally within 5-year birth cohort $c$:


\bar{Y}^m_{male_{i}} = \alpha + \beta Female_{i} + \Gamma X_{i} + \epsilon_{i}


where $Female_{i}$ is a dummy variable indicating whether the respondent $i$  has self-reported as female and $X_{i}$ is a vector of demographic characteristics: race, state of birth, masters attainment, doctorate attainment, and marital status. Our potential wage index, $I^{Major}_{c}$, is defined as $\beta$ from each local regression by 5-year birth cohort and therefore, measures the differential ``potential'' wage of women of cohort $c$ given that the female distribution of  majors in a given cohort may differ from males in their cohort. The units of this index are differential potential log wage based on major. In computing the comparable index for occupation, we substitute detailed occupation code, $o$, for detailed major code, $m$.

*/


# delimit ;
clear all ;

cd "C:\Users\cmslo\Box Sync\JEP Replication files" ;
use "main_analysis_file" ;

/*Potential Wages from Human Capital Specialization: Solid Line*/
#delimit cr
keep if strong_attach == 1 
reg  wt_med_wage_nat female i.race i.super_state  i.marst  masters doctorate [aw=wt] if main_sample == 1 & a25 == 1, cluster(super_state) 

gen potential_major_1990	= _b[female] 

reg  wt_med_wage_nat female i.race i.super_state  i.marst  masters doctorate [aw=wt] if main_sample == 1 & a30 == 1, cluster(super_state) 

gen potential_major_1985	= _b[female] 

reg  wt_med_wage_nat female i.race i.super_state  i.marst  masters doctorate  [aw=wt] if main_sample == 1 & a35 == 1, cluster(super_state) 

gen potential_major_1980	= _b[female] 

reg  wt_med_wage_nat female i.race i.super_state  i.marst  masters doctorate  [aw=wt] if main_sample == 1 & a40 == 1, cluster(super_state) 

gen potential_major_1975	= _b[female] 

reg  wt_med_wage_nat female i.race i.super_state  i.marst  masters doctorate [aw=wt] if main_sample == 1 & a45 == 1, cluster(super_state) 

gen potential_major_1970	= _b[female] 

reg  wt_med_wage_nat female i.race i.super_state  i.marst  masters doctorate  [aw=wt] if main_sample == 1 & a50 == 1, cluster(super_state) 

gen potential_major_1965	= _b[female] 

reg  wt_med_wage_nat female i.race i.super_state  i.marst  masters doctorate [aw=wt] if main_sample == 1 & a55 == 1, cluster(super_state) 

gen potential_major_1960	= _b[female] 

reg  wt_med_wage_nat female i.race i.super_state  i.marst  masters doctorate [aw=wt] if main_sample == 1 & a60 == 1, cluster(super_state) 

gen potential_major_1955	= _b[female] 

reg  wt_med_wage_nat female i.race i.super_state  i.marst  masters doctorate  [aw=wt] if main_sample == 1 & a65 == 1, cluster(super_state) 

gen potential_major_1950	= _b[female] 


/*Potential Wages from Occupational Specialization: Dashed Line*/


reg  wt_occ_wage_nat female i.race i.super_state  i.marst  masters doctorate [aw=wt] if main_sample == 1 & a25 == 1, cluster(super_state) 

gen potential_occ_1990	= _b[female] 

reg  wt_occ_wage_nat female i.race i.super_state  i.marst  masters doctorate [aw=wt] if main_sample == 1 & a30 == 1, cluster(super_state) 

gen potential_occ_1985	= _b[female] 

reg  wt_occ_wage_nat female i.race i.super_state  i.marst  masters doctorate  [aw=wt] if main_sample == 1 & a35 == 1, cluster(super_state) 

gen potential_occ_1980	= _b[female] 

reg  wt_occ_wage_nat female i.race i.super_state  i.marst  masters doctorate  [aw=wt] if main_sample == 1 & a40 == 1, cluster(super_state) 

gen potential_occ_1975	= _b[female] 

reg  wt_occ_wage_nat female i.race i.super_state  i.marst  masters doctorate [aw=wt] if main_sample == 1 & a45 == 1, cluster(super_state) 

gen potential_occ_1970	= _b[female] 

reg  wt_occ_wage_nat female i.race i.super_state  i.marst  masters doctorate  [aw=wt] if main_sample == 1 & a50 == 1, cluster(super_state) 

gen potential_occ_1965	= _b[female] 

reg  wt_occ_wage_nat female i.race i.super_state  i.marst  masters doctorate [aw=wt] if main_sample == 1 & a55 == 1, cluster(super_state) 

gen potential_occ_1960	= _b[female] 

reg  wt_occ_wage_nat female i.race i.super_state  i.marst  masters doctorate [aw=wt] if main_sample == 1 & a60 == 1, cluster(super_state) 

gen potential_occ_1955	= _b[female] 

reg  wt_occ_wage_nat female i.race i.super_state  i.marst  masters doctorate  [aw=wt] if main_sample == 1 & a65 == 1, cluster(super_state) 

gen potential_occ_1950	= _b[female] 

/*here, we just collapse so we have an easy file with just our potential wage indices to copy and paste into Excel-- it reads wide */
gen sample = 1 
collapse (mean) potential* [aw=wt], by(sample)

/*here, we go to browse mode so we can easily copy and paste to Excel*/
browse
log close 

/***************************************************************************************************************************************************************/
/************Figure A7: Cross-Major Variation in Within-Major Gender Differences in Potential Wage by Occupation, 1968-1977 Birth Cohort:

Panel A: Gender Composition of the Majors
Panel B: Potential Income of the Major

the variable wt  is our Herfindahl-Hirschman Index 
*/


/* We begin by calculating the Herfindahl-Hirschman Index in all of our detailed major categories 
We calculate this index by: (1) calculating the share employed in an occupation of the relevant gender-major-cohort group, (2) squaring those shares, and (3) summing up over all occupations. 
Then, we graph Panel A and Panel B
*/

/**Panel A*******/
# delimit cr
clear all 

cd "C:\Users\cmslo\Box Sync\JEP Replication files" 
log using "C:\Users\cmslo\Box Sync\JEP Replication files\replication Figure A7_check.smcl", replace 
use "main_analysis_file"

#delimit ;

keep if wt_occ_wage_nat != . &  wt_med_wage_nat != . ;
keep if a45 == 1 | a40 == 1 ;
drop if major == 6104 ;
gen size = 1 ;
collapse (mean) wt_med_wage_nat wt_occ_wage_nat (sum)size [aw=wt], by (sex major) ; 
reshape wide wt_med_wage_nat wt_occ_wage_nat size, i(major) j(sex) ;

gen occ_wage_diff = wt_occ_wage_nat2 - wt_occ_wage_nat1 ;
drop if occ_wage_diff == . ;
rename wt_med_wage_nat1 potential_wage_major ;

gen size = size1 + size2 ;
drop if size == . ;
gen msize_ratio = size1/size ;
format msize_ratio %6.4f ;
gen fsize_ratio = size2/size ;
format fsize_ratio %6.4f ;
gen share_diff =  fsize_ratio  - msize_ratio ;
format share_diff %6.4f ;


/*Male - Female Differences in Potential  on Female- Male Share*/

# delimit cr 
reg occ_wage_diff share_diff [aw=size]
egen sd_x1 = sd(share_diff)
egen sd_y1 = sd(occ_wage_diff)
gen scale1 = sd_x1/sd_y1
local b1 = string(_b[share_diff], "%6.4f") 
local s1 = string(_se[share_diff], "%6.4f") 
gen standard1 = scale1*`b1'
local x1 = string(standard1, "%6.4f")
#delimit ;
gen large_majors = 0 ;
foreach num of numlist
23 24 34 36 52 55 56 61 62{;
replace large_majors = 1 if major == `num' ;
} ;

# delimit ;
twoway ///
(lfit occ_wage_diff share_diff [aw=size], lcolor(maroon) lwidth(thick))
(scatter occ_wage_diff share_diff [aw=size], msymbol(circle) mlcolor(blue%50) mfcolor(none))
,legend(off)  xtitle(Female - Male Share Major) ytitle(Female - Male Mean Potential Ln Wage Occupation)
graphregion(color(white) margin(medlarge)) plotregion(fcolor(white) style(none)) ;
	  
graph export "major_sorting_female_dominated.pdf", replace ; 

/********Panel B*********/
# delimit cr
clear all 
cd "C:\Users\cmslo\Box Sync\JEP Replication files" 
use "main_analysis_file"
#delimit ;
keep if wt_occ_wage_nat != . &  wt_med_wage_nat != . ;
keep if a45 == 1 | a40 == 1 ;
drop if major == 6104 ;
gen size = 1 ;
collapse (mean) wt_med_wage_nat wt_occ_wage_nat (sum)size [aw=wt], by (sex major) ; 
reshape wide wt_med_wage_nat wt_occ_wage_nat size, i(major) j(sex) ;

gen occ_wage_diff = wt_occ_wage_nat2 - wt_occ_wage_nat1 ;
drop if occ_wage_diff == . ;
rename wt_med_wage_nat1 potential_wage_major ;

gen size = size1 + size2 ;
drop if size == . ;

/*Male - Female Differences in Potential  on Potential Wage based on Major*/

# delimit cr 
reg occ_wage_diff potential_wage_major [aw=size]
egen sd_x1 = sd(potential_wage_major)
egen sd_y1 = sd(occ_wage_diff)
gen scale1 = sd_x1/sd_y1
local b1 = string(_b[potential_wage_major], "%6.4f") 
local s1 = string(_se[potential_wage_major], "%6.4f") 
gen standard1 = scale1*`b1'
local x1 = string(standard1, "%6.4f")
#delimit ;
gen large_majors = 0 ;
foreach num of numlist
23 24 34 36 52 55 56 61 62{;
replace large_majors = 1 if major == `num' ;
} ;

# delimit ;
twoway ///
(lfit occ_wage_diff potential_wage_major [aw=size], lcolor(maroon) lwidth(thick))
(scatter occ_wage_diff potential_wage_major [aw=size], msymbol(circle) mlcolor(blue%50) mfcolor(none))
,legend(off)  xtitle(Potential Wage Based on Major) ytitle(Female - Male Mean Potential Ln Wage Occupation)
  graphregion(color(white) margin(medlarge)) plotregion(fcolor(white) style(none)) ;
	  
graph export "major_sorting_major_income.pdf", replace ; 

log close ;

/************Figure A8: Potential Hours Worked Index in Major and Occupation by Cohort :
The data for these graphs is generated in  this program and is exported to Excel to make into graphs.
x-axis for Figure A8: five-year birth cohort
y-axis for Figure A8: potential hours worked indices for detailed major  (solid line), detailed occupation (dashed line)
Note: 
the variable age_group identifies our 5-year birth cohorts, the variable wt is our weight variable, 
the variable wt_med_hours_nat is our potential hours worked for majors 
the variable wt_occ_hours_nat  is our potential hours worked for occupations
the variable potential_major_* is our potential hours worked index for majors, birth cohort (this is what is graphed on y axis)
the variable wt_occ_hours_nat  is our potential hours worked for occupations
he variable potential_occ_* is our potential hours worked index for occupations, birth cohort (this is what is graphed on y axis)


Figure A9 displays $I^{H,Major}_c$ and $I^{H,Occ}_c$ for different cohorts. $I^{H,Major}_c$ is our potential hours index based on male annual hours worked in different majors
where $I^{H,Major}_{c} =  \frac{\sum_{m=1}^{M} s^m_{female,c} \bar{H}^m_{male}}{\sum_{m=1}^{M} s^m_{male,c} \bar{H}^m_{male}}-1$. 

Like our potential wage indices in the main text, the only reason $I^{H,Major}_{c}$ only differs from 0 if men and women inhabit different majors. Likewise, $I^{H,Occ}_c$ is our potential hours index based on male annual hours worked in different occupations and is defined as $I^{H,Occ}_{c} =  \frac{\sum_{o=1}^{O} s^m_{female,c} \bar{H}^o_{male}}{\sum_{o=1}^{O} s^m_{male,c} \bar{H}^o_{male}}-1$.

In practice, we compute this index by running the following regression locally within 5-year birth cohort $c$:


\bar{H}^m_{male_{i}} = \alpha + \beta Female_{i} + \Gamma X_{i} + \epsilon_{i}


where $Female_{i}$ is a dummy variable indicating whether the respondent $i$  has self-reported as female and $X_{i}$ is a vector of demographic characteristics: race, state of birth, masters attainment, doctorate attainment, and marital status. Our potential hours worked index, $I^{H,Major}_{c}, is defined as $\beta$ from each local regression by 5-year birth cohort and therefore, measures the differential ``potential'' hours worked of women of cohort $c$ given that the female distribution of  majors in a given cohort may differ from males in their cohort. The units of this index are differential potential hours worked based on major. In computing the comparable index for occupation, we substitute detailed occupation code, $o$, for detailed major code, $m$.

*/

/*First, we calculate male shares within each detailed major category for each five-year birth cohort*/
# delimit cr
clear all 

cd "C:\Users\cmslo\Box Sync\JEP Replication files" 
log using "C:\Users\cmslo\Box Sync\JEP Replication files\replication Figure A8_check.smcl", replace 
use "main_analysis_file"

/*Potential Hours Worked from Human Capital Specialization (Solid line)*/
#delimit cr

reg  wt_med_hours_nat female i.race i.super_state  i.marst  masters doctorate [aw=wt] if main_sample == 1 & a25 == 1, cluster(super_state) 

gen potential_major_1990	= _b[female] 

reg  wt_med_hours_nat female i.race i.super_state  i.marst  masters doctorate [aw=wt] if main_sample == 1 & a30 == 1, cluster(super_state) 

gen potential_major_1985	= _b[female] 

reg  wt_med_hours_nat female i.race i.super_state  i.marst  masters doctorate  [aw=wt] if main_sample == 1 & a35 == 1, cluster(super_state) 

gen potential_major_1980	= _b[female] 

reg  wt_med_hours_nat female i.race i.super_state  i.marst  masters doctorate  [aw=wt] if main_sample == 1 & a40 == 1, cluster(super_state) 

gen potential_major_1975	= _b[female] 

reg  wt_med_hours_nat female i.race i.super_state  i.marst  masters doctorate [aw=wt] if main_sample == 1 & a45 == 1, cluster(super_state) 

gen potential_major_1970	= _b[female] 

reg  wt_med_hours_nat female i.race i.super_state  i.marst  masters doctorate  [aw=wt] if main_sample == 1 & a50 == 1, cluster(super_state) 

gen potential_major_1965	= _b[female] 

reg  wt_med_hours_nat female i.race i.super_state  i.marst  masters doctorate [aw=wt] if main_sample == 1 & a55 == 1, cluster(super_state) 

gen potential_major_1960	= _b[female] 

reg  wt_med_hours_nat female i.race i.super_state  i.marst  masters doctorate [aw=wt] if main_sample == 1 & a60 == 1, cluster(super_state) 

gen potential_major_1955	= _b[female] 

reg  wt_med_hours_nat female i.race i.super_state  i.marst  masters doctorate  [aw=wt] if main_sample == 1 & a65 == 1, cluster(super_state) 

gen potential_major_1950	= _b[female] 


/*Potential Hours Worked from Occupational Specialization (dashed line)*/


reg  wt_occ_hours_nat female i.race i.super_state  i.marst  masters doctorate [aw=wt] if main_sample == 1 & a25 == 1, cluster(super_state) 

gen potential_occ_1990	= _b[female] 

reg  wt_occ_hours_nat female i.race i.super_state  i.marst  masters doctorate [aw=wt] if main_sample == 1 & a30 == 1, cluster(super_state) 

gen potential_occ_1985	= _b[female] 

reg  wt_occ_hours_nat female i.race i.super_state  i.marst  masters doctorate  [aw=wt] if main_sample == 1 & a35 == 1, cluster(super_state) 

gen potential_occ_1980	= _b[female] 

reg  wt_occ_hours_nat female i.race i.super_state  i.marst  masters doctorate  [aw=wt] if main_sample == 1 & a40 == 1, cluster(super_state) 

gen potential_occ_1975	= _b[female] 

reg  wt_occ_hours_nat female i.race i.super_state  i.marst  masters doctorate [aw=wt] if main_sample == 1 & a45 == 1, cluster(super_state) 

gen potential_occ_1970	= _b[female] 

reg  wt_occ_hours_nat female i.race i.super_state  i.marst  masters doctorate  [aw=wt] if main_sample == 1 & a50 == 1, cluster(super_state) 

gen potential_occ_1965	= _b[female] 

reg  wt_occ_hours_nat female i.race i.super_state  i.marst  masters doctorate [aw=wt] if main_sample == 1 & a55 == 1, cluster(super_state) 

gen potential_occ_1960	= _b[female] 

reg  wt_occ_hours_nat female i.race i.super_state  i.marst  masters doctorate [aw=wt] if main_sample == 1 & a60 == 1, cluster(super_state) 

gen potential_occ_1955	= _b[female] 

reg  wt_occ_hours_nat female i.race i.super_state  i.marst  masters doctorate  [aw=wt] if main_sample == 1 & a65 == 1, cluster(super_state) 

gen potential_occ_1950	= _b[female] 

/*here, we just collapse so we have an easy file with just our potential hours worked indices to copy and paste into Excel-- it reads wide */
gen sample = 1 
collapse (mean) potential* [aw=wt], by(sample)

/*here, we go to browse mode so we can easily copy and paste to Excel*/
browse
log close 


/***************************************************************************************************************************************************************/
/************Figure A9: Mapping of Potential Wage by Major to Potential Wage by Occupation, by Gender and Cohort:

The data for these graphs is generated in this program and is exported to Excel to make into graphs.

We focus on the 1955 & 1975 5-year birth cohorts. 

Panel A: measures the extent to which the mapping patterns overall are concentrated within certain parts of the major pay distribution

x-axis: we bin the detailed group of 134 majors into deciles based on the potential wage of the major. The top decile of majors (right-most bin along the x-axis) includes high earning majors like Economics, Chemical Engineering, Biochemical Sciences, Physics and Pharmacy. The bottom decile includes majors like Communications, Elementary Education, Theology, Counseling Psychology, and Drama and Theater Arts. 

y-axis:  we compute the within-major-bin mean potential wages based on occupation. We perform this analysis separately by gender and five-year birth cohort (1955, 1975 cohorts)
The two top lines (that are dashed) show the mapping of majors to occupations for men from 1955 and 1975 five-year birth cohorts. The bottom two lines (that are solid) show the mapping of majors to occupations for women of the 1955 and 1975 five-year birth cohorts. 

Panel B: shows the difference in the mapping between men and women for each of the two cohorts. 

x-axis: we bin the detailed group of 134 majors into deciles based on the potential wage of the major. (same as in Panel A)

y-axis:  we compute the female - male within-major-bin mean potential wages based on occupation. We do this for both five-year birth cohorts (1955, 1975 cohorts)

The black dashed line 1955 five-year birth cohort. The blue dashed line 1975 five-year birth cohort. 


***********************************************/

# delimit cr
clear all 

cd "C:\Users\cmslo\Box Sync\JEP Replication files" 
log using "C:\Users\cmslo\Box Sync\JEP Replication files\replication Figure A9_check.smcl", replace 
use "main_analysis_file"

 
 /*we rank majors by the potential wage index in majors (this is based on men, so for the binning part of this exercise, we drop women)*/
 
keep if male_sample == 1

egen major_bins = xtile(wt_med_wage_nat),  nq(10)
 
tab major_bins [aw=wt]
 
 /*need to create a csv file that maps the majors to the bin group to be merged into the larger file*/
 tab major if major_bin == 1
 tab major if major_bin == 2
 tab major if major_bin == 3
 tab major if major_bin == 4
 tab major if major_bin == 5
 tab major if major_bin == 6
 tab major if major_bin == 7
  tab major if major_bin == 8
 tab major if major_bin == 9
 tab major if major_bin == 10
 
 /*now, we copy & paste this into an Excel file (found in replication folder as "bin groups.csv")*/
#delimit cr
 clear all 

cd "C:\Users\cmslo\Box Sync\JEP Replication files" 
 /*now, we read the .csv file in to generate a .dta file that idenitifies our bin groups"*/

 import delimited "C:\Users\cmslo\Box Sync\JEP Replication files\bin groups.csv"
 
 save "bin groups", replace 
 
 
 /*now, we need to merge in our bin group file to our larger data set*/
 
 # delimit cr
clear all 

cd "C:\Users\cmslo\Box Sync\JEP Replication files" 
use "main_analysis_file"
sort major

joinby major using "bin groups"

/*we restrict the sample to those without missing occupation data.*/
keep if wt_occ_wage_nat !=.

/*we are going to focus on only the 1955 & 1975 5-year birth cohorts. here, we restict our sample to just those birth cohorts*/

keep if a60 == 1 | a40 == 1 

tab age_group

/*now, we calculate the within-bin mean potential occupaton wage. */
collapse (mean ) wt_occ_wage_nat [pw=wt], by(age_group sex bin_group) 

/*Note: now the unit of observation for the file is the five-year birth cohort x gender x bin*/

/*now, we go to browse mode so we can easily copy and paste data to Excel to make the graphs*/

browse 

/*for Panel B, once in Excel, for each cohort, we subtract female - male within-bin mean potential wage based on occupation */

 
 log close 
 
 /***************************************************************************************************************************************************************/
/************Figure A10: Within-Major Gender Differences in Potential Hours by Occupation, by Gender and Cohort:



The data for these graphs is generated in  this program and is exported to Excel to make into graphs.
x-axis for Figure A10: five-year birth cohort
y-axis for Figure A10: female - male mean potential occupational hours worked
Panel A: male-dominated majors of Biology/Life Sciences, Business, History, Physical Sciences, Engineering
Panel B: female-dominated majors Nursing/ Pharmacy, Education, Psychology, Foreign Language, Fine Arts
Note: the variable major_broad identifies our broad major categories, the variable age_group identifies our 5-year birth cohorts, the variable wt is our weight variable
wt_occ_hours_nat is our potential occupational hours worked variable

****************/

# delimit ;
clear all ;

cd "C:\Users\cmslo\Box Sync\JEP Replication files" ;
log using "C:\Users\cmslo\Box Sync\JEP Replication files\replication Figure A10_check.smcl", replace ;
use "main_analysis_file" ;

gen engineering = 0 ;

replace engineering = 1 if major_broad == 24 ;

gen biology = 0 ;
replace biology = 1 if major_broad == 36 ;

gen physical_sciences = 0 ;
replace physical_sciences = 1 if major_broad == 50 ;

gen business = 0 ;
replace business = 1 if major_broad == 62 ;

gen history = 0 ;
replace history = 1 if major_broad == 64 ;

gen education = 0 ;
replace education = 1 if major_broad == 23 ;

gen psychology = 0 ;
replace psychology = 1 if major_broad == 52 ;

gen fine_arts = 0 ;
replace fine_arts = 1 if major_broad == 60 ;

gen medical = 0 ;
replace medical = 1 if major_broad == 61 ;

gen languages = 0 ;
replace languages = 1 if major_broad == 26 ;

keep if major != . ;

#delimit cr
gen major_cat = .
replace major_cat = 1 if engineering == 1 
replace major_cat = 2 if biology == 1
replace major_cat = 3 if physical_sciences == 1
replace major_cat = 4 if business == 1
replace major_cat = 5 if history == 1
replace major_cat = 6 if education == 1
replace major_cat = 7 if psychology == 1
replace major_cat = 8 if fine_arts == 1
replace major_cat = 9 if medical == 1 
replace major_cat = 10 if languages == 1

label var major_cat      `"major name"'
label define major_cat_lbl 1 `"engineering"'
label define major_cat_lbl 2 `"biology"', add
label define major_cat_lbl 3 `"physical sciences"', add
label define major_cat_lbl 4 `"business"', add
label define major_cat_lbl 5 `"history"', add
label define major_cat_lbl 6 `"education"', add
label define major_cat_lbl 7 `"psychology"', add
label define major_cat_lbl 8 `"fine arts"', add
label define major_cat_lbl 9 `"medical"', add
label define major_cat_lbl 10 `"languages"', add
label values major_cat major_cat_lbl


#delimit ;
collapse (mean ) wt_occ_hours_nat [pw=wt], by(age_group sex major_cat) ;

drop if major_cat == . ;

/*now, we go to browse mode so we can easily copy and paste data to Excel to make the graphs*/

browse ;

/*Note: In excel, we subtract female- male values of wt_occ_hours_nat to get our y-axis */

log close ;

/***************************************************************************************************************************************************************/
/************Figure A11: Mapping of Potential Hours by Major to Potential Wage by Occupation, by Gender and Cohort:

The data for these graphs is generated in this program and is exported to Excel to make into graphs.

We focus on the 1955 & 1975 5-year birth cohorts. This Figure is analagous to Figure A9 but instead of describing occupations by potential wages, we describe them by potential hours worked. The x-axis is the same as Figure A9.

Panel A: measures the extent to which the mapping patterns overall are concentrated within certain parts of the major pay distribution

x-axis: we bin the detailed group of 134 majors into deciles based on the potential wage of the major (just as we do in Figure A9).  

y-axis:  we compute the within-major-bin mean potential hours worked based on occupation. We perform this analysis separately by gender and five-year birth cohort (1955, 1975 cohorts)
The two top lines (that are dashed) show the mapping of majors to occupations for men from 1955 and 1975 five-year birth cohorts. The bottom two lines (that are solid) show the mapping of majors to occupations for women of the 1955 and 1975 five-year birth cohorts. 

Panel B: shows the difference in the mapping between men and women for each of the two cohorts. 

x-axis: we bin the detailed group of 134 majors into deciles based on the potential wage of the major. (same as in Panel A)

y-axis:  we compute the female - male within-major-bin mean potential hours worked based on occupation. We do this for both five-year birth cohorts (1955, 1975 cohorts)

The black dashed line 1955 five-year birth cohort. The blue dashed line 1975 five-year birth cohort. 


***********************************************/

# delimit cr
clear all 

cd "C:\Users\cmslo\Box Sync\JEP Replication files" 
log using "C:\Users\cmslo\Box Sync\JEP Replication files\replication Figure A11_check.smcl", replace 
use "main_analysis_file"

 
 /*we rank majors by the potential wage index in majors (this is based on men, so for the binning part of this exercise, we drop women): this exactly what we do in Figure A10*/
 
keep if male_sample == 1

egen major_bins = xtile(wt_med_wage_nat),  nq(10)
 
tab major_bins [aw=wt]
 
 /*need to create a csv file that maps the majors to the bin group to be merged into the larger file*/
 tab major if major_bin == 1
 tab major if major_bin == 2
 tab major if major_bin == 3
 tab major if major_bin == 4
 tab major if major_bin == 5
 tab major if major_bin == 6
 tab major if major_bin == 7
  tab major if major_bin == 8
 tab major if major_bin == 9
 tab major if major_bin == 10
 
 /*now, we copy & paste this into an Excel file (found in replication folder as "bin groups.csv")*/
#delimit cr
 clear all 

cd "C:\Users\cmslo\Box Sync\JEP Replication files" 
 /*now, we read the .csv file in to generate a .dta file that idenitifies our bin groups"*/

 import delimited "C:\Users\cmslo\Box Sync\JEP Replication files\bin groups.csv"
 
 save "bin groups", replace 
 
 
 /*now, we need to merge in our bin group file to our larger data set*/
 
 # delimit cr
clear all 

cd "C:\Users\cmslo\Box Sync\JEP Replication files" 
use "main_analysis_file"
sort major

joinby major using "bin groups"

/*we restrict the sample to those without missing occupation data.*/
keep if wt_occ_hours_nat !=.

/*we are going to focus on only the 1955 & 1975 5-year birth cohorts. here, we restict our sample to just those birth cohorts*/

keep if a60 == 1 | a40 == 1 

tab age_group

/*now, we calculate the within-bin mean potential occupaton hours. */
collapse (mean ) wt_occ_hours_nat [pw=wt], by(age_group sex bin_group) 

/*Note: now the unit of observation for the file is the five-year birth cohort x gender x bin*/

/*now, we go to browse mode so we can easily copy and paste data to Excel to make the graphs*/

browse 

/*for Panel B, once in Excel, for each cohort, we subtract female - male within-bin mean potential wage based on occupation */

 
 log close 
 
/**************************************************************************************************************************************************************************************************/
/*************************************************************************TABLES*******************************************************************************************************************/
/**************************************************************************************************************************************************************************************************/

/************Table A1: Robustness of Trends in Inverse Duncan-Duncan Index for Gender Occupational Similarity, Controlling for Age Effects:

Values are calculated here for the table and then copy and pasted into our Overleaf table.

This table computes the inverse Duncan-Duncan index for gender similarity in occupational sorting ($I^{DD,Occ}_c$) for different birth cohorts and age ranges. See main text for construction of the index. Cohorts are five year birth cohorts centered around the birth cohort listed. Age are five year age ranges centered around the age listed. Data come from the 1980, 1990, and 2000 U.S. Censuses as well as various years of the American Community Survey. 

We start by reading in and cleaning the U.S. Census Data: 1980, 1990, 2000 Census, the 2008-2012 ACS, and the 2014-2017 ACS from IPUMS USA (Ruggles et al, 2019) 
****************/
# delimit ;
clear all ;

cd "C:\Users\cmslo\Box Sync\JEP Replication files" ;
log using "C:\Users\cmslo\Box Sync\JEP Replication files\replication Table A1_check.smcl", replace ;

#delimit cr
set more off

clear
quietly infix                 ///
  int     year       1-4      ///
  byte    datanum    5-6      ///
  double  serial     7-14     ///
  double  cbserial   15-27    ///
  double  hhwt       28-37    ///
  byte    gq         38-38    ///
  byte    qgq        39-39    ///
  int     pernum     40-43    ///
  double  perwt      44-53    ///
  byte    sex        54-54    ///
  int     age        55-57    ///
  int     birthyr    58-61    ///
  byte    race       62-62    ///
  int     raced      63-65    ///
  byte    hispan     66-66    ///
  int     hispand    67-69    ///
  int     bpl        70-72    ///
  long    bpld       73-77    ///
  byte    educ       78-79    ///
  int     educd      80-82    ///
  int     occ        83-86    ///
  int     occ1950    87-89    ///
  int     occ1990    90-92    ///
  int     occ2010    93-96    ///
  int     ind        97-100   ///
  int     ind1950    101-103  ///
  int     ind1990    104-106  ///
  byte    classwkr   107-107  ///
  byte    classwkrd  108-109  ///
  byte    wkswork2   110-110  ///
  byte    uhrswork   111-112  ///
  byte    qage       113-113  ///
  byte    qsex       114-114  ///
  byte    qbpl       115-115  ///
  byte    qhispan    116-116  ///
  byte    qrace      117-117  ///
  byte    qrace2     118-118  ///
  byte    qeduc      119-119  ///
  byte    qclasswk   120-120  ///
  byte    qind       121-121  ///
  byte    qocc       122-122  ///
  byte    quhrswor   123-123  ///
  byte    qwkswork   124-124  ///
  using `"usa_00147.dat"'

replace hhwt      = hhwt      / 100
replace perwt     = perwt     / 100

format serial    %8.0g
format cbserial  %13.0g
format hhwt      %10.2f
format perwt     %10.2f

label var year      `"Census year"'
label var datanum   `"Data set number"'
label var serial    `"Household serial number"'
label var cbserial  `"Original Census Bureau household serial number"'
label var hhwt      `"Household weight"'
label var gq        `"Group quarters status"'
label var qgq       `"Flag for Gq"'
label var pernum    `"Person number in sample unit"'
label var perwt     `"Person weight"'
label var sex       `"Sex"'
label var age       `"Age"'
label var birthyr   `"Year of birth"'
label var race      `"Race [general version]"'
label var raced     `"Race [detailed version]"'
label var hispan    `"Hispanic origin [general version]"'
label var hispand   `"Hispanic origin [detailed version]"'
label var bpl       `"Birthplace [general version]"'
label var bpld      `"Birthplace [detailed version]"'
label var educ      `"Educational attainment [general version]"'
label var educd     `"Educational attainment [detailed version]"'
label var occ       `"Occupation"'
label var occ1950   `"Occupation, 1950 basis"'
label var occ1990   `"Occupation, 1990 basis"'
label var occ2010   `"Occupation, 2010 basis"'
label var ind       `"Industry"'
label var ind1950   `"Industry, 1950 basis"'
label var ind1990   `"Industry, 1990 basis"'
label var classwkr  `"Class of worker [general version]"'
label var classwkrd `"Class of worker [detailed version]"'
label var wkswork2  `"Weeks worked last year, intervalled"'
label var uhrswork  `"Usual hours worked per week"'
label var qage      `"Flag for Age"'
label var qsex      `"Flag for Sex"'
label var qbpl      `"Flag for Bpl, Nativity"'
label var qhispan   `"Flag for Hispan"'
label var qrace     `"Flag for Race, Racamind, Racasian, Racblk, Racpais, Racwht, Racoth, Racnum, Race"'
label var qrace2    `"Flag for Race"'
label var qeduc     `"Flag for Educrec, Higrade, Educ99"'
label var qclasswk  `"Flag for Classwkr"'
label var qind      `"Flag for Ind, Ind1950"'
label var qocc      `"Flag for Occ, Occ1950, SEI, Occscore, Occsoc, Labforce"'
label var quhrswor  `"Flag for Uhrswork"'
label var qwkswork  `"Flag for Wkswork1, Wkswork2"'

label define year_lbl 1850 `"1850"'
label define year_lbl 1860 `"1860"', add
label define year_lbl 1870 `"1870"', add
label define year_lbl 1880 `"1880"', add
label define year_lbl 1900 `"1900"', add
label define year_lbl 1910 `"1910"', add
label define year_lbl 1920 `"1920"', add
label define year_lbl 1930 `"1930"', add
label define year_lbl 1940 `"1940"', add
label define year_lbl 1950 `"1950"', add
label define year_lbl 1960 `"1960"', add
label define year_lbl 1970 `"1970"', add
label define year_lbl 1980 `"1980"', add
label define year_lbl 1990 `"1990"', add
label define year_lbl 2000 `"2000"', add
label define year_lbl 2001 `"2001"', add
label define year_lbl 2002 `"2002"', add
label define year_lbl 2003 `"2003"', add
label define year_lbl 2004 `"2004"', add
label define year_lbl 2005 `"2005"', add
label define year_lbl 2006 `"2006"', add
label define year_lbl 2007 `"2007"', add
label define year_lbl 2008 `"2008"', add
label define year_lbl 2009 `"2009"', add
label define year_lbl 2010 `"2010"', add
label define year_lbl 2011 `"2011"', add
label define year_lbl 2012 `"2012"', add
label define year_lbl 2013 `"2013"', add
label define year_lbl 2014 `"2014"', add
label define year_lbl 2015 `"2015"', add
label define year_lbl 2016 `"2016"', add
label define year_lbl 2017 `"2017"', add
label values year year_lbl

label define gq_lbl 0 `"Vacant unit"'
label define gq_lbl 1 `"Households under 1970 definition"', add
label define gq_lbl 2 `"Additional households under 1990 definition"', add
label define gq_lbl 3 `"Group quarters--Institutions"', add
label define gq_lbl 4 `"Other group quarters"', add
label define gq_lbl 5 `"Additional households under 2000 definition"', add
label define gq_lbl 6 `"Fragment"', add
label values gq gq_lbl

label define qgq_lbl 0 `"Original entry or Inapplicable (not in universe)"'
label define qgq_lbl 1 `"Failed edit"', add
label define qgq_lbl 2 `"Illegible"', add
label define qgq_lbl 3 `"Missing"', add
label define qgq_lbl 4 `"Allocated"', add
label define qgq_lbl 5 `"Cold deck allocation (select variables)"', add
label define qgq_lbl 6 `"Missing"', add
label define qgq_lbl 7 `"Original entry illegible"', add
label define qgq_lbl 8 `"Original entry missing or failed edit"', add
label values qgq qgq_lbl

label define sex_lbl 1 `"Male"'
label define sex_lbl 2 `"Female"', add
label values sex sex_lbl

label define age_lbl 000 `"Less than 1 year old"'
label define age_lbl 001 `"1"', add
label define age_lbl 002 `"2"', add
label define age_lbl 003 `"3"', add
label define age_lbl 004 `"4"', add
label define age_lbl 005 `"5"', add
label define age_lbl 006 `"6"', add
label define age_lbl 007 `"7"', add
label define age_lbl 008 `"8"', add
label define age_lbl 009 `"9"', add
label define age_lbl 010 `"10"', add
label define age_lbl 011 `"11"', add
label define age_lbl 012 `"12"', add
label define age_lbl 013 `"13"', add
label define age_lbl 014 `"14"', add
label define age_lbl 015 `"15"', add
label define age_lbl 016 `"16"', add
label define age_lbl 017 `"17"', add
label define age_lbl 018 `"18"', add
label define age_lbl 019 `"19"', add
label define age_lbl 020 `"20"', add
label define age_lbl 021 `"21"', add
label define age_lbl 022 `"22"', add
label define age_lbl 023 `"23"', add
label define age_lbl 024 `"24"', add
label define age_lbl 025 `"25"', add
label define age_lbl 026 `"26"', add
label define age_lbl 027 `"27"', add
label define age_lbl 028 `"28"', add
label define age_lbl 029 `"29"', add
label define age_lbl 030 `"30"', add
label define age_lbl 031 `"31"', add
label define age_lbl 032 `"32"', add
label define age_lbl 033 `"33"', add
label define age_lbl 034 `"34"', add
label define age_lbl 035 `"35"', add
label define age_lbl 036 `"36"', add
label define age_lbl 037 `"37"', add
label define age_lbl 038 `"38"', add
label define age_lbl 039 `"39"', add
label define age_lbl 040 `"40"', add
label define age_lbl 041 `"41"', add
label define age_lbl 042 `"42"', add
label define age_lbl 043 `"43"', add
label define age_lbl 044 `"44"', add
label define age_lbl 045 `"45"', add
label define age_lbl 046 `"46"', add
label define age_lbl 047 `"47"', add
label define age_lbl 048 `"48"', add
label define age_lbl 049 `"49"', add
label define age_lbl 050 `"50"', add
label define age_lbl 051 `"51"', add
label define age_lbl 052 `"52"', add
label define age_lbl 053 `"53"', add
label define age_lbl 054 `"54"', add
label define age_lbl 055 `"55"', add
label define age_lbl 056 `"56"', add
label define age_lbl 057 `"57"', add
label define age_lbl 058 `"58"', add
label define age_lbl 059 `"59"', add
label define age_lbl 060 `"60"', add
label define age_lbl 061 `"61"', add
label define age_lbl 062 `"62"', add
label define age_lbl 063 `"63"', add
label define age_lbl 064 `"64"', add
label define age_lbl 065 `"65"', add
label define age_lbl 066 `"66"', add
label define age_lbl 067 `"67"', add
label define age_lbl 068 `"68"', add
label define age_lbl 069 `"69"', add
label define age_lbl 070 `"70"', add
label define age_lbl 071 `"71"', add
label define age_lbl 072 `"72"', add
label define age_lbl 073 `"73"', add
label define age_lbl 074 `"74"', add
label define age_lbl 075 `"75"', add
label define age_lbl 076 `"76"', add
label define age_lbl 077 `"77"', add
label define age_lbl 078 `"78"', add
label define age_lbl 079 `"79"', add
label define age_lbl 080 `"80"', add
label define age_lbl 081 `"81"', add
label define age_lbl 082 `"82"', add
label define age_lbl 083 `"83"', add
label define age_lbl 084 `"84"', add
label define age_lbl 085 `"85"', add
label define age_lbl 086 `"86"', add
label define age_lbl 087 `"87"', add
label define age_lbl 088 `"88"', add
label define age_lbl 089 `"89"', add
label define age_lbl 090 `"90 (90+ in 1980 and 1990)"', add
label define age_lbl 091 `"91"', add
label define age_lbl 092 `"92"', add
label define age_lbl 093 `"93"', add
label define age_lbl 094 `"94"', add
label define age_lbl 095 `"95"', add
label define age_lbl 096 `"96"', add
label define age_lbl 097 `"97"', add
label define age_lbl 098 `"98"', add
label define age_lbl 099 `"99"', add
label define age_lbl 100 `"100 (100+ in 1960-1970)"', add
label define age_lbl 101 `"101"', add
label define age_lbl 102 `"102"', add
label define age_lbl 103 `"103"', add
label define age_lbl 104 `"104"', add
label define age_lbl 105 `"105"', add
label define age_lbl 106 `"106"', add
label define age_lbl 107 `"107"', add
label define age_lbl 108 `"108"', add
label define age_lbl 109 `"109"', add
label define age_lbl 110 `"110"', add
label define age_lbl 111 `"111"', add
label define age_lbl 112 `"112 (112+ in the 1980 internal data)"', add
label define age_lbl 113 `"113"', add
label define age_lbl 114 `"114"', add
label define age_lbl 115 `"115 (115+ in the 1990 internal data)"', add
label define age_lbl 116 `"116"', add
label define age_lbl 117 `"117"', add
label define age_lbl 118 `"118"', add
label define age_lbl 119 `"119"', add
label define age_lbl 120 `"120"', add
label define age_lbl 121 `"121"', add
label define age_lbl 122 `"122"', add
label define age_lbl 123 `"123"', add
label define age_lbl 124 `"124"', add
label define age_lbl 125 `"125"', add
label define age_lbl 126 `"126"', add
label define age_lbl 129 `"129"', add
label define age_lbl 130 `"130"', add
label define age_lbl 135 `"135"', add
label values age age_lbl

label define race_lbl 1 `"White"'
label define race_lbl 2 `"Black/African American/Negro"', add
label define race_lbl 3 `"American Indian or Alaska Native"', add
label define race_lbl 4 `"Chinese"', add
label define race_lbl 5 `"Japanese"', add
label define race_lbl 6 `"Other Asian or Pacific Islander"', add
label define race_lbl 7 `"Other race, nec"', add
label define race_lbl 8 `"Two major races"', add
label define race_lbl 9 `"Three or more major races"', add
label values race race_lbl

label define raced_lbl 100 `"White"'
label define raced_lbl 110 `"Spanish write_in"', add
label define raced_lbl 120 `"Blank (white) (1850)"', add
label define raced_lbl 130 `"Portuguese"', add
label define raced_lbl 140 `"Mexican (1930)"', add
label define raced_lbl 150 `"Puerto Rican (1910 Hawaii)"', add
label define raced_lbl 200 `"Black/African American/Negro"', add
label define raced_lbl 210 `"Mulatto"', add
label define raced_lbl 300 `"American Indian/Alaska Native"', add
label define raced_lbl 302 `"Apache"', add
label define raced_lbl 303 `"Blackfoot"', add
label define raced_lbl 304 `"Cherokee"', add
label define raced_lbl 305 `"Cheyenne"', add
label define raced_lbl 306 `"Chickasaw"', add
label define raced_lbl 307 `"Chippewa"', add
label define raced_lbl 308 `"Choctaw"', add
label define raced_lbl 309 `"Comanche"', add
label define raced_lbl 310 `"Creek"', add
label define raced_lbl 311 `"Crow"', add
label define raced_lbl 312 `"Iroquois"', add
label define raced_lbl 313 `"Kiowa"', add
label define raced_lbl 314 `"Lumbee"', add
label define raced_lbl 315 `"Navajo"', add
label define raced_lbl 316 `"Osage"', add
label define raced_lbl 317 `"Paiute"', add
label define raced_lbl 318 `"Pima"', add
label define raced_lbl 319 `"Potawatomi"', add
label define raced_lbl 320 `"Pueblo"', add
label define raced_lbl 321 `"Seminole"', add
label define raced_lbl 322 `"Shoshone"', add
label define raced_lbl 323 `"Sioux"', add
label define raced_lbl 324 `"Tlingit (Tlingit_Haida, 2000/ACS)"', add
label define raced_lbl 325 `"Tohono O Odham"', add
label define raced_lbl 326 `"All other tribes (1990)"', add
label define raced_lbl 328 `"Hopi"', add
label define raced_lbl 329 `"Central American Indian"', add
label define raced_lbl 330 `"Spanish American Indian"', add
label define raced_lbl 350 `"Delaware"', add
label define raced_lbl 351 `"Latin American Indian"', add
label define raced_lbl 352 `"Puget Sound Salish"', add
label define raced_lbl 353 `"Yakama"', add
label define raced_lbl 354 `"Yaqui"', add
label define raced_lbl 355 `"Colville"', add
label define raced_lbl 356 `"Houma"', add
label define raced_lbl 357 `"Menominee"', add
label define raced_lbl 358 `"Yuman"', add
label define raced_lbl 359 `"South American Indian"', add
label define raced_lbl 360 `"Mexican American Indian"', add
label define raced_lbl 361 `"Other Amer. Indian tribe (2000,ACS)"', add
label define raced_lbl 362 `"2+ Amer. Indian tribes (2000,ACS)"', add
label define raced_lbl 370 `"Alaskan Athabaskan"', add
label define raced_lbl 371 `"Aleut"', add
label define raced_lbl 372 `"Eskimo"', add
label define raced_lbl 373 `"Alaskan mixed"', add
label define raced_lbl 374 `"Inupiat"', add
label define raced_lbl 375 `"Yup'ik"', add
label define raced_lbl 379 `"Other Alaska Native tribe(s) (2000,ACS)"', add
label define raced_lbl 398 `"Both Am. Ind. and Alaska Native (2000,ACS)"', add
label define raced_lbl 399 `"Tribe not specified"', add
label define raced_lbl 400 `"Chinese"', add
label define raced_lbl 410 `"Taiwanese"', add
label define raced_lbl 420 `"Chinese and Taiwanese"', add
label define raced_lbl 500 `"Japanese"', add
label define raced_lbl 600 `"Filipino"', add
label define raced_lbl 610 `"Asian Indian (Hindu 1920_1940)"', add
label define raced_lbl 620 `"Korean"', add
label define raced_lbl 630 `"Hawaiian"', add
label define raced_lbl 631 `"Hawaiian and Asian (1900,1920)"', add
label define raced_lbl 632 `"Hawaiian and European (1900,1920)"', add
label define raced_lbl 634 `"Hawaiian mixed"', add
label define raced_lbl 640 `"Vietnamese"', add
label define raced_lbl 641 `"Bhutanese"', add
label define raced_lbl 642 `"Mongolian"', add
label define raced_lbl 643 `"Nepalese"', add
label define raced_lbl 650 `"Other Asian or Pacific Islander (1920,1980)"', add
label define raced_lbl 651 `"Asian only (CPS)"', add
label define raced_lbl 652 `"Pacific Islander only (CPS)"', add
label define raced_lbl 653 `"Asian or Pacific Islander, n.s. (1990 Internal Census files)"', add
label define raced_lbl 660 `"Cambodian"', add
label define raced_lbl 661 `"Hmong"', add
label define raced_lbl 662 `"Laotian"', add
label define raced_lbl 663 `"Thai"', add
label define raced_lbl 664 `"Bangladeshi"', add
label define raced_lbl 665 `"Burmese"', add
label define raced_lbl 666 `"Indonesian"', add
label define raced_lbl 667 `"Malaysian"', add
label define raced_lbl 668 `"Okinawan"', add
label define raced_lbl 669 `"Pakistani"', add
label define raced_lbl 670 `"Sri Lankan"', add
label define raced_lbl 671 `"Other Asian, n.e.c."', add
label define raced_lbl 672 `"Asian, not specified"', add
label define raced_lbl 673 `"Chinese and Japanese"', add
label define raced_lbl 674 `"Chinese and Filipino"', add
label define raced_lbl 675 `"Chinese and Vietnamese"', add
label define raced_lbl 676 `"Chinese and Asian write_in"', add
label define raced_lbl 677 `"Japanese and Filipino"', add
label define raced_lbl 678 `"Asian Indian and Asian write_in"', add
label define raced_lbl 679 `"Other Asian race combinations"', add
label define raced_lbl 680 `"Samoan"', add
label define raced_lbl 681 `"Tahitian"', add
label define raced_lbl 682 `"Tongan"', add
label define raced_lbl 683 `"Other Polynesian (1990)"', add
label define raced_lbl 684 `"1+ other Polynesian races (2000,ACS)"', add
label define raced_lbl 685 `"Guamanian/Chamorro"', add
label define raced_lbl 686 `"Northern Mariana Islander"', add
label define raced_lbl 687 `"Palauan"', add
label define raced_lbl 688 `"Other Micronesian (1990)"', add
label define raced_lbl 689 `"1+ other Micronesian races (2000,ACS)"', add
label define raced_lbl 690 `"Fijian"', add
label define raced_lbl 691 `"Other Melanesian (1990)"', add
label define raced_lbl 692 `"1+ other Melanesian races (2000,ACS)"', add
label define raced_lbl 698 `"2+ PI races from 2+ PI regions"', add
label define raced_lbl 699 `"Pacific Islander, n.s."', add
label define raced_lbl 700 `"Other race, n.e.c."', add
label define raced_lbl 801 `"White and Black"', add
label define raced_lbl 802 `"White and AIAN"', add
label define raced_lbl 810 `"White and Asian"', add
label define raced_lbl 811 `"White and Chinese"', add
label define raced_lbl 812 `"White and Japanese"', add
label define raced_lbl 813 `"White and Filipino"', add
label define raced_lbl 814 `"White and Asian Indian"', add
label define raced_lbl 815 `"White and Korean"', add
label define raced_lbl 816 `"White and Vietnamese"', add
label define raced_lbl 817 `"White and Asian write_in"', add
label define raced_lbl 818 `"White and other Asian race(s)"', add
label define raced_lbl 819 `"White and two or more Asian groups"', add
label define raced_lbl 820 `"White and PI"', add
label define raced_lbl 821 `"White and Native Hawaiian"', add
label define raced_lbl 822 `"White and Samoan"', add
label define raced_lbl 823 `"White and Guamanian"', add
label define raced_lbl 824 `"White and PI write_in"', add
label define raced_lbl 825 `"White and other PI race(s)"', add
label define raced_lbl 826 `"White and other race write_in"', add
label define raced_lbl 827 `"White and other race, n.e.c."', add
label define raced_lbl 830 `"Black and AIAN"', add
label define raced_lbl 831 `"Black and Asian"', add
label define raced_lbl 832 `"Black and Chinese"', add
label define raced_lbl 833 `"Black and Japanese"', add
label define raced_lbl 834 `"Black and Filipino"', add
label define raced_lbl 835 `"Black and Asian Indian"', add
label define raced_lbl 836 `"Black and Korean"', add
label define raced_lbl 837 `"Black and Asian write_in"', add
label define raced_lbl 838 `"Black and other Asian race(s)"', add
label define raced_lbl 840 `"Black and PI"', add
label define raced_lbl 841 `"Black and PI write_in"', add
label define raced_lbl 842 `"Black and other PI race(s)"', add
label define raced_lbl 845 `"Black and other race write_in"', add
label define raced_lbl 850 `"AIAN and Asian"', add
label define raced_lbl 851 `"AIAN and Filipino (2000 1%)"', add
label define raced_lbl 852 `"AIAN and Asian Indian"', add
label define raced_lbl 853 `"AIAN and Asian write_in (2000 1%)"', add
label define raced_lbl 854 `"AIAN and other Asian race(s)"', add
label define raced_lbl 855 `"AIAN and PI"', add
label define raced_lbl 856 `"AIAN and other race write_in"', add
label define raced_lbl 860 `"Asian and PI"', add
label define raced_lbl 861 `"Chinese and Hawaiian"', add
label define raced_lbl 862 `"Chinese, Filipino, Hawaiian (2000 1%)"', add
label define raced_lbl 863 `"Japanese and Hawaiian (2000 1%)"', add
label define raced_lbl 864 `"Filipino and Hawaiian"', add
label define raced_lbl 865 `"Filipino and PI write_in"', add
label define raced_lbl 866 `"Asian Indian and PI write_in (2000 1%)"', add
label define raced_lbl 867 `"Asian write_in and PI write_in"', add
label define raced_lbl 868 `"Other Asian race(s) and PI race(s)"', add
label define raced_lbl 869 `"Japanese and Korean (ACS)"', add
label define raced_lbl 880 `"Asian and other race write_in"', add
label define raced_lbl 881 `"Chinese and other race write_in"', add
label define raced_lbl 882 `"Japanese and other race write_in"', add
label define raced_lbl 883 `"Filipino and other race write_in"', add
label define raced_lbl 884 `"Asian Indian and other race write_in"', add
label define raced_lbl 885 `"Asian write_in and other race write_in"', add
label define raced_lbl 886 `"Other Asian race(s) and other race write_in"', add
label define raced_lbl 887 `"Chinese and Korean"', add
label define raced_lbl 890 `"PI and other race write_in:"', add
label define raced_lbl 891 `"PI write_in and other race write_in"', add
label define raced_lbl 892 `"Other PI race(s) and other race write_in"', add
label define raced_lbl 893 `"Native Hawaiian or PI other race(s)"', add
label define raced_lbl 899 `"API and other race write_in"', add
label define raced_lbl 901 `"White, Black, AIAN"', add
label define raced_lbl 902 `"White, Black, Asian"', add
label define raced_lbl 903 `"White, Black, PI"', add
label define raced_lbl 904 `"White, Black, other race write_in"', add
label define raced_lbl 905 `"White, AIAN, Asian"', add
label define raced_lbl 906 `"White, AIAN, PI"', add
label define raced_lbl 907 `"White, AIAN, other race write_in"', add
label define raced_lbl 910 `"White, Asian, PI"', add
label define raced_lbl 911 `"White, Chinese, Hawaiian"', add
label define raced_lbl 912 `"White, Chinese, Filipino, Hawaiian (2000 1%)"', add
label define raced_lbl 913 `"White, Japanese, Hawaiian (2000 1%)"', add
label define raced_lbl 914 `"White, Filipino, Hawaiian"', add
label define raced_lbl 915 `"Other White, Asian race(s), PI race(s)"', add
label define raced_lbl 916 `"White, AIAN and Filipino"', add
label define raced_lbl 917 `"White, Black, and Filipino"', add
label define raced_lbl 920 `"White, Asian, other race write_in"', add
label define raced_lbl 921 `"White, Filipino, other race write_in (2000 1%)"', add
label define raced_lbl 922 `"White, Asian write_in, other race write_in (2000 1%)"', add
label define raced_lbl 923 `"Other White, Asian race(s), other race write_in (2000 1%)"', add
label define raced_lbl 925 `"White, PI, other race write_in"', add
label define raced_lbl 930 `"Black, AIAN, Asian"', add
label define raced_lbl 931 `"Black, AIAN, PI"', add
label define raced_lbl 932 `"Black, AIAN, other race write_in"', add
label define raced_lbl 933 `"Black, Asian, PI"', add
label define raced_lbl 934 `"Black, Asian, other race write_in"', add
label define raced_lbl 935 `"Black, PI, other race write_in"', add
label define raced_lbl 940 `"AIAN, Asian, PI"', add
label define raced_lbl 941 `"AIAN, Asian, other race write_in"', add
label define raced_lbl 942 `"AIAN, PI, other race write_in"', add
label define raced_lbl 943 `"Asian, PI, other race write_in"', add
label define raced_lbl 944 `"Asian (Chinese, Japanese, Korean, Vietnamese); and Native Hawaiian or PI; and Other"', add
label define raced_lbl 949 `"2 or 3 races (CPS)"', add
label define raced_lbl 950 `"White, Black, AIAN, Asian"', add
label define raced_lbl 951 `"White, Black, AIAN, PI"', add
label define raced_lbl 952 `"White, Black, AIAN, other race write_in"', add
label define raced_lbl 953 `"White, Black, Asian, PI"', add
label define raced_lbl 954 `"White, Black, Asian, other race write_in"', add
label define raced_lbl 955 `"White, Black, PI, other race write_in"', add
label define raced_lbl 960 `"White, AIAN, Asian, PI"', add
label define raced_lbl 961 `"White, AIAN, Asian, other race write_in"', add
label define raced_lbl 962 `"White, AIAN, PI, other race write_in"', add
label define raced_lbl 963 `"White, Asian, PI, other race write_in"', add
label define raced_lbl 964 `"White, Chinese, Japanese, Native Hawaiian"', add
label define raced_lbl 970 `"Black, AIAN, Asian, PI"', add
label define raced_lbl 971 `"Black, AIAN, Asian, other race write_in"', add
label define raced_lbl 972 `"Black, AIAN, PI, other race write_in"', add
label define raced_lbl 973 `"Black, Asian, PI, other race write_in"', add
label define raced_lbl 974 `"AIAN, Asian, PI, other race write_in"', add
label define raced_lbl 975 `"AIAN, Asian, PI, Hawaiian other race write_in"', add
label define raced_lbl 976 `"Two specified Asian  (Chinese and other Asian, Chinese and Japanese, Japanese and other Asian, Korean and other Asian); Native Hawaiian/PI; and Other Race"', add
label define raced_lbl 980 `"White, Black, AIAN, Asian, PI"', add
label define raced_lbl 981 `"White, Black, AIAN, Asian, other race write_in"', add
label define raced_lbl 982 `"White, Black, AIAN, PI, other race write_in"', add
label define raced_lbl 983 `"White, Black, Asian, PI, other race write_in"', add
label define raced_lbl 984 `"White, AIAN, Asian, PI, other race write_in"', add
label define raced_lbl 985 `"Black, AIAN, Asian, PI, other race write_in"', add
label define raced_lbl 986 `"Black, AIAN, Asian, PI, Hawaiian, other race write_in"', add
label define raced_lbl 989 `"4 or 5 races (CPS)"', add
label define raced_lbl 990 `"White, Black, AIAN, Asian, PI, other race write_in"', add
label define raced_lbl 991 `"White race; Some other race; Black or African American race and/or American Indian and Alaska Native race and/or Asian groups and/or Native Hawaiian and Other Pacific Islander groups"', add
label define raced_lbl 996 `"2+ races, n.e.c. (CPS)"', add
label values raced raced_lbl

label define hispan_lbl 0 `"Not Hispanic"'
label define hispan_lbl 1 `"Mexican"', add
label define hispan_lbl 2 `"Puerto Rican"', add
label define hispan_lbl 3 `"Cuban"', add
label define hispan_lbl 4 `"Other"', add
label define hispan_lbl 9 `"Not Reported"', add
label values hispan hispan_lbl

label define hispand_lbl 000 `"Not Hispanic"'
label define hispand_lbl 100 `"Mexican"', add
label define hispand_lbl 102 `"Mexican American"', add
label define hispand_lbl 103 `"Mexicano/Mexicana"', add
label define hispand_lbl 104 `"Chicano/Chicana"', add
label define hispand_lbl 105 `"La Raza"', add
label define hispand_lbl 106 `"Mexican American Indian"', add
label define hispand_lbl 107 `"Mexico"', add
label define hispand_lbl 200 `"Puerto Rican"', add
label define hispand_lbl 300 `"Cuban"', add
label define hispand_lbl 401 `"Central American Indian"', add
label define hispand_lbl 402 `"Canal Zone"', add
label define hispand_lbl 411 `"Costa Rican"', add
label define hispand_lbl 412 `"Guatemalan"', add
label define hispand_lbl 413 `"Honduran"', add
label define hispand_lbl 414 `"Nicaraguan"', add
label define hispand_lbl 415 `"Panamanian"', add
label define hispand_lbl 416 `"Salvadoran"', add
label define hispand_lbl 417 `"Central American, n.e.c."', add
label define hispand_lbl 420 `"Argentinean"', add
label define hispand_lbl 421 `"Bolivian"', add
label define hispand_lbl 422 `"Chilean"', add
label define hispand_lbl 423 `"Colombian"', add
label define hispand_lbl 424 `"Ecuadorian"', add
label define hispand_lbl 425 `"Paraguayan"', add
label define hispand_lbl 426 `"Peruvian"', add
label define hispand_lbl 427 `"Uruguayan"', add
label define hispand_lbl 428 `"Venezuelan"', add
label define hispand_lbl 429 `"South American Indian"', add
label define hispand_lbl 430 `"Criollo"', add
label define hispand_lbl 431 `"South American, n.e.c."', add
label define hispand_lbl 450 `"Spaniard"', add
label define hispand_lbl 451 `"Andalusian"', add
label define hispand_lbl 452 `"Asturian"', add
label define hispand_lbl 453 `"Castillian"', add
label define hispand_lbl 454 `"Catalonian"', add
label define hispand_lbl 455 `"Balearic Islander"', add
label define hispand_lbl 456 `"Gallego"', add
label define hispand_lbl 457 `"Valencian"', add
label define hispand_lbl 458 `"Canarian"', add
label define hispand_lbl 459 `"Spanish Basque"', add
label define hispand_lbl 460 `"Dominican"', add
label define hispand_lbl 465 `"Latin American"', add
label define hispand_lbl 470 `"Hispanic"', add
label define hispand_lbl 480 `"Spanish"', add
label define hispand_lbl 490 `"Californio"', add
label define hispand_lbl 491 `"Tejano"', add
label define hispand_lbl 492 `"Nuevo Mexicano"', add
label define hispand_lbl 493 `"Spanish American"', add
label define hispand_lbl 494 `"Spanish American Indian"', add
label define hispand_lbl 495 `"Meso American Indian"', add
label define hispand_lbl 496 `"Mestizo"', add
label define hispand_lbl 498 `"Other, n.s."', add
label define hispand_lbl 499 `"Other, n.e.c."', add
label define hispand_lbl 900 `"Not Reported"', add
label values hispand hispand_lbl

label define bpl_lbl 001 `"Alabama"'
label define bpl_lbl 002 `"Alaska"', add
label define bpl_lbl 004 `"Arizona"', add
label define bpl_lbl 005 `"Arkansas"', add
label define bpl_lbl 006 `"California"', add
label define bpl_lbl 008 `"Colorado"', add
label define bpl_lbl 009 `"Connecticut"', add
label define bpl_lbl 010 `"Delaware"', add
label define bpl_lbl 011 `"District of Columbia"', add
label define bpl_lbl 012 `"Florida"', add
label define bpl_lbl 013 `"Georgia"', add
label define bpl_lbl 015 `"Hawaii"', add
label define bpl_lbl 016 `"Idaho"', add
label define bpl_lbl 017 `"Illinois"', add
label define bpl_lbl 018 `"Indiana"', add
label define bpl_lbl 019 `"Iowa"', add
label define bpl_lbl 020 `"Kansas"', add
label define bpl_lbl 021 `"Kentucky"', add
label define bpl_lbl 022 `"Louisiana"', add
label define bpl_lbl 023 `"Maine"', add
label define bpl_lbl 024 `"Maryland"', add
label define bpl_lbl 025 `"Massachusetts"', add
label define bpl_lbl 026 `"Michigan"', add
label define bpl_lbl 027 `"Minnesota"', add
label define bpl_lbl 028 `"Mississippi"', add
label define bpl_lbl 029 `"Missouri"', add
label define bpl_lbl 030 `"Montana"', add
label define bpl_lbl 031 `"Nebraska"', add
label define bpl_lbl 032 `"Nevada"', add
label define bpl_lbl 033 `"New Hampshire"', add
label define bpl_lbl 034 `"New Jersey"', add
label define bpl_lbl 035 `"New Mexico"', add
label define bpl_lbl 036 `"New York"', add
label define bpl_lbl 037 `"North Carolina"', add
label define bpl_lbl 038 `"North Dakota"', add
label define bpl_lbl 039 `"Ohio"', add
label define bpl_lbl 040 `"Oklahoma"', add
label define bpl_lbl 041 `"Oregon"', add
label define bpl_lbl 042 `"Pennsylvania"', add
label define bpl_lbl 044 `"Rhode Island"', add
label define bpl_lbl 045 `"South Carolina"', add
label define bpl_lbl 046 `"South Dakota"', add
label define bpl_lbl 047 `"Tennessee"', add
label define bpl_lbl 048 `"Texas"', add
label define bpl_lbl 049 `"Utah"', add
label define bpl_lbl 050 `"Vermont"', add
label define bpl_lbl 051 `"Virginia"', add
label define bpl_lbl 053 `"Washington"', add
label define bpl_lbl 054 `"West Virginia"', add
label define bpl_lbl 055 `"Wisconsin"', add
label define bpl_lbl 056 `"Wyoming"', add
label define bpl_lbl 090 `"Native American"', add
label define bpl_lbl 099 `"United States, ns"', add
label define bpl_lbl 100 `"American Samoa"', add
label define bpl_lbl 105 `"Guam"', add
label define bpl_lbl 110 `"Puerto Rico"', add
label define bpl_lbl 115 `"U.S. Virgin Islands"', add
label define bpl_lbl 120 `"Other US Possessions"', add
label define bpl_lbl 150 `"Canada"', add
label define bpl_lbl 155 `"St. Pierre and Miquelon"', add
label define bpl_lbl 160 `"Atlantic Islands"', add
label define bpl_lbl 199 `"North America, ns"', add
label define bpl_lbl 200 `"Mexico"', add
label define bpl_lbl 210 `"Central America"', add
label define bpl_lbl 250 `"Cuba"', add
label define bpl_lbl 260 `"West Indies"', add
label define bpl_lbl 299 `"Americas, n.s."', add
label define bpl_lbl 300 `"SOUTH AMERICA"', add
label define bpl_lbl 400 `"Denmark"', add
label define bpl_lbl 401 `"Finland"', add
label define bpl_lbl 402 `"Iceland"', add
label define bpl_lbl 403 `"Lapland, n.s."', add
label define bpl_lbl 404 `"Norway"', add
label define bpl_lbl 405 `"Sweden"', add
label define bpl_lbl 410 `"England"', add
label define bpl_lbl 411 `"Scotland"', add
label define bpl_lbl 412 `"Wales"', add
label define bpl_lbl 413 `"United Kingdom, ns"', add
label define bpl_lbl 414 `"Ireland"', add
label define bpl_lbl 419 `"Northern Europe, ns"', add
label define bpl_lbl 420 `"Belgium"', add
label define bpl_lbl 421 `"France"', add
label define bpl_lbl 422 `"Liechtenstein"', add
label define bpl_lbl 423 `"Luxembourg"', add
label define bpl_lbl 424 `"Monaco"', add
label define bpl_lbl 425 `"Netherlands"', add
label define bpl_lbl 426 `"Switzerland"', add
label define bpl_lbl 429 `"Western Europe, ns"', add
label define bpl_lbl 430 `"Albania"', add
label define bpl_lbl 431 `"Andorra"', add
label define bpl_lbl 432 `"Gibraltar"', add
label define bpl_lbl 433 `"Greece"', add
label define bpl_lbl 434 `"Italy"', add
label define bpl_lbl 435 `"Malta"', add
label define bpl_lbl 436 `"Portugal"', add
label define bpl_lbl 437 `"San Marino"', add
label define bpl_lbl 438 `"Spain"', add
label define bpl_lbl 439 `"Vatican City"', add
label define bpl_lbl 440 `"Southern Europe, ns"', add
label define bpl_lbl 450 `"Austria"', add
label define bpl_lbl 451 `"Bulgaria"', add
label define bpl_lbl 452 `"Czechoslovakia"', add
label define bpl_lbl 453 `"Germany"', add
label define bpl_lbl 454 `"Hungary"', add
label define bpl_lbl 455 `"Poland"', add
label define bpl_lbl 456 `"Romania"', add
label define bpl_lbl 457 `"Yugoslavia"', add
label define bpl_lbl 458 `"Central Europe, ns"', add
label define bpl_lbl 459 `"Eastern Europe, ns"', add
label define bpl_lbl 460 `"Estonia"', add
label define bpl_lbl 461 `"Latvia"', add
label define bpl_lbl 462 `"Lithuania"', add
label define bpl_lbl 463 `"Baltic States, ns"', add
label define bpl_lbl 465 `"Other USSR/Russia"', add
label define bpl_lbl 499 `"Europe, ns"', add
label define bpl_lbl 500 `"China"', add
label define bpl_lbl 501 `"Japan"', add
label define bpl_lbl 502 `"Korea"', add
label define bpl_lbl 509 `"East Asia, ns"', add
label define bpl_lbl 510 `"Brunei"', add
label define bpl_lbl 511 `"Cambodia (Kampuchea)"', add
label define bpl_lbl 512 `"Indonesia"', add
label define bpl_lbl 513 `"Laos"', add
label define bpl_lbl 514 `"Malaysia"', add
label define bpl_lbl 515 `"Philippines"', add
label define bpl_lbl 516 `"Singapore"', add
label define bpl_lbl 517 `"Thailand"', add
label define bpl_lbl 518 `"Vietnam"', add
label define bpl_lbl 519 `"Southeast Asia, ns"', add
label define bpl_lbl 520 `"Afghanistan"', add
label define bpl_lbl 521 `"India"', add
label define bpl_lbl 522 `"Iran"', add
label define bpl_lbl 523 `"Maldives"', add
label define bpl_lbl 524 `"Nepal"', add
label define bpl_lbl 530 `"Bahrain"', add
label define bpl_lbl 531 `"Cyprus"', add
label define bpl_lbl 532 `"Iraq"', add
label define bpl_lbl 533 `"Iraq/Saudi Arabia"', add
label define bpl_lbl 534 `"Israel/Palestine"', add
label define bpl_lbl 535 `"Jordan"', add
label define bpl_lbl 536 `"Kuwait"', add
label define bpl_lbl 537 `"Lebanon"', add
label define bpl_lbl 538 `"Oman"', add
label define bpl_lbl 539 `"Qatar"', add
label define bpl_lbl 540 `"Saudi Arabia"', add
label define bpl_lbl 541 `"Syria"', add
label define bpl_lbl 542 `"Turkey"', add
label define bpl_lbl 543 `"United Arab Emirates"', add
label define bpl_lbl 544 `"Yemen Arab Republic (North)"', add
label define bpl_lbl 545 `"Yemen, PDR (South)"', add
label define bpl_lbl 546 `"Persian Gulf States, n.s."', add
label define bpl_lbl 547 `"Middle East, ns"', add
label define bpl_lbl 548 `"Southwest Asia, nec/ns"', add
label define bpl_lbl 549 `"Asia Minor, ns"', add
label define bpl_lbl 550 `"South Asia, nec"', add
label define bpl_lbl 599 `"Asia, nec/ns"', add
label define bpl_lbl 600 `"AFRICA"', add
label define bpl_lbl 700 `"Australia and New Zealand"', add
label define bpl_lbl 710 `"Pacific Islands"', add
label define bpl_lbl 800 `"Antarctica, ns/nec"', add
label define bpl_lbl 900 `"Abroad (unknown) or at sea"', add
label define bpl_lbl 950 `"Other n.e.c."', add
label define bpl_lbl 999 `"Missing/blank"', add
label values bpl bpl_lbl

label define bpld_lbl 00100 `"Alabama"'
label define bpld_lbl 00200 `"Alaska"', add
label define bpld_lbl 00400 `"Arizona"', add
label define bpld_lbl 00500 `"Arkansas"', add
label define bpld_lbl 00600 `"California"', add
label define bpld_lbl 00800 `"Colorado"', add
label define bpld_lbl 00900 `"Connecticut"', add
label define bpld_lbl 01000 `"Delaware"', add
label define bpld_lbl 01100 `"District of Columbia"', add
label define bpld_lbl 01200 `"Florida"', add
label define bpld_lbl 01300 `"Georgia"', add
label define bpld_lbl 01500 `"Hawaii"', add
label define bpld_lbl 01600 `"Idaho"', add
label define bpld_lbl 01610 `"Idaho Territory"', add
label define bpld_lbl 01700 `"Illinois"', add
label define bpld_lbl 01800 `"Indiana"', add
label define bpld_lbl 01900 `"Iowa"', add
label define bpld_lbl 02000 `"Kansas"', add
label define bpld_lbl 02100 `"Kentucky"', add
label define bpld_lbl 02200 `"Louisiana"', add
label define bpld_lbl 02300 `"Maine"', add
label define bpld_lbl 02400 `"Maryland"', add
label define bpld_lbl 02500 `"Massachusetts"', add
label define bpld_lbl 02600 `"Michigan"', add
label define bpld_lbl 02700 `"Minnesota"', add
label define bpld_lbl 02800 `"Mississippi"', add
label define bpld_lbl 02900 `"Missouri"', add
label define bpld_lbl 03000 `"Montana"', add
label define bpld_lbl 03100 `"Nebraska"', add
label define bpld_lbl 03200 `"Nevada"', add
label define bpld_lbl 03300 `"New Hampshire"', add
label define bpld_lbl 03400 `"New Jersey"', add
label define bpld_lbl 03500 `"New Mexico"', add
label define bpld_lbl 03510 `"New Mexico Territory"', add
label define bpld_lbl 03600 `"New York"', add
label define bpld_lbl 03700 `"North Carolina"', add
label define bpld_lbl 03800 `"North Dakota"', add
label define bpld_lbl 03900 `"Ohio"', add
label define bpld_lbl 04000 `"Oklahoma"', add
label define bpld_lbl 04010 `"Indian Territory"', add
label define bpld_lbl 04100 `"Oregon"', add
label define bpld_lbl 04200 `"Pennsylvania"', add
label define bpld_lbl 04400 `"Rhode Island"', add
label define bpld_lbl 04500 `"South Carolina"', add
label define bpld_lbl 04600 `"South Dakota"', add
label define bpld_lbl 04610 `"Dakota Territory"', add
label define bpld_lbl 04700 `"Tennessee"', add
label define bpld_lbl 04800 `"Texas"', add
label define bpld_lbl 04900 `"Utah"', add
label define bpld_lbl 04910 `"Utah Territory"', add
label define bpld_lbl 05000 `"Vermont"', add
label define bpld_lbl 05100 `"Virginia"', add
label define bpld_lbl 05300 `"Washington"', add
label define bpld_lbl 05400 `"West Virginia"', add
label define bpld_lbl 05500 `"Wisconsin"', add
label define bpld_lbl 05600 `"Wyoming"', add
label define bpld_lbl 05610 `"Wyoming Territory"', add
label define bpld_lbl 09000 `"Native American"', add
label define bpld_lbl 09900 `"United States, ns"', add
label define bpld_lbl 10000 `"American Samoa"', add
label define bpld_lbl 10010 `"Samoa, 1940-1950"', add
label define bpld_lbl 10500 `"Guam"', add
label define bpld_lbl 11000 `"Puerto Rico"', add
label define bpld_lbl 11500 `"U.S. Virgin Islands"', add
label define bpld_lbl 11510 `"St. Croix"', add
label define bpld_lbl 11520 `"St. John"', add
label define bpld_lbl 11530 `"St. Thomas"', add
label define bpld_lbl 12000 `"Other US Possessions:"', add
label define bpld_lbl 12010 `"Johnston Atoll"', add
label define bpld_lbl 12020 `"Midway Islands"', add
label define bpld_lbl 12030 `"Wake Island"', add
label define bpld_lbl 12040 `"Other US Caribbean Islands"', add
label define bpld_lbl 12041 `"Navassa Island"', add
label define bpld_lbl 12050 `"Other US Pacific Islands"', add
label define bpld_lbl 12051 `"Baker Island"', add
label define bpld_lbl 12052 `"Howland Island"', add
label define bpld_lbl 12053 `"Jarvis Island"', add
label define bpld_lbl 12054 `"Kingman Reef"', add
label define bpld_lbl 12055 `"Palmyra Atoll"', add
label define bpld_lbl 12056 `"Canton and Enderbury Island"', add
label define bpld_lbl 12090 `"US outlying areas, ns"', add
label define bpld_lbl 12091 `"US possessions, ns"', add
label define bpld_lbl 12092 `"US territory, ns"', add
label define bpld_lbl 15000 `"Canada"', add
label define bpld_lbl 15010 `"English Canada"', add
label define bpld_lbl 15011 `"British Columbia"', add
label define bpld_lbl 15013 `"Alberta"', add
label define bpld_lbl 15015 `"Saskatchewan"', add
label define bpld_lbl 15017 `"Northwest"', add
label define bpld_lbl 15019 `"Ruperts Land"', add
label define bpld_lbl 15020 `"Manitoba"', add
label define bpld_lbl 15021 `"Red River"', add
label define bpld_lbl 15030 `"Ontario/Upper Canada"', add
label define bpld_lbl 15031 `"Upper Canada"', add
label define bpld_lbl 15032 `"Canada West"', add
label define bpld_lbl 15040 `"New Brunswick"', add
label define bpld_lbl 15050 `"Nova Scotia"', add
label define bpld_lbl 15051 `"Cape Breton"', add
label define bpld_lbl 15052 `"Halifax"', add
label define bpld_lbl 15060 `"Prince Edward Island"', add
label define bpld_lbl 15070 `"Newfoundland"', add
label define bpld_lbl 15080 `"French Canada"', add
label define bpld_lbl 15081 `"Quebec"', add
label define bpld_lbl 15082 `"Lower Canada"', add
label define bpld_lbl 15083 `"Canada East"', add
label define bpld_lbl 15500 `"St. Pierre and Miquelon"', add
label define bpld_lbl 16000 `"Atlantic Islands"', add
label define bpld_lbl 16010 `"Bermuda"', add
label define bpld_lbl 16020 `"Cape Verde"', add
label define bpld_lbl 16030 `"Falkland Islands"', add
label define bpld_lbl 16040 `"Greenland"', add
label define bpld_lbl 16050 `"St. Helena and Ascension"', add
label define bpld_lbl 16060 `"Canary Islands"', add
label define bpld_lbl 19900 `"North America, ns"', add
label define bpld_lbl 20000 `"Mexico"', add
label define bpld_lbl 21000 `"Central America"', add
label define bpld_lbl 21010 `"Belize/British Honduras"', add
label define bpld_lbl 21020 `"Costa Rica"', add
label define bpld_lbl 21030 `"El Salvador"', add
label define bpld_lbl 21040 `"Guatemala"', add
label define bpld_lbl 21050 `"Honduras"', add
label define bpld_lbl 21060 `"Nicaragua"', add
label define bpld_lbl 21070 `"Panama"', add
label define bpld_lbl 21071 `"Canal Zone"', add
label define bpld_lbl 21090 `"Central America, ns"', add
label define bpld_lbl 25000 `"Cuba"', add
label define bpld_lbl 26000 `"West Indies"', add
label define bpld_lbl 26010 `"Dominican Republic"', add
label define bpld_lbl 26020 `"Haiti"', add
label define bpld_lbl 26030 `"Jamaica"', add
label define bpld_lbl 26040 `"British West Indies"', add
label define bpld_lbl 26041 `"Anguilla"', add
label define bpld_lbl 26042 `"Antigua-Barbuda"', add
label define bpld_lbl 26043 `"Bahamas"', add
label define bpld_lbl 26044 `"Barbados"', add
label define bpld_lbl 26045 `"British Virgin Islands"', add
label define bpld_lbl 26046 `"Anegada"', add
label define bpld_lbl 26047 `"Cooper"', add
label define bpld_lbl 26048 `"Jost Van Dyke"', add
label define bpld_lbl 26049 `"Peter"', add
label define bpld_lbl 26050 `"Tortola"', add
label define bpld_lbl 26051 `"Virgin Gorda"', add
label define bpld_lbl 26052 `"Br. Virgin Islands, ns"', add
label define bpld_lbl 26053 `"Cayman Islands"', add
label define bpld_lbl 26054 `"Dominica"', add
label define bpld_lbl 26055 `"Grenada"', add
label define bpld_lbl 26056 `"Montserrat"', add
label define bpld_lbl 26057 `"St. Kitts-Nevis"', add
label define bpld_lbl 26058 `"St. Lucia"', add
label define bpld_lbl 26059 `"St. Vincent"', add
label define bpld_lbl 26060 `"Trinidad and Tobago"', add
label define bpld_lbl 26061 `"Turks and Caicos"', add
label define bpld_lbl 26069 `"Br. Virgin Islands, ns"', add
label define bpld_lbl 26070 `"Other West Indies"', add
label define bpld_lbl 26071 `"Aruba"', add
label define bpld_lbl 26072 `"Netherlands Antilles"', add
label define bpld_lbl 26073 `"Bonaire"', add
label define bpld_lbl 26074 `"Curacao"', add
label define bpld_lbl 26075 `"Dutch St. Maarten"', add
label define bpld_lbl 26076 `"Saba"', add
label define bpld_lbl 26077 `"St. Eustatius"', add
label define bpld_lbl 26079 `"Dutch Caribbean, ns"', add
label define bpld_lbl 26080 `"French St. Maarten"', add
label define bpld_lbl 26081 `"Guadeloupe"', add
label define bpld_lbl 26082 `"Martinique"', add
label define bpld_lbl 26083 `"St. Barthelemy"', add
label define bpld_lbl 26089 `"French Caribbean, ns"', add
label define bpld_lbl 26090 `"Antilles, ns"', add
label define bpld_lbl 26091 `"Caribbean, ns"', add
label define bpld_lbl 26092 `"Latin America, ns"', add
label define bpld_lbl 26093 `"Leeward Islands, ns"', add
label define bpld_lbl 26094 `"West Indies, ns"', add
label define bpld_lbl 26095 `"Windward Islands, ns"', add
label define bpld_lbl 29900 `"Americas, ns"', add
label define bpld_lbl 30000 `"South America"', add
label define bpld_lbl 30005 `"Argentina"', add
label define bpld_lbl 30010 `"Bolivia"', add
label define bpld_lbl 30015 `"Brazil"', add
label define bpld_lbl 30020 `"Chile"', add
label define bpld_lbl 30025 `"Colombia"', add
label define bpld_lbl 30030 `"Ecuador"', add
label define bpld_lbl 30035 `"French Guiana"', add
label define bpld_lbl 30040 `"Guyana/British Guiana"', add
label define bpld_lbl 30045 `"Paraguay"', add
label define bpld_lbl 30050 `"Peru"', add
label define bpld_lbl 30055 `"Suriname"', add
label define bpld_lbl 30060 `"Uruguay"', add
label define bpld_lbl 30065 `"Venezuela"', add
label define bpld_lbl 30090 `"South America, ns"', add
label define bpld_lbl 30091 `"South and Central America, n.s."', add
label define bpld_lbl 40000 `"Denmark"', add
label define bpld_lbl 40010 `"Faeroe Islands"', add
label define bpld_lbl 40100 `"Finland"', add
label define bpld_lbl 40200 `"Iceland"', add
label define bpld_lbl 40300 `"Lapland, ns"', add
label define bpld_lbl 40400 `"Norway"', add
label define bpld_lbl 40410 `"Svalbard and Jan Meyen"', add
label define bpld_lbl 40411 `"Svalbard"', add
label define bpld_lbl 40412 `"Jan Meyen"', add
label define bpld_lbl 40500 `"Sweden"', add
label define bpld_lbl 41000 `"England"', add
label define bpld_lbl 41010 `"Channel Islands"', add
label define bpld_lbl 41011 `"Guernsey"', add
label define bpld_lbl 41012 `"Jersey"', add
label define bpld_lbl 41020 `"Isle of Man"', add
label define bpld_lbl 41100 `"Scotland"', add
label define bpld_lbl 41200 `"Wales"', add
label define bpld_lbl 41300 `"United Kingdom, ns"', add
label define bpld_lbl 41400 `"Ireland"', add
label define bpld_lbl 41410 `"Northern Ireland"', add
label define bpld_lbl 41900 `"Northern Europe, ns"', add
label define bpld_lbl 42000 `"Belgium"', add
label define bpld_lbl 42100 `"France"', add
label define bpld_lbl 42110 `"Alsace-Lorraine"', add
label define bpld_lbl 42111 `"Alsace"', add
label define bpld_lbl 42112 `"Lorraine"', add
label define bpld_lbl 42200 `"Liechtenstein"', add
label define bpld_lbl 42300 `"Luxembourg"', add
label define bpld_lbl 42400 `"Monaco"', add
label define bpld_lbl 42500 `"Netherlands"', add
label define bpld_lbl 42600 `"Switzerland"', add
label define bpld_lbl 42900 `"Western Europe, ns"', add
label define bpld_lbl 43000 `"Albania"', add
label define bpld_lbl 43100 `"Andorra"', add
label define bpld_lbl 43200 `"Gibraltar"', add
label define bpld_lbl 43300 `"Greece"', add
label define bpld_lbl 43310 `"Dodecanese Islands"', add
label define bpld_lbl 43320 `"Turkey Greece"', add
label define bpld_lbl 43330 `"Macedonia"', add
label define bpld_lbl 43400 `"Italy"', add
label define bpld_lbl 43500 `"Malta"', add
label define bpld_lbl 43600 `"Portugal"', add
label define bpld_lbl 43610 `"Azores"', add
label define bpld_lbl 43620 `"Madeira Islands"', add
label define bpld_lbl 43630 `"Cape Verde Islands"', add
label define bpld_lbl 43640 `"St. Miguel"', add
label define bpld_lbl 43700 `"San Marino"', add
label define bpld_lbl 43800 `"Spain"', add
label define bpld_lbl 43900 `"Vatican City"', add
label define bpld_lbl 44000 `"Southern Europe, ns"', add
label define bpld_lbl 45000 `"Austria"', add
label define bpld_lbl 45010 `"Austria-Hungary"', add
label define bpld_lbl 45020 `"Austria-Graz"', add
label define bpld_lbl 45030 `"Austria-Linz"', add
label define bpld_lbl 45040 `"Austria-Salzburg"', add
label define bpld_lbl 45050 `"Austria-Tyrol"', add
label define bpld_lbl 45060 `"Austria-Vienna"', add
label define bpld_lbl 45070 `"Austria-Kaernsten"', add
label define bpld_lbl 45080 `"Austria-Neustadt"', add
label define bpld_lbl 45100 `"Bulgaria"', add
label define bpld_lbl 45200 `"Czechoslovakia"', add
label define bpld_lbl 45210 `"Bohemia"', add
label define bpld_lbl 45211 `"Bohemia-Moravia"', add
label define bpld_lbl 45212 `"Slovakia"', add
label define bpld_lbl 45213 `"Czech Republic"', add
label define bpld_lbl 45300 `"Germany"', add
label define bpld_lbl 45301 `"Berlin"', add
label define bpld_lbl 45302 `"West Berlin"', add
label define bpld_lbl 45303 `"East Berlin"', add
label define bpld_lbl 45310 `"West Germany"', add
label define bpld_lbl 45311 `"Baden"', add
label define bpld_lbl 45312 `"Bavaria"', add
label define bpld_lbl 45313 `"Braunschweig"', add
label define bpld_lbl 45314 `"Bremen"', add
label define bpld_lbl 45315 `"Hamburg"', add
label define bpld_lbl 45316 `"Hanover"', add
label define bpld_lbl 45317 `"Hessen"', add
label define bpld_lbl 45318 `"Hesse-Nassau"', add
label define bpld_lbl 45319 `"Lippe"', add
label define bpld_lbl 45320 `"Lubeck"', add
label define bpld_lbl 45321 `"Oldenburg"', add
label define bpld_lbl 45322 `"Rheinland"', add
label define bpld_lbl 45323 `"Schaumburg-Lippe"', add
label define bpld_lbl 45324 `"Schleswig"', add
label define bpld_lbl 45325 `"Sigmaringen"', add
label define bpld_lbl 45326 `"Schwarzburg"', add
label define bpld_lbl 45327 `"Westphalia"', add
label define bpld_lbl 45328 `"Wurttemberg"', add
label define bpld_lbl 45329 `"Waldeck"', add
label define bpld_lbl 45330 `"Wittenberg"', add
label define bpld_lbl 45331 `"Frankfurt"', add
label define bpld_lbl 45332 `"Saarland"', add
label define bpld_lbl 45333 `"Nordrhein-Westfalen"', add
label define bpld_lbl 45340 `"East Germany"', add
label define bpld_lbl 45341 `"Anhalt"', add
label define bpld_lbl 45342 `"Brandenburg"', add
label define bpld_lbl 45344 `"Kingdom of Saxony"', add
label define bpld_lbl 45345 `"Mecklenburg"', add
label define bpld_lbl 45346 `"Saxony"', add
label define bpld_lbl 45347 `"Thuringian States"', add
label define bpld_lbl 45348 `"Sachsen-Meiningen"', add
label define bpld_lbl 45349 `"Sachsen-Weimar-Eisenach"', add
label define bpld_lbl 45350 `"Probable Saxony"', add
label define bpld_lbl 45351 `"Schwerin"', add
label define bpld_lbl 45352 `"Strelitz"', add
label define bpld_lbl 45353 `"Probably Thuringian States"', add
label define bpld_lbl 45360 `"Prussia, nec"', add
label define bpld_lbl 45361 `"Hohenzollern"', add
label define bpld_lbl 45362 `"Niedersachsen"', add
label define bpld_lbl 45400 `"Hungary"', add
label define bpld_lbl 45500 `"Poland"', add
label define bpld_lbl 45510 `"Austrian Poland"', add
label define bpld_lbl 45511 `"Galicia"', add
label define bpld_lbl 45520 `"German Poland"', add
label define bpld_lbl 45521 `"East Prussia"', add
label define bpld_lbl 45522 `"Pomerania"', add
label define bpld_lbl 45523 `"Posen"', add
label define bpld_lbl 45524 `"Prussian Poland"', add
label define bpld_lbl 45525 `"Silesia"', add
label define bpld_lbl 45526 `"West Prussia"', add
label define bpld_lbl 45530 `"Russian Poland"', add
label define bpld_lbl 45600 `"Romania"', add
label define bpld_lbl 45610 `"Transylvania"', add
label define bpld_lbl 45700 `"Yugoslavia"', add
label define bpld_lbl 45710 `"Croatia"', add
label define bpld_lbl 45720 `"Montenegro"', add
label define bpld_lbl 45730 `"Serbia"', add
label define bpld_lbl 45740 `"Bosnia"', add
label define bpld_lbl 45750 `"Dalmatia"', add
label define bpld_lbl 45760 `"Slovonia"', add
label define bpld_lbl 45770 `"Carniola"', add
label define bpld_lbl 45780 `"Slovenia"', add
label define bpld_lbl 45790 `"Kosovo"', add
label define bpld_lbl 45800 `"Central Europe, ns"', add
label define bpld_lbl 45900 `"Eastern Europe, ns"', add
label define bpld_lbl 46000 `"Estonia"', add
label define bpld_lbl 46100 `"Latvia"', add
label define bpld_lbl 46200 `"Lithuania"', add
label define bpld_lbl 46300 `"Baltic States, ns"', add
label define bpld_lbl 46500 `"Other USSR/Russia"', add
label define bpld_lbl 46510 `"Byelorussia"', add
label define bpld_lbl 46520 `"Moldavia"', add
label define bpld_lbl 46521 `"Bessarabia"', add
label define bpld_lbl 46530 `"Ukraine"', add
label define bpld_lbl 46540 `"Armenia"', add
label define bpld_lbl 46541 `"Azerbaijan"', add
label define bpld_lbl 46542 `"Republic of Georgia"', add
label define bpld_lbl 46543 `"Kazakhstan"', add
label define bpld_lbl 46544 `"Kirghizia"', add
label define bpld_lbl 46545 `"Tadzhik"', add
label define bpld_lbl 46546 `"Turkmenistan"', add
label define bpld_lbl 46547 `"Uzbekistan"', add
label define bpld_lbl 46548 `"Siberia"', add
label define bpld_lbl 46590 `"USSR, ns"', add
label define bpld_lbl 49900 `"Europe, ns."', add
label define bpld_lbl 50000 `"China"', add
label define bpld_lbl 50010 `"Hong Kong"', add
label define bpld_lbl 50020 `"Macau"', add
label define bpld_lbl 50030 `"Mongolia"', add
label define bpld_lbl 50040 `"Taiwan"', add
label define bpld_lbl 50100 `"Japan"', add
label define bpld_lbl 50200 `"Korea"', add
label define bpld_lbl 50210 `"North Korea"', add
label define bpld_lbl 50220 `"South Korea"', add
label define bpld_lbl 50900 `"East Asia, ns"', add
label define bpld_lbl 51000 `"Brunei"', add
label define bpld_lbl 51100 `"Cambodia (Kampuchea)"', add
label define bpld_lbl 51200 `"Indonesia"', add
label define bpld_lbl 51210 `"East Indies"', add
label define bpld_lbl 51220 `"East Timor"', add
label define bpld_lbl 51300 `"Laos"', add
label define bpld_lbl 51400 `"Malaysia"', add
label define bpld_lbl 51500 `"Philippines"', add
label define bpld_lbl 51600 `"Singapore"', add
label define bpld_lbl 51700 `"Thailand"', add
label define bpld_lbl 51800 `"Vietnam"', add
label define bpld_lbl 51900 `"Southeast Asia, ns"', add
label define bpld_lbl 51910 `"Indochina, ns"', add
label define bpld_lbl 52000 `"Afghanistan"', add
label define bpld_lbl 52100 `"India"', add
label define bpld_lbl 52110 `"Bangladesh"', add
label define bpld_lbl 52120 `"Bhutan"', add
label define bpld_lbl 52130 `"Burma (Myanmar)"', add
label define bpld_lbl 52140 `"Pakistan"', add
label define bpld_lbl 52150 `"Sri Lanka (Ceylon)"', add
label define bpld_lbl 52200 `"Iran"', add
label define bpld_lbl 52300 `"Maldives"', add
label define bpld_lbl 52400 `"Nepal"', add
label define bpld_lbl 53000 `"Bahrain"', add
label define bpld_lbl 53100 `"Cyprus"', add
label define bpld_lbl 53200 `"Iraq"', add
label define bpld_lbl 53210 `"Mesopotamia"', add
label define bpld_lbl 53300 `"Iraq/Saudi Arabia"', add
label define bpld_lbl 53400 `"Israel/Palestine"', add
label define bpld_lbl 53410 `"Gaza Strip"', add
label define bpld_lbl 53420 `"Palestine"', add
label define bpld_lbl 53430 `"West Bank"', add
label define bpld_lbl 53440 `"Israel"', add
label define bpld_lbl 53500 `"Jordan"', add
label define bpld_lbl 53600 `"Kuwait"', add
label define bpld_lbl 53700 `"Lebanon"', add
label define bpld_lbl 53800 `"Oman"', add
label define bpld_lbl 53900 `"Qatar"', add
label define bpld_lbl 54000 `"Saudi Arabia"', add
label define bpld_lbl 54100 `"Syria"', add
label define bpld_lbl 54200 `"Turkey"', add
label define bpld_lbl 54210 `"European Turkey"', add
label define bpld_lbl 54220 `"Asian Turkey"', add
label define bpld_lbl 54300 `"United Arab Emirates"', add
label define bpld_lbl 54400 `"Yemen Arab Republic (North)"', add
label define bpld_lbl 54500 `"Yemen, PDR (South)"', add
label define bpld_lbl 54600 `"Persian Gulf States, ns"', add
label define bpld_lbl 54700 `"Middle East, ns"', add
label define bpld_lbl 54800 `"Southwest Asia, nec/ns"', add
label define bpld_lbl 54900 `"Asia Minor, ns"', add
label define bpld_lbl 55000 `"South Asia, nec"', add
label define bpld_lbl 59900 `"Asia, nec/ns"', add
label define bpld_lbl 60000 `"Africa"', add
label define bpld_lbl 60010 `"Northern Africa"', add
label define bpld_lbl 60011 `"Algeria"', add
label define bpld_lbl 60012 `"Egypt/United Arab Rep."', add
label define bpld_lbl 60013 `"Libya"', add
label define bpld_lbl 60014 `"Morocco"', add
label define bpld_lbl 60015 `"Sudan"', add
label define bpld_lbl 60016 `"Tunisia"', add
label define bpld_lbl 60017 `"Western Sahara"', add
label define bpld_lbl 60019 `"North Africa, ns"', add
label define bpld_lbl 60020 `"Benin"', add
label define bpld_lbl 60021 `"Burkina Faso"', add
label define bpld_lbl 60022 `"Gambia"', add
label define bpld_lbl 60023 `"Ghana"', add
label define bpld_lbl 60024 `"Guinea"', add
label define bpld_lbl 60025 `"Guinea-Bissau"', add
label define bpld_lbl 60026 `"Ivory Coast"', add
label define bpld_lbl 60027 `"Liberia"', add
label define bpld_lbl 60028 `"Mali"', add
label define bpld_lbl 60029 `"Mauritania"', add
label define bpld_lbl 60030 `"Niger"', add
label define bpld_lbl 60031 `"Nigeria"', add
label define bpld_lbl 60032 `"Senegal"', add
label define bpld_lbl 60033 `"Sierra Leone"', add
label define bpld_lbl 60034 `"Togo"', add
label define bpld_lbl 60038 `"Western Africa, ns"', add
label define bpld_lbl 60039 `"French West Africa, ns"', add
label define bpld_lbl 60040 `"British Indian Ocean Territory"', add
label define bpld_lbl 60041 `"Burundi"', add
label define bpld_lbl 60042 `"Comoros"', add
label define bpld_lbl 60043 `"Djibouti"', add
label define bpld_lbl 60044 `"Ethiopia"', add
label define bpld_lbl 60045 `"Kenya"', add
label define bpld_lbl 60046 `"Madagascar"', add
label define bpld_lbl 60047 `"Malawi"', add
label define bpld_lbl 60048 `"Mauritius"', add
label define bpld_lbl 60049 `"Mozambique"', add
label define bpld_lbl 60050 `"Reunion"', add
label define bpld_lbl 60051 `"Rwanda"', add
label define bpld_lbl 60052 `"Seychelles"', add
label define bpld_lbl 60053 `"Somalia"', add
label define bpld_lbl 60054 `"Tanzania"', add
label define bpld_lbl 60055 `"Uganda"', add
label define bpld_lbl 60056 `"Zambia"', add
label define bpld_lbl 60057 `"Zimbabwe"', add
label define bpld_lbl 60058 `"Bassas de India"', add
label define bpld_lbl 60059 `"Europa"', add
label define bpld_lbl 60060 `"Gloriosos"', add
label define bpld_lbl 60061 `"Juan de Nova"', add
label define bpld_lbl 60062 `"Mayotte"', add
label define bpld_lbl 60063 `"Tromelin"', add
label define bpld_lbl 60064 `"Eastern Africa, nec/ns"', add
label define bpld_lbl 60065 `"Eritrea"', add
label define bpld_lbl 60066 `"South Sudan"', add
label define bpld_lbl 60070 `"Central Africa"', add
label define bpld_lbl 60071 `"Angola"', add
label define bpld_lbl 60072 `"Cameroon"', add
label define bpld_lbl 60073 `"Central African Republic"', add
label define bpld_lbl 60074 `"Chad"', add
label define bpld_lbl 60075 `"Congo"', add
label define bpld_lbl 60076 `"Equatorial Guinea"', add
label define bpld_lbl 60077 `"Gabon"', add
label define bpld_lbl 60078 `"Sao Tome and Principe"', add
label define bpld_lbl 60079 `"Zaire"', add
label define bpld_lbl 60080 `"Central Africa, ns"', add
label define bpld_lbl 60081 `"Equatorial Africa, ns"', add
label define bpld_lbl 60082 `"French Equatorial Africa, ns"', add
label define bpld_lbl 60090 `"Southern Africa"', add
label define bpld_lbl 60091 `"Botswana"', add
label define bpld_lbl 60092 `"Lesotho"', add
label define bpld_lbl 60093 `"Namibia"', add
label define bpld_lbl 60094 `"South Africa (Union of)"', add
label define bpld_lbl 60095 `"Swaziland"', add
label define bpld_lbl 60096 `"Southern Africa, ns"', add
label define bpld_lbl 60099 `"Africa, ns/nec"', add
label define bpld_lbl 70000 `"Australia and New Zealand"', add
label define bpld_lbl 70010 `"Australia"', add
label define bpld_lbl 70011 `"Ashmore and Cartier Islands"', add
label define bpld_lbl 70012 `"Coral Sea Islands Territory"', add
label define bpld_lbl 70013 `"Christmas Island"', add
label define bpld_lbl 70014 `"Cocos Islands"', add
label define bpld_lbl 70020 `"New Zealand"', add
label define bpld_lbl 71000 `"Pacific Islands"', add
label define bpld_lbl 71010 `"New Caledonia"', add
label define bpld_lbl 71012 `"Papua New Guinea"', add
label define bpld_lbl 71013 `"Solomon Islands"', add
label define bpld_lbl 71014 `"Vanuatu (New Hebrides)"', add
label define bpld_lbl 71015 `"Fiji"', add
label define bpld_lbl 71016 `"Melanesia, ns"', add
label define bpld_lbl 71017 `"Norfolk Islands"', add
label define bpld_lbl 71018 `"Niue"', add
label define bpld_lbl 71020 `"Cook Islands"', add
label define bpld_lbl 71022 `"French Polynesia"', add
label define bpld_lbl 71023 `"Tonga"', add
label define bpld_lbl 71024 `"Wallis and Futuna Islands"', add
label define bpld_lbl 71025 `"Western Samoa"', add
label define bpld_lbl 71026 `"Pitcairn Island"', add
label define bpld_lbl 71027 `"Tokelau"', add
label define bpld_lbl 71028 `"Tuvalu"', add
label define bpld_lbl 71029 `"Polynesia, ns"', add
label define bpld_lbl 71032 `"Kiribati"', add
label define bpld_lbl 71033 `"Canton and Enderbury"', add
label define bpld_lbl 71034 `"Nauru"', add
label define bpld_lbl 71039 `"Micronesia, ns"', add
label define bpld_lbl 71040 `"US Pacific Trust Territories"', add
label define bpld_lbl 71041 `"Marshall Islands"', add
label define bpld_lbl 71042 `"Micronesia"', add
label define bpld_lbl 71043 `"Kosrae"', add
label define bpld_lbl 71044 `"Pohnpei"', add
label define bpld_lbl 71045 `"Truk"', add
label define bpld_lbl 71046 `"Yap"', add
label define bpld_lbl 71047 `"Northern Mariana Islands"', add
label define bpld_lbl 71048 `"Palau"', add
label define bpld_lbl 71049 `"Pacific Trust Terr, ns"', add
label define bpld_lbl 71050 `"Clipperton Island"', add
label define bpld_lbl 71090 `"Oceania, ns/nec"', add
label define bpld_lbl 80000 `"Antarctica, ns/nec"', add
label define bpld_lbl 80010 `"Bouvet Islands"', add
label define bpld_lbl 80020 `"British Antarctic Terr."', add
label define bpld_lbl 80030 `"Dronning Maud Land"', add
label define bpld_lbl 80040 `"French Southern and Antarctic Lands"', add
label define bpld_lbl 80050 `"Heard and McDonald Islands"', add
label define bpld_lbl 90000 `"Abroad (unknown) or at sea"', add
label define bpld_lbl 90010 `"Abroad, ns"', add
label define bpld_lbl 90011 `"Abroad (US citizen)"', add
label define bpld_lbl 90020 `"At sea"', add
label define bpld_lbl 90021 `"At sea (US citizen)"', add
label define bpld_lbl 90022 `"At sea or abroad (U.S. citizen)"', add
label define bpld_lbl 95000 `"Other n.e.c."', add
label define bpld_lbl 99900 `"Missing/blank"', add
label values bpld bpld_lbl

label define educ_lbl 00 `"N/A or no schooling"'
label define educ_lbl 01 `"Nursery school to grade 4"', add
label define educ_lbl 02 `"Grade 5, 6, 7, or 8"', add
label define educ_lbl 03 `"Grade 9"', add
label define educ_lbl 04 `"Grade 10"', add
label define educ_lbl 05 `"Grade 11"', add
label define educ_lbl 06 `"Grade 12"', add
label define educ_lbl 07 `"1 year of college"', add
label define educ_lbl 08 `"2 years of college"', add
label define educ_lbl 09 `"3 years of college"', add
label define educ_lbl 10 `"4 years of college"', add
label define educ_lbl 11 `"5+ years of college"', add
label values educ educ_lbl

label define educd_lbl 000 `"N/A or no schooling"'
label define educd_lbl 001 `"N/A"', add
label define educd_lbl 002 `"No schooling completed"', add
label define educd_lbl 010 `"Nursery school to grade 4"', add
label define educd_lbl 011 `"Nursery school, preschool"', add
label define educd_lbl 012 `"Kindergarten"', add
label define educd_lbl 013 `"Grade 1, 2, 3, or 4"', add
label define educd_lbl 014 `"Grade 1"', add
label define educd_lbl 015 `"Grade 2"', add
label define educd_lbl 016 `"Grade 3"', add
label define educd_lbl 017 `"Grade 4"', add
label define educd_lbl 020 `"Grade 5, 6, 7, or 8"', add
label define educd_lbl 021 `"Grade 5 or 6"', add
label define educd_lbl 022 `"Grade 5"', add
label define educd_lbl 023 `"Grade 6"', add
label define educd_lbl 024 `"Grade 7 or 8"', add
label define educd_lbl 025 `"Grade 7"', add
label define educd_lbl 026 `"Grade 8"', add
label define educd_lbl 030 `"Grade 9"', add
label define educd_lbl 040 `"Grade 10"', add
label define educd_lbl 050 `"Grade 11"', add
label define educd_lbl 060 `"Grade 12"', add
label define educd_lbl 061 `"12th grade, no diploma"', add
label define educd_lbl 062 `"High school graduate or GED"', add
label define educd_lbl 063 `"Regular high school diploma"', add
label define educd_lbl 064 `"GED or alternative credential"', add
label define educd_lbl 065 `"Some college, but less than 1 year"', add
label define educd_lbl 070 `"1 year of college"', add
label define educd_lbl 071 `"1 or more years of college credit, no degree"', add
label define educd_lbl 080 `"2 years of college"', add
label define educd_lbl 081 `"Associate's degree, type not specified"', add
label define educd_lbl 082 `"Associate's degree, occupational program"', add
label define educd_lbl 083 `"Associate's degree, academic program"', add
label define educd_lbl 090 `"3 years of college"', add
label define educd_lbl 100 `"4 years of college"', add
label define educd_lbl 101 `"Bachelor's degree"', add
label define educd_lbl 110 `"5+ years of college"', add
label define educd_lbl 111 `"6 years of college (6+ in 1960-1970)"', add
label define educd_lbl 112 `"7 years of college"', add
label define educd_lbl 113 `"8+ years of college"', add
label define educd_lbl 114 `"Master's degree"', add
label define educd_lbl 115 `"Professional degree beyond a bachelor's degree"', add
label define educd_lbl 116 `"Doctoral degree"', add
label define educd_lbl 999 `"Missing"', add
label values educd educd_lbl

label define occ1950_lbl 000 `"Accountants and auditors"'
label define occ1950_lbl 001 `"Actors and actresses"', add
label define occ1950_lbl 002 `"Airplane pilots and navigators"', add
label define occ1950_lbl 003 `"Architects"', add
label define occ1950_lbl 004 `"Artists and art teachers"', add
label define occ1950_lbl 005 `"Athletes"', add
label define occ1950_lbl 006 `"Authors"', add
label define occ1950_lbl 007 `"Chemists"', add
label define occ1950_lbl 008 `"Chiropractors"', add
label define occ1950_lbl 009 `"Clergymen"', add
label define occ1950_lbl 010 `"College presidents and deans"', add
label define occ1950_lbl 012 `"Agricultural sciences-Professors and instructors"', add
label define occ1950_lbl 013 `"Biological sciences-Professors and instructors"', add
label define occ1950_lbl 014 `"Chemistry-Professors and instructors"', add
label define occ1950_lbl 015 `"Economics-Professors and instructors"', add
label define occ1950_lbl 016 `"Engineering-Professors and instructors"', add
label define occ1950_lbl 017 `"Geology and geophysics-Professors and instructors"', add
label define occ1950_lbl 018 `"Mathematics-Professors and instructors"', add
label define occ1950_lbl 019 `"Medical Sciences-Professors and instructors"', add
label define occ1950_lbl 023 `"Physics-Professors and instructors"', add
label define occ1950_lbl 024 `"Psychology-Professors and instructors"', add
label define occ1950_lbl 025 `"Statistics-Professors and instructors"', add
label define occ1950_lbl 026 `"Natural science (nec)-Professors and instructors"', add
label define occ1950_lbl 027 `"Social sciences (nec)-Professors and instructors"', add
label define occ1950_lbl 028 `"Non-scientific subjects-Professors and instructors"', add
label define occ1950_lbl 029 `"Subject not specified-Professors and instructors"', add
label define occ1950_lbl 031 `"Dancers and dancing teachers"', add
label define occ1950_lbl 032 `"Dentists"', add
label define occ1950_lbl 033 `"Designers"', add
label define occ1950_lbl 034 `"Dietitians and nutritionists"', add
label define occ1950_lbl 035 `"Draftsmen"', add
label define occ1950_lbl 036 `"Editors and reporters"', add
label define occ1950_lbl 041 `"Aeronautical-Engineers"', add
label define occ1950_lbl 042 `"Chemical-Engineers"', add
label define occ1950_lbl 043 `"Civil-Engineers"', add
label define occ1950_lbl 044 `"Electrical-Engineers"', add
label define occ1950_lbl 045 `"Industrial-Engineers"', add
label define occ1950_lbl 046 `"Mechanical-Engineers"', add
label define occ1950_lbl 047 `"Metallurgical, metallurgists-Engineers"', add
label define occ1950_lbl 048 `"Mining-Engineers"', add
label define occ1950_lbl 049 `"Engineers (nec)"', add
label define occ1950_lbl 051 `"Entertainers (nec)"', add
label define occ1950_lbl 052 `"Farm and home management advisors"', add
label define occ1950_lbl 053 `"Foresters and conservationists"', add
label define occ1950_lbl 054 `"Funeral directors and embalmers"', add
label define occ1950_lbl 055 `"Lawyers and judges"', add
label define occ1950_lbl 056 `"Librarians"', add
label define occ1950_lbl 057 `"Musicians and music teachers"', add
label define occ1950_lbl 058 `"Nurses, professional"', add
label define occ1950_lbl 059 `"Nurses, student professional"', add
label define occ1950_lbl 061 `"Agricultural scientists"', add
label define occ1950_lbl 062 `"Biological scientists"', add
label define occ1950_lbl 063 `"Geologists and geophysicists"', add
label define occ1950_lbl 067 `"Mathematicians"', add
label define occ1950_lbl 068 `"Physicists"', add
label define occ1950_lbl 069 `"Misc. natural scientists"', add
label define occ1950_lbl 070 `"Optometrists"', add
label define occ1950_lbl 071 `"Osteopaths"', add
label define occ1950_lbl 072 `"Personnel and labor relations workers"', add
label define occ1950_lbl 073 `"Pharmacists"', add
label define occ1950_lbl 074 `"Photographers"', add
label define occ1950_lbl 075 `"Physicians and surgeons"', add
label define occ1950_lbl 076 `"Radio operators"', add
label define occ1950_lbl 077 `"Recreation and group workers"', add
label define occ1950_lbl 078 `"Religious workers"', add
label define occ1950_lbl 079 `"Social and welfare workers, except group"', add
label define occ1950_lbl 081 `"Economists"', add
label define occ1950_lbl 082 `"Psychologists"', add
label define occ1950_lbl 083 `"Statisticians and actuaries"', add
label define occ1950_lbl 084 `"Misc social scientists"', add
label define occ1950_lbl 091 `"Sports instructors and officials"', add
label define occ1950_lbl 092 `"Surveyors"', add
label define occ1950_lbl 093 `"Teachers (n.e.c.)"', add
label define occ1950_lbl 094 `"Medical and dental-technicians"', add
label define occ1950_lbl 095 `"Testing-technicians"', add
label define occ1950_lbl 096 `"Technicians (nec)"', add
label define occ1950_lbl 097 `"Therapists and healers (nec)"', add
label define occ1950_lbl 098 `"Veterinarians"', add
label define occ1950_lbl 099 `"Professional, technical and kindred workers (nec)"', add
label define occ1950_lbl 100 `"Farmers (owners and tenants)"', add
label define occ1950_lbl 123 `"Farm managers"', add
label define occ1950_lbl 200 `"Buyers and dept heads, store"', add
label define occ1950_lbl 201 `"Buyers and shippers, farm products"', add
label define occ1950_lbl 203 `"Conductors, railroad"', add
label define occ1950_lbl 204 `"Credit men"', add
label define occ1950_lbl 205 `"Floormen and floor managers, store"', add
label define occ1950_lbl 210 `"Inspectors, public administration"', add
label define occ1950_lbl 230 `"Managers and superintendants, building"', add
label define occ1950_lbl 240 `"Officers, pilots, pursers and engineers, ship"', add
label define occ1950_lbl 250 `"Officials and administratators (nec), public administration"', add
label define occ1950_lbl 260 `"Officials, lodge, society, union, etc."', add
label define occ1950_lbl 270 `"Postmasters"', add
label define occ1950_lbl 280 `"Purchasing agents and buyers (nec)"', add
label define occ1950_lbl 290 `"Managers, officials, and proprietors (nec)"', add
label define occ1950_lbl 300 `"Agents (nec)"', add
label define occ1950_lbl 301 `"Attendants and assistants, library"', add
label define occ1950_lbl 302 `"Attendants, physicians and dentists office"', add
label define occ1950_lbl 304 `"Baggagemen, transportation"', add
label define occ1950_lbl 305 `"Bank tellers"', add
label define occ1950_lbl 310 `"Bookkeepers"', add
label define occ1950_lbl 320 `"Cashiers"', add
label define occ1950_lbl 321 `"Collectors, bill and account"', add
label define occ1950_lbl 322 `"Dispatchers and starters, vehicle"', add
label define occ1950_lbl 325 `"Express messengers and railway mail clerks"', add
label define occ1950_lbl 335 `"Mail carriers"', add
label define occ1950_lbl 340 `"Messengers and office boys"', add
label define occ1950_lbl 341 `"Office machine operators"', add
label define occ1950_lbl 342 `"Shipping and receiving clerks"', add
label define occ1950_lbl 350 `"Stenographers, typists, and secretaries"', add
label define occ1950_lbl 360 `"Telegraph messengers"', add
label define occ1950_lbl 365 `"Telegraph operators"', add
label define occ1950_lbl 370 `"Telephone operators"', add
label define occ1950_lbl 380 `"Ticket, station, and express agents"', add
label define occ1950_lbl 390 `"Clerical and kindred workers (n.e.c.)"', add
label define occ1950_lbl 400 `"Advertising agents and salesmen"', add
label define occ1950_lbl 410 `"Auctioneers"', add
label define occ1950_lbl 420 `"Demonstrators"', add
label define occ1950_lbl 430 `"Hucksters and peddlers"', add
label define occ1950_lbl 450 `"Insurance agents and brokers"', add
label define occ1950_lbl 460 `"Newsboys"', add
label define occ1950_lbl 470 `"Real estate agents and brokers"', add
label define occ1950_lbl 480 `"Stock and bond salesmen"', add
label define occ1950_lbl 490 `"Salesmen and sales clerks (nec)"', add
label define occ1950_lbl 500 `"Bakers"', add
label define occ1950_lbl 501 `"Blacksmiths"', add
label define occ1950_lbl 502 `"Bookbinders"', add
label define occ1950_lbl 503 `"Boilermakers"', add
label define occ1950_lbl 504 `"Brickmasons,stonemasons, and tile setters"', add
label define occ1950_lbl 505 `"Cabinetmakers"', add
label define occ1950_lbl 510 `"Carpenters"', add
label define occ1950_lbl 511 `"Cement and concrete finishers"', add
label define occ1950_lbl 512 `"Compositors and typesetters"', add
label define occ1950_lbl 513 `"Cranemen,derrickmen, and hoistmen"', add
label define occ1950_lbl 514 `"Decorators and window dressers"', add
label define occ1950_lbl 515 `"Electricians"', add
label define occ1950_lbl 520 `"Electrotypers and stereotypers"', add
label define occ1950_lbl 521 `"Engravers, except photoengravers"', add
label define occ1950_lbl 522 `"Excavating, grading, and road machinery operators"', add
label define occ1950_lbl 523 `"Foremen (nec)"', add
label define occ1950_lbl 524 `"Forgemen and hammermen"', add
label define occ1950_lbl 525 `"Furriers"', add
label define occ1950_lbl 530 `"Glaziers"', add
label define occ1950_lbl 531 `"Heat treaters, annealers, temperers"', add
label define occ1950_lbl 532 `"Inspectors, scalers, and graders log and lumber"', add
label define occ1950_lbl 533 `"Inspectors (nec)"', add
label define occ1950_lbl 534 `"Jewelers, watchmakers, goldsmiths, and silversmiths"', add
label define occ1950_lbl 535 `"Job setters, metal"', add
label define occ1950_lbl 540 `"Linemen and servicemen, telegraph, telephone, and power"', add
label define occ1950_lbl 541 `"Locomotive engineers"', add
label define occ1950_lbl 542 `"Locomotive firemen"', add
label define occ1950_lbl 543 `"Loom fixers"', add
label define occ1950_lbl 544 `"Machinists"', add
label define occ1950_lbl 545 `"Airplane-mechanics and repairmen"', add
label define occ1950_lbl 550 `"Automobile-mechanics and repairmen"', add
label define occ1950_lbl 551 `"Office machine-mechanics and repairmen"', add
label define occ1950_lbl 552 `"Radio and television-mechanics and repairmen"', add
label define occ1950_lbl 553 `"Railroad and car shop-mechanics and repairmen"', add
label define occ1950_lbl 554 `"Mechanics and repairmen (nec)"', add
label define occ1950_lbl 555 `"Millers, grain, flour, feed, etc"', add
label define occ1950_lbl 560 `"Millwrights"', add
label define occ1950_lbl 561 `"Molders, metal"', add
label define occ1950_lbl 562 `"Motion picture projectionists"', add
label define occ1950_lbl 563 `"Opticians and lens grinders and polishers"', add
label define occ1950_lbl 564 `"Painters, construction and maintenance"', add
label define occ1950_lbl 565 `"Paperhangers"', add
label define occ1950_lbl 570 `"Pattern and model makers, except paper"', add
label define occ1950_lbl 571 `"Photoengravers and lithographers"', add
label define occ1950_lbl 572 `"Piano and organ tuners and repairmen"', add
label define occ1950_lbl 573 `"Plasterers"', add
label define occ1950_lbl 574 `"Plumbers and pipe fitters"', add
label define occ1950_lbl 575 `"Pressmen and plate printers, printing"', add
label define occ1950_lbl 580 `"Rollers and roll hands, metal"', add
label define occ1950_lbl 581 `"Roofers and slaters"', add
label define occ1950_lbl 582 `"Shoemakers and repairers, except factory"', add
label define occ1950_lbl 583 `"Stationary engineers"', add
label define occ1950_lbl 584 `"Stone cutters and stone carvers"', add
label define occ1950_lbl 585 `"Structural metal workers"', add
label define occ1950_lbl 590 `"Tailors and tailoresses"', add
label define occ1950_lbl 591 `"Tinsmiths, coppersmiths, and sheet metal workers"', add
label define occ1950_lbl 592 `"Tool makers, and die makers and setters"', add
label define occ1950_lbl 593 `"Upholsterers"', add
label define occ1950_lbl 594 `"Craftsmen and kindred workers (nec)"', add
label define occ1950_lbl 595 `"Members of the armed services"', add
label define occ1950_lbl 600 `"Auto mechanics apprentice"', add
label define occ1950_lbl 601 `"Bricklayers and masons apprentice"', add
label define occ1950_lbl 602 `"Carpenters apprentice"', add
label define occ1950_lbl 603 `"Electricians apprentice"', add
label define occ1950_lbl 604 `"Machinists and toolmakers apprentice"', add
label define occ1950_lbl 605 `"Mechanics, except auto apprentice"', add
label define occ1950_lbl 610 `"Plumbers and pipe fitters apprentice"', add
label define occ1950_lbl 611 `"Apprentices, building trades (nec)"', add
label define occ1950_lbl 612 `"Apprentices, metalworking trades (nec)"', add
label define occ1950_lbl 613 `"Apprentices, printing  trades"', add
label define occ1950_lbl 614 `"Apprentices, other specified trades"', add
label define occ1950_lbl 615 `"Apprentices, trade not specified"', add
label define occ1950_lbl 620 `"Asbestos and insulation workers"', add
label define occ1950_lbl 621 `"Attendants, auto service and parking"', add
label define occ1950_lbl 622 `"Blasters and powdermen"', add
label define occ1950_lbl 623 `"Boatmen, canalmen, and lock keepers"', add
label define occ1950_lbl 624 `"Brakemen, railroad"', add
label define occ1950_lbl 625 `"Bus drivers"', add
label define occ1950_lbl 630 `"Chainmen, rodmen, and axmen, surveying"', add
label define occ1950_lbl 631 `"Conductors, bus and street railway"', add
label define occ1950_lbl 632 `"Deliverymen and routemen"', add
label define occ1950_lbl 633 `"Dressmakers and seamstresses, except factory"', add
label define occ1950_lbl 634 `"Dyers"', add
label define occ1950_lbl 635 `"Filers, grinders, and polishers, metal"', add
label define occ1950_lbl 640 `"Fruit, nut, and vegetable graders, and packers, except facto"', add
label define occ1950_lbl 641 `"Furnacemen, smeltermen and pourers"', add
label define occ1950_lbl 642 `"Heaters, metal"', add
label define occ1950_lbl 643 `"Laundry and dry cleaning Operatives"', add
label define occ1950_lbl 644 `"Meat cutters, except slaughter and packing house"', add
label define occ1950_lbl 645 `"Milliners"', add
label define occ1950_lbl 650 `"Mine operatives and laborers"', add
label define occ1950_lbl 660 `"Motormen, mine, factory, logging camp, etc"', add
label define occ1950_lbl 661 `"Motormen, street, subway, and elevated railway"', add
label define occ1950_lbl 662 `"Oilers and greaser, except auto"', add
label define occ1950_lbl 670 `"Painters, except construction or maintenance"', add
label define occ1950_lbl 671 `"Photographic process workers"', add
label define occ1950_lbl 672 `"Power station operators"', add
label define occ1950_lbl 673 `"Sailors and deck hands"', add
label define occ1950_lbl 674 `"Sawyers"', add
label define occ1950_lbl 675 `"Spinners, textile"', add
label define occ1950_lbl 680 `"Stationary firemen"', add
label define occ1950_lbl 681 `"Switchmen, railroad"', add
label define occ1950_lbl 682 `"Taxicab drivers and chauffeurs"', add
label define occ1950_lbl 683 `"Truck and tractor drivers"', add
label define occ1950_lbl 684 `"Weavers, textile"', add
label define occ1950_lbl 685 `"Welders and flame cutters"', add
label define occ1950_lbl 690 `"Operative and kindred workers (nec)"', add
label define occ1950_lbl 700 `"Housekeepers, private household"', add
label define occ1950_lbl 710 `"Laundresses, private household"', add
label define occ1950_lbl 720 `"Private household workers (nec)"', add
label define occ1950_lbl 730 `"Attendants, hospital and other institution"', add
label define occ1950_lbl 731 `"Attendants, professional and personal service (nec)"', add
label define occ1950_lbl 732 `"Attendants, recreation and amusement"', add
label define occ1950_lbl 740 `"Barbers, beauticians, and manicurists"', add
label define occ1950_lbl 750 `"Bartenders"', add
label define occ1950_lbl 751 `"Bootblacks"', add
label define occ1950_lbl 752 `"Boarding and lodging house keepers"', add
label define occ1950_lbl 753 `"Charwomen and cleaners"', add
label define occ1950_lbl 754 `"Cooks, except private household"', add
label define occ1950_lbl 760 `"Counter and fountain workers"', add
label define occ1950_lbl 761 `"Elevator operators"', add
label define occ1950_lbl 762 `"Firemen, fire protection"', add
label define occ1950_lbl 763 `"Guards, watchmen, and doorkeepers"', add
label define occ1950_lbl 764 `"Housekeepers and stewards, except private household"', add
label define occ1950_lbl 770 `"Janitors and sextons"', add
label define occ1950_lbl 771 `"Marshals and constables"', add
label define occ1950_lbl 772 `"Midwives"', add
label define occ1950_lbl 773 `"Policemen and detectives"', add
label define occ1950_lbl 780 `"Porters"', add
label define occ1950_lbl 781 `"Practical nurses"', add
label define occ1950_lbl 782 `"Sheriffs and bailiffs"', add
label define occ1950_lbl 783 `"Ushers, recreation and amusement"', add
label define occ1950_lbl 784 `"Waiters and waitresses"', add
label define occ1950_lbl 785 `"Watchmen (crossing) and bridge tenders"', add
label define occ1950_lbl 790 `"Service workers, except private household (nec)"', add
label define occ1950_lbl 810 `"Farm foremen"', add
label define occ1950_lbl 820 `"Farm laborers, wage workers"', add
label define occ1950_lbl 830 `"Farm laborers, unpaid family workers"', add
label define occ1950_lbl 840 `"Farm service laborers, self-employed"', add
label define occ1950_lbl 910 `"Fishermen and oystermen"', add
label define occ1950_lbl 920 `"Garage laborers and car washers and greasers"', add
label define occ1950_lbl 930 `"Gardeners, except farm and groundskeepers"', add
label define occ1950_lbl 940 `"Longshoremen and stevedores"', add
label define occ1950_lbl 950 `"Lumbermen, raftsmen, and woodchoppers"', add
label define occ1950_lbl 960 `"Teamsters"', add
label define occ1950_lbl 970 `"Laborers (nec)"', add
label define occ1950_lbl 979 `"Not yet classified"', add
label define occ1950_lbl 980 `"Keeps house/housekeeping at home/housewife"', add
label define occ1950_lbl 981 `"Imputed keeping house (1850-1900)"', add
label define occ1950_lbl 982 `"Helping at home/helps parents/housework"', add
label define occ1950_lbl 983 `"At school/student"', add
label define occ1950_lbl 984 `"Retired"', add
label define occ1950_lbl 985 `"Unemployed/without occupation"', add
label define occ1950_lbl 986 `"Invalid/disabled w/ no occupation reported"', add
label define occ1950_lbl 987 `"Inmate"', add
label define occ1950_lbl 990 `"New Worker"', add
label define occ1950_lbl 991 `"Gentleman/lady/at leisure"', add
label define occ1950_lbl 995 `"Other non-occupation"', add
label define occ1950_lbl 997 `"Occupation missing/unknown"', add
label define occ1950_lbl 999 `"N/A (blank)"', add
label values occ1950 occ1950_lbl

label define occ1990_lbl 003 `"Legislators"'
label define occ1990_lbl 004 `"Chief executives and public administrators"', add
label define occ1990_lbl 007 `"Financial managers"', add
label define occ1990_lbl 008 `"Human resources and labor relations managers"', add
label define occ1990_lbl 013 `"Managers and specialists in marketing, advertising, and public relations"', add
label define occ1990_lbl 014 `"Managers in education and related fields"', add
label define occ1990_lbl 015 `"Managers of medicine and health occupations"', add
label define occ1990_lbl 016 `"Postmasters and mail superintendents"', add
label define occ1990_lbl 017 `"Managers of food-serving and lodging establishments"', add
label define occ1990_lbl 018 `"Managers of properties and real estate"', add
label define occ1990_lbl 019 `"Funeral directors"', add
label define occ1990_lbl 021 `"Managers of service organizations, n.e.c."', add
label define occ1990_lbl 022 `"Managers and administrators, n.e.c."', add
label define occ1990_lbl 023 `"Accountants and auditors"', add
label define occ1990_lbl 024 `"Insurance underwriters"', add
label define occ1990_lbl 025 `"Other financial specialists"', add
label define occ1990_lbl 026 `"Management analysts"', add
label define occ1990_lbl 027 `"Personnel, HR, training, and labor relations specialists"', add
label define occ1990_lbl 028 `"Purchasing agents and buyers, of farm products"', add
label define occ1990_lbl 029 `"Buyers, wholesale and retail trade"', add
label define occ1990_lbl 033 `"Purchasing managers, agents and buyers, n.e.c."', add
label define occ1990_lbl 034 `"Business and promotion agents"', add
label define occ1990_lbl 035 `"Construction inspectors"', add
label define occ1990_lbl 036 `"Inspectors and compliance officers, outside construction"', add
label define occ1990_lbl 037 `"Management support occupations"', add
label define occ1990_lbl 043 `"Architects"', add
label define occ1990_lbl 044 `"Aerospace engineer"', add
label define occ1990_lbl 045 `"Metallurgical and materials engineers, variously phrased"', add
label define occ1990_lbl 047 `"Petroleum, mining, and geological engineers"', add
label define occ1990_lbl 048 `"Chemical engineers"', add
label define occ1990_lbl 053 `"Civil engineers"', add
label define occ1990_lbl 055 `"Electrical engineer"', add
label define occ1990_lbl 056 `"Industrial engineers"', add
label define occ1990_lbl 057 `"Mechanical engineers"', add
label define occ1990_lbl 059 `"Not-elsewhere-classified engineers"', add
label define occ1990_lbl 064 `"Computer systems analysts and computer scientists"', add
label define occ1990_lbl 065 `"Operations and systems researchers and analysts"', add
label define occ1990_lbl 066 `"Actuaries"', add
label define occ1990_lbl 067 `"Statisticians"', add
label define occ1990_lbl 068 `"Mathematicians and mathematical scientists"', add
label define occ1990_lbl 069 `"Physicists and astronomers"', add
label define occ1990_lbl 073 `"Chemists"', add
label define occ1990_lbl 074 `"Atmospheric and space scientists"', add
label define occ1990_lbl 075 `"Geologists"', add
label define occ1990_lbl 076 `"Physical scientists, n.e.c."', add
label define occ1990_lbl 077 `"Agricultural and food scientists"', add
label define occ1990_lbl 078 `"Biological scientists"', add
label define occ1990_lbl 079 `"Foresters and conservation scientists"', add
label define occ1990_lbl 083 `"Medical scientists"', add
label define occ1990_lbl 084 `"Physicians"', add
label define occ1990_lbl 085 `"Dentists"', add
label define occ1990_lbl 086 `"Veterinarians"', add
label define occ1990_lbl 087 `"Optometrists"', add
label define occ1990_lbl 088 `"Podiatrists"', add
label define occ1990_lbl 089 `"Other health and therapy"', add
label define occ1990_lbl 095 `"Registered nurses"', add
label define occ1990_lbl 096 `"Pharmacists"', add
label define occ1990_lbl 097 `"Dietitians and nutritionists"', add
label define occ1990_lbl 098 `"Respiratory therapists"', add
label define occ1990_lbl 099 `"Occupational therapists"', add
label define occ1990_lbl 103 `"Physical therapists"', add
label define occ1990_lbl 104 `"Speech therapists"', add
label define occ1990_lbl 105 `"Therapists, n.e.c."', add
label define occ1990_lbl 106 `"Physicians' assistants"', add
label define occ1990_lbl 113 `"Earth, environmental, and marine science instructors"', add
label define occ1990_lbl 114 `"Biological science instructors"', add
label define occ1990_lbl 115 `"Chemistry instructors"', add
label define occ1990_lbl 116 `"Physics instructors"', add
label define occ1990_lbl 118 `"Psychology instructors"', add
label define occ1990_lbl 119 `"Economics instructors"', add
label define occ1990_lbl 123 `"History instructors"', add
label define occ1990_lbl 125 `"Sociology instructors"', add
label define occ1990_lbl 127 `"Engineering instructors"', add
label define occ1990_lbl 128 `"Math instructors"', add
label define occ1990_lbl 139 `"Education instructors"', add
label define occ1990_lbl 145 `"Law instructors"', add
label define occ1990_lbl 147 `"Theology instructors"', add
label define occ1990_lbl 149 `"Home economics instructors"', add
label define occ1990_lbl 150 `"Humanities profs/instructors, college, nec"', add
label define occ1990_lbl 154 `"Subject instructors (HS/college)"', add
label define occ1990_lbl 155 `"Kindergarten and earlier school teachers"', add
label define occ1990_lbl 156 `"Primary school teachers"', add
label define occ1990_lbl 157 `"Secondary school teachers"', add
label define occ1990_lbl 158 `"Special education teachers"', add
label define occ1990_lbl 159 `"Teachers , n.e.c."', add
label define occ1990_lbl 163 `"Vocational and educational counselors"', add
label define occ1990_lbl 164 `"Librarians"', add
label define occ1990_lbl 165 `"Archivists and curators"', add
label define occ1990_lbl 166 `"Economists, market researchers, and survey researchers"', add
label define occ1990_lbl 167 `"Psychologists"', add
label define occ1990_lbl 168 `"Sociologists"', add
label define occ1990_lbl 169 `"Social scientists, n.e.c."', add
label define occ1990_lbl 173 `"Urban and regional planners"', add
label define occ1990_lbl 174 `"Social workers"', add
label define occ1990_lbl 175 `"Recreation workers"', add
label define occ1990_lbl 176 `"Clergy and religious workers"', add
label define occ1990_lbl 178 `"Lawyers"', add
label define occ1990_lbl 179 `"Judges"', add
label define occ1990_lbl 183 `"Writers and authors"', add
label define occ1990_lbl 184 `"Technical writers"', add
label define occ1990_lbl 185 `"Designers"', add
label define occ1990_lbl 186 `"Musician or composer"', add
label define occ1990_lbl 187 `"Actors, directors, producers"', add
label define occ1990_lbl 188 `"Art makers: painters, sculptors, craft-artists, and print-makers"', add
label define occ1990_lbl 189 `"Photographers"', add
label define occ1990_lbl 193 `"Dancers"', add
label define occ1990_lbl 194 `"Art/entertainment performers and related"', add
label define occ1990_lbl 195 `"Editors and reporters"', add
label define occ1990_lbl 198 `"Announcers"', add
label define occ1990_lbl 199 `"Athletes, sports instructors, and officials"', add
label define occ1990_lbl 200 `"Professionals, n.e.c."', add
label define occ1990_lbl 203 `"Clinical laboratory technologies and technicians"', add
label define occ1990_lbl 204 `"Dental hygenists"', add
label define occ1990_lbl 205 `"Health record tech specialists"', add
label define occ1990_lbl 206 `"Radiologic tech specialists"', add
label define occ1990_lbl 207 `"Licensed practical nurses"', add
label define occ1990_lbl 208 `"Health technologists and technicians, n.e.c."', add
label define occ1990_lbl 213 `"Electrical and electronic (engineering) technicians"', add
label define occ1990_lbl 214 `"Engineering technicians, n.e.c."', add
label define occ1990_lbl 215 `"Mechanical engineering technicians"', add
label define occ1990_lbl 217 `"Drafters"', add
label define occ1990_lbl 218 `"Surveyors, cartographers, mapping scientists and technicians"', add
label define occ1990_lbl 223 `"Biological technicians"', add
label define occ1990_lbl 224 `"Chemical technicians"', add
label define occ1990_lbl 225 `"Other science technicians"', add
label define occ1990_lbl 226 `"Airplane pilots and navigators"', add
label define occ1990_lbl 227 `"Air traffic controllers"', add
label define occ1990_lbl 228 `"Broadcast equipment operators"', add
label define occ1990_lbl 229 `"Computer software developers"', add
label define occ1990_lbl 233 `"Programmers of numerically controlled machine tools"', add
label define occ1990_lbl 234 `"Legal assistants, paralegals, legal support, etc"', add
label define occ1990_lbl 235 `"Technicians, n.e.c."', add
label define occ1990_lbl 243 `"Supervisors and proprietors of sales jobs"', add
label define occ1990_lbl 253 `"Insurance sales occupations"', add
label define occ1990_lbl 254 `"Real estate sales occupations"', add
label define occ1990_lbl 255 `"Financial services sales occupations"', add
label define occ1990_lbl 256 `"Advertising and related sales jobs"', add
label define occ1990_lbl 258 `"Sales engineers"', add
label define occ1990_lbl 274 `"Salespersons, n.e.c."', add
label define occ1990_lbl 275 `"Retail sales clerks"', add
label define occ1990_lbl 276 `"Cashiers"', add
label define occ1990_lbl 277 `"Door-to-door sales, street sales, and news vendors"', add
label define occ1990_lbl 283 `"Sales demonstrators / promoters / models"', add
label define occ1990_lbl 303 `"Office supervisors"', add
label define occ1990_lbl 308 `"Computer and peripheral equipment operators"', add
label define occ1990_lbl 313 `"Secretaries"', add
label define occ1990_lbl 314 `"Stenographers"', add
label define occ1990_lbl 315 `"Typists"', add
label define occ1990_lbl 316 `"Interviewers, enumerators, and surveyors"', add
label define occ1990_lbl 317 `"Hotel clerks"', add
label define occ1990_lbl 318 `"Transportation ticket and reservation agents"', add
label define occ1990_lbl 319 `"Receptionists"', add
label define occ1990_lbl 323 `"Information clerks, nec"', add
label define occ1990_lbl 326 `"Correspondence and order clerks"', add
label define occ1990_lbl 328 `"Human resources clerks, except payroll and timekeeping"', add
label define occ1990_lbl 329 `"Library assistants"', add
label define occ1990_lbl 335 `"File clerks"', add
label define occ1990_lbl 336 `"Records clerks"', add
label define occ1990_lbl 337 `"Bookkeepers and accounting and auditing clerks"', add
label define occ1990_lbl 338 `"Payroll and timekeeping clerks"', add
label define occ1990_lbl 343 `"Cost and rate clerks (financial records processing)"', add
label define occ1990_lbl 344 `"Billing clerks and related financial records processing"', add
label define occ1990_lbl 345 `"Duplication machine operators / office machine operators"', add
label define occ1990_lbl 346 `"Mail and paper handlers"', add
label define occ1990_lbl 347 `"Office machine operators, n.e.c."', add
label define occ1990_lbl 348 `"Telephone operators"', add
label define occ1990_lbl 349 `"Other telecom operators"', add
label define occ1990_lbl 354 `"Postal clerks, excluding mail carriers"', add
label define occ1990_lbl 355 `"Mail carriers for postal service"', add
label define occ1990_lbl 356 `"Mail clerks, outside of post office"', add
label define occ1990_lbl 357 `"Messengers"', add
label define occ1990_lbl 359 `"Dispatchers"', add
label define occ1990_lbl 361 `"Inspectors, n.e.c."', add
label define occ1990_lbl 364 `"Shipping and receiving clerks"', add
label define occ1990_lbl 365 `"Stock and inventory clerks"', add
label define occ1990_lbl 366 `"Meter readers"', add
label define occ1990_lbl 368 `"Weighers, measurers, and checkers"', add
label define occ1990_lbl 373 `"Material recording, scheduling, production, planning, and expediting clerks"', add
label define occ1990_lbl 375 `"Insurance adjusters, examiners, and investigators"', add
label define occ1990_lbl 376 `"Customer service reps, investigators and adjusters, except insurance"', add
label define occ1990_lbl 377 `"Eligibility clerks for government programs; social welfare"', add
label define occ1990_lbl 378 `"Bill and account collectors"', add
label define occ1990_lbl 379 `"General office clerks"', add
label define occ1990_lbl 383 `"Bank tellers"', add
label define occ1990_lbl 384 `"Proofreaders"', add
label define occ1990_lbl 385 `"Data entry keyers"', add
label define occ1990_lbl 386 `"Statistical clerks"', add
label define occ1990_lbl 387 `"Teacher's aides"', add
label define occ1990_lbl 389 `"Administrative support jobs, n.e.c."', add
label define occ1990_lbl 405 `"Housekeepers, maids, butlers, stewards, and lodging quarters cleaners"', add
label define occ1990_lbl 407 `"Private household cleaners and servants"', add
label define occ1990_lbl 415 `"Supervisors of guards"', add
label define occ1990_lbl 417 `"Fire fighting, prevention, and inspection"', add
label define occ1990_lbl 418 `"Police, detectives, and private investigators"', add
label define occ1990_lbl 423 `"Other law enforcement: sheriffs, bailiffs, correctional institution officers"', add
label define occ1990_lbl 425 `"Crossing guards and bridge tenders"', add
label define occ1990_lbl 426 `"Guards, watchmen, doorkeepers"', add
label define occ1990_lbl 427 `"Protective services, n.e.c."', add
label define occ1990_lbl 434 `"Bartenders"', add
label define occ1990_lbl 435 `"Waiter/waitress"', add
label define occ1990_lbl 436 `"Cooks, variously defined"', add
label define occ1990_lbl 438 `"Food counter and fountain workers"', add
label define occ1990_lbl 439 `"Kitchen workers"', add
label define occ1990_lbl 443 `"Waiter's assistant"', add
label define occ1990_lbl 444 `"Misc food prep workers"', add
label define occ1990_lbl 445 `"Dental assistants"', add
label define occ1990_lbl 446 `"Health aides, except nursing"', add
label define occ1990_lbl 447 `"Nursing aides, orderlies, and attendants"', add
label define occ1990_lbl 448 `"Supervisors of cleaning and building service"', add
label define occ1990_lbl 453 `"Janitors"', add
label define occ1990_lbl 454 `"Elevator operators"', add
label define occ1990_lbl 455 `"Pest control occupations"', add
label define occ1990_lbl 456 `"Supervisors of personal service jobs, n.e.c."', add
label define occ1990_lbl 457 `"Barbers"', add
label define occ1990_lbl 458 `"Hairdressers and cosmetologists"', add
label define occ1990_lbl 459 `"Recreation facility attendants"', add
label define occ1990_lbl 461 `"Guides"', add
label define occ1990_lbl 462 `"Ushers"', add
label define occ1990_lbl 463 `"Public transportation attendants and inspectors"', add
label define occ1990_lbl 464 `"Baggage porters"', add
label define occ1990_lbl 465 `"Welfare service aides"', add
label define occ1990_lbl 468 `"Child care workers"', add
label define occ1990_lbl 469 `"Personal service occupations, nec"', add
label define occ1990_lbl 473 `"Farmers (owners and tenants)"', add
label define occ1990_lbl 474 `"Horticultural specialty farmers"', add
label define occ1990_lbl 475 `"Farm managers, except for horticultural farms"', add
label define occ1990_lbl 476 `"Managers of horticultural specialty farms"', add
label define occ1990_lbl 479 `"Farm workers"', add
label define occ1990_lbl 483 `"Marine life cultivation workers"', add
label define occ1990_lbl 484 `"Nursery farming workers"', add
label define occ1990_lbl 485 `"Supervisors of agricultural occupations"', add
label define occ1990_lbl 486 `"Gardeners and groundskeepers"', add
label define occ1990_lbl 487 `"Animal caretakers except on farms"', add
label define occ1990_lbl 488 `"Graders and sorters of agricultural products"', add
label define occ1990_lbl 489 `"Inspectors of agricultural products"', add
label define occ1990_lbl 496 `"Timber, logging, and forestry workers"', add
label define occ1990_lbl 498 `"Fishers, hunters, and kindred"', add
label define occ1990_lbl 503 `"Supervisors of mechanics and repairers"', add
label define occ1990_lbl 505 `"Automobile mechanics"', add
label define occ1990_lbl 507 `"Bus, truck, and stationary engine mechanics"', add
label define occ1990_lbl 508 `"Aircraft mechanics"', add
label define occ1990_lbl 509 `"Small engine repairers"', add
label define occ1990_lbl 514 `"Auto body repairers"', add
label define occ1990_lbl 516 `"Heavy equipment and farm equipment mechanics"', add
label define occ1990_lbl 518 `"Industrial machinery repairers"', add
label define occ1990_lbl 519 `"Machinery maintenance occupations"', add
label define occ1990_lbl 523 `"Repairers of industrial electrical equipment"', add
label define occ1990_lbl 525 `"Repairers of data processing equipment"', add
label define occ1990_lbl 526 `"Repairers of household appliances and power tools"', add
label define occ1990_lbl 527 `"Telecom and line installers and repairers"', add
label define occ1990_lbl 533 `"Repairers of electrical equipment, n.e.c."', add
label define occ1990_lbl 534 `"Heating, air conditioning, and refigeration mechanics"', add
label define occ1990_lbl 535 `"Precision makers, repairers, and smiths"', add
label define occ1990_lbl 536 `"Locksmiths and safe repairers"', add
label define occ1990_lbl 538 `"Office machine repairers and mechanics"', add
label define occ1990_lbl 539 `"Repairers of mechanical controls and valves"', add
label define occ1990_lbl 543 `"Elevator installers and repairers"', add
label define occ1990_lbl 544 `"Millwrights"', add
label define occ1990_lbl 549 `"Mechanics and repairers, n.e.c."', add
label define occ1990_lbl 558 `"Supervisors of construction work"', add
label define occ1990_lbl 563 `"Masons, tilers, and carpet installers"', add
label define occ1990_lbl 567 `"Carpenters"', add
label define occ1990_lbl 573 `"Drywall installers"', add
label define occ1990_lbl 575 `"Electricians"', add
label define occ1990_lbl 577 `"Electric power installers and repairers"', add
label define occ1990_lbl 579 `"Painters, construction and maintenance"', add
label define occ1990_lbl 583 `"Paperhangers"', add
label define occ1990_lbl 584 `"Plasterers"', add
label define occ1990_lbl 585 `"Plumbers, pipe fitters, and steamfitters"', add
label define occ1990_lbl 588 `"Concrete and cement workers"', add
label define occ1990_lbl 589 `"Glaziers"', add
label define occ1990_lbl 593 `"Insulation workers"', add
label define occ1990_lbl 594 `"Paving, surfacing, and tamping equipment operators"', add
label define occ1990_lbl 595 `"Roofers and slaters"', add
label define occ1990_lbl 596 `"Sheet metal duct installers"', add
label define occ1990_lbl 597 `"Structural metal workers"', add
label define occ1990_lbl 598 `"Drillers of earth"', add
label define occ1990_lbl 599 `"Construction trades, n.e.c."', add
label define occ1990_lbl 614 `"Drillers of oil wells"', add
label define occ1990_lbl 615 `"Explosives workers"', add
label define occ1990_lbl 616 `"Miners"', add
label define occ1990_lbl 617 `"Other mining occupations"', add
label define occ1990_lbl 628 `"Production supervisors or foremen"', add
label define occ1990_lbl 634 `"Tool and die makers and die setters"', add
label define occ1990_lbl 637 `"Machinists"', add
label define occ1990_lbl 643 `"Boilermakers"', add
label define occ1990_lbl 644 `"Precision grinders and filers"', add
label define occ1990_lbl 645 `"Patternmakers and model makers"', add
label define occ1990_lbl 646 `"Lay-out workers"', add
label define occ1990_lbl 649 `"Engravers"', add
label define occ1990_lbl 653 `"Tinsmiths, coppersmiths, and sheet metal workers"', add
label define occ1990_lbl 657 `"Cabinetmakers and bench carpenters"', add
label define occ1990_lbl 658 `"Furniture and wood finishers"', add
label define occ1990_lbl 659 `"Other precision woodworkers"', add
label define occ1990_lbl 666 `"Dressmakers and seamstresses"', add
label define occ1990_lbl 667 `"Tailors"', add
label define occ1990_lbl 668 `"Upholsterers"', add
label define occ1990_lbl 669 `"Shoe repairers"', add
label define occ1990_lbl 674 `"Other precision apparel and fabric workers"', add
label define occ1990_lbl 675 `"Hand molders and shapers, except jewelers"', add
label define occ1990_lbl 677 `"Optical goods workers"', add
label define occ1990_lbl 678 `"Dental laboratory and medical appliance technicians"', add
label define occ1990_lbl 679 `"Bookbinders"', add
label define occ1990_lbl 684 `"Other precision and craft workers"', add
label define occ1990_lbl 686 `"Butchers and meat cutters"', add
label define occ1990_lbl 687 `"Bakers"', add
label define occ1990_lbl 688 `"Batch food makers"', add
label define occ1990_lbl 693 `"Adjusters and calibrators"', add
label define occ1990_lbl 694 `"Water and sewage treatment plant operators"', add
label define occ1990_lbl 695 `"Power plant operators"', add
label define occ1990_lbl 696 `"Plant and system operators, stationary engineers"', add
label define occ1990_lbl 699 `"Other plant and system operators"', add
label define occ1990_lbl 703 `"Lathe, milling, and turning machine operatives"', add
label define occ1990_lbl 706 `"Punching and stamping press operatives"', add
label define occ1990_lbl 707 `"Rollers, roll hands, and finishers of metal"', add
label define occ1990_lbl 708 `"Drilling and boring machine operators"', add
label define occ1990_lbl 709 `"Grinding, abrading, buffing, and polishing workers"', add
label define occ1990_lbl 713 `"Forge and hammer operators"', add
label define occ1990_lbl 717 `"Fabricating machine operators, n.e.c."', add
label define occ1990_lbl 719 `"Molders, and casting machine operators"', add
label define occ1990_lbl 723 `"Metal platers"', add
label define occ1990_lbl 724 `"Heat treating equipment operators"', add
label define occ1990_lbl 726 `"Wood lathe, routing, and planing machine operators"', add
label define occ1990_lbl 727 `"Sawing machine operators and sawyers"', add
label define occ1990_lbl 728 `"Shaping and joining machine operator (woodworking)"', add
label define occ1990_lbl 729 `"Nail and tacking machine operators  (woodworking)"', add
label define occ1990_lbl 733 `"Other woodworking machine operators"', add
label define occ1990_lbl 734 `"Printing machine operators, n.e.c."', add
label define occ1990_lbl 735 `"Photoengravers and lithographers"', add
label define occ1990_lbl 736 `"Typesetters and compositors"', add
label define occ1990_lbl 738 `"Winding and twisting textile/apparel operatives"', add
label define occ1990_lbl 739 `"Knitters, loopers, and toppers textile operatives"', add
label define occ1990_lbl 743 `"Textile cutting machine operators"', add
label define occ1990_lbl 744 `"Textile sewing machine operators"', add
label define occ1990_lbl 745 `"Shoemaking machine operators"', add
label define occ1990_lbl 747 `"Pressing machine operators (clothing)"', add
label define occ1990_lbl 748 `"Laundry workers"', add
label define occ1990_lbl 749 `"Misc textile machine operators"', add
label define occ1990_lbl 753 `"Cementing and gluing maching operators"', add
label define occ1990_lbl 754 `"Packers, fillers, and wrappers"', add
label define occ1990_lbl 755 `"Extruding and forming machine operators"', add
label define occ1990_lbl 756 `"Mixing and blending machine operatives"', add
label define occ1990_lbl 757 `"Separating, filtering, and clarifying machine operators"', add
label define occ1990_lbl 759 `"Painting machine operators"', add
label define occ1990_lbl 763 `"Roasting and baking machine operators (food)"', add
label define occ1990_lbl 764 `"Washing, cleaning, and pickling machine operators"', add
label define occ1990_lbl 765 `"Paper folding machine operators"', add
label define occ1990_lbl 766 `"Furnace, kiln, and oven operators, apart from food"', add
label define occ1990_lbl 768 `"Crushing and grinding machine operators"', add
label define occ1990_lbl 769 `"Slicing and cutting machine operators"', add
label define occ1990_lbl 773 `"Motion picture projectionists"', add
label define occ1990_lbl 774 `"Photographic process workers"', add
label define occ1990_lbl 779 `"Machine operators, n.e.c."', add
label define occ1990_lbl 783 `"Welders and metal cutters"', add
label define occ1990_lbl 784 `"Solderers"', add
label define occ1990_lbl 785 `"Assemblers of electrical equipment"', add
label define occ1990_lbl 789 `"Hand painting, coating, and decorating occupations"', add
label define occ1990_lbl 796 `"Production checkers and inspectors"', add
label define occ1990_lbl 799 `"Graders and sorters in manufacturing"', add
label define occ1990_lbl 803 `"Supervisors of motor vehicle transportation"', add
label define occ1990_lbl 804 `"Truck, delivery, and tractor drivers"', add
label define occ1990_lbl 808 `"Bus drivers"', add
label define occ1990_lbl 809 `"Taxi cab drivers and chauffeurs"', add
label define occ1990_lbl 813 `"Parking lot attendants"', add
label define occ1990_lbl 823 `"Railroad conductors and yardmasters"', add
label define occ1990_lbl 824 `"Locomotive operators (engineers and firemen)"', add
label define occ1990_lbl 825 `"Railroad brake, coupler, and switch operators"', add
label define occ1990_lbl 829 `"Ship crews and marine engineers"', add
label define occ1990_lbl 834 `"Water transport infrastructure tenders and crossing guards"', add
label define occ1990_lbl 844 `"Operating engineers of construction equipment"', add
label define occ1990_lbl 848 `"Crane, derrick, winch, and hoist operators"', add
label define occ1990_lbl 853 `"Excavating and loading machine operators"', add
label define occ1990_lbl 859 `"Misc material moving occupations"', add
label define occ1990_lbl 865 `"Helpers, constructions"', add
label define occ1990_lbl 866 `"Helpers, surveyors"', add
label define occ1990_lbl 869 `"Construction laborers"', add
label define occ1990_lbl 874 `"Production helpers"', add
label define occ1990_lbl 875 `"Garbage and recyclable material collectors"', add
label define occ1990_lbl 876 `"Materials movers: stevedores and longshore workers"', add
label define occ1990_lbl 877 `"Stock handlers"', add
label define occ1990_lbl 878 `"Machine feeders and offbearers"', add
label define occ1990_lbl 883 `"Freight, stock, and materials handlers"', add
label define occ1990_lbl 885 `"Garage and service station related occupations"', add
label define occ1990_lbl 887 `"Vehicle washers and equipment cleaners"', add
label define occ1990_lbl 888 `"Packers and packagers by hand"', add
label define occ1990_lbl 889 `"Laborers outside construction"', add
label define occ1990_lbl 905 `"Military"', add
label define occ1990_lbl 991 `"Unemployed"', add
label define occ1990_lbl 999 `"Unknown"', add
label values occ1990 occ1990_lbl

label define occ2010_lbl 0010 `"Chief executives and legislators/public administration"'
label define occ2010_lbl 0020 `"General and Operations Managers"', add
label define occ2010_lbl 0030 `"Managers in Marketing, Advertising, and Public Relations"', add
label define occ2010_lbl 0100 `"Administrative Services Managers"', add
label define occ2010_lbl 0110 `"Computer and Information Systems Managers"', add
label define occ2010_lbl 0120 `"Financial Managers"', add
label define occ2010_lbl 0130 `"Human Resources Managers"', add
label define occ2010_lbl 0140 `"Industrial Production Managers"', add
label define occ2010_lbl 0150 `"Purchasing Managers"', add
label define occ2010_lbl 0160 `"Transportation, Storage, and Distribution Managers"', add
label define occ2010_lbl 0205 `"Farmers, Ranchers, and Other Agricultural Managers"', add
label define occ2010_lbl 0220 `"Constructions Managers"', add
label define occ2010_lbl 0230 `"Education Administrators"', add
label define occ2010_lbl 0300 `"Architectural and Engineering Managers"', add
label define occ2010_lbl 0310 `"Food Service and Lodging Managers"', add
label define occ2010_lbl 0320 `"Funeral Directors"', add
label define occ2010_lbl 0330 `"Gaming Managers"', add
label define occ2010_lbl 0350 `"Medical and Health Services Managers"', add
label define occ2010_lbl 0360 `"Natural Science Managers"', add
label define occ2010_lbl 0410 `"Property, Real Estate, and Community Association Managers"', add
label define occ2010_lbl 0420 `"Social and Community Service Managers"', add
label define occ2010_lbl 0430 `"Managers, nec (including Postmasters)"', add
label define occ2010_lbl 0500 `"Agents and Business Managers of Artists, Performers, and Athletes"', add
label define occ2010_lbl 0510 `"Buyers and Purchasing Agents, Farm Products"', add
label define occ2010_lbl 0520 `"Wholesale and Retail Buyers, Except Farm Products"', add
label define occ2010_lbl 0530 `"Purchasing Agents, Except Wholesale, Retail, and Farm Products"', add
label define occ2010_lbl 0540 `"Claims Adjusters, Appraisers, Examiners, and Investigators"', add
label define occ2010_lbl 0560 `"Compliance Officers, Except Agriculture"', add
label define occ2010_lbl 0600 `"Cost Estimators"', add
label define occ2010_lbl 0620 `"Human Resources, Training, and Labor Relations Specialists"', add
label define occ2010_lbl 0700 `"Logisticians"', add
label define occ2010_lbl 0710 `"Management Analysts"', add
label define occ2010_lbl 0720 `"Meeting and Convention Planners"', add
label define occ2010_lbl 0730 `"Other Business Operations and Management Specialists"', add
label define occ2010_lbl 0800 `"Accountants and Auditors"', add
label define occ2010_lbl 0810 `"Appraisers and Assessors of Real Estate"', add
label define occ2010_lbl 0820 `"Budget Analysts"', add
label define occ2010_lbl 0830 `"Credit Analysts"', add
label define occ2010_lbl 0840 `"Financial Analysts"', add
label define occ2010_lbl 0850 `"Personal Financial Advisors"', add
label define occ2010_lbl 0860 `"Insurance Underwriters"', add
label define occ2010_lbl 0900 `"Financial Examiners"', add
label define occ2010_lbl 0910 `"Credit Counselors and Loan Officers"', add
label define occ2010_lbl 0930 `"Tax Examiners and Collectors, and Revenue Agents"', add
label define occ2010_lbl 0940 `"Tax Preparers"', add
label define occ2010_lbl 0950 `"Financial Specialists, nec"', add
label define occ2010_lbl 1000 `"Computer Scientists and Systems Analysts/Network systems Analysts/Web Developers"', add
label define occ2010_lbl 1010 `"Computer Programmers"', add
label define occ2010_lbl 1020 `"Software Developers, Applications and Systems Software"', add
label define occ2010_lbl 1050 `"Computer Support Specialists"', add
label define occ2010_lbl 1060 `"Database Administrators"', add
label define occ2010_lbl 1100 `"Network and Computer Systems Administrators"', add
label define occ2010_lbl 1200 `"Actuaries"', add
label define occ2010_lbl 1220 `"Operations Research Analysts"', add
label define occ2010_lbl 1230 `"Statisticians"', add
label define occ2010_lbl 1240 `"Mathematical science occupations, nec"', add
label define occ2010_lbl 1300 `"Architects, Except Naval"', add
label define occ2010_lbl 1310 `"Surveyors, Cartographers, and Photogrammetrists"', add
label define occ2010_lbl 1320 `"Aerospace Engineers"', add
label define occ2010_lbl 1350 `"Chemical Engineers"', add
label define occ2010_lbl 1360 `"Civil Engineers"', add
label define occ2010_lbl 1400 `"Computer Hardware Engineers"', add
label define occ2010_lbl 1410 `"Electrical and Electronics Engineers"', add
label define occ2010_lbl 1420 `"Environmental Engineers"', add
label define occ2010_lbl 1430 `"Industrial Engineers, including Health and Safety"', add
label define occ2010_lbl 1440 `"Marine Engineers and Naval Architects"', add
label define occ2010_lbl 1450 `"Materials Engineers"', add
label define occ2010_lbl 1460 `"Mechanical Engineers"', add
label define occ2010_lbl 1520 `"Petroleum, mining and geological engineers, including mining safety engineers"', add
label define occ2010_lbl 1530 `"Engineers, nec"', add
label define occ2010_lbl 1540 `"Drafters"', add
label define occ2010_lbl 1550 `"Engineering Technicians, Except Drafters"', add
label define occ2010_lbl 1560 `"Surveying and Mapping Technicians"', add
label define occ2010_lbl 1600 `"Agricultural and Food Scientists"', add
label define occ2010_lbl 1610 `"Biological Scientists"', add
label define occ2010_lbl 1640 `"Conservation Scientists and Foresters"', add
label define occ2010_lbl 1650 `"Medical Scientists, and Life Scientists, All Other"', add
label define occ2010_lbl 1700 `"Astronomers and Physicists"', add
label define occ2010_lbl 1710 `"Atmospheric and Space Scientists"', add
label define occ2010_lbl 1720 `"Chemists and Materials Scientists"', add
label define occ2010_lbl 1740 `"Environmental Scientists and Geoscientists"', add
label define occ2010_lbl 1760 `"Physical Scientists, nec"', add
label define occ2010_lbl 1800 `"Economists and market researchers"', add
label define occ2010_lbl 1820 `"Psychologists"', add
label define occ2010_lbl 1830 `"Urban and Regional Planners"', add
label define occ2010_lbl 1840 `"Social Scientists, nec"', add
label define occ2010_lbl 1900 `"Agricultural and Food Science Technicians"', add
label define occ2010_lbl 1910 `"Biological Technicians"', add
label define occ2010_lbl 1920 `"Chemical Technicians"', add
label define occ2010_lbl 1930 `"Geological and Petroleum Technicians, and Nuclear Technicians"', add
label define occ2010_lbl 1960 `"Life, Physical, and Social Science Technicians, nec"', add
label define occ2010_lbl 1980 `"Professional, Research, or Technical Workers, nec"', add
label define occ2010_lbl 2000 `"Counselors"', add
label define occ2010_lbl 2010 `"Social Workers"', add
label define occ2010_lbl 2020 `"Community and Social Service Specialists, nec"', add
label define occ2010_lbl 2040 `"Clergy"', add
label define occ2010_lbl 2050 `"Directors, Religious Activities and Education"', add
label define occ2010_lbl 2060 `"Religious Workers, nec"', add
label define occ2010_lbl 2100 `"Lawyers, and judges, magistrates, and other judicial workers"', add
label define occ2010_lbl 2140 `"Paralegals and Legal Assistants"', add
label define occ2010_lbl 2150 `"Legal Support Workers, nec"', add
label define occ2010_lbl 2200 `"Postsecondary Teachers"', add
label define occ2010_lbl 2300 `"Preschool and Kindergarten Teachers"', add
label define occ2010_lbl 2310 `"Elementary and Middle School Teachers"', add
label define occ2010_lbl 2320 `"Secondary School Teachers"', add
label define occ2010_lbl 2330 `"Special Education Teachers"', add
label define occ2010_lbl 2340 `"Other Teachers and Instructors"', add
label define occ2010_lbl 2400 `"Archivists, Curators, and Museum Technicians"', add
label define occ2010_lbl 2430 `"Librarians"', add
label define occ2010_lbl 2440 `"Library Technicians"', add
label define occ2010_lbl 2540 `"Teacher Assistants"', add
label define occ2010_lbl 2550 `"Education, Training, and Library Workers, nec"', add
label define occ2010_lbl 2600 `"Artists and Related Workers"', add
label define occ2010_lbl 2630 `"Designers"', add
label define occ2010_lbl 2700 `"Actors, Producers, and Directors"', add
label define occ2010_lbl 2720 `"Athletes, Coaches, Umpires, and Related Workers"', add
label define occ2010_lbl 2740 `"Dancers and Choreographers"', add
label define occ2010_lbl 2750 `"Musicians, Singers, and Related Workers"', add
label define occ2010_lbl 2760 `"Entertainers and Performers, Sports and Related Workers, All Other"', add
label define occ2010_lbl 2800 `"Announcers"', add
label define occ2010_lbl 2810 `"Editors, News Analysts, Reporters, and Correspondents"', add
label define occ2010_lbl 2825 `"Public Relations Specialists"', add
label define occ2010_lbl 2840 `"Technical Writers"', add
label define occ2010_lbl 2850 `"Writers and Authors"', add
label define occ2010_lbl 2860 `"Media and Communication Workers, nec"', add
label define occ2010_lbl 2900 `"Broadcast and Sound Engineering Technicians and Radio Operators, and media and communication equipment workers, all other"', add
label define occ2010_lbl 2910 `"Photographers"', add
label define occ2010_lbl 2920 `"Television, Video, and Motion Picture Camera Operators and Editors"', add
label define occ2010_lbl 3000 `"Chiropractors"', add
label define occ2010_lbl 3010 `"Dentists"', add
label define occ2010_lbl 3030 `"Dieticians and Nutritionists"', add
label define occ2010_lbl 3040 `"Optometrists"', add
label define occ2010_lbl 3050 `"Pharmacists"', add
label define occ2010_lbl 3060 `"Physicians and Surgeons"', add
label define occ2010_lbl 3110 `"Physician Assistants"', add
label define occ2010_lbl 3120 `"Podiatrists"', add
label define occ2010_lbl 3130 `"Registered Nurses"', add
label define occ2010_lbl 3140 `"Audiologists"', add
label define occ2010_lbl 3150 `"Occupational Therapists"', add
label define occ2010_lbl 3160 `"Physical Therapists"', add
label define occ2010_lbl 3200 `"Radiation Therapists"', add
label define occ2010_lbl 3210 `"Recreational Therapists"', add
label define occ2010_lbl 3220 `"Respiratory Therapists"', add
label define occ2010_lbl 3230 `"Speech Language Pathologists"', add
label define occ2010_lbl 3240 `"Therapists, nec"', add
label define occ2010_lbl 3250 `"Veterinarians"', add
label define occ2010_lbl 3260 `"Health Diagnosing and Treating Practitioners, nec"', add
label define occ2010_lbl 3300 `"Clinical Laboratory Technologists and Technicians"', add
label define occ2010_lbl 3310 `"Dental Hygienists"', add
label define occ2010_lbl 3320 `"Diagnostic Related Technologists and Technicians"', add
label define occ2010_lbl 3400 `"Emergency Medical Technicians and Paramedics"', add
label define occ2010_lbl 3410 `"Health Diagnosing and Treating Practitioner Support Technicians"', add
label define occ2010_lbl 3500 `"Licensed Practical and Licensed Vocational Nurses"', add
label define occ2010_lbl 3510 `"Medical Records and Health Information Technicians"', add
label define occ2010_lbl 3520 `"Opticians, Dispensing"', add
label define occ2010_lbl 3530 `"Health Technologists and Technicians, nec"', add
label define occ2010_lbl 3540 `"Healthcare Practitioners and Technical Occupations, nec"', add
label define occ2010_lbl 3600 `"Nursing, Psychiatric, and Home Health Aides"', add
label define occ2010_lbl 3610 `"Occupational Therapy Assistants and Aides"', add
label define occ2010_lbl 3620 `"Physical Therapist Assistants and Aides"', add
label define occ2010_lbl 3630 `"Massage Therapists"', add
label define occ2010_lbl 3640 `"Dental Assistants"', add
label define occ2010_lbl 3650 `"Medical Assistants and Other Healthcare Support Occupations, nec"', add
label define occ2010_lbl 3700 `"First-Line Supervisors of Correctional Officers"', add
label define occ2010_lbl 3710 `"First-Line Supervisors of Police and Detectives"', add
label define occ2010_lbl 3720 `"First-Line Supervisors of Fire Fighting and Prevention Workers"', add
label define occ2010_lbl 3730 `"Supervisors, Protective Service Workers, All Other"', add
label define occ2010_lbl 3740 `"Firefighters"', add
label define occ2010_lbl 3750 `"Fire Inspectors"', add
label define occ2010_lbl 3800 `"Sheriffs, Bailiffs, Correctional Officers, and Jailers"', add
label define occ2010_lbl 3820 `"Police Officers and Detectives"', add
label define occ2010_lbl 3900 `"Animal Control"', add
label define occ2010_lbl 3910 `"Private Detectives and Investigators"', add
label define occ2010_lbl 3930 `"Security Guards and Gaming Surveillance Officers"', add
label define occ2010_lbl 3940 `"Crossing Guards"', add
label define occ2010_lbl 3950 `"Law enforcement workers, nec"', add
label define occ2010_lbl 4000 `"Chefs and Cooks"', add
label define occ2010_lbl 4010 `"First-Line Supervisors of Food Preparation and Serving Workers"', add
label define occ2010_lbl 4030 `"Food Preparation Workers"', add
label define occ2010_lbl 4040 `"Bartenders"', add
label define occ2010_lbl 4050 `"Combined Food Preparation and Serving Workers, Including Fast Food"', add
label define occ2010_lbl 4060 `"Counter Attendant, Cafeteria, Food Concession, and Coffee Shop"', add
label define occ2010_lbl 4110 `"Waiters and Waitresses"', add
label define occ2010_lbl 4120 `"Food Servers, Nonrestaurant"', add
label define occ2010_lbl 4130 `"Food preparation and serving related workers, nec"', add
label define occ2010_lbl 4140 `"Dishwashers"', add
label define occ2010_lbl 4150 `"Host and Hostesses, Restaurant, Lounge, and Coffee Shop"', add
label define occ2010_lbl 4200 `"First-Line Supervisors of Housekeeping and Janitorial Workers"', add
label define occ2010_lbl 4210 `"First-Line Supervisors of Landscaping, Lawn Service, and Groundskeeping Workers"', add
label define occ2010_lbl 4220 `"Janitors and Building Cleaners"', add
label define occ2010_lbl 4230 `"Maids and Housekeeping Cleaners"', add
label define occ2010_lbl 4240 `"Pest Control Workers"', add
label define occ2010_lbl 4250 `"Grounds Maintenance Workers"', add
label define occ2010_lbl 4300 `"First-Line Supervisors of Gaming Workers"', add
label define occ2010_lbl 4320 `"First-Line Supervisors of Personal Service Workers"', add
label define occ2010_lbl 4340 `"Animal Trainers"', add
label define occ2010_lbl 4350 `"Nonfarm Animal Caretakers"', add
label define occ2010_lbl 4400 `"Gaming Services Workers"', add
label define occ2010_lbl 4420 `"Ushers, Lobby Attendants, and Ticket Takers"', add
label define occ2010_lbl 4430 `"Entertainment Attendants and Related Workers, nec"', add
label define occ2010_lbl 4460 `"Funeral Service Workers and Embalmers"', add
label define occ2010_lbl 4500 `"Barbers"', add
label define occ2010_lbl 4510 `"Hairdressers, Hairstylists, and Cosmetologists"', add
label define occ2010_lbl 4520 `"Personal Appearance Workers, nec"', add
label define occ2010_lbl 4530 `"Baggage Porters, Bellhops, and Concierges"', add
label define occ2010_lbl 4540 `"Tour and Travel Guides"', add
label define occ2010_lbl 4600 `"Childcare Workers"', add
label define occ2010_lbl 4610 `"Personal Care Aides"', add
label define occ2010_lbl 4620 `"Recreation and Fitness Workers"', add
label define occ2010_lbl 4640 `"Residential Advisors"', add
label define occ2010_lbl 4650 `"Personal Care and Service Workers, All Other"', add
label define occ2010_lbl 4700 `"First-Line Supervisors of Sales Workers"', add
label define occ2010_lbl 4720 `"Cashiers"', add
label define occ2010_lbl 4740 `"Counter and Rental Clerks"', add
label define occ2010_lbl 4750 `"Parts Salespersons"', add
label define occ2010_lbl 4760 `"Retail Salespersons"', add
label define occ2010_lbl 4800 `"Advertising Sales Agents"', add
label define occ2010_lbl 4810 `"Insurance Sales Agents"', add
label define occ2010_lbl 4820 `"Securities, Commodities, and Financial Services Sales Agents"', add
label define occ2010_lbl 4830 `"Travel Agents"', add
label define occ2010_lbl 4840 `"Sales Representatives, Services, All Other"', add
label define occ2010_lbl 4850 `"Sales Representatives, Wholesale and Manufacturing"', add
label define occ2010_lbl 4900 `"Models, Demonstrators, and Product Promoters"', add
label define occ2010_lbl 4920 `"Real Estate Brokers and Sales Agents"', add
label define occ2010_lbl 4930 `"Sales Engineers"', add
label define occ2010_lbl 4940 `"Telemarketers"', add
label define occ2010_lbl 4950 `"Door-to-Door Sales Workers, News and Street Vendors, and Related Workers"', add
label define occ2010_lbl 4965 `"Sales and Related Workers, All Other"', add
label define occ2010_lbl 5000 `"First-Line Supervisors of Office and Administrative Support Workers"', add
label define occ2010_lbl 5010 `"Switchboard Operators, Including Answering Service"', add
label define occ2010_lbl 5020 `"Telephone Operators"', add
label define occ2010_lbl 5030 `"Communications Equipment Operators, All Other"', add
label define occ2010_lbl 5100 `"Bill and Account Collectors"', add
label define occ2010_lbl 5110 `"Billing and Posting Clerks"', add
label define occ2010_lbl 5120 `"Bookkeeping, Accounting, and Auditing Clerks"', add
label define occ2010_lbl 5130 `"Gaming Cage Workers"', add
label define occ2010_lbl 5140 `"Payroll and Timekeeping Clerks"', add
label define occ2010_lbl 5150 `"Procurement Clerks"', add
label define occ2010_lbl 5160 `"Bank Tellers"', add
label define occ2010_lbl 5165 `"Financial Clerks, nec"', add
label define occ2010_lbl 5200 `"Brokerage Clerks"', add
label define occ2010_lbl 5220 `"Court, Municipal, and License Clerks"', add
label define occ2010_lbl 5230 `"Credit Authorizers, Checkers, and Clerks"', add
label define occ2010_lbl 5240 `"Customer Service Representatives"', add
label define occ2010_lbl 5250 `"Eligibility Interviewers, Government Programs"', add
label define occ2010_lbl 5260 `"File Clerks"', add
label define occ2010_lbl 5300 `"Hotel, Motel, and Resort Desk Clerks"', add
label define occ2010_lbl 5310 `"Interviewers, Except Eligibility and Loan"', add
label define occ2010_lbl 5320 `"Library Assistants, Clerical"', add
label define occ2010_lbl 5330 `"Loan Interviewers and Clerks"', add
label define occ2010_lbl 5340 `"New Account Clerks"', add
label define occ2010_lbl 5350 `"Correspondent clerks and order clerks"', add
label define occ2010_lbl 5360 `"Human Resources Assistants, Except Payroll and Timekeeping"', add
label define occ2010_lbl 5400 `"Receptionists and Information Clerks"', add
label define occ2010_lbl 5410 `"Reservation and Transportation Ticket Agents and Travel Clerks"', add
label define occ2010_lbl 5420 `"Information and Record Clerks, All Other"', add
label define occ2010_lbl 5500 `"Cargo and Freight Agents"', add
label define occ2010_lbl 5510 `"Couriers and Messengers"', add
label define occ2010_lbl 5520 `"Dispatchers"', add
label define occ2010_lbl 5530 `"Meter Readers, Utilities"', add
label define occ2010_lbl 5540 `"Postal Service Clerks"', add
label define occ2010_lbl 5550 `"Postal Service Mail Carriers"', add
label define occ2010_lbl 5560 `"Postal Service Mail Sorters, Processors, and Processing Machine Operators"', add
label define occ2010_lbl 5600 `"Production, Planning, and Expediting Clerks"', add
label define occ2010_lbl 5610 `"Shipping, Receiving, and Traffic Clerks"', add
label define occ2010_lbl 5620 `"Stock Clerks and Order Fillers"', add
label define occ2010_lbl 5630 `"Weighers, Measurers, Checkers, and Samplers, Recordkeeping"', add
label define occ2010_lbl 5700 `"Secretaries and Administrative Assistants"', add
label define occ2010_lbl 5800 `"Computer Operators"', add
label define occ2010_lbl 5810 `"Data Entry Keyers"', add
label define occ2010_lbl 5820 `"Word Processors and Typists"', add
label define occ2010_lbl 5840 `"Insurance Claims and Policy Processing Clerks"', add
label define occ2010_lbl 5850 `"Mail Clerks and Mail Machine Operators, Except Postal Service"', add
label define occ2010_lbl 5860 `"Office Clerks, General"', add
label define occ2010_lbl 5900 `"Office Machine Operators, Except Computer"', add
label define occ2010_lbl 5910 `"Proofreaders and Copy Markers"', add
label define occ2010_lbl 5920 `"Statistical Assistants"', add
label define occ2010_lbl 5940 `"Office and administrative support workers, nec"', add
label define occ2010_lbl 6005 `"First-Line Supervisors of Farming, Fishing, and Forestry Workers"', add
label define occ2010_lbl 6010 `"Agricultural Inspectors"', add
label define occ2010_lbl 6040 `"Graders and Sorters, Agricultural Products"', add
label define occ2010_lbl 6050 `"Agricultural workers, nec"', add
label define occ2010_lbl 6100 `"Fishing and hunting workers"', add
label define occ2010_lbl 6120 `"Forest and Conservation Workers"', add
label define occ2010_lbl 6130 `"Logging Workers"', add
label define occ2010_lbl 6200 `"First-Line Supervisors of Construction Trades and Extraction Workers"', add
label define occ2010_lbl 6210 `"Boilermakers"', add
label define occ2010_lbl 6220 `"Brickmasons, Blockmasons, and Stonemasons"', add
label define occ2010_lbl 6230 `"Carpenters"', add
label define occ2010_lbl 6240 `"Carpet, Floor, and Tile Installers and Finishers"', add
label define occ2010_lbl 6250 `"Cement Masons, Concrete Finishers, and Terrazzo Workers"', add
label define occ2010_lbl 6260 `"Construction Laborers"', add
label define occ2010_lbl 6300 `"Paving, Surfacing, and Tamping Equipment Operators"', add
label define occ2010_lbl 6320 `"Construction equipment operators except paving, surfacing, and tamping equipment operators"', add
label define occ2010_lbl 6330 `"Drywall Installers, Ceiling Tile Installers, and Tapers"', add
label define occ2010_lbl 6355 `"Electricians"', add
label define occ2010_lbl 6360 `"Glaziers"', add
label define occ2010_lbl 6400 `"Insulation Workers"', add
label define occ2010_lbl 6420 `"Painters, Construction and Maintenance"', add
label define occ2010_lbl 6430 `"Paperhangers"', add
label define occ2010_lbl 6440 `"Pipelayers, Plumbers, Pipefitters, and Steamfitters"', add
label define occ2010_lbl 6460 `"Plasterers and Stucco Masons"', add
label define occ2010_lbl 6500 `"Reinforcing Iron and Rebar Workers"', add
label define occ2010_lbl 6515 `"Roofers"', add
label define occ2010_lbl 6520 `"Sheet Metal Workers, metal-working"', add
label define occ2010_lbl 6530 `"Structural Iron and Steel Workers"', add
label define occ2010_lbl 6600 `"Helpers, Construction Trades"', add
label define occ2010_lbl 6660 `"Construction and Building Inspectors"', add
label define occ2010_lbl 6700 `"Elevator Installers and Repairers"', add
label define occ2010_lbl 6710 `"Fence Erectors"', add
label define occ2010_lbl 6720 `"Hazardous Materials Removal Workers"', add
label define occ2010_lbl 6730 `"Highway Maintenance Workers"', add
label define occ2010_lbl 6740 `"Rail-Track Laying and Maintenance Equipment Operators"', add
label define occ2010_lbl 6765 `"Construction workers, nec"', add
label define occ2010_lbl 6800 `"Derrick, rotary drill, and service unit operators, and roustabouts, oil, gas, and mining"', add
label define occ2010_lbl 6820 `"Earth Drillers, Except Oil and Gas"', add
label define occ2010_lbl 6830 `"Explosives Workers, Ordnance Handling Experts, and Blasters"', add
label define occ2010_lbl 6840 `"Mining Machine Operators"', add
label define occ2010_lbl 6940 `"Extraction workers, nec"', add
label define occ2010_lbl 7000 `"First-Line Supervisors of Mechanics, Installers, and Repairers"', add
label define occ2010_lbl 7010 `"Computer, Automated Teller, and Office Machine Repairers"', add
label define occ2010_lbl 7020 `"Radio and Telecommunications Equipment Installers and Repairers"', add
label define occ2010_lbl 7030 `"Avionics Technicians"', add
label define occ2010_lbl 7040 `"Electric Motor, Power Tool, and Related Repairers"', add
label define occ2010_lbl 7100 `"Electrical and electronics repairers, transportation equipment, and industrial and utility"', add
label define occ2010_lbl 7110 `"Electronic Equipment Installers and Repairers, Motor Vehicles"', add
label define occ2010_lbl 7120 `"Electronic Home Entertainment Equipment Installers and Repairers"', add
label define occ2010_lbl 7125 `"Electronic Repairs, nec"', add
label define occ2010_lbl 7130 `"Security and Fire Alarm Systems Installers"', add
label define occ2010_lbl 7140 `"Aircraft Mechanics and Service Technicians"', add
label define occ2010_lbl 7150 `"Automotive Body and Related Repairers"', add
label define occ2010_lbl 7160 `"Automotive Glass Installers and Repairers"', add
label define occ2010_lbl 7200 `"Automotive Service Technicians and Mechanics"', add
label define occ2010_lbl 7210 `"Bus and Truck Mechanics and Diesel Engine Specialists"', add
label define occ2010_lbl 7220 `"Heavy Vehicle and Mobile Equipment Service Technicians and Mechanics"', add
label define occ2010_lbl 7240 `"Small Engine Mechanics"', add
label define occ2010_lbl 7260 `"Vehicle and Mobile Equipment Mechanics, Installers, and Repairers, nec"', add
label define occ2010_lbl 7300 `"Control and Valve Installers and Repairers"', add
label define occ2010_lbl 7315 `"Heating, Air Conditioning, and Refrigeration Mechanics and Installers"', add
label define occ2010_lbl 7320 `"Home Appliance Repairers"', add
label define occ2010_lbl 7330 `"Industrial and Refractory Machinery Mechanics"', add
label define occ2010_lbl 7340 `"Maintenance and Repair Workers, General"', add
label define occ2010_lbl 7350 `"Maintenance Workers, Machinery"', add
label define occ2010_lbl 7360 `"Millwrights"', add
label define occ2010_lbl 7410 `"Electrical Power-Line Installers and Repairers"', add
label define occ2010_lbl 7420 `"Telecommunications Line Installers and Repairers"', add
label define occ2010_lbl 7430 `"Precision Instrument and Equipment Repairers"', add
label define occ2010_lbl 7510 `"Coin, Vending, and Amusement Machine Servicers and Repairers"', add
label define occ2010_lbl 7540 `"Locksmiths and Safe Repairers"', add
label define occ2010_lbl 7550 `"Manufactured Building and Mobile Home Installers"', add
label define occ2010_lbl 7560 `"Riggers"', add
label define occ2010_lbl 7610 `"Helpers--Installation, Maintenance, and Repair Workers"', add
label define occ2010_lbl 7630 `"Other Installation, Maintenance, and Repair Workers Including Wind Turbine Service Technicians, and Commercial Divers, and Signal and Track Switch Repairers"', add
label define occ2010_lbl 7700 `"First-Line Supervisors of Production and Operating Workers"', add
label define occ2010_lbl 7710 `"Aircraft Structure, Surfaces, Rigging, and Systems Assemblers"', add
label define occ2010_lbl 7720 `"Electrical, Electronics, and Electromechanical Assemblers"', add
label define occ2010_lbl 7730 `"Engine and Other Machine Assemblers"', add
label define occ2010_lbl 7740 `"Structural Metal Fabricators and Fitters"', add
label define occ2010_lbl 7750 `"Assemblers and Fabricators, nec"', add
label define occ2010_lbl 7800 `"Bakers"', add
label define occ2010_lbl 7810 `"Butchers and Other Meat, Poultry, and Fish Processing Workers"', add
label define occ2010_lbl 7830 `"Food and Tobacco Roasting, Baking, and Drying Machine Operators and Tenders"', add
label define occ2010_lbl 7840 `"Food Batchmakers"', add
label define occ2010_lbl 7850 `"Food Cooking Machine Operators and Tenders"', add
label define occ2010_lbl 7855 `"Food Processing, nec"', add
label define occ2010_lbl 7900 `"Computer Control Programmers and Operators"', add
label define occ2010_lbl 7920 `"Extruding and Drawing Machine Setters, Operators, and Tenders, Metal and Plastic"', add
label define occ2010_lbl 7930 `"Forging Machine Setters, Operators, and Tenders, Metal and Plastic"', add
label define occ2010_lbl 7940 `"Rolling Machine Setters, Operators, and Tenders, metal and Plastic"', add
label define occ2010_lbl 7950 `"Cutting, Punching, and Press Machine Setters, Operators, and Tenders, Metal and Plastic"', add
label define occ2010_lbl 7960 `"Drilling and Boring Machine Tool Setters, Operators, and Tenders, Metal and Plastic"', add
label define occ2010_lbl 8000 `"Grinding, Lapping, Polishing, and Buffing Machine Tool Setters, Operators, and Tenders, Metal and Plastic"', add
label define occ2010_lbl 8010 `"Lathe and Turning Machine Tool Setters, Operators, and Tenders, Metal and Plastic"', add
label define occ2010_lbl 8030 `"Machinists"', add
label define occ2010_lbl 8040 `"Metal Furnace Operators, Tenders, Pourers, and Casters"', add
label define occ2010_lbl 8060 `"Model Makers and Patternmakers, Metal and Plastic"', add
label define occ2010_lbl 8100 `"Molders and Molding Machine Setters, Operators, and Tenders, Metal and Plastic"', add
label define occ2010_lbl 8130 `"Tool and Die Makers"', add
label define occ2010_lbl 8140 `"Welding, Soldering, and Brazing Workers"', add
label define occ2010_lbl 8150 `"Heat Treating Equipment Setters, Operators, and Tenders, Metal and Plastic"', add
label define occ2010_lbl 8200 `"Plating and Coating Machine Setters, Operators, and Tenders, Metal and Plastic"', add
label define occ2010_lbl 8210 `"Tool Grinders, Filers, and Sharpeners"', add
label define occ2010_lbl 8220 `"Metal workers and plastic workers, nec"', add
label define occ2010_lbl 8230 `"Bookbinders, Printing Machine Operators, and Job Printers"', add
label define occ2010_lbl 8250 `"Prepress Technicians and Workers"', add
label define occ2010_lbl 8300 `"Laundry and Dry-Cleaning Workers"', add
label define occ2010_lbl 8310 `"Pressers, Textile, Garment, and Related Materials"', add
label define occ2010_lbl 8320 `"Sewing Machine Operators"', add
label define occ2010_lbl 8330 `"Shoe and Leather Workers and Repairers"', add
label define occ2010_lbl 8340 `"Shoe Machine Operators and Tenders"', add
label define occ2010_lbl 8350 `"Tailors, Dressmakers, and Sewers"', add
label define occ2010_lbl 8400 `"Textile bleaching and dyeing, and cutting machine setters, operators, and tenders"', add
label define occ2010_lbl 8410 `"Textile Knitting and Weaving Machine Setters, Operators, and Tenders"', add
label define occ2010_lbl 8420 `"Textile Winding, Twisting, and Drawing Out Machine Setters, Operators, and Tenders"', add
label define occ2010_lbl 8450 `"Upholsterers"', add
label define occ2010_lbl 8460 `"Textile, Apparel, and Furnishings workers, nec"', add
label define occ2010_lbl 8500 `"Cabinetmakers and Bench Carpenters"', add
label define occ2010_lbl 8510 `"Furniture Finishers"', add
label define occ2010_lbl 8530 `"Sawing Machine Setters, Operators, and Tenders, Wood"', add
label define occ2010_lbl 8540 `"Woodworking Machine Setters, Operators, and Tenders, Except Sawing"', add
label define occ2010_lbl 8550 `"Woodworkers including model makers and patternmakers, nec"', add
label define occ2010_lbl 8600 `"Power Plant Operators, Distributors, and Dispatchers"', add
label define occ2010_lbl 8610 `"Stationary Engineers and Boiler Operators"', add
label define occ2010_lbl 8620 `"Water Wastewater Treatment Plant and System Operators"', add
label define occ2010_lbl 8630 `"Plant and System Operators, nec"', add
label define occ2010_lbl 8640 `"Chemical Processing Machine Setters, Operators, and Tenders"', add
label define occ2010_lbl 8650 `"Crushing, Grinding, Polishing, Mixing, and Blending Workers"', add
label define occ2010_lbl 8710 `"Cutting Workers"', add
label define occ2010_lbl 8720 `"Extruding, Forming, Pressing, and Compacting Machine Setters, Operators, and Tenders"', add
label define occ2010_lbl 8730 `"Furnace, Kiln, Oven, Drier, and Kettle Operators and Tenders"', add
label define occ2010_lbl 8740 `"Inspectors, Testers, Sorters, Samplers, and Weighers"', add
label define occ2010_lbl 8750 `"Jewelers and Precious Stone and Metal Workers"', add
label define occ2010_lbl 8760 `"Medical, Dental, and Ophthalmic Laboratory Technicians"', add
label define occ2010_lbl 8800 `"Packaging and Filling Machine Operators and Tenders"', add
label define occ2010_lbl 8810 `"Painting Workers and Dyers"', add
label define occ2010_lbl 8830 `"Photographic Process Workers and Processing Machine Operators"', add
label define occ2010_lbl 8850 `"Adhesive Bonding Machine Operators and Tenders"', add
label define occ2010_lbl 8860 `"Cleaning, Washing, and Metal Pickling Equipment Operators and Tenders"', add
label define occ2010_lbl 8910 `"Etchers, Engravers, and Lithographers"', add
label define occ2010_lbl 8920 `"Molders, Shapers, and Casters, Except Metal and Plastic"', add
label define occ2010_lbl 8930 `"Paper Goods Machine Setters, Operators, and Tenders"', add
label define occ2010_lbl 8940 `"Tire Builders"', add
label define occ2010_lbl 8950 `"Helpers--Production Workers"', add
label define occ2010_lbl 8965 `"Other production workers including semiconductor processors and cooling and freezing equipment operators"', add
label define occ2010_lbl 9000 `"Supervisors of Transportation and Material Moving Workers"', add
label define occ2010_lbl 9030 `"Aircraft Pilots and Flight Engineers"', add
label define occ2010_lbl 9040 `"Air Traffic Controllers and Airfield Operations Specialists"', add
label define occ2010_lbl 9050 `"Flight Attendants and Transportation Workers and Attendants"', add
label define occ2010_lbl 9100 `"Bus and Ambulance Drivers and Attendants"', add
label define occ2010_lbl 9130 `"Driver/Sales Workers and Truck Drivers"', add
label define occ2010_lbl 9140 `"Taxi Drivers and Chauffeurs"', add
label define occ2010_lbl 9150 `"Motor Vehicle Operators, All Other"', add
label define occ2010_lbl 9200 `"Locomotive Engineers and Operators"', add
label define occ2010_lbl 9230 `"Railroad Brake, Signal, and Switch Operators"', add
label define occ2010_lbl 9240 `"Railroad Conductors and Yardmasters"', add
label define occ2010_lbl 9260 `"Subway, Streetcar, and Other Rail Transportation Workers"', add
label define occ2010_lbl 9300 `"Sailors and marine oilers, and ship engineers"', add
label define occ2010_lbl 9310 `"Ship and Boat Captains and Operators"', add
label define occ2010_lbl 9350 `"Parking Lot Attendants"', add
label define occ2010_lbl 9360 `"Automotive and Watercraft Service Attendants"', add
label define occ2010_lbl 9410 `"Transportation Inspectors"', add
label define occ2010_lbl 9420 `"Transportation workers, nec"', add
label define occ2010_lbl 9510 `"Crane and Tower Operators"', add
label define occ2010_lbl 9520 `"Dredge, Excavating, and Loading Machine Operators"', add
label define occ2010_lbl 9560 `"Conveyor operators and tenders, and hoist and winch operators"', add
label define occ2010_lbl 9600 `"Industrial Truck and Tractor Operators"', add
label define occ2010_lbl 9610 `"Cleaners of Vehicles and Equipment"', add
label define occ2010_lbl 9620 `"Laborers and Freight, Stock, and Material Movers, Hand"', add
label define occ2010_lbl 9630 `"Machine Feeders and Offbearers"', add
label define occ2010_lbl 9640 `"Packers and Packagers, Hand"', add
label define occ2010_lbl 9650 `"Pumping Station Operators"', add
label define occ2010_lbl 9720 `"Refuse and Recyclable Material Collectors"', add
label define occ2010_lbl 9750 `"Material moving workers, nec"', add
label define occ2010_lbl 9800 `"Military Officer Special and Tactical Operations Leaders"', add
label define occ2010_lbl 9810 `"First-Line Enlisted Military Supervisors"', add
label define occ2010_lbl 9820 `"Military Enlisted Tactical Operations and Air/Weapons Specialists and Crew Members"', add
label define occ2010_lbl 9830 `"Military, Rank Not Specified"', add
label define occ2010_lbl 9920 `"Unemployed, with No Work Experience in the Last 5 Years or Earlier or Never Worked"', add
label values occ2010 occ2010_lbl

label define ind1950_lbl 000 `"N/A or none reported"'
label define ind1950_lbl 105 `"Agriculture"', add
label define ind1950_lbl 116 `"Forestry"', add
label define ind1950_lbl 126 `"Fisheries"', add
label define ind1950_lbl 206 `"Metal mining"', add
label define ind1950_lbl 216 `"Coal mining"', add
label define ind1950_lbl 226 `"Crude petroleum and natural gas extraction"', add
label define ind1950_lbl 236 `"Nonmettalic  mining and quarrying, except fuel"', add
label define ind1950_lbl 239 `"Mining, not specified"', add
label define ind1950_lbl 246 `"Construction"', add
label define ind1950_lbl 306 `"Logging"', add
label define ind1950_lbl 307 `"Sawmills, planing mills, and mill work"', add
label define ind1950_lbl 308 `"Misc wood products"', add
label define ind1950_lbl 309 `"Furniture and fixtures"', add
label define ind1950_lbl 316 `"Glass and glass products"', add
label define ind1950_lbl 317 `"Cement, concrete, gypsum and plaster products"', add
label define ind1950_lbl 318 `"Structural clay products"', add
label define ind1950_lbl 319 `"Pottery and related prods"', add
label define ind1950_lbl 326 `"Misc nonmetallic mineral and stone products"', add
label define ind1950_lbl 336 `"Blast furnaces, steel works, and rolling mills"', add
label define ind1950_lbl 337 `"Other primary iron and steel industries"', add
label define ind1950_lbl 338 `"Primary nonferrous industries"', add
label define ind1950_lbl 346 `"Fabricated steel products"', add
label define ind1950_lbl 347 `"Fabricated nonferrous metal products"', add
label define ind1950_lbl 348 `"Not specified metal industries"', add
label define ind1950_lbl 356 `"Agricultural machinery and tractors"', add
label define ind1950_lbl 357 `"Office and store machines"', add
label define ind1950_lbl 358 `"Misc machinery"', add
label define ind1950_lbl 367 `"Electrical machinery, equipment and supplies"', add
label define ind1950_lbl 376 `"Motor vehicles and motor vehicle equipment"', add
label define ind1950_lbl 377 `"Aircraft and parts"', add
label define ind1950_lbl 378 `"Ship and boat building and repairing"', add
label define ind1950_lbl 379 `"Railroad and misc transportation equipment"', add
label define ind1950_lbl 386 `"Professional equipment"', add
label define ind1950_lbl 387 `"Photographic equipment and supplies"', add
label define ind1950_lbl 388 `"Watches, clocks, and clockwork-operated devices"', add
label define ind1950_lbl 399 `"Misc manufacturing industries"', add
label define ind1950_lbl 406 `"Meat products"', add
label define ind1950_lbl 407 `"Dairy products"', add
label define ind1950_lbl 408 `"Canning and preserving fruits, vegetables, and seafoods"', add
label define ind1950_lbl 409 `"Grain-mill products"', add
label define ind1950_lbl 416 `"Bakery products"', add
label define ind1950_lbl 417 `"Confectionery and related products"', add
label define ind1950_lbl 418 `"Beverage industries"', add
label define ind1950_lbl 419 `"Misc food preparations and kindred products"', add
label define ind1950_lbl 426 `"Not specified food industries"', add
label define ind1950_lbl 429 `"Tobacco manufactures"', add
label define ind1950_lbl 436 `"Knitting mills"', add
label define ind1950_lbl 437 `"Dyeing and finishing textiles, except knit goods"', add
label define ind1950_lbl 438 `"Carpets, rugs, and other floor coverings"', add
label define ind1950_lbl 439 `"Yarn, thread, and fabric"', add
label define ind1950_lbl 446 `"Misc textile mill products"', add
label define ind1950_lbl 448 `"Apparel and accessories"', add
label define ind1950_lbl 449 `"Misc fabricated textile products"', add
label define ind1950_lbl 456 `"Pulp, paper, and paper-board mills"', add
label define ind1950_lbl 457 `"Paperboard containers and boxes"', add
label define ind1950_lbl 458 `"Misc paper and pulp products"', add
label define ind1950_lbl 459 `"Printing, publishing, and allied industries"', add
label define ind1950_lbl 466 `"Synthetic fibers"', add
label define ind1950_lbl 467 `"Drugs and medicines"', add
label define ind1950_lbl 468 `"Paints, varnishes, and related products"', add
label define ind1950_lbl 469 `"Misc chemicals and allied products"', add
label define ind1950_lbl 476 `"Petroleum refining"', add
label define ind1950_lbl 477 `"Misc petroleum and coal products"', add
label define ind1950_lbl 478 `"Rubber products"', add
label define ind1950_lbl 487 `"Leather: tanned, curried, and finished"', add
label define ind1950_lbl 488 `"Footwear, except rubber"', add
label define ind1950_lbl 489 `"Leather products, except footwear"', add
label define ind1950_lbl 499 `"Not specified manufacturing industries"', add
label define ind1950_lbl 506 `"Railroads and railway"', add
label define ind1950_lbl 516 `"Street railways and bus lines"', add
label define ind1950_lbl 526 `"Trucking service"', add
label define ind1950_lbl 527 `"Warehousing and storage"', add
label define ind1950_lbl 536 `"Taxicab service"', add
label define ind1950_lbl 546 `"Water transportation"', add
label define ind1950_lbl 556 `"Air transportation"', add
label define ind1950_lbl 567 `"Petroleum and gasoline pipe lines"', add
label define ind1950_lbl 568 `"Services incidental to transportation"', add
label define ind1950_lbl 578 `"Telephone"', add
label define ind1950_lbl 579 `"Telegraph"', add
label define ind1950_lbl 586 `"Electric light and power"', add
label define ind1950_lbl 587 `"Gas and steam supply systems"', add
label define ind1950_lbl 588 `"Electric-gas utilities"', add
label define ind1950_lbl 596 `"Water supply"', add
label define ind1950_lbl 597 `"Sanitary services"', add
label define ind1950_lbl 598 `"Other and not specified utilities"', add
label define ind1950_lbl 606 `"Motor vehicles and equipment"', add
label define ind1950_lbl 607 `"Drugs, chemicals, and allied products"', add
label define ind1950_lbl 608 `"Dry goods apparel"', add
label define ind1950_lbl 609 `"Food and related products"', add
label define ind1950_lbl 616 `"Electrical goods, hardware, and plumbing equipment"', add
label define ind1950_lbl 617 `"Machinery, equipment, and supplies"', add
label define ind1950_lbl 618 `"Petroleum products"', add
label define ind1950_lbl 619 `"Farm prods--raw materials"', add
label define ind1950_lbl 626 `"Misc wholesale trade"', add
label define ind1950_lbl 627 `"Not specified wholesale trade"', add
label define ind1950_lbl 636 `"Food stores, except dairy"', add
label define ind1950_lbl 637 `"Dairy prods stores and milk retailing"', add
label define ind1950_lbl 646 `"General merchandise"', add
label define ind1950_lbl 647 `"Five and ten cent stores"', add
label define ind1950_lbl 656 `"Apparel and accessories stores, except shoe"', add
label define ind1950_lbl 657 `"Shoe stores"', add
label define ind1950_lbl 658 `"Furniture and house furnishings stores"', add
label define ind1950_lbl 659 `"Household appliance and radio stores"', add
label define ind1950_lbl 667 `"Motor vehicles and accessories retailing"', add
label define ind1950_lbl 668 `"Gasoline service stations"', add
label define ind1950_lbl 669 `"Drug stores"', add
label define ind1950_lbl 679 `"Eating and drinking  places"', add
label define ind1950_lbl 686 `"Hardware and farm implement stores"', add
label define ind1950_lbl 687 `"Lumber and building material retailing"', add
label define ind1950_lbl 688 `"Liquor stores"', add
label define ind1950_lbl 689 `"Retail florists"', add
label define ind1950_lbl 696 `"Jewelry stores"', add
label define ind1950_lbl 697 `"Fuel and ice retailing"', add
label define ind1950_lbl 698 `"Misc retail stores"', add
label define ind1950_lbl 699 `"Not specified retail trade"', add
label define ind1950_lbl 716 `"Banking and credit"', add
label define ind1950_lbl 726 `"Security and commodity brokerage and invest companies"', add
label define ind1950_lbl 736 `"Insurance"', add
label define ind1950_lbl 746 `"Real estate"', add
label define ind1950_lbl 756 `"Real estate-insurance-law  offices"', add
label define ind1950_lbl 806 `"Advertising"', add
label define ind1950_lbl 807 `"Accounting, auditing, and bookkeeping services"', add
label define ind1950_lbl 808 `"Misc business services"', add
label define ind1950_lbl 816 `"Auto repair services and garages"', add
label define ind1950_lbl 817 `"Misc repair services"', add
label define ind1950_lbl 826 `"Private households"', add
label define ind1950_lbl 836 `"Hotels and lodging places"', add
label define ind1950_lbl 846 `"Laundering, cleaning, and dyeing"', add
label define ind1950_lbl 847 `"Dressmaking shops"', add
label define ind1950_lbl 848 `"Shoe repair shops"', add
label define ind1950_lbl 849 `"Misc personal services"', add
label define ind1950_lbl 856 `"Radio broadcasting and television"', add
label define ind1950_lbl 857 `"Theaters and motion pictures"', add
label define ind1950_lbl 858 `"Bowling alleys, and billiard and pool parlors"', add
label define ind1950_lbl 859 `"Misc entertainment and recreation services"', add
label define ind1950_lbl 868 `"Medical and other health services, except hospitals"', add
label define ind1950_lbl 869 `"Hospitals"', add
label define ind1950_lbl 879 `"Legal services"', add
label define ind1950_lbl 888 `"Educational services"', add
label define ind1950_lbl 896 `"Welfare and religious services"', add
label define ind1950_lbl 897 `"Nonprofit membership organizs."', add
label define ind1950_lbl 898 `"Engineering and architectural services"', add
label define ind1950_lbl 899 `"Misc professional and related"', add
label define ind1950_lbl 906 `"Postal service"', add
label define ind1950_lbl 916 `"Federal public administration"', add
label define ind1950_lbl 926 `"State public administration"', add
label define ind1950_lbl 936 `"Local public administration"', add
label define ind1950_lbl 946 `"Public Administration, level not specified"', add
label define ind1950_lbl 976 `"Common or general laborer"', add
label define ind1950_lbl 979 `"Not yet specified"', add
label define ind1950_lbl 980 `"Unpaid domestic work"', add
label define ind1950_lbl 982 `"Housework at home"', add
label define ind1950_lbl 983 `"School response (students, etc.)"', add
label define ind1950_lbl 984 `"Retired"', add
label define ind1950_lbl 986 `"Sick/disabled"', add
label define ind1950_lbl 987 `"Institution response"', add
label define ind1950_lbl 991 `"Lady/Man of leisure"', add
label define ind1950_lbl 995 `"Non-industrial response"', add
label define ind1950_lbl 997 `"Nonclassifiable"', add
label define ind1950_lbl 998 `"Industry not reported"', add
label define ind1950_lbl 999 `"Blank or blank equivalent"', add
label values ind1950 ind1950_lbl

label define ind1990_lbl 000 `"N/A (not applicable)"'
label define ind1990_lbl 010 `"Agricultural production, crops"', add
label define ind1990_lbl 011 `"Agricultural production, livestock"', add
label define ind1990_lbl 012 `"Veterinary services"', add
label define ind1990_lbl 020 `"Landscape and horticultural services"', add
label define ind1990_lbl 030 `"Agricultural services, n.e.c."', add
label define ind1990_lbl 031 `"Forestry"', add
label define ind1990_lbl 032 `"Fishing, hunting, and trapping"', add
label define ind1990_lbl 040 `"Metal mining"', add
label define ind1990_lbl 041 `"Coal mining"', add
label define ind1990_lbl 042 `"Oil and gas extraction"', add
label define ind1990_lbl 050 `"Nonmetallic mining and quarrying, except fuels"', add
label define ind1990_lbl 060 `"All construction"', add
label define ind1990_lbl 100 `"Meat products"', add
label define ind1990_lbl 101 `"Dairy products"', add
label define ind1990_lbl 102 `"Canned, frozen, and preserved fruits and vegetables"', add
label define ind1990_lbl 110 `"Grain mill products"', add
label define ind1990_lbl 111 `"Bakery products"', add
label define ind1990_lbl 112 `"Sugar and confectionery products"', add
label define ind1990_lbl 120 `"Beverage industries"', add
label define ind1990_lbl 121 `"Misc. food preparations and kindred products"', add
label define ind1990_lbl 122 `"Food industries, n.s."', add
label define ind1990_lbl 130 `"Tobacco manufactures"', add
label define ind1990_lbl 132 `"Knitting mills"', add
label define ind1990_lbl 140 `"Dyeing and finishing textiles, except wool and knit goods"', add
label define ind1990_lbl 141 `"Carpets and rugs"', add
label define ind1990_lbl 142 `"Yarn, thread, and fabric mills"', add
label define ind1990_lbl 150 `"Miscellaneous textile mill products"', add
label define ind1990_lbl 151 `"Apparel and accessories, except knit"', add
label define ind1990_lbl 152 `"Miscellaneous fabricated textile products"', add
label define ind1990_lbl 160 `"Pulp, paper, and paperboard mills"', add
label define ind1990_lbl 161 `"Miscellaneous paper and pulp products"', add
label define ind1990_lbl 162 `"Paperboard containers and boxes"', add
label define ind1990_lbl 171 `"Newspaper publishing and printing"', add
label define ind1990_lbl 172 `"Printing, publishing, and allied industries, except newspapers"', add
label define ind1990_lbl 180 `"Plastics, synthetics, and resins"', add
label define ind1990_lbl 181 `"Drugs"', add
label define ind1990_lbl 182 `"Soaps and cosmetics"', add
label define ind1990_lbl 190 `"Paints, varnishes, and related products"', add
label define ind1990_lbl 191 `"Agricultural chemicals"', add
label define ind1990_lbl 192 `"Industrial and miscellaneous chemicals"', add
label define ind1990_lbl 200 `"Petroleum refining"', add
label define ind1990_lbl 201 `"Miscellaneous petroleum and coal products"', add
label define ind1990_lbl 210 `"Tires and inner tubes"', add
label define ind1990_lbl 211 `"Other rubber products, and plastics footwear and belting"', add
label define ind1990_lbl 212 `"Miscellaneous plastics products"', add
label define ind1990_lbl 220 `"Leather tanning and finishing"', add
label define ind1990_lbl 221 `"Footwear, except rubber and plastic"', add
label define ind1990_lbl 222 `"Leather products, except footwear"', add
label define ind1990_lbl 230 `"Logging"', add
label define ind1990_lbl 231 `"Sawmills, planing mills, and millwork"', add
label define ind1990_lbl 232 `"Wood buildings and mobile homes"', add
label define ind1990_lbl 241 `"Miscellaneous wood products"', add
label define ind1990_lbl 242 `"Furniture and fixtures"', add
label define ind1990_lbl 250 `"Glass and glass products"', add
label define ind1990_lbl 251 `"Cement, concrete, gypsum, and plaster products"', add
label define ind1990_lbl 252 `"Structural clay products"', add
label define ind1990_lbl 261 `"Pottery and related products"', add
label define ind1990_lbl 262 `"Misc. nonmetallic mineral and stone products"', add
label define ind1990_lbl 270 `"Blast furnaces, steelworks, rolling and finishing mills"', add
label define ind1990_lbl 271 `"Iron and steel foundries"', add
label define ind1990_lbl 272 `"Primary aluminum industries"', add
label define ind1990_lbl 280 `"Other primary metal industries"', add
label define ind1990_lbl 281 `"Cutlery, handtools, and general hardware"', add
label define ind1990_lbl 282 `"Fabricated structural metal products"', add
label define ind1990_lbl 290 `"Screw machine products"', add
label define ind1990_lbl 291 `"Metal forgings and stampings"', add
label define ind1990_lbl 292 `"Ordnance"', add
label define ind1990_lbl 300 `"Miscellaneous fabricated metal products"', add
label define ind1990_lbl 301 `"Metal industries, n.s."', add
label define ind1990_lbl 310 `"Engines and turbines"', add
label define ind1990_lbl 311 `"Farm machinery and equipment"', add
label define ind1990_lbl 312 `"Construction and material handling machines"', add
label define ind1990_lbl 320 `"Metalworking machinery"', add
label define ind1990_lbl 321 `"Office and accounting machines"', add
label define ind1990_lbl 322 `"Computers and related equipment"', add
label define ind1990_lbl 331 `"Machinery, except electrical, n.e.c."', add
label define ind1990_lbl 332 `"Machinery, n.s."', add
label define ind1990_lbl 340 `"Household appliances"', add
label define ind1990_lbl 341 `"Radio, TV, and communication equipment"', add
label define ind1990_lbl 342 `"Electrical machinery, equipment, and supplies, n.e.c."', add
label define ind1990_lbl 350 `"Electrical machinery, equipment, and supplies, n.s."', add
label define ind1990_lbl 351 `"Motor vehicles and motor vehicle equipment"', add
label define ind1990_lbl 352 `"Aircraft and parts"', add
label define ind1990_lbl 360 `"Ship and boat building and repairing"', add
label define ind1990_lbl 361 `"Railroad locomotives and equipment"', add
label define ind1990_lbl 362 `"Guided missiles, space vehicles, and parts"', add
label define ind1990_lbl 370 `"Cycles and miscellaneous transportation equipment"', add
label define ind1990_lbl 371 `"Scientific and controlling instruments"', add
label define ind1990_lbl 372 `"Medical, dental, and optical instruments and supplies"', add
label define ind1990_lbl 380 `"Photographic equipment and supplies"', add
label define ind1990_lbl 381 `"Watches, clocks, and clockwork operated devices"', add
label define ind1990_lbl 390 `"Toys, amusement, and sporting goods"', add
label define ind1990_lbl 391 `"Miscellaneous manufacturing industries"', add
label define ind1990_lbl 392 `"Manufacturing industries, n.s."', add
label define ind1990_lbl 400 `"Railroads"', add
label define ind1990_lbl 401 `"Bus service and urban transit"', add
label define ind1990_lbl 402 `"Taxicab service"', add
label define ind1990_lbl 410 `"Trucking service"', add
label define ind1990_lbl 411 `"Warehousing and storage"', add
label define ind1990_lbl 412 `"U.S. Postal Service"', add
label define ind1990_lbl 420 `"Water transportation"', add
label define ind1990_lbl 421 `"Air transportation"', add
label define ind1990_lbl 422 `"Pipe lines, except natural gas"', add
label define ind1990_lbl 432 `"Services incidental to transportation"', add
label define ind1990_lbl 440 `"Radio and television broadcasting and cable"', add
label define ind1990_lbl 441 `"Telephone communications"', add
label define ind1990_lbl 442 `"Telegraph and miscellaneous communications services"', add
label define ind1990_lbl 450 `"Electric light and power"', add
label define ind1990_lbl 451 `"Gas and steam supply systems"', add
label define ind1990_lbl 452 `"Electric and gas, and other combinations"', add
label define ind1990_lbl 470 `"Water supply and irrigation"', add
label define ind1990_lbl 471 `"Sanitary services"', add
label define ind1990_lbl 472 `"Utilities, n.s."', add
label define ind1990_lbl 500 `"Motor vehicles and equipment"', add
label define ind1990_lbl 501 `"Furniture and home furnishings"', add
label define ind1990_lbl 502 `"Lumber and construction materials"', add
label define ind1990_lbl 510 `"Professional and commercial equipment and supplies"', add
label define ind1990_lbl 511 `"Metals and minerals, except petroleum"', add
label define ind1990_lbl 512 `"Electrical goods"', add
label define ind1990_lbl 521 `"Hardware, plumbing and heating supplies"', add
label define ind1990_lbl 530 `"Machinery, equipment, and supplies"', add
label define ind1990_lbl 531 `"Scrap and waste materials"', add
label define ind1990_lbl 532 `"Miscellaneous wholesale, durable goods"', add
label define ind1990_lbl 540 `"Paper and paper products"', add
label define ind1990_lbl 541 `"Drugs, chemicals, and allied products"', add
label define ind1990_lbl 542 `"Apparel, fabrics, and notions"', add
label define ind1990_lbl 550 `"Groceries and related products"', add
label define ind1990_lbl 551 `"Farm-product raw materials"', add
label define ind1990_lbl 552 `"Petroleum products"', add
label define ind1990_lbl 560 `"Alcoholic beverages"', add
label define ind1990_lbl 561 `"Farm supplies"', add
label define ind1990_lbl 562 `"Miscellaneous wholesale, nondurable goods"', add
label define ind1990_lbl 571 `"Wholesale trade, n.s."', add
label define ind1990_lbl 580 `"Lumber and building material retailing"', add
label define ind1990_lbl 581 `"Hardware stores"', add
label define ind1990_lbl 582 `"Retail nurseries and garden stores"', add
label define ind1990_lbl 590 `"Mobile home dealers"', add
label define ind1990_lbl 591 `"Department stores"', add
label define ind1990_lbl 592 `"Variety stores"', add
label define ind1990_lbl 600 `"Miscellaneous general merchandise stores"', add
label define ind1990_lbl 601 `"Grocery stores"', add
label define ind1990_lbl 602 `"Dairy products stores"', add
label define ind1990_lbl 610 `"Retail bakeries"', add
label define ind1990_lbl 611 `"Food stores, n.e.c."', add
label define ind1990_lbl 612 `"Motor vehicle dealers"', add
label define ind1990_lbl 620 `"Auto and home supply stores"', add
label define ind1990_lbl 621 `"Gasoline service stations"', add
label define ind1990_lbl 622 `"Miscellaneous vehicle dealers"', add
label define ind1990_lbl 623 `"Apparel and accessory stores, except shoe"', add
label define ind1990_lbl 630 `"Shoe stores"', add
label define ind1990_lbl 631 `"Furniture and home furnishings stores"', add
label define ind1990_lbl 632 `"Household appliance stores"', add
label define ind1990_lbl 633 `"Radio, TV, and computer stores"', add
label define ind1990_lbl 640 `"Music stores"', add
label define ind1990_lbl 641 `"Eating and drinking places"', add
label define ind1990_lbl 642 `"Drug stores"', add
label define ind1990_lbl 650 `"Liquor stores"', add
label define ind1990_lbl 651 `"Sporting goods, bicycles, and hobby stores"', add
label define ind1990_lbl 652 `"Book and stationery stores"', add
label define ind1990_lbl 660 `"Jewelry stores"', add
label define ind1990_lbl 661 `"Gift, novelty, and souvenir shops"', add
label define ind1990_lbl 662 `"Sewing, needlework, and piece goods stores"', add
label define ind1990_lbl 663 `"Catalog and mail order houses"', add
label define ind1990_lbl 670 `"Vending machine operators"', add
label define ind1990_lbl 671 `"Direct selling establishments"', add
label define ind1990_lbl 672 `"Fuel dealers"', add
label define ind1990_lbl 681 `"Retail florists"', add
label define ind1990_lbl 682 `"Miscellaneous retail stores"', add
label define ind1990_lbl 691 `"Retail trade, n.s."', add
label define ind1990_lbl 700 `"Banking"', add
label define ind1990_lbl 701 `"Savings institutions, including credit unions"', add
label define ind1990_lbl 702 `"Credit agencies, n.e.c."', add
label define ind1990_lbl 710 `"Security, commodity brokerage, and investment companies"', add
label define ind1990_lbl 711 `"Insurance"', add
label define ind1990_lbl 712 `"Real estate, including real estate-insurance offices"', add
label define ind1990_lbl 721 `"Advertising"', add
label define ind1990_lbl 722 `"Services to dwellings and other buildings"', add
label define ind1990_lbl 731 `"Personnel supply services"', add
label define ind1990_lbl 732 `"Computer and data processing services"', add
label define ind1990_lbl 740 `"Detective and protective services"', add
label define ind1990_lbl 741 `"Business services, n.e.c."', add
label define ind1990_lbl 742 `"Automotive rental and leasing, without drivers"', add
label define ind1990_lbl 750 `"Automobile parking and carwashes"', add
label define ind1990_lbl 751 `"Automotive repair and related services"', add
label define ind1990_lbl 752 `"Electrical repair shops"', add
label define ind1990_lbl 760 `"Miscellaneous repair services"', add
label define ind1990_lbl 761 `"Private households"', add
label define ind1990_lbl 762 `"Hotels and motels"', add
label define ind1990_lbl 770 `"Lodging places, except hotels and motels"', add
label define ind1990_lbl 771 `"Laundry, cleaning, and garment services"', add
label define ind1990_lbl 772 `"Beauty shops"', add
label define ind1990_lbl 780 `"Barber shops"', add
label define ind1990_lbl 781 `"Funeral service and crematories"', add
label define ind1990_lbl 782 `"Shoe repair shops"', add
label define ind1990_lbl 790 `"Dressmaking shops"', add
label define ind1990_lbl 791 `"Miscellaneous personal services"', add
label define ind1990_lbl 800 `"Theaters and motion pictures"', add
label define ind1990_lbl 801 `"Video tape rental"', add
label define ind1990_lbl 802 `"Bowling centers"', add
label define ind1990_lbl 810 `"Miscellaneous entertainment and recreation services"', add
label define ind1990_lbl 812 `"Offices and clinics of physicians"', add
label define ind1990_lbl 820 `"Offices and clinics of dentists"', add
label define ind1990_lbl 821 `"Offices and clinics of chiropractors"', add
label define ind1990_lbl 822 `"Offices and clinics of optometrists"', add
label define ind1990_lbl 830 `"Offices and clinics of health practitioners, n.e.c."', add
label define ind1990_lbl 831 `"Hospitals"', add
label define ind1990_lbl 832 `"Nursing and personal care facilities"', add
label define ind1990_lbl 840 `"Health services, n.e.c."', add
label define ind1990_lbl 841 `"Legal services"', add
label define ind1990_lbl 842 `"Elementary and secondary schools"', add
label define ind1990_lbl 850 `"Colleges and universities"', add
label define ind1990_lbl 851 `"Vocational schools"', add
label define ind1990_lbl 852 `"Libraries"', add
label define ind1990_lbl 860 `"Educational services, n.e.c."', add
label define ind1990_lbl 861 `"Job training and vocational rehabilitation services"', add
label define ind1990_lbl 862 `"Child day care services"', add
label define ind1990_lbl 863 `"Family child care homes"', add
label define ind1990_lbl 870 `"Residential care facilities, without nursing"', add
label define ind1990_lbl 871 `"Social services, n.e.c."', add
label define ind1990_lbl 872 `"Museums, art galleries, and zoos"', add
label define ind1990_lbl 873 `"Labor unions"', add
label define ind1990_lbl 880 `"Religious organizations"', add
label define ind1990_lbl 881 `"Membership organizations, n.e.c."', add
label define ind1990_lbl 882 `"Engineering, architectural, and surveying services"', add
label define ind1990_lbl 890 `"Accounting, auditing, and bookkeeping services"', add
label define ind1990_lbl 891 `"Research, development, and testing services"', add
label define ind1990_lbl 892 `"Management and public relations services"', add
label define ind1990_lbl 893 `"Miscellaneous professional and related services"', add
label define ind1990_lbl 900 `"Executive and legislative offices"', add
label define ind1990_lbl 901 `"General government, n.e.c."', add
label define ind1990_lbl 910 `"Justice, public order, and safety"', add
label define ind1990_lbl 921 `"Public finance, taxation, and monetary policy"', add
label define ind1990_lbl 922 `"Administration of human resources programs"', add
label define ind1990_lbl 930 `"Administration of environmental quality and housing programs"', add
label define ind1990_lbl 931 `"Administration of economic programs"', add
label define ind1990_lbl 932 `"National security and international affairs"', add
label define ind1990_lbl 940 `"Army"', add
label define ind1990_lbl 941 `"Air Force"', add
label define ind1990_lbl 942 `"Navy"', add
label define ind1990_lbl 950 `"Marines"', add
label define ind1990_lbl 951 `"Coast Guard"', add
label define ind1990_lbl 952 `"Armed Forces, branch not specified"', add
label define ind1990_lbl 960 `"Military Reserves or National Guard"', add
label define ind1990_lbl 992 `"Last worked 1984 or earlier"', add
label define ind1990_lbl 999 `"DID NOT RESPOND"', add
label values ind1990 ind1990_lbl

label define classwkr_lbl 0 `"N/A"'
label define classwkr_lbl 1 `"Self-employed"', add
label define classwkr_lbl 2 `"Works for wages"', add
label values classwkr classwkr_lbl

label define classwkrd_lbl 00 `"N/A"'
label define classwkrd_lbl 10 `"Self-employed"', add
label define classwkrd_lbl 11 `"Employer"', add
label define classwkrd_lbl 12 `"Working on own account"', add
label define classwkrd_lbl 13 `"Self-employed, not incorporated"', add
label define classwkrd_lbl 14 `"Self-employed, incorporated"', add
label define classwkrd_lbl 20 `"Works for wages"', add
label define classwkrd_lbl 21 `"Works on salary (1920)"', add
label define classwkrd_lbl 22 `"Wage/salary, private"', add
label define classwkrd_lbl 23 `"Wage/salary at non-profit"', add
label define classwkrd_lbl 24 `"Wage/salary, government"', add
label define classwkrd_lbl 25 `"Federal govt employee"', add
label define classwkrd_lbl 26 `"Armed forces"', add
label define classwkrd_lbl 27 `"State govt employee"', add
label define classwkrd_lbl 28 `"Local govt employee"', add
label define classwkrd_lbl 29 `"Unpaid family worker"', add
label values classwkrd classwkrd_lbl

label define wkswork2_lbl 0 `"N/A"'
label define wkswork2_lbl 1 `"1-13 weeks"', add
label define wkswork2_lbl 2 `"14-26 weeks"', add
label define wkswork2_lbl 3 `"27-39 weeks"', add
label define wkswork2_lbl 4 `"40-47 weeks"', add
label define wkswork2_lbl 5 `"48-49 weeks"', add
label define wkswork2_lbl 6 `"50-52 weeks"', add
label values wkswork2 wkswork2_lbl

label define uhrswork_lbl 00 `"N/A"'
label define uhrswork_lbl 01 `"1"', add
label define uhrswork_lbl 02 `"2"', add
label define uhrswork_lbl 03 `"3"', add
label define uhrswork_lbl 04 `"4"', add
label define uhrswork_lbl 05 `"5"', add
label define uhrswork_lbl 06 `"6"', add
label define uhrswork_lbl 07 `"7"', add
label define uhrswork_lbl 08 `"8"', add
label define uhrswork_lbl 09 `"9"', add
label define uhrswork_lbl 10 `"10"', add
label define uhrswork_lbl 11 `"11"', add
label define uhrswork_lbl 12 `"12"', add
label define uhrswork_lbl 13 `"13"', add
label define uhrswork_lbl 14 `"14"', add
label define uhrswork_lbl 15 `"15"', add
label define uhrswork_lbl 16 `"16"', add
label define uhrswork_lbl 17 `"17"', add
label define uhrswork_lbl 18 `"18"', add
label define uhrswork_lbl 19 `"19"', add
label define uhrswork_lbl 20 `"20"', add
label define uhrswork_lbl 21 `"21"', add
label define uhrswork_lbl 22 `"22"', add
label define uhrswork_lbl 23 `"23"', add
label define uhrswork_lbl 24 `"24"', add
label define uhrswork_lbl 25 `"25"', add
label define uhrswork_lbl 26 `"26"', add
label define uhrswork_lbl 27 `"27"', add
label define uhrswork_lbl 28 `"28"', add
label define uhrswork_lbl 29 `"29"', add
label define uhrswork_lbl 30 `"30"', add
label define uhrswork_lbl 31 `"31"', add
label define uhrswork_lbl 32 `"32"', add
label define uhrswork_lbl 33 `"33"', add
label define uhrswork_lbl 34 `"34"', add
label define uhrswork_lbl 35 `"35"', add
label define uhrswork_lbl 36 `"36"', add
label define uhrswork_lbl 37 `"37"', add
label define uhrswork_lbl 38 `"38"', add
label define uhrswork_lbl 39 `"39"', add
label define uhrswork_lbl 40 `"40"', add
label define uhrswork_lbl 41 `"41"', add
label define uhrswork_lbl 42 `"42"', add
label define uhrswork_lbl 43 `"43"', add
label define uhrswork_lbl 44 `"44"', add
label define uhrswork_lbl 45 `"45"', add
label define uhrswork_lbl 46 `"46"', add
label define uhrswork_lbl 47 `"47"', add
label define uhrswork_lbl 48 `"48"', add
label define uhrswork_lbl 49 `"49"', add
label define uhrswork_lbl 50 `"50"', add
label define uhrswork_lbl 51 `"51"', add
label define uhrswork_lbl 52 `"52"', add
label define uhrswork_lbl 53 `"53"', add
label define uhrswork_lbl 54 `"54"', add
label define uhrswork_lbl 55 `"55"', add
label define uhrswork_lbl 56 `"56"', add
label define uhrswork_lbl 57 `"57"', add
label define uhrswork_lbl 58 `"58"', add
label define uhrswork_lbl 59 `"59"', add
label define uhrswork_lbl 60 `"60"', add
label define uhrswork_lbl 61 `"61"', add
label define uhrswork_lbl 62 `"62"', add
label define uhrswork_lbl 63 `"63"', add
label define uhrswork_lbl 64 `"64"', add
label define uhrswork_lbl 65 `"65"', add
label define uhrswork_lbl 66 `"66"', add
label define uhrswork_lbl 67 `"67"', add
label define uhrswork_lbl 68 `"68"', add
label define uhrswork_lbl 69 `"69"', add
label define uhrswork_lbl 70 `"70"', add
label define uhrswork_lbl 71 `"71"', add
label define uhrswork_lbl 72 `"72"', add
label define uhrswork_lbl 73 `"73"', add
label define uhrswork_lbl 74 `"74"', add
label define uhrswork_lbl 75 `"75"', add
label define uhrswork_lbl 76 `"76"', add
label define uhrswork_lbl 77 `"77"', add
label define uhrswork_lbl 78 `"78"', add
label define uhrswork_lbl 79 `"79"', add
label define uhrswork_lbl 80 `"80"', add
label define uhrswork_lbl 81 `"81"', add
label define uhrswork_lbl 82 `"82"', add
label define uhrswork_lbl 83 `"83"', add
label define uhrswork_lbl 84 `"84"', add
label define uhrswork_lbl 85 `"85"', add
label define uhrswork_lbl 86 `"86"', add
label define uhrswork_lbl 87 `"87"', add
label define uhrswork_lbl 88 `"88"', add
label define uhrswork_lbl 89 `"89"', add
label define uhrswork_lbl 90 `"90"', add
label define uhrswork_lbl 91 `"91"', add
label define uhrswork_lbl 92 `"92"', add
label define uhrswork_lbl 93 `"93"', add
label define uhrswork_lbl 94 `"94"', add
label define uhrswork_lbl 95 `"95"', add
label define uhrswork_lbl 96 `"96"', add
label define uhrswork_lbl 97 `"97"', add
label define uhrswork_lbl 98 `"98"', add
label define uhrswork_lbl 99 `"99 (Topcode)"', add
label values uhrswork uhrswork_lbl

label define qage_lbl 0 `"Entered as written"'
label define qage_lbl 1 `"Failed edit"', add
label define qage_lbl 2 `"Illegible"', add
label define qage_lbl 3 `"Missing"', add
label define qage_lbl 4 `"Allocated"', add
label define qage_lbl 5 `"Illegible"', add
label define qage_lbl 6 `"Missing"', add
label define qage_lbl 7 `"Original entry illegible"', add
label define qage_lbl 8 `"Original entry missing or failed edit"', add
label values qage qage_lbl

label define qsex_lbl 0 `"Entered as written"'
label define qsex_lbl 1 `"Failed edit"', add
label define qsex_lbl 2 `"Illegible"', add
label define qsex_lbl 3 `"Missing"', add
label define qsex_lbl 4 `"Allocated"', add
label define qsex_lbl 5 `"Illegible"', add
label define qsex_lbl 6 `"Missing"', add
label define qsex_lbl 7 `"Original entry illegible"', add
label define qsex_lbl 8 `"Original entry missing or failed edit"', add
label values qsex qsex_lbl

label define qbpl_lbl 0 `"Entered as written"'
label define qbpl_lbl 1 `"Specific U.S. state or foreign country of birth pre-edited or not reported (1980 Puerto Rico)"', add
label define qbpl_lbl 2 `"Failed edit/illegible"', add
label define qbpl_lbl 3 `"Consistency edit"', add
label define qbpl_lbl 4 `"Allocated"', add
label define qbpl_lbl 5 `"Both general and specific response allocated (1980 Puerto Rico)"', add
label define qbpl_lbl 6 `"Failed edit/missing"', add
label define qbpl_lbl 7 `"Illegible"', add
label define qbpl_lbl 8 `"Illegible/missing or failed edit"', add
label values qbpl qbpl_lbl

label define qhispan_lbl 0 `"Not allocated"'
label define qhispan_lbl 1 `"Allocated from information for this person or from relative, this household"', add
label define qhispan_lbl 2 `"Allocated from nonrelative, this household"', add
label define qhispan_lbl 4 `"Allocated"', add
label values qhispan qhispan_lbl

label define qrace_lbl 0 `"Entered as written"'
label define qrace_lbl 1 `"Failed edit"', add
label define qrace_lbl 2 `"Illegible"', add
label define qrace_lbl 3 `"Missing"', add
label define qrace_lbl 4 `"Allocated"', add
label define qrace_lbl 5 `"Allocated, hot deck"', add
label define qrace_lbl 6 `"Missing"', add
label define qrace_lbl 7 `"Original entry illegible"', add
label define qrace_lbl 8 `"Original entry missing or failed edit"', add
label values qrace qrace_lbl

label define qeduc_lbl 0 `"Original entry or Inapplicable (not in universe)"'
label define qeduc_lbl 1 `"Failed edit"', add
label define qeduc_lbl 2 `"Failed edit/illegible"', add
label define qeduc_lbl 3 `"Failed edit/missing"', add
label define qeduc_lbl 4 `"Consistency edit"', add
label define qeduc_lbl 5 `"Consistency edit/allocated, hot deck"', add
label define qeduc_lbl 6 `"Failed edit/missing"', add
label define qeduc_lbl 7 `"Illegible"', add
label define qeduc_lbl 8 `"Illegible/missing or failed edit"', add
label values qeduc qeduc_lbl

label define qclasswk_lbl 0 `"Original entry or Inapplicable (not in universe)"'
label define qclasswk_lbl 1 `"Failed edit"', add
label define qclasswk_lbl 2 `"Illegible"', add
label define qclasswk_lbl 3 `"Missing"', add
label define qclasswk_lbl 4 `"Allocated"', add
label define qclasswk_lbl 5 `"Illegible"', add
label define qclasswk_lbl 6 `"Missing"', add
label define qclasswk_lbl 7 `"Original entry illegible"', add
label define qclasswk_lbl 8 `"Original entry missing or failed edit"', add
label values qclasswk qclasswk_lbl

label define qind_lbl 0 `"Original entry or Inapplicable (not in universe)"'
label define qind_lbl 1 `"Failed edit"', add
label define qind_lbl 2 `"Illegible"', add
label define qind_lbl 3 `"Missing"', add
label define qind_lbl 4 `"Allocated"', add
label define qind_lbl 5 `"Illegible"', add
label define qind_lbl 6 `"Missing"', add
label define qind_lbl 7 `"Original entry illegible"', add
label define qind_lbl 8 `"Original entry missing or failed edit"', add
label values qind qind_lbl

label define qocc_lbl 0 `"Entered as written"'
label define qocc_lbl 1 `"Failed edit"', add
label define qocc_lbl 2 `"Illegible"', add
label define qocc_lbl 3 `"Missing"', add
label define qocc_lbl 4 `"Allocated"', add
label define qocc_lbl 5 `"Illegible"', add
label define qocc_lbl 6 `"Missing"', add
label define qocc_lbl 7 `"Original entry illegible"', add
label define qocc_lbl 8 `"Original entry missing or failed edit"', add
label values qocc qocc_lbl

label define quhrswor_lbl 0 `"Not allocated"'
label define quhrswor_lbl 3 `"Allocated, direct"', add
label define quhrswor_lbl 4 `"Allocated"', add
label define quhrswor_lbl 5 `"Allocated, indirect"', add
label define quhrswor_lbl 9 `"Allocated, direct/indirect"', add
label values quhrswor quhrswor_lbl

label define qwkswork_lbl 0 `"Original entry or Inapplicable (not in universe)"'
label define qwkswork_lbl 1 `"Failed edit"', add
label define qwkswork_lbl 2 `"Illegible"', add
label define qwkswork_lbl 3 `"Missing"', add
label define qwkswork_lbl 4 `"Allocated, pre-edit"', add
label define qwkswork_lbl 5 `"Allocated, hot deck"', add
label define qwkswork_lbl 6 `"Missing"', add
label define qwkswork_lbl 7 `"Original entry illegible"', add
label define qwkswork_lbl 8 `"Original entry missing or failed edit"', add
label values qwkswork qwkswork_lbl
compress
save d-draw, replace


/*********************************************************************************************/
/********************************************************************************************/
/* Now, we create five year cohorts and uses those to calculate the Duncan-Duncan indexes.*/

clear all
set more off
cd "C:\Users\cmslo\Box Sync\JEP Replication files" 
use d-draw.dta
*
* kept only those 25 to 60 in each data set. 
* kept only native born
* kept only those with at BA or better (or at least 16 years of schooling in 1980)
*
* do a drop of group quarters
*
keep if gq == 1
*
* drop those with missing occupation and military
*
keep if occ2010 < 9800
* this is an error in ipums coding I would guess
drop if occ1990 == 905
*
* start with 1980 birth cohorts
*
gen bcohort80 = 1925 if year == 1980 & birthyr > 1922 & birthyr < 1928
replace bcohort80 = 1930 if year == 1980 & birthyr > 1927 & birthyr < 1933
replace bcohort80 = 1935 if year == 1980 & birthyr > 1932 & birthyr < 1938
replace bcohort80 = 1940 if year == 1980 & birthyr > 1937 & birthyr < 1943
replace bcohort80 = 1945 if year == 1980 & birthyr > 1942 & birthyr < 1948
replace bcohort80 = 1950 if year == 1980 & birthyr > 1947 & birthyr < 1953
*
* 1990 birth cohorts
*
gen bcohort90 = 1935 if year == 1990 & birthyr > 1932 & birthyr < 1938
replace bcohort90 = 1940 if year == 1990 & birthyr > 1937 & birthyr < 1943
replace bcohort90 = 1945 if year == 1990 & birthyr > 1942 & birthyr < 1948
replace bcohort90 = 1950 if year == 1990 & birthyr > 1947 & birthyr < 1953
replace bcohort90 = 1955 if year == 1990 & birthyr > 1952 & birthyr < 1955
replace bcohort90 = 1960 if year == 1990 & birthyr > 1957 & birthyr < 1963
*
* 2000 birth cohorts
*
gen bcohort00 = 1945 if year == 2000 & birthyr > 1942 & birthyr < 1948
replace bcohort00 = 1950 if year == 2000 & birthyr > 1947 & birthyr < 1953
replace bcohort00 = 1955 if year == 2000 & birthyr > 1952 & birthyr < 1955
replace bcohort00 = 1960 if year == 2000 & birthyr > 1957 & birthyr < 1963
replace bcohort00 = 1965 if year == 2000 & birthyr > 1962 & birthyr < 1968
replace bcohort00 = 1970 if year == 2000 & birthyr > 1967 & birthyr < 1973
*
* 2010 birth cohorts
*
gen bcohort10 = 1955 if year > 2000 & year < 2014 & birthyr > 1952 & birthyr < 1955
replace bcohort10 = 1960 if year > 2000 & year < 2014 & birthyr > 1957 & birthyr < 1963
replace bcohort10 = 1965 if year > 2000 & year < 2014 & birthyr > 1962 & birthyr < 1968
replace bcohort10 = 1970 if year > 2000 & year < 2014 & birthyr > 1967 & birthyr < 1973 
replace bcohort10 = 1975 if year > 2000 & year < 2014 & birthyr > 1972 & birthyr < 1978
replace bcohort10 = 1980 if year > 2000 & year < 2014 & birthyr > 1977 & birthyr < 1983
*
* 2017 birth cohorts
*
gen bcohort17 = 1960 if year > 2012 & birthyr > 1957 & birthyr < 1963
replace bcohort17 = 1965 if year > 2012 & birthyr > 1962 & birthyr < 1968
replace bcohort17 = 1970 if year > 2012 & birthyr > 1967 & birthyr < 1973 
replace bcohort17 = 1975 if year > 2012 & birthyr > 1972 & birthyr < 1978
replace bcohort17 = 1980 if year > 2012 & birthyr > 1977 & birthyr < 1983
replace bcohort17 = 1985 if year > 2012 & birthyr > 1982 & birthyr < 1988
*
* drop nonrelevant observations
*
drop if year == 1980 & bcohort80 == .
drop if year == 1990 & bcohort90 == .
drop if year == 2000 & bcohort00 == .
drop if year > 2000 & year < 2014 & bcohort10 == .
drop if year > 2012 & bcohort17 == .
save temp1, replace
*
* now do the ipw
*
gen miss = 0
replace miss = 1 if qsex > 0
replace miss = 1 if qage > 0
replace miss = 1 if qeduc > 0
replace miss = 1 if qbpl > 0
replace miss = 1 if qocc > 0
tab miss
egen den = sum(perwt), by(year age sex race hispan)
egen num = sum(perwt*miss),by(year age sex race hispan)
gen phat = num/den
gen wt = perwt/(1-phat) if miss == 0
tab age if age < 40 [aw=perwt]
tab age if age < 40 [aw=wt]
drop if miss == 1
drop den num
*
* Calculate fraction of men and women in occupation
*
gen fem = sex == 2
gen men = sex == 1
*
* 1980
*
egen nfem80 = sum(wt*fem) if year == 1980, by(bcohort80)
egen noccfem80 = sum(wt*fem) if year == 1980, by(bcohort80 occ2010)
egen nmen80 = sum(wt*men) if year == 1980, by(bcohort80)
egen noccmen80 = sum(wt*men) if year == 1980, by(bcohort80 occ2010)
gen ffem80 = noccfem80/nfem80 if year == 1980
gen fmen80 = noccmen80/nmen80 if year == 1980
gen diff80 = abs(fmen80-ffem80) if year == 1980
*
* 1990
*
egen nfem90 = sum(wt*fem) if year == 1990, by(bcohort90)
egen noccfem90 = sum(wt*fem) if year == 1990, by(bcohort90 occ2010)
egen nmen90 = sum(wt*men) if year == 1990, by(bcohort90)
egen noccmen90 = sum(wt*men) if year == 1990, by(bcohort90 occ2010)
gen ffem90 = noccfem90/nfem90 if year == 1990
gen fmen90 = noccmen90/nmen90 if year == 1990
gen diff90 = abs(fmen90-ffem90) if year == 1990
*
* 2000
*
egen nfem00 = sum(wt*fem) if year == 2000, by(bcohort00)
egen noccfem00 = sum(wt*fem) if year == 2000, by(bcohort00 occ2010)
egen nmen00 = sum(wt*men) if year == 2000, by(bcohort00)
egen noccmen00 = sum(wt*men) if year == 2000, by(bcohort00 occ2010)
gen ffem00 = noccfem00/nfem00 if year == 2000
gen fmen00 = noccmen00/nmen00 if year == 2000
gen diff00 = abs(fmen00-ffem00) if year == 2000
*
* 2010
*
egen nfem10 = sum(wt*fem) if year > 2000 & year < 2014, by(bcohort10)
egen noccfem10 = sum(wt*fem) if year > 2000 & year < 2014, by(bcohort10 occ2010)
egen nmen10 = sum(wt*men) if year > 2000 & year < 2014, by(bcohort10)
egen noccmen10 = sum(wt*men) if year > 2000 & year < 2014, by(bcohort10 occ2010)
gen ffem10 = noccfem10/nfem10 if year > 2000 & year < 2014
gen fmen10 = noccmen10/nmen10 if year > 2000 & year < 2014
gen diff10 = abs(fmen10-ffem10) if year > 2000 & year < 2014
*
* 2017
*
egen nfem17 = sum(wt*fem) if year > 2012, by(bcohort17)
egen noccfem17 = sum(wt*fem) if year > 2012, by(bcohort17 occ2010)
egen nmen17 = sum(wt*men) if year > 2012, by(bcohort17)
egen noccmen17 = sum(wt*men) if year > 2012, by(bcohort17 occ2010)
gen ffem17 = noccfem17/nfem17 if year > 2012
gen fmen17 = noccmen17/nmen17 if year > 2012
gen diff17 = abs(fmen17-ffem17) if year > 2012
*
* 
replace year = 2010 if year > 2000 & year < 2014
replace year = 2017 if year > 2012
*
* Collapse the data
*
collapse diff80 diff90 diff00 diff10 diff17, by(bcohort80 bcohort90 bcohort00 bcohort10 bcohort17 occ2010 year)

/*Now, we calculate our Classic Duncan-Duncan Indices*/
egen tr = sum(diff80), by(bcohort80)
gen dd80 = 0.5*tr if year == 1980
drop tr
egen tr = sum(diff90), by(bcohort90)
gen dd90 = 0.5*tr if year == 1990
drop tr
egen tr = sum(diff00), by(bcohort00)
gen dd00 = 0.5*tr if year == 2000
drop tr
egen tr = sum(diff10), by(bcohort10)
gen dd10 = 0.5*tr if year == 2010
drop tr
egen tr = sum(diff17), by(bcohort17)
gen dd17 = 0.5*tr if year == 2017 
*
* Reporting our D-D by birthcohorts
*
tab bcohort80, sum(dd80)
tab bcohort90, sum(dd90)
tab bcohort00, sum(dd00)
tab bcohort10, sum(dd10)
tab bcohort17, sum(dd17)

/*Now, we calculate our inverse Duncan-Duncan Indices (1-Classic Duncan-Duncan). This is what is copy and pasted into Overleaf for Table A1*/

gen inverse_dd80 = 1-dd80
gen inverse_dd90 = 1-dd90
gen inverse_dd00 = 1-dd00
gen inverse_dd10 = 1-dd10
gen inverse_dd17 = 1-dd17

* Reporting our D-D by birthcohorts
*
tab bcohort80, sum(inverse_dd80)
tab bcohort90, sum(inverse_dd90)
tab bcohort00, sum(inverse_dd00)
tab bcohort10, sum(inverse_dd10)
tab bcohort17, sum(inverse_dd17)
save ddocc201, replace

log close


/**********************************************************************************************************************************************/


/************Table A2: Occupational Concentration Conditional on Major:

Values are calculated here for the table and then copy and pasted into our Overleaf table.

This table shows occupational concentration within major category for men and women born between 1968 and 1977 for different majors. Specifically, this table reports $HHI^{Major}_{g,c}$ from the 2014-2017 ACS. We use broad major and broad occupation categories. Values closer to 0 reflect more dispersion.  

We already calculate all of these values when we made Column 5 of Table 1. Here, we just include all the broad major categories. 


****************/
# delimit cr
clear all 

cd "C:\Users\cmslo\Box Sync\JEP Replication files" 
log using "C:\Users\cmslo\Box Sync\JEP Replication files\replication Table A2_check.smcl", replace 
/***************We start by merging in the Broad HHI values file we calculated for Column 5 of Table 1************/

use "male_broad_herfindahl_index_1968_1977"

append using "female_broad_herfindahl_index_1968_1977"

/*we now make some indicator variables to identify the broad major categories */

keep if major != . 

#delimit cr
gen major_cat = .
replace major_cat = 1 if major_broad == 11 
replace major_cat = 2 if major_broad == 13 
replace major_cat = 3 if major_broad == 14
replace major_cat = 4 if major_broad == 15
replace major_cat = 5 if major_broad == 19
replace major_cat = 6 if major_broad == 21
replace major_cat = 7 if major_broad == 22
replace major_cat = 8 if major_broad == 23 
replace major_cat = 9 if major_broad == 24
replace major_cat = 10 if major_broad == 26
replace major_cat = 11 if major_broad == 29
replace major_cat = 12 if major_broad == 32
replace major_cat = 13 if major_broad == 33
replace major_cat = 14 if major_broad == 34
replace major_cat = 15 if major_broad == 36
replace major_cat = 16 if major_broad == 37
replace major_cat = 17 if major_broad == 40
replace major_cat = 18 if major_broad == 48
replace major_cat = 19 if major_broad == 50
replace major_cat = 20 if major_broad == 52 
replace major_cat = 21 if major_broad == 53
replace major_cat = 22 if major_broad == 54
replace major_cat = 23 if major_broad == 55
replace major_cat = 24 if major_broad == 56
replace major_cat = 25 if major_broad == 60
replace major_cat = 26 if major_broad == 61
replace major_cat = 27 if major_broad == 62
replace major_cat = 28 if major_broad == 64

label var major_cat      `"major name"'
label define major_cat_lbl 1 `"agriculture"'
label define major_cat_lbl 2 `"environment"', add
label define major_cat_lbl 3 `"architecture"', add
label define major_cat_lbl 4 `"ethnic studies"', add
label define major_cat_lbl 5 `"communications"', add
label define major_cat_lbl 6 `"computer science"', add
label define major_cat_lbl 7 `"cosmetology"', add
label define major_cat_lbl 8 `"education"', add
label define major_cat_lbl 9 `"engineering"' , add
label define major_cat_lbl 10 `"languages"', add
label define major_cat_lbl 11 `"family studies"', add
label define major_cat_lbl 12 `"law"', add
label define major_cat_lbl 13 `"english"', add
label define major_cat_lbl 14 `"liberal arts"', add
label define major_cat_lbl 15 `"biology"', add
label define major_cat_lbl 16 `"math/stats"', add
label define major_cat_lbl 17 `"multi disc"' , add
label define major_cat_lbl 18 `"philosophy"', add
label define major_cat_lbl 19 `"physical sciences"', add
label define major_cat_lbl 20 `"psychology"', add
label define major_cat_lbl 21 `"criminal studies"', add
label define major_cat_lbl 22 `"public affairs"', add
label define major_cat_lbl 23 `"social sciences"', add
label define major_cat_lbl 24 `"construction"', add
label define major_cat_lbl 25 `"fine arts"' , add
label define major_cat_lbl 26 `"nursing/pharm"', add
label define major_cat_lbl 27 `"business"', add
label define major_cat_lbl 28 `"history"', add

label values major_cat major_cat_lbl

/*Here, we report the HHI indices by gender. These are pasted into our Overleaf document
****Note**** all male values (sex == 1) are reported first for each major and then all female values (sex == 2) are reported for each major */
sort sex major_cat 

by sex major_cat: sum herf_index_major_broad if major_cat != .

save "herfindahl_indices_all_broad_majors_1968_1977" , replace

log close



/************Tables A3-A6: Major to Occupation Mapping Measure, 1968-1977 Birth Cohort:

Values are calculated here for the table and then copy and pasted into Excel.


****************/
# delimit cr
clear all 

cd "C:\Users\cmslo\Box Sync\JEP Replication files" 
log using "C:\Users\cmslo\Box Sync\JEP Replication files\replication Table A3_A6_check.smcl", replace 

use "main_analysis_file"

/*We keep the 1968-1977 birth cohort*/
keep if a45 == 1 | a40 == 1 

/*We keep people with occupation information */
keep if wt_occ_wage_nat !=.

/*now, we calculate the within-major mean potential occupational wage -- this is our mapping measure for each detailed major*/
collapse (mean) wt_occ_wage_nat [aw=wt], by(sex major)

/*here, we label the majors to make it easier to copy and paste into our table */
label define major_lbl 0000 `"N/A"'
label define major_lbl 1100 `"General Agriculture"', add
label define major_lbl 1101 `"Agriculture Production and Management"', add
label define major_lbl 1102 `"Agricultural Economics"', add
label define major_lbl 1103 `"Animal Sciences"', add
label define major_lbl 1104 `"Food Science"', add
label define major_lbl 1105 `"Plant Science and Agronomy"', add
label define major_lbl 1106 `"Soil Science"', add
label define major_lbl 1199 `"Miscellaneous Agriculture"', add
label define major_lbl 1300 `"Environment and Natural Resources"', add
label define major_lbl 1301 `"Environmental Science"', add
label define major_lbl 1302 `"Forestry"', add
label define major_lbl 1303 `"Natural Resources Management"', add
label define major_lbl 1401 `"Architecture"', add
label define major_lbl 1501 `"Area, Ethnic, and Civilization Studies"', add
label define major_lbl 1900 `"Communications"', add
label define major_lbl 1901 `"Communications"', add
label define major_lbl 1902 `"Journalism"', add
label define major_lbl 1903 `"Mass Media"', add
label define major_lbl 1904 `"Advertising and Public Relations"', add
label define major_lbl 2001 `"Communication Technologies"', add
label define major_lbl 2100 `"Computer and Information Systems"', add
label define major_lbl 2101 `"Computer Programming and Data Processing"', add
label define major_lbl 2102 `"Computer Science"', add
label define major_lbl 2105 `"Information Sciences"', add
label define major_lbl 2106 `"Computer Information Management and Security"', add
label define major_lbl 2107 `"Computer Networking and Telecommunications"', add
label define major_lbl 2201 `"Cosmetology Services and Culinary Arts"', add
label define major_lbl 2300 `"General Education"', add
label define major_lbl 2301 `"Educational Administration and Supervision"', add
label define major_lbl 2303 `"School Student Counseling"', add
label define major_lbl 2304 `"Elementary Education"', add
label define major_lbl 2305 `"Mathematics Teacher Education"', add
label define major_lbl 2306 `"Physical and Health Education Teaching"', add
label define major_lbl 2307 `"Early Childhood Education"', add
label define major_lbl 2308 `"Science  and Computer Teacher Education"', add
label define major_lbl 2309 `"Secondary Teacher Education"', add
label define major_lbl 2310 `"Special Needs Education"', add
label define major_lbl 2311 `"Social Science or History Teacher Education"', add
label define major_lbl 2312 `"Teacher Education:  Multiple Levels"', add
label define major_lbl 2313 `"Language and Drama Education"', add
label define major_lbl 2314 `"Art and Music Education"', add
label define major_lbl 2399 `"Miscellaneous Education"', add
label define major_lbl 2400 `"General Engineering"', add
label define major_lbl 2401 `"Aerospace Engineering"', add
label define major_lbl 2402 `"Biological Engineering"', add
label define major_lbl 2403 `"Architectural Engineering"', add
label define major_lbl 2404 `"Biomedical Engineering"', add
label define major_lbl 2405 `"Chemical Engineering"', add
label define major_lbl 2406 `"Civil Engineering"', add
label define major_lbl 2407 `"Computer Engineering"', add
label define major_lbl 2408 `"Electrical Engineering"', add
label define major_lbl 2409 `"Engineering Mechanics, Physics, and Science"', add
label define major_lbl 2410 `"Environmental Engineering"', add
label define major_lbl 2411 `"Geological and Geophysical Engineering"', add
label define major_lbl 2412 `"Industrial and Manufacturing Engineering"', add
label define major_lbl 2413 `"Materials Engineering and Materials Science"', add
label define major_lbl 2414 `"Mechanical Engineering"', add
label define major_lbl 2415 `"Metallurgical Engineering"', add
label define major_lbl 2416 `"Mining and Mineral Engineering"', add
label define major_lbl 2417 `"Naval Architecture and Marine Engineering"', add
label define major_lbl 2418 `"Nuclear Engineering"', add
label define major_lbl 2419 `"Petroleum Engineering"', add
label define major_lbl 2499 `"Miscellaneous Engineering"', add
label define major_lbl 2500 `"Engineering Technologies"', add
label define major_lbl 2501 `"Engineering and Industrial Management"', add
label define major_lbl 2502 `"Electrical Engineering Technology"', add
label define major_lbl 2503 `"Industrial Production Technologies"', add
label define major_lbl 2504 `"Mechanical Engineering Related Technologies"', add
label define major_lbl 2599 `"Miscellaneous Engineering Technologies"', add
label define major_lbl 2600 `"Linguistics and Foreign Languages"', add
label define major_lbl 2601 `"Linguistics and Comparative Language and Literature"', add
label define major_lbl 2602 `"French, German, Latin and Other Common Foreign Language Studies"', add
label define major_lbl 2603 `"Other Foreign Languages"', add
label define major_lbl 2901 `"Family and Consumer Sciences"', add
label define major_lbl 3200 `"Law"', add
label define major_lbl 3201 `"Court Reporting"', add
label define major_lbl 3202 `"Pre-Law and Legal Studies"', add
label define major_lbl 3300 `"English Language, Literature, and Composition"', add
label define major_lbl 3301 `"English Language and Literature"', add
label define major_lbl 3302 `"Composition and Speech"', add
label define major_lbl 3400 `"Liberal Arts and Humanities"', add
label define major_lbl 3401 `"Liberal Arts"', add
label define major_lbl 3402 `"Humanities"', add
label define major_lbl 3501 `"Library Science"', add
label define major_lbl 3600 `"Biology"', add
label define major_lbl 3601 `"Biochemical Sciences"', add
label define major_lbl 3602 `"Botany"', add
label define major_lbl 3603 `"Molecular Biology"', add
label define major_lbl 3604 `"Ecology"', add
label define major_lbl 3605 `"Genetics"', add
label define major_lbl 3606 `"Microbiology"', add
label define major_lbl 3607 `"Pharmacology"', add
label define major_lbl 3608 `"Physiology"', add
label define major_lbl 3609 `"Zoology"', add
label define major_lbl 3611 `"Neuroscience"', add
label define major_lbl 3699 `"Miscellaneous Biology"', add
label define major_lbl 3700 `"Mathematics"', add
label define major_lbl 3701 `"Applied Mathematics"', add
label define major_lbl 3702 `"Statistics and Decision Science"', add
label define major_lbl 3801 `"Military Technologies"', add
label define major_lbl 4000 `"Interdisciplinary and Multi-Disciplinary Studies (General)"', add
label define major_lbl 4001 `"Intercultural and International Studies"', add
label define major_lbl 4002 `"Nutrition Sciences"', add
label define major_lbl 4003 `"Neuroscience"', add
label define major_lbl 4005 `"Mathematics and Computer Science"', add
label define major_lbl 4006 `"Cognitive Science and Biopsychology"', add
label define major_lbl 4007 `"Interdisciplinary Social Sciences"', add
label define major_lbl 4008 `"Multi-disciplinary or General Science"', add
label define major_lbl 4101 `"Physical Fitness, Parks, Recreation, and Leisure"', add
label define major_lbl 4801 `"Philosophy and Religious Studies"', add
label define major_lbl 4901 `"Theology and Religious Vocations"', add
label define major_lbl 5000 `"Physical Sciences"', add
label define major_lbl 5001 `"Astronomy and Astrophysics"', add
label define major_lbl 5002 `"Atmospheric Sciences and Meteorology"', add
label define major_lbl 5003 `"Chemistry"', add
label define major_lbl 5004 `"Geology and Earth Science"', add
label define major_lbl 5005 `"Geosciences"', add
label define major_lbl 5006 `"Oceanography"', add
label define major_lbl 5007 `"Physics"', add
label define major_lbl 5008 `"Materials Science"', add
label define major_lbl 5098 `"Multi-disciplinary or General Science"', add
label define major_lbl 5102 `"Nuclear, Industrial Radiology, and Biological Technologies"', add
label define major_lbl 5200 `"Psychology"', add
label define major_lbl 5201 `"Educational Psychology"', add
label define major_lbl 5202 `"Clinical Psychology"', add
label define major_lbl 5203 `"Counseling Psychology"', add
label define major_lbl 5205 `"Industrial and Organizational Psychology"', add
label define major_lbl 5206 `"Social Psychology"', add
label define major_lbl 5299 `"Miscellaneous Psychology"', add
label define major_lbl 5301 `"Criminal Justice and Fire Protection"', add
label define major_lbl 5400 `"Public Affairs, Policy, and Social Work"', add
label define major_lbl 5401 `"Public Administration"', add
label define major_lbl 5402 `"Public Policy"', add
label define major_lbl 5403 `"Human Services and Community Organization"', add
label define major_lbl 5404 `"Social Work"', add
label define major_lbl 5500 `"General Social Sciences"', add
label define major_lbl 5501 `"Economics"', add
label define major_lbl 5502 `"Anthropology and Archeology"', add
label define major_lbl 5503 `"Criminology"', add
label define major_lbl 5504 `"Geography"', add
label define major_lbl 5505 `"International Relations"', add
label define major_lbl 5506 `"Political Science and Government"', add
label define major_lbl 5507 `"Sociology"', add
label define major_lbl 5599 `"Miscellaneous Social Sciences"', add
label define major_lbl 5601 `"Construction Services"', add
label define major_lbl 5701 `"Electrical and Mechanic Repairs and Technologies"', add
label define major_lbl 5801 `"Precision Production and Industrial Arts"', add
label define major_lbl 5901 `"Transportation Sciences and Technologies"', add
label define major_lbl 6000 `"Fine Arts"', add
label define major_lbl 6001 `"Drama and Theater Arts"', add
label define major_lbl 6002 `"Music"', add
label define major_lbl 6003 `"Visual and Performing Arts"', add
label define major_lbl 6004 `"Commercial Art and Graphic Design"', add
label define major_lbl 6005 `"Film, Video and Photographic Arts"', add
label define major_lbl 6006 `"Art History and Criticism"', add
label define major_lbl 6007 `"Studio Arts"', add
label define major_lbl 6099 `"Miscellaneous Fine Arts"', add
label define major_lbl 6100 `"General Medical and Health Services"', add
label define major_lbl 6102 `"Communication Disorders Sciences and Services"', add
label define major_lbl 6103 `"Health and Medical Administrative Services"', add
label define major_lbl 6104 `"Medical Assisting Services"', add
label define major_lbl 6105 `"Medical Technologies Technicians"', add
label define major_lbl 6106 `"Health and Medical Preparatory Programs"', add
label define major_lbl 6107 `"Nursing"', add
label define major_lbl 6108 `"Pharmacy, Pharmaceutical Sciences, and Administration"', add
label define major_lbl 6109 `"Treatment Therapy Professions"', add
label define major_lbl 6110 `"Community and Public Health"', add
label define major_lbl 6199 `"Miscellaneous Health Medical Professions"', add
label define major_lbl 6200 `"General Business"', add
label define major_lbl 6201 `"Accounting"', add
label define major_lbl 6202 `"Actuarial Science"', add
label define major_lbl 6203 `"Business Management and Administration"', add
label define major_lbl 6204 `"Operations, Logistics and E-Commerce"', add
label define major_lbl 6205 `"Business Economics"', add
label define major_lbl 6206 `"Marketing and Marketing Research"', add
label define major_lbl 6207 `"Finance"', add
label define major_lbl 6209 `"Human Resources and Personnel Management"', add
label define major_lbl 6210 `"International Business"', add
label define major_lbl 6211 `"Hospitality Management"', add
label define major_lbl 6212 `"Management Information Systems and Statistics"', add
label define major_lbl 6299 `"Miscellaneous Business and Medical Administration"', add
label define major_lbl 6402 `"History"', add
label define major_lbl 6403 `"United States History"', add
label values major major_lbl

sort sex major 
/*we now go to browse mode to we can easily copy and paste this data to Excel. 
Note: all male values presented first and then all female values presented
In Excel, we subtract female- male within- major Mean Potential Occupational Wage */
browse 

log close

/************Table A7: Major Sorting and Gender Gaps in Employment:

Values are calculated here for the table and then copy and pasted into our Overleaf table.
This table reports our OLS regressions for employment. 

Table shows estimates from regression $Employed_{i} = \alpha + \beta Female_{i} + \delta_m Major_{i} + \Gamma X_{i} + \epsilon_{i}$ where $Employed_{i}$ is a dummy variable equal to 1 if individual is employed and $Female_{i}$ is a dummy variable equal to 1 if the individual is female. 

Our estimated variable of interest is $\beta$ that measures the gender gap in employment. $Major_{i}$ is a summary measures of the individual's chosen undergraduate major. We summarize an individual's major with the potential log wage variable $\bar{Y}^m_{i}$.  In all specifications, we include a vector of demographic controls summarized in the vector $X_{i}$. Specifically, we control for five-year birth cohort, race, state of residence, educational attainment beyond bachelor's, survey year, and marital status. Standard errors are clustered by state of residence.

Note: wt_med_wage_nat is our potential wage based on major variable
wt is our weight variable
a* are five-year birth cohort indicator variables
masters and doctorate are indicator variables indicating attainment of a masters (doctorate) degree


****************/
# delimit cr
clear all 

cd "C:\Users\cmslo\Box Sync\JEP Replication files" 
log using "C:\Users\cmslo\Box Sync\JEP Replication files\replication Table A7_check.smcl", replace 

use "main_analysis_file"

/*Column 1 (Demographic Controls Only)*/

reg employed female i.race i.super_state a25 a30 a35 a40  a50 a55 a60 a65 i.marst masters doctorate i.year [aw=wt] if wt_med_wage_nat != . , cluster(super_state)

/*Column 2 (Demographic Controls & Major Sorting)*/

reg employed female i.race i.super_state a25 a30 a35 a40  a50 a55 a60 a65 i.marst masters doctorate i.year wt_med_wage_nat [aw=wt] if wt_med_wage_nat != .  , cluster(super_state)

log close 


/************Table A8:  Major, Occupation and Gender Gaps in Wages :

This table reports our OLS regressions. It is a robustness check on panel (a) of Table 2 and Table A7 with no demographic or time controls.

For Columns 1-4:

We estimate ln(Wage)_{i} = \alpha + \beta Female_{i} + \delta_m Major_{i} + \delta_o Occ_{i} +  \epsilon_{i}

where $ln(Wage)_{i}$ is a measure of individual {i}'s log wage and $Female_{i}$ is a dummy variable equal to 1 if the individual is female. Our estimated variable of interest is $\beta$ that measures the gender gap in log wages. $Major_{i}$ and $Occ_{i}$ are summary measures of the individual's chosen undergraduate major and observed occupation. We summarize an individual's major and occupation choice with the potential log wage variables $\bar{Y}^m_{i}$ and  $\bar{Y}^o_{i}$.  

Note: wt_med_wage_nat is our potential wage based on major variable, wt_occ_wage_nat is our potential wage based on occupation variable
wt is our weight variable

For Columns 5 & 6: 
We estimate $Employed_{i} = \alpha + \beta Female_{i} + \delta_m Major_{i} + \epsilon_{i}$ where $Employed_{i}$ is a dummy variable equal to 1 if individual is employed and $Female_{i}$ is a dummy variable equal to 1 if the individual is female. 

\begin{equation}\label{eq:main_regression}
ln(Wage)_{i} = \alpha + \beta Female_{i} + \delta_m Major_{i} + \delta_o Occ_{i} +  \epsilon_{i}
\end{equation}

Note: wt_med_wage_nat is our potential wage based on major variable, wt_occ_wage_nat is our potential wage based on occupation variable
wt is our weight variable */

# delimit cr
clear all 

cd "C:\Users\cmslo\Box Sync\JEP Replication files" 
log using "C:\Users\cmslo\Box Sync\JEP Replication files\replication Table A8_check.smcl", replace 
use "main_analysis_file"

/*Wage Regressions*/

/*Column 1 (Raw wage gap)*/

reg actual_wage female i.year [aw=wt] if wt_med_wage_nat != . & wt_occ_wage_nat != . , cluster(super_state)

/*Column 2 (Major)*/

reg actual_wage female i.year wt_med_wage_nat [aw=wt] if wt_med_wage_nat != . & wt_occ_wage_nat != . , cluster(super_state)

/*Column 3 (Occupation)*/

reg actual_wage female  i.year wt_occ_wage_nat [aw=wt] if wt_med_wage_nat != . & wt_occ_wage_nat != . , cluster(super_state)

/*Column 4 (Major & Occupation)*/

reg actual_wage female  i.year wt_med_wage_nat wt_occ_wage_nat [aw=wt] if wt_med_wage_nat != . & wt_occ_wage_nat != . , cluster(super_state)

/*Employment Regressions*/

/*Column 5 (Raw Employment Gap)*/

reg employed female  i.year [aw=wt] if wt_med_wage_nat != . , cluster(super_state)

/*Column 6 (Major Sorting)*/

reg employed female  i.year wt_med_wage_nat [aw=wt] if wt_med_wage_nat != .  , cluster(super_state)

log close

/************Table A9:  Major, Occupation and Gender Gaps in Wages and Employment, Alternative Specifications Using Broad Major and Occupations :

This table reports our OLS regressions. It is a robustness check on the main results in Panel (a) of Table 2 using two alternate ways to control for occupation and major sorting.

Panel A:
We include as independent variables measures of potential wages determined by the broad majors and occupations instead of detailed majors and occupations. 

Panel B:
We include as independent variables vectors of broad major dummies and occupation dummies instead of our potential wage controls.

Note: wt_med_broad_wage_nat is our potential wage based on broad major categories variable, wt_occ_broad_wage_nat is our potential wage based on occupation variable
wt is our weight variable */

# delimit cr
clear all 

cd "C:\Users\cmslo\Box Sync\JEP Replication files" 
log using "C:\Users\cmslo\Box Sync\JEP Replication files\replication Table A9_check.smcl", replace 
use "main_analysis_file"

/*Panel A*/
/*Wage Regressions*/

/*Column 1 (Demographic Controls Only)*/

reg actual_wage female i.race i.super_state a25 a30 a35 a40  a50 a55 a60 a65 i.marst masters doctorate i.year [aw=wt] if wt_med_broad_wage_nat  != . & wt_occ_broad_wage_nat != . , cluster(super_state)

/*Column 2 (Demographic Controls & Broad Pot Wage Major)*/

reg actual_wage female i.race i.super_state a25 a30 a35 a40  a50 a55 a60 a65 i.marst masters doctorate i.year wt_med_broad_wage_nat  [aw=wt] if wt_med_broad_wage_nat  != . & wt_occ_broad_wage_nat != . , cluster(super_state)

/*Column 3 (Demographic Controls & Broad Pot Wage Occupation )*/

reg actual_wage female i.race i.super_state a25 a30 a35 a40  a50 a55 a60 a65 i.marst masters doctorate i.year wt_occ_broad_wage_nat [aw=wt] if wt_med_broad_wage_nat  != . & wt_occ_broad_wage_nat != . , cluster(super_state)

/*Column 4 (Demographic Controls & Broad Pot Wage Major & Broad Pot Wage Occupation)*/

reg actual_wage female i.race i.super_state a25 a30 a35 a40  a50 a55 a60 a65 i.marst masters doctorate i.year wt_med_broad_wage_nat  wt_occ_broad_wage_nat [aw=wt] if wt_med_broad_wage_nat  != . & wt_occ_broad_wage_nat != . , cluster(super_state)

/*Employment Regressions*/

/*Column 5 (Demographic Controls Only)*/

reg employed female i.race i.super_state a25 a30 a35 a40  a50 a55 a60 a65 i.marst masters doctorate i.year [aw=wt] if wt_med_broad_wage_nat  != . , cluster(super_state)

/*Column 2 (Demographic Controls & Broad Pot Wage Major)*/

reg employed female i.race i.super_state a25 a30 a35 a40  a50 a55 a60 a65 i.marst masters doctorate i.year wt_med_broad_wage_nat  [aw=wt] if wt_med_broad_wage_nat  != .  , cluster(super_state)

/*Panel B*/

/*Wage Regressions*/

/*Column 1 (Demographic Controls Only)*/

reg actual_wage female i.race i.super_state a25 a30 a35 a40  a50 a55 a60 a65 i.marst masters doctorate i.year [aw=wt] if wt_med_broad_wage_nat  != . & wt_occ_broad_wage_nat != . , cluster(super_state)

/*Column 2 (Demographic Controls & Broad Pot Wage Major)*/

reg actual_wage female i.race i.super_state a25 a30 a35 a40  a50 a55 a60 a65 i.marst masters doctorate i.year i.major_broad  [aw=wt] if wt_med_broad_wage_nat  != . & wt_occ_broad_wage_nat != . , cluster(super_state)

/*Column 3 (Demographic Controls & Broad Pot Wage Occupation )*/

reg actual_wage female i.race i.super_state a25 a30 a35 a40  a50 a55 a60 a65 i.marst masters doctorate i.year i.occ_broad [aw=wt] if wt_med_broad_wage_nat  != . & wt_occ_broad_wage_nat != . , cluster(super_state)

/*Column 4 (Demographic Controls & Broad Pot Wage Major & Broad Pot Wage Occupation)*/

reg actual_wage female i.race i.super_state a25 a30 a35 a40  a50 a55 a60 a65 i.marst masters doctorate i.year i.major_broad  i.occ_broad [aw=wt] if wt_med_broad_wage_nat  != . & wt_occ_broad_wage_nat != . , cluster(super_state)

/*Employment Regressions*/

/*Column 5 (Demographic Controls Only)*/

reg employed female i.race i.super_state a25 a30 a35 a40  a50 a55 a60 a65 i.marst masters doctorate i.year [aw=wt] if wt_med_broad_wage_nat  != . , cluster(super_state)

/*Column 6 (Demographic Controls & Broad Pot Wage Major)*/

reg employed female i.race i.super_state a25 a30 a35 a40  a50 a55 a60 a65 i.marst masters doctorate i.year i.major_broad  [aw=wt] if wt_med_broad_wage_nat  != .  , cluster(super_state)


log close 


/************Tables A10 & A11: Major, Occupation and Gender Gaps in Wages and Employment & Wage Decompositions Explanatory Variables

This table reports our OLS regressions for each 5-year birth cohort. These estimates are copy and pasted into an Overleaf Table (Table A10) and are used for an accounting exercise (in Excel) that results in Table A11

Specifically, we estimate regressions of the following form:


ln(Wage)_{i} = \alpha + \beta Female_{i} + \delta_m Major_{i} + \delta_o Occ_{i} + \Gamma X_{i} + \epsilon_{i}


where $ln(Wage)_{i}$ is a measure of individual {i}'s log wage and $Female_{i}$ is a dummy variable equal to 1 if the individual is female. Our estimated variable of interest is $\beta$ that measures the gender gap in log wages. $Major_{i}$ and $Occ_{i}$ are summary measures of the individual's chosen undergraduate major and observed occupation. We summarize an individual's major and occupation choice with the potential log wage variables $\bar{Y}^m_{i}$ and  $\bar{Y}^o_{i}$.  In all specifications, we include a vector of demographic controls summarized in the vector $X_{i}$. Specifically, we control for five-year birth cohort, race, state of residence, educational attainment beyond bachelor's, survey year, and marital status. Standard errors are clustered by state of residence.

Note: wt_med_wage_nat is our potential wage based on major variable, wt_occ_wage_nat is our potential wage based on occupation variable
wt is our weight variable
masters and doctorate are indicator variables indicating attainment of a masters (doctorate) degree

****************/
/**********************************************PANEL A: Older Cohorts*********************************/

/*Columns 1-3 1948-1957 Birth Cohorts*/
#delimit cr
clear all
cd "C:\Users\cmslo\Box Sync\JEP Replication files" 
log using "C:\Users\cmslo\Box Sync\JEP Replication files\replication Tables A10-A11_check.smcl", replace 
use "main_analysis_file"
keep if a65 == 1 | a60 == 1

/*Column 1 (Demographic Controls Only)*/

reg actual_wage female i.age i.race i.super_state  i.marst masters doctorate i.year [aw=wt] if wt_med_wage_nat != . & wt_occ_wage_nat != . , cluster(super_state)

/*Column 2 (Demographic Controls & Occupation)*/

reg actual_wage female i.age i.race i.super_state  i.marst masters doctorate i.year wt_occ_wage_nat [aw=wt] if wt_med_wage_nat != . & wt_occ_wage_nat != . , cluster(super_state)

/*Column 3 (Demographic Controls & Major & Occupation)*/

reg actual_wage female i.age i.race i.super_state i.marst masters doctorate i.year wt_med_wage_nat wt_occ_wage_nat [aw=wt] if wt_med_wage_nat != . & wt_occ_wage_nat != . , cluster(super_state)

/*Columns 4-6 1958-1967 Birth Cohorts*/
#delimit cr
clear all
cd "C:\Users\cmslo\Box Sync\JEP Replication files" 
use "main_analysis_file"
keep if a55 == 1 | a50 == 1

/*Column 4 (Demographic Controls Only)*/

reg actual_wage female i.age i.race i.super_state  i.marst masters doctorate i.year [aw=wt] if wt_med_wage_nat != . & wt_occ_wage_nat != . , cluster(super_state)

/*Column 5 (Demographic Controls & Occupation)*/

reg actual_wage female i.age i.race i.super_state  i.marst masters doctorate i.year wt_occ_wage_nat [aw=wt] if wt_med_wage_nat != . & wt_occ_wage_nat != . , cluster(super_state)

/*Column 6 (Demographic Controls & Major & Occupation)*/

reg actual_wage female i.age i.race i.super_state i.marst masters doctorate i.year wt_med_wage_nat wt_occ_wage_nat [aw=wt] if wt_med_wage_nat != . & wt_occ_wage_nat != . , cluster(super_state)

/**********************************************PANEL B: Younger Cohorts*********************************/

/*Columns 1-3 1968-1977 Birth Cohorts*/
#delimit cr
clear all
cd "C:\Users\cmslo\Box Sync\JEP Replication files" 
use "main_analysis_file"
keep if a45 == 1 | a40 == 1

/*Column 1 (Demographic Controls Only)*/

reg actual_wage female i.age i.race i.super_state  i.marst masters doctorate i.year [aw=wt] if wt_med_wage_nat != . & wt_occ_wage_nat != . , cluster(super_state)

/*Column 2 (Demographic Controls & Occupation)*/

reg actual_wage female i.age i.race i.super_state  i.marst masters doctorate i.year wt_occ_wage_nat [aw=wt] if wt_med_wage_nat != . & wt_occ_wage_nat != . , cluster(super_state)

/*Column 3 (Demographic Controls & Major & Occupation)*/

reg actual_wage female i.age i.race i.super_state i.marst masters doctorate i.year wt_med_wage_nat wt_occ_wage_nat [aw=wt] if wt_med_wage_nat != . & wt_occ_wage_nat != . , cluster(super_state)


/*Columns 4-6 1978-1987 Birth Cohorts*/
#delimit cr
clear all
cd "C:\Users\cmslo\Box Sync\JEP Replication files" 
use "main_analysis_file"
keep if a35 == 1 | a30 == 1

/*Column 4 (Demographic Controls Only)*/

reg actual_wage female i.age i.race i.super_state  i.marst masters doctorate i.year [aw=wt] if wt_med_wage_nat != . & wt_occ_wage_nat != . , cluster(super_state)

/*Column 5 (Demographic Controls & Occupation)*/

reg actual_wage female i.age i.race i.super_state  i.marst masters doctorate i.year wt_occ_wage_nat [aw=wt] if wt_med_wage_nat != . & wt_occ_wage_nat != . , cluster(super_state)

/*Column 6 (Demographic Controls & Major & Occupation)*/

reg actual_wage female i.age i.race i.super_state i.marst masters doctorate i.year wt_med_wage_nat wt_occ_wage_nat [aw=wt] if wt_med_wage_nat != . & wt_occ_wage_nat != . , cluster(super_state)

log close