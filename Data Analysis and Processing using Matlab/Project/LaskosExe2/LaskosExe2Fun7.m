function data = LaskosExe2Fun7(x,y)
    % Author: Laskos-Patkos Pavlos, AEM: 4388
    %{
    This function transforms the set of values x,y to a sample
    assuming x is the random variable and y it's counts.
    %}

    data = ones(1,sum(y));
    i = 1;
    for j=1:(length(y))
        if y(j) ~= 0
        
            data(i:i+(y(j)-1)) = x(j)*ones(1,y(j));
            i = i+y(j);
        end
    end
    %Returning a column vector
    data = transpose(data);
end