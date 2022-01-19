use "O:\Documents\SOCIOL 213 - Data Collections and Analysis\GSS dataset.dta", clear

ssc install fre // installs the "fre" command

//IV: Education - measures SES
gen educ4=.
	replace educ4= 1 if educ<=11 //less than high school completed
	replace educ4= 2 if educ==12 // high school completed
	replace educ4= 3 if educ>=13 & educ<16 //some college
	replace educ4= 4 if educ>=16 & educ<. // college completed &+
	label def educ4 1"less hs" 2"hs" 3"some college" 4"college cpl&+" // define the categories
	label values educ4 educ4
	fre educ4
	tab educ educ4, missing  //confirming everything is OK
	
//DV: Happiness level
codebook happy
gen happiness=.
	replace happiness=1 if happy==1
	replace happiness=2 if happy==2
	replace happiness=3 if happy==3
	label def happiness 1"very happy" 2"pretty happy" 3"not too happy" // define the categories
	label values happiness happiness
	fre happiness
	tab happy happiness, m 
	
//Third variable: Marital Status - acts as control variable
codebook marital
gen married=.
	replace married=1 if marital<=4 //1 if ever been married
	replace married=0 if marital==5 //1 if never narried
	label def married  0"never married" 1"has married"
	label values married married
	fre married
	tab marital married, m
	
// restrict my sample to observations with no missing values on any of my variables (to work with same number of observations for all my analysis).
	drop if educ4==. | happiness==. | married==.
	
// Frequency distributions of my variables
	tab educ4
	tab happiness
	tab married
	
// shows the number of obs, mean, standard deviation, min, max for each variable. All variables have same number of observations
	sum educ4 happiness married
	

// CrossTtabulations
	tab happiness educ4, col chi2 //IV vs DV 
	tab educ4 married, col chi2 //IV vs Third Variable(aka control variable) 
	tab happiness married, col chi2	//DV vs Third Variable(aka control variable) 
	// Crosstasb (IV & DV) for each category of the third variable
	tab happiness educ4 if married==0, col chi2 
	tab happiness educ4 if married==1, col chi2 
		//another way for last set of crosstabs
		bysort married: tab happiness educ4, col chi2

	exit
	
	
	
	

