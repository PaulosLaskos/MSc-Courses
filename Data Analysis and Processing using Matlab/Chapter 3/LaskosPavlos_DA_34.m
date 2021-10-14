% Askisi 3.4

%%
Data = [41,46,47,47,48,50,50,50,50,50,50,50,48,50,50,50,50,50,50,50,52,52,53,55,50,50,50,50,52,52,53,53,53,53,53,57,52,52,53,53,53,53,53,53,54,54,55,68];

%Finding the confidence 95% interval for the variance of the sample
var_check = 25; %ó^2=var
[h_std,~,ci_std] = vartest(Data,var_check); %+Checking if var = 25 is included in the ci
fprintf("The test for the null hypothesis about standard deviaton being 5,gives h=%d\n",h_std);
fprintf("The confidence interval for the variance is [%f,%f]\n\n",ci_std(1,1),ci_std(1,2))
%%
%Finding the 95% confidence interval for the mean value of the sample
mean_check = 52;
[h_mean,~,ci_mean] = ttest(Data,mean_check); %+Checking if mean = 52 is included in the ci
fprintf("The test for the null hypothesis gives h=%d\n",h_mean);
fprintf("The confidence interval for the variance is [%f,%f]\n\n",ci_mean(1,1),ci_mean(1,2))
%%
%Performing a chi-square goodness-of-fit test for normal distribution
[h_x,p] = chi2gof(Data);
fprintf("The chi-square goodness-of-fit for normal distribution gives h=%d and p=%f\n\n",h_x,p)
%%