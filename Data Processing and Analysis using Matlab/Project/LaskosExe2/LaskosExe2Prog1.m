% Project on Data Analysis Course: Covid19 
% MSc: Computationals Physics
% Course: Data Processing & Analysis using Matlab
% Author: Laskos-Patkos Pavlos, AEM: 4388

% Exercise 2: Testing the model extracted from Croatia to other European countries

%{
In this exercise we are going to see if the parametric distributions that
we found using Croatia's data are able to explain other European countries.
We will attemp to fit Generalized Extreme Value distributions to the data 
for the confirmed cases and deaths. The code will return coefficient R^2 . 
Since mse is at the scale of the frequencies it can not be used to show us 
which country is explained better by the given parametric distribution. 
For that reason the comparison is done with R^2 parameter.
%}

%{
Functions created for this exercise: 

Every function is the same as in the previous excercise except the last one

-LaskosExe2Fun1 = Given a range that contains the 1st wave calculates it's
start
-LaskosExe2Fun2 = Given a range that contains the 1st wave calculates it's
end
-LaskosExe2Fun3 = checking and correcting NaN values in the data
-LaskosExe2Fun4 = checking and correcting negative values in the data
-LaskosExe2Fun5 = Checking for zeros followed by large numbers.
-LaskosExe2Fun6 = fitting a probabillity distribution and returning values 
predicted, p value and mse 
-LaskosExe2Fun7 = creates a sample where day is the random variable and
confirmed/deaths are the counts.
-LaskosExe2Fun8 = calculates the coeffecient of determination R^2
%}

clear all;

% Loading the data
filename_confirmed = 'Covid19Confirmed.xlsx';
filename_deaths = 'Covid19Deaths.xlsx';
confirmed  = xlsread(filename_confirmed);
deaths = xlsread(filename_deaths);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                           %%%
%%%    Confirmed Infections   %%%
%%%                           %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Testing if Generalized Extreme Value distribution can explain other data for
% confirmed cases
fprintf('\n');
distname_confirmed = 'GeneralizedExtremeValue';

%Countries we are testing
countries = {'Germany','Belgium','France','Spain','Switzerland','Norway','Netherlands','Finland','Austria','Italy'};
idx_of_country = [52,13,48,130,134,103,97,47,8,67];
n = length(countries);
start_of_january = 2;
end_of_june = 191;


%Starting the calculations
Rsquared_confirmed = zeros(1,n);
figure(1)
clf;
for i=1:n
    fprintf('.');
    confirmed_i = confirmed(idx_of_country(i),start_of_january:end_of_june);
    %Checking for NaNs and negative values to fix the data
    confirmed_i = LaskosExe2Fun3(confirmed_i);
    confirmed_i = LaskosExe2Fun4(confirmed_i);
    
    
    %Finding the start and the end of the 1st wave
    start_confirmed = LaskosExe2Fun1(confirmed_i);
    stop_confirmed = LaskosExe2Fun2(confirmed_i);
    
    %Days of the first wave
    days = linspace(1,stop_confirmed-start_confirmed+1,stop_confirmed-start_confirmed+1);
    
    %Data for confirmed infection in the country i
    confirmed_cases = confirmed_i(start_confirmed:stop_confirmed);
    confirmed_cases = LaskosExe2Fun5(confirmed_cases);
    
    %Transforming the data: days is the random variable and the data how many
    %times it appears in the sample.
    hist_confirmed = LaskosExe2Fun7(days,confirmed_cases);
    
    %Fitting the distribution and calculating the parameter R^2
    c = sum(confirmed_cases);
    [pdf,~,~] = LaskosExe2Fun6(days,confirmed_cases,hist_confirmed,distname_confirmed);
    Rsquared_confirmed(i) = LaskosExe2Fun8(confirmed_cases/c,pdf);

    
    %Plotting the data and the fitted probabillity distribution
    subplot(2,5,i)
    hist(hist_confirmed,length(hist_confirmed));
    hold on;
    plot(days,pdf*c,'r','LineWidth',2.5);
    xlabel('Day');
    ylabel('Confirmed Infections')
    title(sprintf('%s',cell2mat(countries(i))));
    hold off;
end

fprintf('\n')
%Checking the values that R^2 takes in order to print the results
confirmed_test1 = length(find(Rsquared_confirmed>0.7 & Rsquared_confirmed<0.8));
confirmed_test2 = length(find(Rsquared_confirmed>0.8 & Rsquared_confirmed<0.9));
confirmed_test3 = length(find(Rsquared_confirmed>0.9));
[mac,idxc] = max(Rsquared_confirmed);
[~,sort_idxc] = sort(Rsquared_confirmed);
sorted_countriesc = fliplr(countries(sort_idxc));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                        %%%
%%%    Confirmed Deaths    %%%
%%%                        %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Testing if Generalized Extreme Value distribution can explain other data for
% deaths due to covid19
distname_deaths = 'GeneralizedExtremeValue';


