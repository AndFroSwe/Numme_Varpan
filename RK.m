function [kast, tut] = RK (u, k, h, tin)
%RungeKuttas method for solving ODE

%Equation constants
k1 = h*F(u,k);
k2 = h*F(u+h*k1/2,k);
k3 = h*F(u+h*k2/2,k);
k4 = h*F(u+h*k3,k);

kast = u + (k1+2*k2+2*k3+k4)/6;
tut = tin+h;

end