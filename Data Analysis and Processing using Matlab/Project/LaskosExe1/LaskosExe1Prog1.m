% Project on Data Analysis Course: Covid19 
% MSc: Computationals Physics
% Course: Data Processing & Analysis using Matlab
% Author: Laskos-Patkos Pavlos, AEM: 4388

% Exercise 1: Fitting a probabillity density function to the data


%The country that I was given by the algorithm was Croatia. 
%{
Functions created for this exercise: 
-LaskosExe1Fun1 = Given a range that contains the 1st wave calculates it's
start
-LaskosExe1Fun2 = Given a range that contains the 1st wave calculates it's
end
-LaskosExe1Fun3 = checking and correcting NaN values in the data
-LaskosExe1Fun4 = checking and correcting negative values in the data
-LaskosExe1Fun5 = Chcecking for zeros followed by large numbers.
-LaskosExe1Fun6 = fitting a probabillity distribution and returning values 
predicted, p value and mse 
-LaskosExe1Fun7 = creates a sample where day is the random variable and
confirmed/deaths are the counts.                                    
%}

clear all;

% Loading the data
filename_confirmed = 'Covid19Confirmed.xlsx';
filename_deaths = 'Covid19Deaths.xlsx';
confirmed  = xlsread(filename_confirmed);
deaths = xlsread(filename_deaths);

%Croatia index in the data
croatia = 33;

% Defining the start and end for the first wave for confirmed cases and deaths.
%{
By observing the evolution of covid 19 in croatia(worldmeter) we attempt to find the
start and stop of the 1st wave from the 1st of junaruary until the end of
june. This is because after june we observe the start of the 2nd wave.
The start and end of the 1st wave are calculated by the functions
LaskosExe1Fun1 and LaskosExe1Fun2. Note that in order for the functions to
work properly the range we are giving for the search must not have a value
of the 2nd wave that is larger than max value of the 1st wave(and in order not
to miss information we should give the widest range that contains the 1st wave and 
not the 2nd). 
%}

%Largest range that contains the 1st wave and not the 2nd
start_of_january = 2;
end_of_june = 191;

%Testing for NaNs and negative values
croatia_confirmed = LaskosExe1Fun4(LaskosExe1Fun3(confirmed(croatia,start_of_january:end_of_june)));
croatia_deaths = LaskosExe1Fun4(LaskosExe1Fun3(deaths(croatia,start_of_january:end_of_june)));

%Obtaining the start and the end of the first wave
start_confirmed = LaskosExe1Fun1(croatia_confirmed);
stop_confirmed = LaskosExe1Fun2(croatia_confirmed);
start_deaths = LaskosExe1Fun1(croatia_deaths);
stop_deaths = LaskosExe1Fun2(croatia_deaths);


%First wave data of covid19 in Croatia
days_confirmed = linspace(1,stop_confirmed-start_confirmed+1,stop_confirmed-start_confirmed+1);
days_deaths = linspace(1,stop_deaths-start_deaths+1,stop_deaths-start_deaths+1);
croatia_confirmed = croatia_confirmed(start_confirmed:stop_confirmed);
croatia_deaths = croatia_deaths(start_deaths:stop_deaths);

%Correcting the data
%{
We need to correct the data at this point. Because of less tests many 
times there are zero confirmed infections reported during the weekend and
a very large number on Monday. For this reason below we divide the
confirmed infections in Monday and place them in Saturday,Sunday and
Monday. For this reason we created the function LaskosExe1Fun5.
%}
croatia_confirmed = LaskosExe1Fun5(croatia_confirmed);

%{
Since the deaths reported each day are not dependend on parameters like
number of tests etc. we won't use the previous function on deaths
%}


%{
The next step is needed in order to use the function chi2gof later.
Transforming the data so that they can be used to form a histogram.
In other words we create a sample in which the random variable is the day and
it's frequency is the cases/deaths.
%}
hist_confirmed = LaskosExe1Fun7(days_confirmed,croatia_confirmed);
hist_deaths = LaskosExe1Fun7(days_deaths,croatia_deaths);


%Normalization parameters for later graphic comparison with the fitted distribution
c_confirmed = sum(croatia_confirmed);
c_deaths = sum(croatia_deaths);

