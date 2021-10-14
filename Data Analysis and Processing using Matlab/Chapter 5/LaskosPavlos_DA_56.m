% Askisi 5.6

x = [2,3,8,16,32,48,64,80];
y = [98.2,91.7,81.3,64.0,36.4,32.6,17.1,11.3];
n = length(x);
value = 25;

%Variance diagram
figure(1)
scatter(x,y);
xlabel("distance");
ylabel("percentage for the abillity of use");
title("Variance Diagram");


%%
%Case 1: Exponential Model
logy = log(y);

figure(2)
subplot(1,2,1)
bexp = regress_diagnostic(x,logy);
subplot(1,2,2)
x_axis = linspace(min(x),max(x),100);
yexp =  exp(bexp(1)+x_axis.*(bexp(2)));
scatter(x,y);
hold on;
plot(x_axis,yexp);
xlabel("distance");
ylabel("percentage for the abillity of use");
title("Testing an exponential model");
hold off;
fprintf("The prediction for distance = 25 of the exponential model equals %f\n",exp(bexp(1)+value*(bexp(2))));



%Case 2: Power Law Model
figure(3)
logx = log(x);
subplot(1,2,1)
bpow = regress_diagnostic(logx,logy);
subplot(1,2,2)
ypow =  exp(bpow(1))*x_axis.^(bpow(2));
scatter(x,y);
hold on;
plot(x_axis,ypow);
xlabel("distance");
ylabel("percentage for the abillity of use");
title("Testing a power law model");
hold off;
fprintf("The prediction for distance = 25 of the power law model equals %f\n",exp(bpow(1))*value^(bpow(2)));



%Case 3: Logarithim Model
figure(4)
subplot(1,2,1)
blog = regress_diagnostic(logx,y);
subplot(1,2,2)
ylog =  blog(1)+log(x_axis).*(blog(2));
scatter(x,y);
hold on;
plot(x_axis,ylog);
xlabel("distance");
ylabel("percentage for the abillity of use");
title("Testing a logarithm model");
hold off;
fprintf("The prediction for distance = 25 of the logarithm model equals %f\n",blog(1)+log(value)*(blog(2)));


%Case 4: Inverse Model
figure(5)
xinv = 1./x;
subplot(1,2,1)
binv = regress_diagnostic(xinv,y);
subplot(1,2,2)
yinv =  binv(1)+(binv(2))./x_axis;
scatter(x,y);
hold on;
plot(x_axis,yinv);
xlabel("distance");
ylabel("percentage for the abillity of use");
title("Testing an inverse model");
hold off;
fprintf("The prediction for distance = 25 of the inverse model equals %f\n",binv(1)+(binv(2))/value);


function y = regress_diagnostic(x,y)

    %Linear Regression
    n = length(x);
    mean_x = mean(x);
    Sxx = sum((x-mean_x).^2);
    b1 = sum((x-mean_x).*(y-mean(y)))/Sxx;     
    b0 = (sum(y)-b1*sum(x))/n;
    
    %Diagnostic diagram
    Se = sqrt((n-1)/(n-2)*(std(y)^2-(b1*std(x))^2));
    error = y - b0-b1*x;
    terror = error/Se;
    x95 = linspace(0,max(y)+1,100);
    y95 = 2*ones(1,length(x95));
    xaxis = zeros(1,length(x95));
    scatter(b0+b1*x,terror);
    hold on;
    plot(x95,y95,"r");
    hold on;
    plot(x95,-y95,"r");
    hold on;
    plot(x95,xaxis,"black");
    xlabel("y'");
    ylabel("Standardised Error");
    title("Diagnostic Diagram");
    ylim([-4,4])
    hold off;
    y = [b0,b1];
    
end
  