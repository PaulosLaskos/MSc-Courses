% Askisi 5.1

%Input the theoretical values
M = 1000;
n = 2;
alpha = 0.05;
meanx = 0;
meany = 0;
sigmax = 1;
sigmay = 1;
mu = [meanx,meany];
rho1 = 0;
rho2 = 0.5;
r1V = zeros(M,1);
r1Vsq = zeros(M,1);
r2V = zeros(M,1);
r2Vsq = zeros(M,1);
counter = 0;
countersq = 0;
counter2 = 0;
countersq2 = 0;
k = 0;
for j=1:2
    k = k+1;
    counter = 0;
    countersq = 0;
    counter2 = 0;
    countersq2 = 0;
    %Size of sample
    n = n*10;
    
    %Producing the data and reshaping the matrices containing the make
    %the analysis easier
    sigma1 = [sigmax^2 rho1*sigmax*sigmay;rho1*sigmax*sigmay sigmay^2];
    exp1 = mvnrnd(mu,sigma1,n*M);
    x1 = reshape(exp1(:,1),n,M);
    y1 = reshape(exp1(:,2),n,M);
    x1sq = x1.^2;
    y1sq = y1.^2;
    sigma2 = [sigmax^2 rho2*sigmax*sigmay;rho2*sigmax*sigmay sigmay^2];
    exp2 = mvnrnd(mu,sigma2,n*M);
    x2 = reshape(exp2(:,1),n,M);
    y2 = reshape(exp2(:,2),n,M);
    x2sq = x2.^2;
    y2sq = y2.^2;
    
    %In this for there is a calculation performed for the value of r from
    %every one of the 1000 samples and for both case(data genereted from
    %rho=0,rho=0.5).Plus both (x,y) and (x^2,y^2) samples are used.
    for i=1:M
        covM = cov(x1(:,i),y1(:,i));
        r1V(i,1) = covM(1,2)/sqrt(covM(1,1)*covM(2,2));
        covM = cov(x1sq(:,i),y1sq(:,i));
        r1Vsq(i,1) = covM(1,2)/sqrt(covM(1,1)*covM(2,2));
        covM = cov(x2(:,i),y2(:,i));
        r2V(i,1) = covM(1,2)/sqrt(covM(1,1)*covM(2,2));
        covM = cov(x2sq(:,i),y2sq(:,i));
        r2Vsq(i,1) = covM(1,2)/sqrt(covM(1,1)*covM(2,2));
    end
    
    z95 = norminv(1-alpha/2);
  
    z1 = 0.5*log((1+r1V)./(1-r1V));                                %(X,Y) 95% ci for rho=0
    ci_z = [z1-z95/sqrt(n-3), z1+z95/sqrt(n-3)];
    ci_rho1 = [tanh(ci_z(:,1)),tanh(ci_z(:,2))];
    
    z1sq = 0.5*log((1+r1Vsq)./(1-r1Vsq));                          %(X^2,Y^2) 95% ci for rho=0
    ci_zsq1 = [z1sq-z95/sqrt(n-3), z1sq+z95/sqrt(n-3)];             
    ci_rho1sq = [tanh(ci_zsq1(:,1)),tanh(ci_zsq1(:,2))];
    
    z2 = 0.5*log((1+r2V)./(1-r2V));                                %(X,Y) 95% ci for rho=0.5
    ci_z2 = [z2-z95/sqrt(n-3), z2+z95/sqrt(n-3)];
    ci_rho2 = [tanh(ci_z2(:,1)),tanh(ci_z2(:,2))];
    
    z2sq = 0.5*log((1+r2Vsq)./(1-r2Vsq));                          %(X^2,Y^2) 95% ci for rho=0.5
    ci_zsq2 = [z2sq-z95/sqrt(n-3), z2sq+z95/sqrt(n-3)];
    ci_rho2sq = [tanh(ci_zsq2(:,1)),tanh(ci_zsq2(:,2))];
   
    %In this for loop we count the times that rho appers in the cis
    %calculated before
    for i=1:M
        if ci_rho1(i,1)<=rho1 && rho1<=ci_rho1(i,2)
            counter = counter+1;
        end
        if ci_rho1sq(i,1)<=rho1 && rho1<=ci_rho1sq(i,2)
            countersq = countersq+1;
        end
        if ci_rho2(i,1)<=rho2 && rho2<=ci_rho2(i,2)
            counter2 = counter2+1;
        end
        if ci_rho2sq(i,1)<=rho2^2 && rho2^2<=ci_rho2sq(i,2)
            countersq2 = countersq2+1;
        end
    end
    
    %Printing the results
    fprintf("%d.Confidence interval test\n",k);
    fprintf("Size of sample n=%d.Experiment (X,Y)\n",n);
    fprintf("The probabillity of rho=0 being inside the confidence interval of each sample is:%f\n",counter/M);
    fprintf("The probabillity of rho=0.5 being inside the confidence interval of each sample is:%f\n\n",counter2/M);
    fprintf("Size of sample n=%d.Experiment (X^2,Y^2)\n",n);
    fprintf("The probabillity of rho=0 being inside the confidence interval of each sample is:%f\n",countersq/M);
    fprintf("The probabillity of rho=0.5 being inside the confidence interval of each sample is:%f\n\n\n",countersq2/M);
    pause;
    
    %Prepating for t test for null hypothesis of x,y not being correlated
    r = [r1V r1Vsq r2V r2Vsq];
    count = zeros(4,1);
    k = k+1;
    for i=1:4
        t1 = r(:,i).*sqrt((n-2)./(1.-r(:,i).^2));   %Calculation of t-statistic
        p1_values = 2*(1-tcdf(abs(t1),n-2));        %Calculation of p value
        counter = 0;                                %Setting up the counter
        for j=1:M
            if p1_values(j)>0.05                    %Checking if p value is greater than level of significance
                counter = counter+1;                %and if so increase counter by 1
            end
        end
        count(i,1) = counter;                       %Input the value of counter for the i element of r vector to another vector to save
                                                    %the result
    end
    
    %Printing the results
    fprintf("%d.t-test with p value\n",k);
    fprintf("Size of samples n=%d. Experiment (X,Y)\n",n)
    fprintf("Case 1:rho=0\n")
    fprintf("The hypothesis that there is no correlation(with significance level a=0.05) is positive for the %d of the %d samples\n",count(1,1),M);
    fprintf("Case 2:rho=0.5\n")
    fprintf("The hypothesis that there is no correlation(with significance level a=0.05) is positive for the %d of the %d samples\n\n",count(3,1),M);
    fprintf("Size of samples n=%d. Experiment (X^2,Y^2)\n",n)
    fprintf("Case 1:rho=0\n")
    fprintf("The hypothesis that there is no correlation(with significance level a=0.05) is positive for the %d of the %d samples\n",count(2,1),M);
    fprintf("Case 2:rho=0.25\n")
    fprintf("The hypothesis that there is no correlation(with significance level a=0.05) is positive for the %d of the %d samples\n\n\n",count(4,1),M);
    pause;
end
