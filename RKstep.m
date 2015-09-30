%Step in RungeKuttas method for solving ODE 
% u input vector, h step length, tin current time step
function [kast, tut] = RKstep (u, h, t)

%Equation constants
k1 = F(t, u);
k2 = F(t, u+h*k1/2);
k3 = F(t, u+h*k2/2);
k4 = F(t, u+h*k3);

kast = u + h*(k1+2*k2+2*k3+k4)/6;
tut = t+h;

end