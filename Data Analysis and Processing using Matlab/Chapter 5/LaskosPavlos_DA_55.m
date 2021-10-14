%Askisi 5.5

%importing the data
data = importdata("lightair.dat");

rho = data(:,1);            %density                                     
sol = data(:,2);            %speed of light
n = length(rho);            %number of data points
a = 0.05;                   %level of significance
M = 1000;                   %number of random repetitions

%indexes
idx1 = round(M*a/2);        
idx2 = round(M*(1-a/2));

%vectors that are going to  be filled with b values
b1V = zeros(1,M);
b0V = zeros(1,M);

for i=1:M
    idx = unidrnd(n,n,1);                                                                        %random indexes
    rho_new = rho(idx);                                                                          
    sol_new = sol(idx);
    mean_rho_new = mean(rho_new);
    mean_sol_new = mean(sol_new);
    b1 = sum((rho_new-mean_rho_new).*(sol_new-mean_sol_new))/sum((rho_new-mean_rho_new).^2);     %b1 coefficient
    b0 = (sum(sol)-b1*sum(rho_new))/n;                                                           %b0 coefficient
    b1V(i) = b1;
    b0V(i) = b0;
end

b1sort = sort(b1V);
b0sort = sort(b0V);
ci_b1 = [b1sort(idx1),b1sort(idx2)];
ci_b0 = [b0sort(idx1),b0sort(idx2)];

fprintf("No parametric test\n");
fprintf("The confidence interval(level of significance 0.05) for b1 is [%f,%f]\n",ci_b1(1),ci_b1(2));
fprintf("The confidence interval(level of significance 0.05) for b0 is [%f,%f]\n",ci_b0(1),ci_b0(2));
    