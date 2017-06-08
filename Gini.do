** Please see following PDF files for the reference: http://www.stata.com/manuals13/rinequality.pdf

** Please install "sg30" to get various inequality index in Stata by typing below
findit sg30

** All install "glcurve" by typing below
ssc install glcurve


** Case 1
clear
set obs 100
gen x=10
inequal x


** Case 2
clear
set obs 4
gen x=.
replace x=1 in 1
replace x=2 in 2
replace x=3 in 3
replace x=4 in 4
inequal x

glcurve x, pvar(p) glvar(l) lorenz nograph
graph twoway (line l p, sort)  ///    
          (function y = x, range(0 1)) ///    
          , aspect(1) xtitle("Cumulative population share, p") ///    
          title("Lorenz Curve Comparison") ///    
          ytitle("Cumulative proportion of income") ///    
          legend(label(1 "L") label(2 "Equality") c(2))
		  
		  
** Case 3
clear
set obs 5
gen x=.
replace x=3.5 in 1
replace x=8.8 in 2
replace x=14.8 in 3
replace x=23.3 in 4
replace x=49.6 in 5
inequal x


** Case 4
clear 
set obs 100

gen x1=.
replace x1=10000 in 1/90
replace x1=110000 in 91/100
inequal x1
lorenz x1

gen x2=.
replace x2=10000 in 1/50
replace x2=20000 in 51/70
replace x2=30000 in 71/90
replace x2=50000 in 91/100

inequal x2
lorenz x2

glcurve x1, pvar(p1) glvar(l1) lorenz nograph
glcurve x2, pvar(p2) glvar(l2) lorenz nograph

graph twoway (line l1 p1, sort)  ///    
           (line l2 p2, sort) ///    
          (function y = x, range(0 1)) ///    
          , aspect(1) xtitle("Cumulative population share, p") ///    
          title("Lorenz Curve Comparison") ///    
          ytitle("Cumulative proportion of income") ///    
          legend(label(1 "L1") label(2 "L2") label(3 "Equality") c(3))
		  
		  
** Example - Lorenz Curves
twoway (function y=exp(log(2)*x)-1, range(0 1)) (function y=x^2, range(0 1)) (function y=x), legend(label(1 "Country A")  label (2 "Country B") label(3 "Perfect Equality") c(3))
