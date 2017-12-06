
***********************************************
** EITC Replicate - DID (Eissa and Liebman QJE 1996)
***********************************************

cd "D:\LE"

use eitc.dta, clear

** Q1 & Q2.
d
su

gen earnifwork = earn if work==1

su if children==0
su if children==1
su if children>=2

recode children (0=0) (1=1) (2/10=2), gen(c_children)
tab c_children, sum(earnifwork)


** Q3.
gen anykids = (children>=1)
gen post93 = (year>1993)
su children year anykids post93

 
** Q4.
bys anykids post93: su work
mean work, over(anykids post93)

 
** Q5.
gen postXany = post93*anykids
reg work post93 anykids postXany

 
 
** Additional Analysis using a graph.
preserve

* Graph 1: Trend
collapse work, by(year anykids)
gen work0 = work if anykids==0
label var work0 "Single women, no children"
gen work1 = work if anykids==1
label var work1 "Single women, children"

twoway (line work0 year) (line work1 year), ytitle(Labor Force Participation Rates)
graph save eitc1.gph, replace

* Graph 2: Set Year 1991 as baseline
su work0 if year==1991
gen work0_yr1 = r(mean) // Stores results from sum command
replace work0 = work0/work0_yr1

su work1 if year==1991
gen work1_yr1 = r(mean) // Stores results from sum command
replace work1 = work1/work1_yr1

twoway (line work0 year) (line work1 year), ytitle(Ratio of LFPR to 1991 rate)
graph save eitc2.gph, replace

graph combine eitc1.gph eitc2.gph, saving(eitc_combined, replace) col(1) ysize(7)

restore
 
