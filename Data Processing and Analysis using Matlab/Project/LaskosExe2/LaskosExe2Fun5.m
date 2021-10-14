function new = LaskosExe2Fun5(data)
    % Author: Laskos-Patkos Pavlos, AEM: 4388
    %This function tests for zeros in the data followed by cases greater
    %than 20 and divides the cases to all the days.
    idx = find(data==0);
    n = length(idx); 
    m = length(data);
    for i=1:n
        if idx(i)+2 <= m
            if idx(i)>5 && data(idx(i)+1)==0 && data(idx(i)+2)>20
                data(idx(i)) = fix(data(idx(i)+2)/3);
                data(idx(i)+1) = fix(data(idx(i)+2)/3);
                data(idx(i)+2) = data(idx(i)+2)-2*data(idx(i)+1);
            elseif data(idx(i)+1) > 20 
                data(idx(i)) = fix(data(idx(i)+1)/2);
                data(idx(i)+1) = data(idx(i));
            end
        end
    end
    new = data;
end