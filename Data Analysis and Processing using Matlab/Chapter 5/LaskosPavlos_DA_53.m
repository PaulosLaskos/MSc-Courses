%Askisi 3.5

temp = importdata("tempThes59_97.dat");
rain = importdata("rainThes59_97.dat");

m = length(temp(1,:));
n = length(temp(:,1));
L = 1000;

%Plot the data to see if it appers to be a correlation between temperature
%and rain
scatter(reshape(temp,1,m*n),reshape(rain,1,m*n));
xlabel("Temperature");
ylabel("Rain");
pause;

%Setting up the counter
counter_p = 0;
counter_np = 0;

%Level of significance
a = 0.05;

%Indexes
idx1 = round(L*a/2);
if idx1==0
    idx1 = 1;
end
idx2 = round(L-L*a/2);

%Vector containing the standard deviation of rain for each month
stdrn = std(rain);
meanrn = mean(rain);

%Vector that will be filled with t0 statistic value for each sample
t0 = zeros(1,m);

%%%% PARAMETRIC TEST %%%%
for i=1:m
    tmp = temp(:,i);
    r = (sum(tmp.*rain(:,i))-n*mean(tmp)*meanrn(i))/(std(tmp)*stdrn(i))/(n-1);
    t0(i) = r*sqrt((n-2)/(1-r^2));
    p = 2*(1-tcdf(abs(t0(i)),n-2));
    if p>a
        counter_p = counter_p+1;
    end 
end

%%%% NON PARAMETRIC TEST %%%%
ts = zeros(L,m);
for i=1:L
    ran = randperm(n);
    tmp = temp(ran,:);
    r = (sum(tmp.*rain)-n*mean(tmp).*mean(rain))./(std(tmp).*std(rain))/(n-1);
    ts(i,:) = r.*sqrt((n-2)./(1.-r.^2));
end
tsort = sort(ts);
for i=1:m
    if tsort(idx1,i)<=t0(i) && t0(i)<=tsort(idx2,i)
        counter_np = counter_np+1;
    end
end

%Printing the results
fprintf("Using parametric t-test(a=0.05) %d of %d samples confirme the hypothesis that there is no correlation between temperature and rain\n",counter_p,m);
fprintf("Using no parametric test %d of %d samples confirme the hypothesis that there is no correlation between temperature and rain\n\n",counter_np,m);
