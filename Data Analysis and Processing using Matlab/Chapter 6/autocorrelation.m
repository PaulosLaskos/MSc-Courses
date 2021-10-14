function y = autocorrelation(data,t)
    mu = mean(data);
    n = length(data);
    dat1 = data(t+1:n);
    dat2 = data(1:n-t);
    y = sum((dat1-mu).*(dat2-mu))/sum((dat1-mu).^2);
end
    