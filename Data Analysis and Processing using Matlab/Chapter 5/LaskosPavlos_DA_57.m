%Askisi 5.7

R = [0.76 0.86 0.97 1.11 1.45 1.67 1.92 2.23 2.59 3.02 3.54 4.16 4.91 5.83 6.94 8.31 10 12.09 14.68 17.96 22.05 27.28 33.89 42.45 53.39 67.74 86.39 111.30 144 188.40 247.50 329.20];
T = [110 105 100 95 85 80 75 70 65 60 55 50 45 40 35 30 25 20 15 10 5 0 -5 -10 -15 -20 -25 -30 -35 -40 -45 -50]+273.15;
invT = 1./T;
lnR = log(R);

%Fitting polyonymial models and making the diagnostic diagrams
bmat = zeros(4,5);
adj_r = zeros(1,4);

figure(1)
clf;
for i=1:4
    subplot(2,2,i)
    [bmat(i,1:i+1),pred] = fit_diagnostic(lnR,invT,i,"1/T");
    adj_r(i) = adjR2gof(invT,pred,i);
end

fprintf("The value of adjR^2 test are shown below:\n");
fprintf('1st degree polyonymial: %.10f\n',adj_r(1))
fprintf('2nd degree polyonymial: %.10f\n',adj_r(2))
fprintf('3rd degree polyonymial: %.10f\n',adj_r(3))
fprintf('4rth degree polyonymial: %.10f\n',adj_r(4))

y3 = @(x) bmat(3,1)*x.^3+bmat(3,2)*x.^2+bmat(3,3)*x+bmat(3,4);
ysh = @(x) bmat(3,1)*x.^3+bmat(3,3)*x+bmat(3,4);
adj_rsh = adjR2gof(invT,ysh(lnR),3);
fprintf('Steinhand-Hart model: %.10f\n',adj_rsh);

figure(2)
xx = linspace(min(lnR),max(lnR),10*length(lnR));
scatter(lnR,invT)
hold on;
plot(xx,ysh(xx),'black');
hold on;
plot(xx,y3(xx),'r');
xlabel('lnR');
ylabel('1/T');
title('3rd degree polyonymial fit and Steinhart-Hart model');
hold off;

fprintf('\n\n---------------------------------\n\n')

function [b,z] = fit_diagnostic(x,y,n,xname)
    
    b = polyfit(x,y,n);
    nn = length(x);
    z = zeros(1,nn);
    for i=0:n
        z = z + b(n+1-i)*(x.^i);
    end
    
    Se = sqrt(sum((y-z).^2)/(nn-2));
    ei = (y-z)/Se;
    
    t = sprintf('diagnostic diagram for n=%d degree polyonymial',n);
    
    x95 = linspace(z(1),z(end),100);
    y95 = 2*ones(1,length(x95));
    xaxis = zeros(1,length(x95));
    scatter(z,ei,'filled');
    hold on;
    plot(x95,y95,'r');
    hold on;
    plot(x95,-y95,'r');
    hold on;
    plot(x95,xaxis,'black');
    xlabel(xname);
    ylabel('ei');
    title(t);
    hold off;
    
end

function v = adjR2gof(x,y,df)
    n = length(x);
    v = 1 - ((n-1)/(n-(df+1)))*sum((x-y).^2)/sum((x-mean(x)).^2);
end
    
