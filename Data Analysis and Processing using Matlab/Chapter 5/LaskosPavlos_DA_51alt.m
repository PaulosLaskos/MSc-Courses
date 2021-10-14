% Askisi 5.1
tic
%Input the theoretical values
M = 1000;
n = 20;
alpha = 0.05;
meanx = 0;
meany = 0;
sigmax = 1;
sigmay = 1;
mu = [meanx,meany];

fprintf("Askisi 5.1a\n");
%Case 1:rho=0
fprintf("Case 1:rho=0\n")
rho1 = 0;
sigma1 = [sigmax^2 rho1*sigmax*sigmay;rho1*sigmax*sigmay sigmay^2];
exp1 = mvnrnd(mu,sigma1,n*M);

x1 = reshape(exp1(:,1),n,M);
y1 = reshape(exp1(:,2),n,M);

r1V = zeros(M,1);

for i=1:M
    covM = cov(x1(:,i),y1(:,i));
    r1V(i,1) = covM(1,2)/sqrt(covM(1,1)*covM(2,2));
end

z = 0.5*log((1+r1V)./(1-r1V));
z95 = norminv(1-alpha/2);
ci_z = [z-z95/sqrt(n-3), z+z95/sqrt(n-3)];
ci_rho = [tanh(ci_z(:,1)),tanh(ci_z(:,2))];

counter = 0; 
for i=1:M
    if ci_rho(i,1)<=rho1 && rho1<=ci_rho(i,2)
        counter = counter+1;
    end
end
p = counter/M;
fprintf("The probabillity of rho=0 being inside the confidence interval of each sample is:%f\n",p);

%%
%Case 2:rho=0.5
fprintf("Case 2:rho=0.5\n")
rho2 = 0.5;
sigma2 = [sigmax^2 rho2*sigmax*sigmay;rho2*sigmax*sigmay sigmay^2];
exp2 = mvnrnd(mu,sigma2,n*M);
x2 = reshape(exp2(:,1),n,M);
y2 = reshape(exp2(:,2),n,M);

x2 = reshape(exp2(:,1),n,M);
y2 = reshape(exp2(:,2),n,M);

r2V = zeros(M,1);

for i=1:M
    covM = cov(x2(:,i),y2(:,i));
    r2V(i,1) = covM(1,2)/sqrt(covM(1,1)*covM(2,2));
end

z2 = 0.5*log((1+r2V)./(1-r2V));
z95 = norminv(1-alpha/2);
ci_z2 = [z2-z95/sqrt(n-3), z2+z95/sqrt(n-3)];
ci_rho2 = [tanh(ci_z2(:,1)),tanh(ci_z2(:,2))];

counter = 0; 
for i=1:M
    if ci_rho2(i,1)<=rho2 && rho2<=ci_rho2(i,2)
        counter = counter+1;
    end
end
p = counter/M;
fprintf("The probabillity of rho=0.5 being inside the confidence interval of each sample is:%f\n\n\n",p);
%%

fprintf("Askisi 5.1b\n")
fprintf("Case 1:rho=0\n")
t1 = r1V.*sqrt((n-2)./(1.-r1V.^2));
p1_values = 2*(1-tcdf(abs(t1),n-2));
counter = 0;
for i=1:M
    if p1_values(i)>0.05
        counter = counter+1;
    end
end
fprintf("The hypothesis that there is no correlation(with significance level a=0.05) is positive for the %d of the %d samples\n",counter,M);

fprintf("Case 2:rho=0.5\n");
t1 = r2V.*sqrt((n-2)./(1.-r2V.^2));
p1_values = 2*(1-tcdf(abs(t1),n-2));
counter = 0;
for i=1:M
    if p1_values(i)>0.05
        counter = counter+1;
    end
end
fprintf("The hypothesis that there is no correlation(with significance level a=0.05) is positive for the %d of the %d samples\n\n\n",counter,M);
%%

fprintf("Askisi 5.1c\n")
n = 200;

%Case 1:rho=0
fprintf("!!!! CONFIDENCE INTERVAL TEST !!!!\n")
fprintf("Case 1:rho=0\n")
rho1 = 0;
sigma1 = [sigmax^2 rho1*sigmax*sigmay;rho1*sigmax*sigmay sigmay^2];
exp1 = mvnrnd(mu,sigma1,n*M);

x1 = reshape(exp1(:,1),n,M);
y1 = reshape(exp1(:,2),n,M);

r1V = zeros(M,1);

for i=1:M
    covM = cov(x1(:,i),y1(:,i));
    r1V(i,1) = covM(1,2)/sqrt(covM(1,1)*covM(2,2));
end

z = 0.5*log((1+r1V)./(1-r1V));
z95 = norminv(1-alpha/2);
ci_z = [z-z95/sqrt(n-3), z+z95/sqrt(n-3)];
ci_rho = [tanh(ci_z(:,1)),tanh(ci_z(:,2))];

counter = 0; 
for i=1:M
    if ci_rho(i,1)<=rho1 && rho1<=ci_rho(i,2)
        counter = counter+1;
    end
end
p = counter/M;
fprintf("The probabillity of rho=0 being inside the confidence interval of each sample is:%f\n",p);


%Case 2:rho=0.5
fprintf("Case 2:rho=0.5\n")
rho2 = 0.5;
sigma2 = [sigmax^2 rho2*sigmax*sigmay;rho2*sigmax*sigmay sigmay^2];
exp2 = mvnrnd(mu,sigma2,n*M);
x2 = reshape(exp2(:,1),n,M);
y2 = reshape(exp2(:,2),n,M);

x2 = reshape(exp2(:,1),n,M);
y2 = reshape(exp2(:,2),n,M);

r2V = zeros(M,1);

for i=1:M
    covM = cov(x2(:,i),y2(:,i));
    r2V(i,1) = covM(1,2)/sqrt(covM(1,1)*covM(2,2));
end

z2 = 0.5*log((1+r2V)./(1-r2V));
z95 = norminv(1-alpha/2);
ci_z2 = [z2-z95/sqrt(n-3), z2+z95/sqrt(n-3)];
ci_rho2 = [tanh(ci_z2(:,1)),tanh(ci_z2(:,2))];

counter = 0; 
for i=1:M
    if ci_rho2(i,1)<=rho2 && rho2<=ci_rho2(i,2)
        counter = counter+1;
    end
end
p = counter/M;
fprintf("The probabillity of rho=0.5 being inside the confidence interval of each sample is:%f\n\n\n",p);


fprintf("!!!! P VALUE TEST !!!!\n")
fprintf("Case 1:rho=0\n")
t1 = r1V.*sqrt((n-2)./(1.-r1V.^2));
p1_values = 2*(1-tcdf(abs(t1),n-2));
counter = 0;
for i=1:M
    if p1_values(i)>0.05
        counter = counter+1;
    end
end
fprintf("The hypothesis that there is no correlation(with significance level a=0.05) is positive for the %d of the %d samples\n",counter,M);

fprintf("Case 2:rho=0.5\n");
t1 = r2V.*sqrt((n-2)./(1.-r2V.^2));
p1_values = 2*(1-tcdf(abs(t1),n-2));
counter = 0;
for i=1:M
    if p1_values(i)>0.05
        counter = counter+1;
    end
end
fprintf("The hypothesis that there is no correlation(with significance level a=0.05) is positive for the %d of the %d samples\n\n\n",counter,M);

toc













