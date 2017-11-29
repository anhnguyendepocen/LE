* Stata exercise from the lecture note by Måns Söderbom

* 1. Simulating LATE in Stata

clear
set seed 54687
set obs 20000

/* first, randomly assign the instrument - say half-half */
ge z = uniform()>.5

/* then, generate never-takers (d00), always-takers (d11) and compliers (d01), independent of z */
ge d00=(_n<=5000)
ge d11=(_n>5000 & _n<=10000)
ge d01=(_n>10000)

/* observed outcomes: always zero for never-takers, always one for
always-takers, depends on the IV for compliers */
ge D=d11+z*d01

/* now give the three groups different LATE. Without loss of generality, assume within group homogeneity. */
ge late=-1 if d00==1
replace late=0 if d11==1
replace late=1 if d01==1

/* next generate potential outcomes y0,y1 */
ge y0=0.25*invnorm(uniform())
ge y1=y0+late

/* actual outcome depends on treatment status */
ge y = D*y1+(1-D)*y0

/* the average treatment effect is simply the sample mean of late */
sum late

/* OLS doesn't give you ATE or LATE */
reg y D

/* IV gives you the LATE for the compliers */
ivreg y (D=z)
