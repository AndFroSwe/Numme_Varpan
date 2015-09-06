function [xut,yut] = RungeKuttasMetod (F,x,y,h)
%RungeKuttas method for solving ODE

%Equation constants
k1 = h*feval(F,x,y);
k2 = h*feval(F,x+h/2,y+k1/2);
k3 = h*feval(F,x+h/2,y+k2/2);
k4 = h*feval(F,x+h,y+k3);

%Calulate x and y
yut = y + (k1+2*k2+2*k3+k4)/6;
xut = x + h;

end