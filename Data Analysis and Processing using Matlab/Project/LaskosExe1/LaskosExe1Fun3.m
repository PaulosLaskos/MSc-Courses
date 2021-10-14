function new = LaskosExe1Fun3(data)
    % Author: Laskos-Patkos Pavlos, AEM: 4388
    %{
    This function replaces a nan value in the sample with the same of its
    next element
    %}
    n = length(data);
    k = find(isnan(data));
    k(end+1)=1;
    if k(end) == n
        data(end)=0;
    end
    while sum(isnan(data)) ~= 0
        data(find(isnan(data))) = data(find(isnan(data))+1);
    end
    new = data;
end