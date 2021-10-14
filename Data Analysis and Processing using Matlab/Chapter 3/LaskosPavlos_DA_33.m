% Askisi 3.3

t = 15;                                   %mean time 

percentage5 = prcfunc(15,1000,5)          %question a n=5

percentage100 = prcfunc(15,1000,100)      %question b n=100

function y = prcfunc(t,M,n)

    counter = 0;                          %setting up a counter
    matrix = exprnd(t,n,M);               %creating a n x M matrix with rnd from exp distribution
    
    for i=1:M
        [h,p,ci] = ttest(matrix(:,i));    %ci is the 95% confidence interval
        if (ci(1,1)<=t) && (ci(2,1)>=t)   %checking if t is inside the confidence interval
            counter = counter+1;          
        end
    end
    y = counter/M;
    
end