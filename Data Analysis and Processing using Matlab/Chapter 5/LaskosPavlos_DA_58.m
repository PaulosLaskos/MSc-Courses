%Askisi 5.8

physical = load('physical.txt');

y = physical(:,1);
n = length(y);
x = [ones(n,1),physical(:,2:11)];
xx = physical(:,2:11);

b10 = regress(y,x);
y10 = zeros(n,1)+b10(1);
def = length(b10)
for i=2:11
    y10 = y10+b10(i)*x(:,i);
end

fprintf('\n-----------------------------------------------------------\n');
fprintf('Calculation of Se,R^2,adjR^2 for the 10 independent variable model\n');
fprintf('Se = %f\n',svar(y,y10));
fprintf('R^2 = %f\n',R2gof(y,y10));
fprintf('adjR^2 = %f\n',adjR2gof(y,y10,def-1));
fprintf('-----------------------------------------------------------\n');

model = stepwise(xx,y);
b5 = [-113.312,2.03558,0.646884,0.271747,0.540084];
def5 = length(b5);
idx = [1,6,7,9];
n3 = length(idx);
y3 = zeros(n,1)+b5(1);
for i=1:n3
    y3 = y3+b5(i+1)*xx(:,idx(i));
end

fprintf('\n-----------------------------------------------------------\n');
fprintf('Calculation of Se,R^2,adjR^2 for the 4 independent variable model\n');
fprintf('Se = %f\n',svar(y,y3));
fprintf('R^2 = %f\n',R2gof(y,y3));
fprintf('adjR^2 = %f\n',adjR2gof(y,y3,def5-1));
fprintf('-----------------------------------------------------------\n');

function v = svar(x,y)
    n = length(x);
    v = sqrt(sum((x-y).^2)/(n-2));
end
function v = adjR2gof(x,y,df)
    n = length(x);
    v = 1 - ((n-1)/(n-(df+1)))*sum((x-y).^2)/sum((x-mean(x)).^2);
end
function v = R2gof(x,y)
    n = length(x);
    v = 1 - sum((x-y).^2)/sum((x-mean(x)).^2);
end