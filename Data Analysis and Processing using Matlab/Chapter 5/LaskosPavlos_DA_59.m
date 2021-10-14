%Askisi 5.9

hospital = load('hospital.txt');

y = hospital(:,1);
n = length(y);
x = [ones(n,1),hospital(:,2:4)];
xx = hospital(:,2:4);

b4 = regress(y,x);
def = length(b4);
y2 = zeros(n,1)+b4(1);
for i=2:4
    y2 = y2+b4(i)*x(:,i);
end

fprintf('Montelo me 10 aneksartites metavlites')
fprintf('\n-----------------------------------------------------------\n');
fprintf('Calculation of Se,R^2,adjR^2 for the 3 independent variable model\n');
fprintf('Se = %f\n',svar(y,y2));
fprintf('R^2 = %f\n',R2gof(y,y2));
fprintf('adjR^2 = %f\n',adjR2gof(y,y2,def));
fprintf('-----------------------------------------------------------\n');

model = stepwise(xx,y);
b3 = [-176.805,2.6691,127.0154];
def3 = length(b3);
idx = [1,3];
n3 = length(idx);
y3 = zeros(n,1)+b3(1);
for i=1:n3
    y3 = y3+b3(i+1)*xx(:,idx(i));
end

fprintf('Stepwise regression')
fprintf('\n-----------------------------------------------------------\n');
fprintf('Calculation of Se,R^2,adjR^2 for the stepwise 2 independent variable model\n');
fprintf('Se = %f\n',svar(y,y3));
fprintf('R^2 = %f\n',R2gof(y,y3));
fprintf('adjR^2 = %f\n',adjR2gof(y,y3,def3));
fprintf('-----------------------------------------------------------\n\n');

fprintf('Elegxos sigkramikotitas\n')
fprintf('Test for variable Cases')
sygram(1,2,3,xx);
fprintf('Test for variable Eligible')
sygram(2,3,1,xx);
fprintf('Test for variable OpRooms')
sygram(3,1,2,xx);

function a = sygram(z,k,j,l)
    xtest = l(:,z);
    n = length(xtest);
    indvar =  [ones(n,1),l(:,j),l(:,k)];
    b2 = regress(xtest,indvar);
    def2 = length(b2);
    y2 = zeros(n,1)+b2(1);
    for i=2:3
        y2 = y2+b2(i)*indvar(:,i);
    end
    fprintf('\n-----------------------------------------------------------\n');
    fprintf('Calculation of Se,R^2,adjR^2 for the colinear model\n');
    fprintf('Se = %f\n',svar(xtest,y2));
    fprintf('R^2 = %f\n',R2gof(xtest,y2));
    fprintf('adjR^2 = %f\n',adjR2gof(xtest,y2,def2-1));
    fprintf('-----------------------------------------------------------\n');
end
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




