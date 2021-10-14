% Askisi_DA_26
Y = zeros(1,10000);
n=100;

for i=1:10000
    X = rand(1,n);
    Y(1,i) = mean(X);
end
%sigma_uniform = (b-a)/sqrt(12)
sigma_uniform = 1/sqrt(12);
%sigma = sigma_uniform/sqrt(n)
sigma = sigma_uniform/10;
%mu_uniform = b+a/2
mu = 0.5;

%plot the histogram and the normal distribution
hist(Y,6000)
hold on
fplot(@(x) normpdf(x,mu,sigma),'r')
xlim([0.3 0.7])
