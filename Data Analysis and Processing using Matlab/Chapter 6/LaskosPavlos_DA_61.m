% Askisi 6.1

sunspots = importdata('sunspots.dat');

years = sunspots(:,1);
num = sunspots(:,2);
n = length(num);

figure(1)
scatter(years,num,'filled');
hold on;
plot(years,num);
xlabel('Year');
ylabel('Number of Sunspots');
title('Time Series')
hold off;

figure(2)
autocorr(num)
xlabel('t');
ylabel('r(t)');

%%

mv = [];
period = 11;
for i=1:(period-1)
    st = num(i:(period-1):n);
    mv(end+1) = mean(st);
end

st = repmat(mv,1,40);
st(n-1:n) = [];

res = transpose(num) - st(1:n);

figure(3)
clf;
scatter(years,res,'filled');
hold on;
plot(years,res);
xlabel('Year');
ylabel('Number of Sunspots');
title('Residual Diagram')

figure(4)
clf;
autocorr(res)
xlabel('t');
ylabel('r(t)');
title('Sample autocorrelation function for residuals');

