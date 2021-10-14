function start = LaskosExe1Fun1(data)
    % Author: Laskos-Patkos Pavlos, AEM: 4388
    %This function calculates the start of the 1st wave
    %{
    As input we give the dataset(confirmed/deaths).
    Then the function calculates the max value of confirmed/deaths
    and divides the data in groups of r values. Then it tries to find the 
    closest group before the maximazition that has confirmed/deaths in total
    less than the max value divided by m. Since the frequencies for each
    country differ if there is not any group of values with that property
    we redo the above process dividing this time the max value by m/2(
    if it happens again with m/4 etc).
    If the above process(division by m/2) is not needed the start of the
    first wave is defined as the index(in the dataset) of the first non zero 
    value of the group obtained. Otherwise we get the last non zero value 
    of the previous group from the one obtained.
    %}
    
    %Max value of the data
    max_value = max(data);
    %Length of each group
    r = 10;
    %Size of data
    n = length(data);
    %Modulo of size of data and size of group
    md = mod(n,r);
    
    %Starting value for division m
    starting_treshold = 10;
    m = starting_treshold;
    %Data that can be reshaped. We exclude the final values since we attemt
    %to find the start of the 1st wave
    dat = [zeros(1,10-md) data(1:n)];
    columns = length(dat)/r;
    mat = reshape(dat,r,columns);
    %Calculating the sum of confirmed/deaths for each group
    range_data = sum(mat);
    %Finding the index of the max sum
    [~,idx_of_max_range] = max(range_data);
    
    %Finding the groups that are before the last group and have sum<max/m
    idxs = find(range_data<max_value/m);
    if length(idxs)==0
        idxs = [idx_of_max_range-1];
    end
    while(min(idxs)>idx_of_max_range)
        idxs = find(range_data<max_value/m);
        m = m/2;
        if length(idxs)==0;
            idxs = [idx_of_max_range-1];
        end
    end
    
    %Finding the indexes of the groups we the above property
    last = find(idxs<idx_of_max_range);
    
    %If we did not have to lower m to find a group then pick the group
    %obtained otherwise the previous one
    if m == starting_treshold
        stopping = r*idxs(max(last));
    else
        stopping = r*idxs(max(last)-1);
    end

    %Finding the last non zero value of the group 
    stop_idx = find(data(stopping-r:stopping)>0);
    if length(stop_idx)==0
        start = stopping+1+md-10;
    else
        start = stopping-r+stop_idx(end)+1+md-10;
    end
end