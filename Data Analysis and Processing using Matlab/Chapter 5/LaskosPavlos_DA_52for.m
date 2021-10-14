% Askisi 5.2
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
rho1 = 0;
sigma1 = [sigmax^2 rho1*sigmax*sigmay;rho1*sigmax*sigmay sigmay^2];
exp = mvnrnd(mu,sigma1,M*n);
x1 = reshape(exp(:,1),n,M);
y1 = reshape(exp(:,2),n,M);
rho2 = 0.5;
sigma2 = [sigmax^2 rho2*sigmax*sigmay;rho2*sigmax*sigmay sigmay^2];
exp = mvnrnd(mu,sigma2,M*n);
x2 = reshape(exp(:,1),n,M);
y2 = reshape(exp(:,2),n,M);
counter = 0;
counter2 = 0;
idx1 = M*alpha/2;
idx2 = M*(1-alpha/2);
for j=1:(M)
    x = x1(:,j);
    y = y1(:,j);
    t = zeros(1,M-1);
    covM = cov(x,y);
    r = covM(1,2)/sqrt(covM(1,1)*covM(2,2));
    t0 = r*sqrt((n-2)/(1-r^2));
    xd = x2(:,j);
    yd = y2(:,j);
    td = zeros(1,M);
    covMd = cov(xd,yd);
    rd = covMd(1,2)/sqrt(covMd(1,1)*covMd(2,2));
    t0d = rd*sqrt((n-2)/(1-rd^2));
    for i=1:(M)
        ran = randperm(n);
        x = x(ran);
        r = (sum(x.*y)-n*mean(x).*mean(y))./(std(x).*std(y))/(n-1);
        t(i) = r*sqrt((n-2)/(1-r^2));
        ran2 = randperm(n);
        covM = cov(xd(ran2),yd);
        r = covM(1,2)/sqrt(covM(1,1)*covM(2,2));
        td(i) = r*sqrt((n-2)/(1-r^2));
    end    
    t = sort(t);
    td = sort(td);
    if t(idx1)<=t0 && t0<=t(idx2)
        counter = counter+1;
    end
    if td(idx1)<=t0d && t0d<=td(idx2)
        counter2 = counter2+1;
    end
end

fprintf("rho=0:Using no parametric test %d of %d samples confirm the hypothesis that there is no correlation\n",counter,M);
fprintf("rho=0.5:Using no parametric test %d of %d samples confirm the hypothesis that there is no correlation\n\n",counter2,M);
toc

