%Askisi 5.4

fprintf("Askisi 5.4a\n")
%importing the data
data = importdata("lightair.dat");
rho = data(:,1);    %density                                     
sol = data(:,2);    %speed of light

%plot the data to check if it is appeared to be a linear correlation
figure(1)
scatter(rho,sol);
xlabel("Density(kg/m^3)");
ylabel("Speed of light(+299000 km/sec)");
title("Variance diagram");

%calculating Pearson's correlation coefficient
r = corr(rho,sol);
fprintf("The correlation coefficient between density and speed of light equals r = %f\n\n\n",r);

%%
fprintf("Askisi 5.2b\n")
%linear regression model
a = 0.05;
mean_rho = mean(rho);
mean_sol = mean(sol);
s_rho = std(rho);
s_sol = std(sol);
Sxx = sum((rho-mean_rho).^2);
n = length(rho);

b1 = sum((rho-mean_rho).*(sol-mean_sol))/Sxx;     %b1 coefficient
b0 = (sum(sol)-b1*sum(rho))/n;                    %b0 coefficient

Se = sqrt((n-1)/(n-2)*(s_sol^2-b1^2*s_rho^2));

t = tinv(1-a/2,n-2);

%calculation of confidence intervals
ci_b1 = [b1-t*Se/sqrt(Sxx),b1+t*Se/sqrt(Sxx)];
ci_b0 = [b0-t*Se*sqrt(1/n+mean_rho^2/Sxx),b0+t*Se*sqrt(1/n+mean_rho^2/Sxx)];

fprintf("Linear regression model coeffitients\n");
fprintf("b1 = %f\n",b1);
fprintf("b0 = %f\n\n",b0);
fprintf("Parametric test\n")
fprintf("The confidence interval(level of significance 0.05) for b1 is [%f,%f]\n",ci_b1(1),ci_b1(2));
fprintf("The confidence interval(level of significance 0.05) for b0 is [%f,%f]\n\n\n",ci_b0(1),ci_b0(2));
%%
fprintf("Askisi 5.4c\n")
regress_line = @(x) b1*x+b0;
y_m_err = t*Se*sqrt(1/n+(rho-mean_rho).^2/Sxx);
y_err = t*Se*sqrt(1+1/n+(rho-mean_rho).^2/Sxx);

%plotting the regress line on the variance diagram
figure(2)
scatter(rho,sol);
xlabel("Density(kg/m^3)");
ylabel("Speed of light(+299000 km/sec)");
hold on;
fplot(regress_line,[min(rho),max(rho)]);
hold on;
errorbar(rho,regress_line(rho),y_m_err);
hold on;
errorbar(rho,regress_line(rho),y_err,"r");
title("Variance diagram and regress line");
hold off;

%confidence intervals for preidictions
rho_prediction = 1.29;
ci_mean = [regress_line(rho_prediction)-t*Se*sqrt(1/n+(rho_prediction-mean_rho)^2/Sxx),regress_line(rho_prediction)+t*Se*sqrt(1/n+(rho_prediction-mean_rho)^2/Sxx)];  
ci_fut = [regress_line(rho_prediction)-t*Se*sqrt(1+1/n+(rho_prediction-mean_rho)^2/Sxx),regress_line(rho_prediction)+t*Se*sqrt(1+1/n+(rho_prediction-mean_rho)^2/Sxx)];

%printing the results
fprintf("The prediction for the air speed of light at density rho = 1.29kg/m^3 is c_air = %f (+299000km/s)\n",regress_line(rho_prediction));
fprintf("The interval of mean prediction for rho = 1.29kg/m^3 is [%f,%f]\n",ci_mean(1),ci_mean(2));
fprintf("The interval of prediction for rho = 1.29kg/m^3 is [%f,%f]\n\n\n",ci_fut(1),ci_fut(2));
%%
fprintf("Askisi 5.4d\n");
%real relation between speed of light and air density
c0 = 299792.458;
d0 = 1.29;
c = @(d) c0*(1-0.00029*d/d0)-299000;

%real b coefficients
b0_real = c0-299000;
b1_real = -0.00029*c0/d0;

%plotting real line on the previous diagram
figure(3)
scatter(rho,sol);
xlabel("Density(kg/m^3)");
ylabel("Speed of light(+299000 km/sec)");
hold on;
fplot(regress_line,[min(rho),max(rho)]);
hold on;
fplot(c,[min(rho),max(rho)],"r");
title("Variance diagram, regress line and real curve c-d");
hold off;

fprintf("The real value for the coefficient b0 is b0 = %f\n",b0_real);
fprintf("The real value for the coefficient b1 is b1 = %f\n\n",b1_real);

%test for the real values of b being in the cis calculated in 5.4b
if ci_b0(1)<=b0_real && b0_real<=ci_b0(2)
    fprintf("Real value of b0 is in the confidence interval produced by the data\n");
else
    fprintf("Real value of b0 is not in the confidence interval produced by the data\n");
end

if ci_b1(1)<=b1_real && b1_real<=ci_b1(2)
    fprintf("Real value of b1 is in the confidence interval produced by the data\n");
else
    fprintf("Real value of b1 is not in the confidence interval produced by the data\n");
end
fprintf("\n\n");

%checking if values from real line agree with the ci from the regress line
%from the data
counter = 0;
for i=1:n
    if regress_line(rho(i))-y_m_err(i)<=c(rho(i)) && c(rho(i))<= regress_line(rho(i))+y_m_err(i)
        counter = counter+1;
    end
end

fprintf("The test for the real value of speed of light being in the ci for the mean prediction gives-->%d of %d values are inside\n\n",counter,n);






