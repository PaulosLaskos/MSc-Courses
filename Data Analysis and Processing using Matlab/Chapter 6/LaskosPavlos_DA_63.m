% Askisi 6.3

n = 100;
t = linspace(1,n,n);
x = ones(1,n);
x(1) = 0.36;

for i=1:(n-1)
    x(i+1) = 4*x(i)*(1-x(i));
end

figure(1)
scatter(t,x,'filled');
hold on;
plot(t,x);
xlabel('x');
ylabel('ts');
title('Time Series')
hold off;

figure(2)
autocorr(x)
xlabel('t');
ylabel('r(t)');