%List of distributions that are going to be tested
dist = {'Normal','Loglogistic','Gamma','GeneralizedExtremeValue','InverseGaussian'};
num_of_dists = length(dist);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                           %%%
%%%    Confirmed Infections   %%%
%%%                           %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mse_confirmed = zeros(1,num_of_dists);                %Mean Squared Error
p_confirmed = zeros(1,num_of_dists);                  %p value
pdfs_confirmed = zeros(num_of_dists,length(days_confirmed));    %Predictions of the fitted probabillity density function 

%Testing each distribution using the function created: LaskosExe1Fun6
for i=1:num_of_dists
    [pdfs_confirmed(i,:),p_confirmed(i),mse_confirmed(i)] = LaskosExe1Fun6(days_confirmed,croatia_confirmed,hist_confirmed,cell2mat(dist(i)));
end
%Finding the index of the minimum value in the Mean Squared Error list
[m_confirmed,idx_confirmed] = min(mse_confirmed);
%Printing the results
fprintf('\n');
fprintf('------------------------------------------------------------------------------------------------------------------------\n');
fprintf('Confirmed Infections of Covid19 in the first wave\n');
fprintf('The parametric distributions that fits better to the data for the confirmed cases of Covid19 is %s\n',cell2mat(dist(idx_confirmed)));
fprintf('Mean Squared Error = %.10f\n',m_confirmed);
%Note that due to very high frequency the p value might appear very small
fprintf('p value  = %g\n',p_confirmed(idx_confirmed));
fprintf('------------------------------------------------------------------------------------------------------------------------\n\n');

%Plotting the best fit and the data.
figure(1)
clf;
hist(hist_confirmed,c_confirmed);
hold on;
plot(days_confirmed,c_confirmed*pdfs_confirmed(idx_confirmed,:),'r','LineWidth',2.5);
xlabel('Number of Day');
ylabel('Confirmed Infections');
legend('Data',sprintf('%s',cell2mat(dist(idx_confirmed))));
title('Confirmed infections in Croatia due to Covid19 and parametric fitting')
hold off;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                        %%%
%%%    Confirmed Deaths    %%%
%%%                        %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mse_deaths = zeros(1,num_of_dists);                     %Mean Squared Error
p_deaths = zeros(1,num_of_dists);                       %p value
pdfs_deaths = zeros(num_of_dists,length(days_deaths));  %Predictions of the fitted probabillity density function 

%Testing each distribution using the function created: LaskosExe1Fun6
for i=1:num_of_dists
    [pdfs_deaths(i,:),p_deaths(i),mse_deaths(i)] = LaskosExe1Fun6(days_deaths,croatia_deaths,hist_deaths,cell2mat(dist(i)));
end
%Finding the index of the minimum value in the Mean Squared Error list
[m_deaths,idx_deaths] = min(mse_deaths);
p_test = max(p_deaths);
%Printing the results
fprintf('------------------------------------------------------------------------------------------------------------------------\n');
fprintf('Confirmed Deaths of Covid19 in the first wave\n');
fprintf('The parametric distributions that fits better to the data for the deaths due to Covid19 is %s\n',cell2mat(dist(idx_deaths)));
fprintf('Mean Squared Error = %.10f\n',m_deaths);
%Note that due to very high frequency the p value might appear very small
fprintf('p value  = %f\n',p_deaths(idx_deaths));
if p_test == p_deaths(idx_deaths) &&  p_deaths(idx_deaths)>0.05
    fprintf('p value test and mse test agree\n');
end
fprintf('------------------------------------------------------------------------------------------------------------------------\n\n');

%Plotting the best fit and the data.
figure(2)
clf;
hist(hist_deaths,c_deaths);
hold on;
plot(days_deaths,c_deaths*pdfs_deaths(idx_deaths,:),'r','LineWidth',2.5);
legend('Data',sprintf("%s",cell2mat(dist(idx_deaths))));
xlabel('Number of Day');
ylabel('Confirmed Deaths');
title('Confirmed Deaths in Croatia due to Covid19 and parametric fitting')
hold off;

%Conclusions
%{
By using the code we find two important results:
- The parametric distribution that explains better the data for the
confirmed cases of covid19 is the GeneralizedExtremeValue.
- The parametric distribution that explains better the data for the deaths
due to covid19 is also the Generalized Extreme Value.
Due to the high frequency of confirmed cases the p value test gives very low
values so the results for the best fitting are extracted using mean squared
error. 
On the other hand the p value test for the deaths' data confirm the null
hypothesis(result: p=0.36). Also the mean squared error agrees with the results of p value
test for the distribution that explains better the data.
%}