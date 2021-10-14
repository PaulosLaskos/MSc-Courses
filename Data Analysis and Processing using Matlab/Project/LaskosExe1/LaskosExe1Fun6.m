function [pd,p,mse] = LaskosExe1Fun6(x,y,data,distname)
    % Author: Laskos-Patkos Pavlos, AEM: 4388
    %{
    Input:
    - x: variable x
    - y: variable y
    - data: sample assuming x is the random variable and y it's frequancy
    - distname: Name of distribution fitted

    Output:
    - pd: Prediction from the fitted distribution for the values x
    - p: p value of chi Squared goodness of fit test
    - mse: Mean squared error for the fit
    %}
 
    pdo = fitdist(data,distname);
    [~,p] = chi2gof(data,'cdf',pdo);
    pd = pdf(pdo,x);
    mse = immse(y/sum(y),pd);
end
    
    