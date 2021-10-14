% Askisi 4.1
 
%Symbolic calculation of propagation of error formula
fprintf("ASKISI 4.1a\n");
syms e(h1,h2)
syms uncertainty_e(h1,h2,sh1,sh2)
e(h1,h2) = sqrt(h2/h1);
dedh2 = diff(e,h2);
dedh1 = diff(e,h1);
uncertainty_e(h1,h2,sh1,sh2) = sqrt((dedh2*sh2)^2+(dedh1*sh1)^2);
uncer_e = matlabFunction(uncertainty_e);

%%
% a)
%Starting height
h1_a = 100;
%Defining the dataset
h2_a = [60,54,58,60,56];
%Expected value for the coefficient of restitution
e_real = 0.76;
%Calculating mean of e from the dataset
e_sample = sqrt(h2_a./h1_a);
e_mean = mean(e_sample);
%Calculating the acurracy(akriveia orthotitas) <x>-m
accur = abs(e_real-e_mean);
fprintf("H avevaiothta orthotitas einai %f\n",accur);
%Calculating the uncertainty for every repetition
prec = uncer_e(h1_a,mean(h2_a),0,std(h2_a));
fprintf("H avevaiothta akriveias epanalipsis einai %f\n\n",prec);


%%
% b)
fprintf("ASKISI 4.1b\n");
%Creating data from normal distribution for h2 
normmean = 58;
normstd = 2;
M = 1000;
n = 5;
data = normrnd(normmean,normstd,[n,M]);
%Calculating the mean and std of the data
mean_data = mean(data);
std_data = std(data);
%Calculating e from every simulation
e_data = sqrt(data./100);
e_mean = mean(e_data);
e_std = std(e_data);
%Making the histogram of e_data
figure;
histfit(e_mean);
xlabel("value of e");
ylabel("counts");
title("coefficient of restitution histogram");
%Calculating e for h2=58+-2
e_mb = sqrt(normmean/h1_a);
uncer_eb = uncer_e(h1_a,normmean,0,normstd);
%Hypothesis test if e_real is contained in the std ci of e_data f
h = ttest(e_mean,e_mb);
hv = vartest(e_mean,uncer_eb^2);
%Printing results
fprintf("O elegxos tis upothesis oti i timi tou e gia h2=58  einai mesa sto ci apo ta e twn prosomiosewn dinei h=%d\n",h);
fprintf("O elegxos tis upothesis oti i avevaiotita tou e gia s_h2=2 einai mesa sto ci apo ta std(e) twn prosomiosewn dinei h=%d\n\n",h);
%%
fprintf("ASKISI 4.1c\n");
%Defining the data for h1 and h2 and calculating their uncettainties
h1c = [80 100 90 120 95];
h2c = [48 60 50 75 56];
uncer_h1 = std(h1c);
uncer_h2 = std(h2c);
%Printing the uncertainties calculated before
fprintf("H avevaiothta gia ta h1 einai %f\n",uncer_h1);
fprintf("H avevaiothta gia ta h2 einai %f\n",uncer_h2);
%Calculating uncertainty of e using the law of propagation of error and
%printing the result
uncer_ec = uncer_e(mean(h1c),mean(h2c),uncer_h1,uncer_h2);
fprintf("H avevaiothta gia to e einai %f\n",uncer_ec)
%Test if ei is in the ci of e sample calculated from the data
ei = sqrt(h2c./h1c);
[he,~,ci] = ttest(ei,0.76);
fprintf("The test for the value 0.76 being the the ci given from the data gives h=%d\n",he);





