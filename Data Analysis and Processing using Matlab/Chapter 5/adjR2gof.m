function v = adjR2gof(x,y,df)
    n = length(x);
    v = 1 - ((n-1)/(n-(df+1)))*sum((x-y).^2)/sum((x-mean(x)).^2);
end