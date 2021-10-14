% Askisi 4.3


%Defining the mean values and standard deviations of V,I,f
Vmean = 77.78;
Vstd = 0.710;
Imean = 1.21;
Istd = 0.071;
fmean = 0.283;
fstd = 0.017;

fprintf("Askisi 4.3b\n")
%Creating a simulations with 1000 values from normal distribution for V,I,f
V = normrnd(Vmean,Vstd,[1000,1]);
I = normrnd(Imean,Istd,[1000,1]);
f = normrnd(fmean,fstd,[1000,1]);
%Calculating P vector from the simulation and it's mean, standard deviation
P = V.*I.*cos(f);
Pstd = std(P);
Pmean = mean(P);
%Defining the partial derivatives of function P=VIcosf in the mean point
partial_V = Imean*cos(fmean);
partial_I = Vmean*cos(fmean);
partial_f = -Vmean*Imean*sin(fmean);
%Calculating expected P
Pm = Vmean*Imean*cos(fmean);
%Testing if uncertainty Pm is in the ci(a=0.05) for mean of the P sample 
hm = ttest(P,Pm);
%Printing the results
fprintf("The mean of the 1000 simulations is %f and the value of P(calculated from the mean of V,I,f) is %f\n",Pmean,Pm)
fprintf("The test for the value of P(calculated from the mean of V,I,f) being in the ci(a=0.05) produced by the simulations gives h=%d\n",hm);
%Calculating the uncertainty using law of propagation of error
sP = sqrt((partial_V*Vstd)^2+(partial_I*Istd)^2+(partial_f*fstd)^2);
%Testing if uncertainty sP is in the ci(a=0.05) for std of the P sample 
hvar = vartest(P,sP^2);
%Printing the results
fprintf("The standard deviation of the 1000 simulations is %f and the uncertainty is calculated to be %f\n",Pstd,sP)
fprintf("The test for the uncertainty of P being in the ci(a=0.05) produced by the simulations gives h=%d\n\n\n",hvar);



%%
fprintf("Askisi 4.3c\n")
%Creating simulation with 1000 values from normal distribution for I
I = normrnd(Imean,Istd,[1000,1]);
%Creating a simulations with 1000 values from multivariable normal distribution for V,f
rho_Vf = 0.500;
mean_Vf = [Vmean fmean];
sigma = [Vstd^2 rho_Vf*Vstd*fstd;rho_Vf*Vstd*fstd fstd^2];
arr = mvnrnd(mean_Vf,sigma,1000);
Vc = arr(:,1);
fc = arr(:,2);
%%Calculating P vector from the simulation and it's mean, standard deviation
Pc = I.*Vc.*cos(fc);
Pstdc = std(Pc);
Pmeanc = mean(Pc);
%Defining the partial derivatives of function P=VIcosf in the mean point
partial_V = Imean*cos(mean(fc));
partial_I = mean(Vc)*cos(mean(fc));
partial_f = -mean(Vc)*Imean*sin(mean(fc));
%Calculating P from the mean of V,I,f
Pmc = Vmean*Imean*cos(fmean);
%Testing if Pmc is in the ci(a=0.05) for std of the P sample
hmc = ttest(Pc,Pmc);
%Printing the results
fprintf("The mean of the 1000 simulations is %f and P(calculated from the mean of V,I,f) is %f\n",Pmeanc,Pmc);
fprintf("The test for the P(calculated from the mean of V,I,f) being in the ci(a=0.05) produced by the simulations gives h=%d\n",hmc);
%Calculating the uncertainty using law of propagation of error
sPc = sqrt((partial_V*Vstd)^2+(partial_I*Istd)^2+(partial_f*fstd)^2+2*partial_V*partial_f*rho_Vf*fstd*Vstd);
%Testing if uncertainty sP is in the ci(a=0.05) for std of the P sample
hstdc = vartest(Pc,sPc^2);
%Printing the results
fprintf("The standard deviation of the 1000 simulations is %f and the uncertainty is calculated to be %f\n",Pstdc,sPc);
fprintf("The test for the standard deviation of P being in the ci(a=0.05) produced by the simulations gives h=%d\n\n\n",hstdc);







