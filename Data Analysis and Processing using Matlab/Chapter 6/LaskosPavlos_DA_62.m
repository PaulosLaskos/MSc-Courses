% Askisi 6.2

data = importdata('crutem3nh.dat');
years = data(:,1);
temp = data(:,2);
n = length(years);
m = 3;
figure(1)
scatter(years,temp,'filled');
hold on;
plot(years,temp);
xlabel('Year');
ylabel('Temperature Index');
title('Time Series')
hold off;

figure(2)
autocorr(temp)
xlabel('t');
ylabel('r(t)');

xt = zeros(n,m);
j = 1;
figure(3)
for i=1:m
    b = polyfit(years,temp,i);
    xt(:,i) = temp - polyval(b,years);
    subplot(3,2,j)
    scatter(years,xt(:,i),'filled');
    hold on;
    plot(years,xt(:,i));
    xlabel('Year');
    ylabel('Temperature Index - Tension');
    title(sprintf('Polyonymial degree: %d',i))
    hold off;
    subplot(3,2,j+1)
    autocorr(xt(:,i))
    xlabel('t');
    ylabel('r(t)');
    j = j+2;
end

y = zeros(1,n-1);
for i=1:(n-1)
    y(i) = temp(i+1)-temp(i);
end

t = linspace(1,n-1,n-1);
figure(4)
scatter(t,y,'filled');
hold on;
plot(t,y);
xlabel('t');
ylabel('y(t)');
title('First differences')
hold off;

figure(5)
autocorr(y)
xlabel('t');
ylabel('r(t)');

    