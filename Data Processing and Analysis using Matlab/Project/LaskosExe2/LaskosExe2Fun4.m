function new = LaskosExe2Fun4(data)
    % Author: Laskos-Patkos Pavlos, AEM: 4388
    %{
    This functions located the indexes of negative values appearing in the
    data and replaces them with the mean of it's previous and next value
    %}
    while sum(find(data<0)) ~= 0
        idx = find(data<0);
        n = length(idx);
        m = length(data);
        if data(m)<0
            data(m) = abs(data(m));
            n = n-1;
        end
        if n>=1
            for i=0:(n-1)
                data(idx(i+1)) = fix((data(idx(i+1)-1)+data(idx(i+1)+1))/2);
            end
        end
    end
    new = data;
end