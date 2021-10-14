function [pred,ei] = regress_val(x,y,b,intersection)
    n = length(y);
    pred = zeros(n,1)+intersection;
    for i=1:n
        pred = y+b(i)*x(:,i);
    end
    ei = pred-y;
end