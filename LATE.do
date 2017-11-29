* Stata exercise from the lecture note by Måns Söderbom

*****************************************
** 1. Codes for Simulating LATE in Stata
*****************************************

clear
set seed 54687
set obs 20000

/* first, randomly assign the instrument - say half-half */
gen z = uniform()>.5

/* then, generate never-takers (d00), always-takers (d11) and compliers (d01), independent of z */
gen d00=(_n<=5000)
gen d11=(_n>5000 & _n<=10000)
gen d01=(_n>10000)

/* observed outcomes: always zero for never-takers, always one for always-takers, depends on the IV for compliers */
gen D=d11+z*d01

/* now give the three groups different LATE. Without loss of generality, assume within group homogeneity. */
gen late=-1 if d00==1
replace late=0 if d11==1
replace late=1 if d01==1

/* next generate potential outcomes y0,y1 */
gen y0=0.25*invnorm(uniform())
gen y1=y0+late

/* actual outcome depends on treatment status */
gen y = D*y1+(1-D)*y0

/* the average treatment effect is simply the sample mean of late */
sum late

/* OLS doesn't give you ATE or LATE */
reg y D

/* IV gives you the LATE for the compliers */
ivreg y (D=z)




*******************
** 2. Stata Results
*******************

. /* the average treatment effect is simply the sample mean of late */
. sum late

    Variable |       Obs        Mean    Std. Dev.       Min        Max
-------------+--------------------------------------------------------
        late |     20000         .25    .8291769         -1          1

. 
. /* OLS doesn't give you ATE or LATE */
. reg y D

      Source |       SS       df       MS              Number of obs =   20000
-------------+------------------------------           F(  1, 19998) = 6631.34
       Model |  1246.68658     1  1246.68658           Prob > F      =  0.0000
    Residual |  3759.60651 19998  .187999125           R-squared     =  0.2490
-------------+------------------------------           Adj R-squared =  0.2490
       Total |  5006.29309 19999  .250327171           Root MSE      =  .43359

------------------------------------------------------------------------------
           y |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
           D |   .4993491    .006132    81.43   0.000     .4873298    .5113684
       _cons |   .0005316   .0043511     0.12   0.903     -.007997    .0090602
------------------------------------------------------------------------------

. 
. /* IV gives you the LATE for the compliers */
. ivreg y (D=z)

Instrumental variables (2SLS) regression

      Source |       SS       df       MS              Number of obs =   20000
-------------+------------------------------           F(  1, 19998) = 5048.40
       Model | -86.6843722     1 -86.6843722           Prob > F      =  0.0000
    Residual |  5092.97746 19998   .25467434           R-squared     =       .
-------------+------------------------------           Adj R-squared =       .
       Total |  5006.29309 19999  .250327171           Root MSE      =  .50465

------------------------------------------------------------------------------
           y |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
           D |   1.015767   .0142961    71.05   0.000     .9877453    1.043788
       _cons |  -.2594847   .0080341   -32.30   0.000    -.2752322   -.2437373
------------------------------------------------------------------------------
Instrumented:  D
Instruments:   z


* Recall: Treatment effect is 1.0 for the compliers, 0.0 for the always-takers and -1.0 for
the never-takers.
