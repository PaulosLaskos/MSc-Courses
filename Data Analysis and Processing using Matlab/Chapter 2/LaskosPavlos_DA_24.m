% Askisi 2.6

%Sets that are going to be filled with the data
counter = 1;
n = 2;
Ap1 = zeros(20);
Bp1 = zeros(20);
Ap2 = zeros(20);
Bp2 = zeros(20);
Ap3 = zeros(20);
Bp3 = zeros(20);
Number = zeros(20);

while(n<2^20)
    
    %Three different sets of random number from uniform distribution
    A1 = 1+rand(n,1);
    B1 = 1./A1;
    A2 = rand(1,n);
    B2 = 1./A2;
    A3 = -1+2*rand(1,n);
    B3 = 1./A3;
    
    Ap1(counter) = 1/mean(A1);
    Bp1(counter) = mean(B1);
    Ap2(counter) = 1/mean(A2);
    Bp2(counter) = mean(B2);
    Ap3(counter) = 1/mean(A3);
    Bp3(counter) = mean(B3);
    
    Number(counter) = n;
    counter = counter+1;
    
    n = n*2;
end

%Plotting the results
figure(1)
semilogx(Number,Ap1,"o-")
hold on
semilogx(Number,Bp1,"ro-")
grid

figure(2)
semilogx(Number,Ap2,"o-")
hold on
semilogx(Number,Bp2,"ro-")
grid

figure(3)
semilogx(Number,Ap3,"o-")
hold on
semilogx(Number,Bp3,"ro-")
grid


