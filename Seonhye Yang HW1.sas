data heart;
infile '/folders/myshortcuts/myfolder/heart.dat';
input age sex type restingbp serumchol over120 restingecg
maxheartrate exang oldpeak slope majvessels thal presence;
keep restingbp serumchol maxheartrate presence;
data heartred;
set heart;
where serumchol<400;
run;

ods select BasicMeasures;
proc univariate data=heart;
var restingbp;
title 'Resting BP Statistics';
run;
ods select BasicMeasures;
proc univariate data=heart;
var serumchol;
title 'Serum Cholestrol Statistics';
run;
ods select BasicMeasures;
proc univariate data=heart;
var maxheartrate;
title 'Max Heart Rate Statistics';
footnote 'We can see from these results that resting heart rate averages around 130 with a  standard deviation of around 18. This is quite high relative to healthy people. Our serum cholestrol also centers around 245 (for both mean and median). Finally, our max heart rate has a mean of 149, with 23 bpm of deviation.';
run;


ods select BasicMeasures;
proc univariate data=heart;
class presence;
var restingbp;
title 'Resting BP Statistics with Presence';
run;
ods select BasicMeasures;
proc univariate data=heart;
class presence;
var serumchol;
title 'Serum Cholestrol Statistics with Presence';
run;
ods select BasicMeasures;
proc univariate data=heart;
class presence;
var maxheartrate;
title 'Max Heart Rate Statistics with Presence';
footnote 'The story changes when we group by presence. Here we can see that there are two groups of resting heart rates: A group with 128 BPM and a group with 134 BPM, with presence 1 and 2 respectively. The same happens with serum cholestrol, where the gap is even wider with means of 244 and 256 respectively. Finally, with maxheartrate, we see that group 1 has a higher mean of 158 vs 138 of group 2. Surprising because group 1 usually showed lower values.';
run;

proc univariate data=heart;
var serumchol;
title 'Serum Cholestrol Statistics Full';
histogram;
footnote 'In the first histogram, we can see that we have obtained a fairly normal result. This can be confirmed quantitatively by looking at quartile distribution. We can see that one standard deviation of the data from either side of the mean covers 80% of the population. This is not as close to the near 70% that we would like for a true normal distribution, but it evenly spread.';
run;

proc univariate data=heart;
class presence;
var serumchol;
title 'Serum Cholestrol Statistics Full With Presence';
histogram;
footnote 'When we group by presence, we can now see that the normalness has gone, both visually and quantatively. However, we can see that group 1 is much more left skewed over group 2, which still has some normality.';
run;

proc ttest h0=200 alpha=0.05 data=heart;
var serumchol;
footnote 'We can see from the T Test results that our median is significantly higher from 200 due to our p value being less than 0.05.';
run;

proc ttest h0=200 alpha=0.05 data=heart;
class presence;
var serumchol;
footnote 'Here, we have the same results, where for both presences, we can see that the mean is significantly higher than 200 with p value less than 0.05';
run;

proc corr data=heart;
var restingbp serumchol maxheartrate;
footnote 'We see that thre results here are mostly unremarkable, with the only real interesting point being that heart rate and max heart rate have basically no correlation';
run;

proc sort data=heart out=heart;
by presence;
run;

proc corr data=heart;
var restingbp serumchol maxheartrate;
by presence;
footnote 'Here the results become more interesting. We can see that the correlation between resting heart rate and serum cholestrol significantly differ between presence groups. The rest of the data is relatively the same, indicating nearly no corrleation between variables.';
run;