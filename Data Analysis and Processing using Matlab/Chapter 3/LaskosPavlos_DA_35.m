% Askisi 3.5

%%
Data = importdata("eruption.dat"); %Loading the data in the code
year = [1989,1989,2006];
variation = [100,1,100];
meanV = [75,2.5,75];
dt = ["waiting","duration","waiting"];

for i=1:3
    [h,~,ci] = vartest(Data(:,i),variation(i));
    [h_m,~,ci_m] = ttest(Data(:,i),meanV(i));
    [h_nd,p] = chi2gof(Data(:,i));
    fprintf("%d %s time data\n",year(i),dt(i));
    fprintf("The confidence interval for the variance of the %s time data is [%f,%f].\n",dt(i),ci(1,1),ci(2,1));
    fprintf("The test for the null hypothesis of the standard deviation being %f gives h=%d\n",sqrt(variation(i)),h);
    fprintf("The confidence interval for the mean of the %s time data is [%f,%f].\n",dt(i),ci_m(1,1),ci_m(2,1));
    fprintf("The test for the null hypothesis of the mean being %f gives h=%d\n",meanV(i),h);
    fprintf("The chi-square goodness-of-fit for normal distribution gives h=%d and p=%f\n\n",h_nd,p)
end
%%
data_less25 = Data(Data(:,2)<2.5,1);
data_more25 = Data(Data(:,2)>2.5,1);

[h_less,p_less,ci_less] = ttest(data_less25,65);
[h_more,p_more,ci_more] = ttest(data_more25,91);

%Case 1:Duration time<2.5 
%The probabllity for the waiting time being less than 75 and more than 55 is
prop1 = length(find(data_less25<=75 & data_less25>=55))/length(data_less25);
fprintf("The probalitity of the waiting time being 55'<t<75' after and eruption lasting less than 2.5' is %f\n",prop1);

%Case 2:Duration time>2.5 
%The probabllity for the waiting time being less than 75 and more than 55 is
prop2 = length(find(data_more25<=101 & data_more25>=81))/length(data_more25);
fprintf("The probalitity of the waiting time being 81'<t<101' after and eruption lasting more than 2.5' is %f\n",prop2);
