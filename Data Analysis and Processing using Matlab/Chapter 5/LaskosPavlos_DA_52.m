% Askisi 5.2

%Theoretical values
%Number of samples
M = 1000;
%Number of random permutations
L = 1000;
%Size of
n = 20;
%Level of significance,mean values and standard deviations
alpha = 0.05;
meanx = 0;
meany = 0;
sigmax = 1;
sigmay = 1;
mu = [meanx,meany];

for j=1:2
    
    %%%% Case 1 theoretical rho=0: NO CORRELATION %%%%
    rho1 = 0;
    %Covariance matrix
    sigma1 = [sigmax^2 rho1*sigmax*sigmay;rho1*sigmax*sigmay sigmay^2];
    %Using a techniche to achieve vectorization
    %We do an experiment of M*n pairs of x,y and then we reshape the matrices
    exp1 = mvnrnd(mu,sigma1,M*n);
    x1 = reshape(exp1(:,1),n,M).^j;
    y1 = reshape(exp1(:,2),n,M).^j;
    
    %%%% Case 2 theoretical rho=0.5 %%%%
    %we work simillarly to the first case
    rho2 = 0.5;
    sigma2 = [sigmax^2 rho2*sigmax*sigmay;rho2*sigmax*sigmay sigmay^2];
    exp2 = mvnrnd(mu,sigma2,M*n);
    x2 = reshape(exp2(:,1),n,M).^j;
    y2 = reshape(exp2(:,2),n,M).^j;
    
    %Setting up the counters
    counter = 0;
    counter2 = 0;
    
    %Indexes for no parametric test
    idx1 = round(L*alpha/2);
    idx2 = round(L*(1-alpha/2));
    
    %Vectors that contain the standard deviarion of every y sample
    stdy1 = std(y1);
    stdy2 = std(y2);
    
    %Creating two LxM matrices to get filled from the t values of each case
    t = zeros(L,M);
    t2 = zeros(L,M);
    
    %Starting the loop
    for i=1:L
        ran = randperm(size(x1,1));                                  %Creating a vector of length n with elements 1:n randomly placed
        x = x1(ran,:);                                               %Reshaping in random way the rows of x1 matrix
        r = (sum(x.*y1)-n*mean(x).*mean(y1))./(std(x).*stdy1)/(n-1); %Calculating r vector that contains r value for each x,y sample
        t(i,:) = r.*sqrt((n-2)./(1.-r.^2));                          %Calculating t matrix i row that contains t statistic for each r value
        ran = randperm(size(x2,1));                                  %repeating the process for case 2
        x = x2(ran,:);                                               %...
        r = (sum(x.*y2)-n*mean(x).*mean(y2))./(std(x).*stdy2)/(n-1); %...
        t2(i,:) = r.*sqrt((n-2)./(1.-r.^2));                         %...
    end
    
    %Sorting columns of t matrices calculated in the previous step
    t = sort(t);
    t2 = sort(t2);
    
    %Preparing for vectorized calculation of t0 for all initial samples
    %Vectors containing the standrad deviation of each x sample
    stdx1 = std(x1);
    stdx2 = std(x2);
    %Vectors containing the mean of each x and y sample
    meanx1 = mean(x1);
    meanx2 = mean(x2);
    meany1 = mean(y1);
    meany2 = mean(y2);
    
    %Calculating r1,r2,t01,t02 with wise element formulas(2nd index referes to the case)
    r1 = (sum(x1.*y1)-n*meanx1.*meany1)./(stdx1.*stdy1)/(n-1);
    t01 = r1.*sqrt((n-2)./(1.-r1.^2));
    r2 = (sum(x2.*y2)-n*meanx2.*meany2)./(stdx2.*stdy2)/(n-1);
    t02 = r2.*sqrt((n-2)./(1.-r2.^2));
    
    %Testing if t0 is included in the intervals
    for i=1:L
        if t(idx1,i)<=t01(i) && t01(i)<=t(idx2,i)
            counter = counter+1;
        end
        if t2(idx1,i)<=t02(i) && t02(i)<=t2(idx2,i)
            counter2 = counter2+1;
        end
    end
    
    %Printing the results
    if(j==1)
        fprintf("(X,Y)\n");
    else
        fprintf("(X^2,Y^2)\n");
    end
    
    fprintf("rho=0:Using no parametric test %d of %d samples confirm the hypothesis that there is no correlation\n",counter,M);
    fprintf("rho=0.5:Using no parametric test %d of %d samples confirm the hypothesis that there is no correlation\n\n",counter2,M);
    pause;
    
end


