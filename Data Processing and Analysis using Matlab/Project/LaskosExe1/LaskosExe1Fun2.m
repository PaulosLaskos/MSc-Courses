function stop = LaskosExe1Fun2(data)
    % Author: Laskos-Patkos Pavlos, AEM: 4388

    %This function calculates the end of the 1st wave
    %{
    As input we give the dataset(confirmed/deaths).
    Then the function calculates the max value of confirmed/deaths
    and divides the data in groups of r values. Then it tries to find the 
    closest group after the maximazition that has confirmed/deaths in total
    less than the max value divided by m. Since the frequencies for each
    country differ if there is not any group of values with that property
    we redo the above process dividing this time the max value by m/2(
    if it happens again with m/4 etc).
    The end of the first wave is defined as the index(in the dataset) of 
    the last non zero value of the group obtained.
    %}
    
    %Calculating the max value of the data
    max_value = max(data);
    %Size of groups 
    r = 10;
    %The number with which we divide
    starting_treshold = 10;
    m = starting_treshold;
    %Size of the dataset
    n = length(data);
    %Modulo from size of data and size of groups
    md = mod(n,r);
    dat = data(1+md:n);
    s = length(dat);
    columns = s/r;
    %Reshaping dat
    range_data = sum(reshape(dat,r,columns));
    %Finding the group we the most cases
    [~,idx_of_max_range] = max(range_data);
    %Finding the groups after the max_group with the total cases less than
    %max_value/m
    idxs = find(range_data<max_value/m);
    if length(idxs)==0;
        idxs = [0];
    end    
    while(max(idxs)<idx_of_max_range)
        idxs = find(range_data<max_value/m);
        m = m/2;
        if length(idxs)==0;
            idxs = [0];
        end
    end
    
    %Finding the indexes of the groups obtained
    last = find(idxs>idx_of_max_range);
    %Finding the closest group to the max_value group and finding the index
    %of it's last element in the starting dataset
    stopping = r*idxs(min(last));
    
    %Calculating the index of the last non zero element until stopping
    %variable
    stop_idx = find(data(1:stopping)>0);

    %Finding the stop of the 1st wave
    if stop_idx(end)>=n
        stop = n;
    else
        stop = stop_idx(end)+1;
    end    
end
    
    