%Starting the calculations
Rsquared_deaths = zeros(1,n);
figure(2)
clf;
for i=1:n
    fprintf('.');
    deaths_i = deaths(idx_of_country(i),start_of_january:end_of_june);
    %Checking for NaNs and negative values to fix the data
    deaths_i = LaskosExe2Fun4(LaskosExe2Fun3(deaths_i));
    
    start_deaths = LaskosExe2Fun1(deaths_i);
    stop_deaths = LaskosExe2Fun2(deaths_i);
    
    %Days of the first wave
    days = linspace(1,stop_deaths-start_deaths+1,stop_deaths-start_deaths+1);
    
    %Data for confirmed infection in the country i
    deaths_cases = deaths_i(start_deaths:stop_deaths);
    
    %Transforming the data: days is the random var and the data how many
    %times it appears in the sample.
    hist_deaths = LaskosExe2Fun7(days,deaths_cases);
    
    %Fitting the distribution and calculating the parameters
    c = sum(deaths_cases);
    [pdf,~,~] = LaskosExe2Fun6(days,deaths_cases,hist_deaths,distname_deaths);
    Rsquared_deaths(i) = LaskosExe2Fun8(deaths_cases/c,pdf);

    %Printing and plotting the results
    subplot(2,5,i)
    hist(hist_deaths,length(hist_deaths));
    hold on;
    plot(days,pdf*c,'r','LineWidth',2.5);
    xlabel('Day');
    ylabel('Confirmed Deaths')
    title(sprintf('%s',cell2mat(countries(i))));
    hold off;
end

fprintf('\n');
%Checking the values that R^2 takes in order to print the results
deaths_test1 = length(find(Rsquared_deaths>0.7 & Rsquared_deaths<0.8));
deaths_test2 = length(find(Rsquared_deaths>0.8 & Rsquared_deaths<0.9));
deaths_test3 = length(find(Rsquared_deaths>0.9));
[mad,idxd] = max(Rsquared_deaths); 
[~,sort_idxd] = sort(Rsquared_deaths);
sorted_countriesd = fliplr(countries(sort_idxd));

%Printing the final results
fprintf('-----------------------------------------------------------------------------------------------------------------------\n');
fprintf('The test for the Generalized Extreme Value fit on the data for the confirmed infections of covid19 gave:\n');
fprintf('%d out of %d countries have 0.7 < R^2 < 0.8\n',confirmed_test1,n);
fprintf('%d out of %d countries have 0.8 < R^2 < 0.9\n',confirmed_test2,n);
fprintf('%d out of %d countries have  R^2 > 0.9\n',confirmed_test3,n);
fprintf('Best fit: %s with R^2 = %f\n',cell2mat(countries(idxc)),mac);
fprintf('Classification based on the goodness of fit\n');
for i=1:n
    fprintf('%d. %s   ',i,cell2mat(sorted_countriesc(i)));
end
fprintf('\n')
fprintf('-----------------------------------------------------------------------------------------------------------------------\n\n');

fprintf('-----------------------------------------------------------------------------------------------------------------------\n');
fprintf('The test for the Generalized Extreme Value fit on the data for the deaths due to covid19 gave:\n');
fprintf('%d out of %d countries have 0.7 < R^2 < 0.8\n',deaths_test1,n);
fprintf('%d out of %d countries have 0.8 < R^2 < 0.9\n',deaths_test2,n);
fprintf('%d out of %d countries have  R^2 > 0.9\n',deaths_test3,n);
fprintf('Best fit: %s with R^2 = %f\n',cell2mat(countries(idxd)),mad);
fprintf('Classification based on the goodness of fit\n');
for i=1:n
    fprintf('%d. %s   ',i,cell2mat(sorted_countriesd(i)));
end
fprintf('\n')
fprintf('----------------------------------------------------------------------------------------------------------------------\n\n');
fprintf('waiting for the diagrams...\n\n')



%{
Conclusions
From the above analysis we might say that the distributions found in the
previous step using Croatia seem to explain in a good way the data from
other countries of Europe. 

1. Confirmed Cases
For the part of confirmed cases Generalized Extreme Value 
distribution seems to fit very well. Specifically 2/10 countries give an
R^2 value greater than 0.9 with Italy showing the best
agreement(R^2=0.94). In total 8 countries give R^2 value greater than
0.7.

2. Deaths
In this case the fitting was worse than before since only 2 countries had
R^2>0.9. Although the fitting still shows good agreemnent for 5 out of 10
countries(R^2>0.8). The best fit occured in Belgium with an incredibly
large number for the coefficient of determination R^2=0.98.

The goodness of fit can also be seen in a lot of countries from the diagrams
created.
Since the counts for both deaths and confirmed cases were very high p value
test showed no significant results.
%}