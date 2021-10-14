% Askisi 2.5
% a)
% X-N(4,0.01)->mu=4 kai sigma^2=0.01
% Theloume tin pithanotita P(X<3.9)
% P(X<3.9) = Fx(3.9)

X = 3.9;
mu = 4;
sigma = 0.1;

P = normcdf(X,mu,sigma)


% b)
% P(X<a) = Fx(a) = 1%

a = norminv(0.01,mu,sigma)