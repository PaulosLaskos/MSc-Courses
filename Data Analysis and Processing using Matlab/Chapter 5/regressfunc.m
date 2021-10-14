function y = linear_regress(x,y)
    n = length(x);
    mean_x = mean(x);
    Sxx = sum((x-mean_x).^2);
    b1 = sum((x-mean_x).*(y-mean(y)))/Sxx;     
    b0 = (sum(y)-b1*sum(x))/n;
    y = [b0,b1];
end