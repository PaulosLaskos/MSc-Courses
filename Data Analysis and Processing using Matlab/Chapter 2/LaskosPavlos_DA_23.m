s = rand(1,1000);

r = exprandom(s);

hist(r,1000,"b")
hold on
fplot(@(x) exp(-x),[0,5],'r')

function y = exprandom(x)
    y = - log(1-x)
end
