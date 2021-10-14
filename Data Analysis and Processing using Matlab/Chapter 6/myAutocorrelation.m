function [r,h] = myAutocorrelation(x,t,M,a);
    
    n = length(x);
    nt = length(t);
    idx1 = round(M*a/2);
    idx2 = round(M*(1-a/2));
    r = zeros(1,nt);
    h = zeros(1,nt);
    for i=1:nt
        x1 = x(t(i)+1:n);
        x2 = x(1:n-t(i));
        n_new = length(x1);
        a = corrcoef(x1,x2);
        r(i) = a(1,2);
        bootstrap = zeros(1,M);
        tstat = r(i)*sqrt((n_new-2)/(1-r(i)^2));
        for j=1:M
            ran = randperm(n_new);
            xi  = x2(ran);
            rj = (sum(xi.*x1)-n_new*mean(xi)*mean(x1))/(std(xi)*std(x1))/(n_new-1);
            bootstrap(j) = rj*sqrt((n_new-2)/(1-rj^2));
        end
        sorted_bts = sort(bootstrap);
        null = sorted_bts(idx1)<=tstat && sorted_bts(idx2)>=tstat;
        h(i) = abs(null-1);
    end
end
            
            