%Askisi 3.5
tic
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
idx2 = round((L-L*a/2));


for i=1:m
    ts = zeros(1,L);
    tmp = temp(:,i);
    rn = rain(:,i);
    covM = cov(tmp,rn);
    r = covM(1,2)/sqrt(covM(1,1)*covM(2,2));
    t0 = r*sqrt((n-2)/(1-r^2));
    p = 1-tcdf(t0,n-2);
    if p>a
        counter_p = counter_p+1;
    end
    for j=1:L
        ran = randperm(n);
        tm = tmp(ran);
        r = (sum(tm.*rn)-n*mean(tm)*mean(rn))/(std(rn)*std(tm))/(n-1);
        ts(j) = r*sqrt((n-2)/(1-r^2));
    end
    tsort = sort(ts);
    if tsort(idx1)<=t0 && t0<=tsort(idx2)
        counter_np = counter_np+1;
    end
end

fprintf("Using parametric t-test(a=0.05) %d of %d samples confirme the hypothesis that there is no correlation between temperature and rain\n",counter_p,m);
fprintf("Using no parametric test %d of %d samples confirme the hypothesis that there is no correlation between temperature and rain\n\n",counter_np,m);
toc