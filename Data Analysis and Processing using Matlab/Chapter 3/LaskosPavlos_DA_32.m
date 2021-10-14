% Askisi 3.2b

M = 200;            %Number of samples
n = 200;            %Length of samples
lamda = 1;          %Exponential distribution parameter

for i=1:5
    figure(i)
    expfunc(M*i,n*i,lamda*i) %Calling the function
end

function y = expfunc(M,n,t)

    matrix = exprnd(t,n,M);
    meanvalues = mean(matrix);  
    hist(meanvalues)
    xlabel("mean value")
    ylabel("frecuency")
    y = mean(meanvalues);
    
end
