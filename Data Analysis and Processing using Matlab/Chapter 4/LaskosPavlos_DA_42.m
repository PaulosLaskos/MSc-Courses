% Askisi 4.2

fprintf("Askisi 4.2a\n")
syms E(x,y);
E(x,y) = x*y;
dEdx = diff(E,x);
dEdy = diff(E,y);
sx = 5;
sy = 5;
xv = 300;
yv = 500;
uncer_E = sqrt((dEdx(xv,yv)*sx)^2+(dEdy(xv,yv)*sy)^2);
fprintf("The uncertainty of the surface is %f\n",uncer_E);


%%
[x,y] = meshgrid(0:10:500,0:10:500);
z = 5*sqrt(x.^2+y.^2);

subplot(1,2,1)
surf(x,y,z)
xlabel("Length")
ylabel("Width")
zlabel("Surface uncertainty")
title("3D Plot of the surface uncertainty")

subplot(1,2,2)
contour(x,y,z)
xlabel("Length")
ylabel("Width")
title("Contour Plot of the surface uncertainty")