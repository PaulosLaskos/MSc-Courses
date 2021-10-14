% Askisi 3.1b

M = 200;            %Number of samples
n = 200;           %Length of samples
lamda = 1;         %Poisson distribution parameter

for i=1:5
    figure(i)
    poissfunc(M*i,n*i,lamda*i) %Calling the function
end

function y = poissfunc(M,n,l)

    matrix = poissrnd(l,n,M);
    meanvalues = mean(matrix);  
    hist(meanvalues)
    xlabel("mean value")
    ylabel("frecuency")
    
    y = mean(meanvalues);
    
end
