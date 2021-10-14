mu = [1 2]; 
Sigma = [.7 .4; .4 .3];

r = mvnrnd(mu, Sigma, 10000);

var(r(:,1))+var(r(:,2))
var(r(:,1)+r(:,2))
