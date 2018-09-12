cd "D:\1 SKKU 강의\1 SKKU_학부_Labor\Stata_Session\reg_mean_example"
cd "D:\Google Drive\LaborEcon_2016S\Stata\reg_mean_example"

clear
insheet using reg_mean_example.csv

** Test Score Mean by Groups
mean score, over(boy grade)


** By Gender
bys boy: su score
ttest score, by(boy)
reg score boy


** By Senior Status
bys grade: su score
ttest score, by(grade)
reg score grade
gen d_senior=grade==3
reg score d_senior


** Interaction Term
gen d_seniorXboy=d_senior*boy
reg score d_senior boy d_seniorXboy

replace score=score+2 if boy==0 & grade==3
reg score d_senior boy d_seniorXboy
su score if boy==0 & d_senior==0