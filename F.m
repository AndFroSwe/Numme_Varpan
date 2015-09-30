% ODE for use in function RK
function F = F (t, u)

global uw

kx = 0.020;  % Air resistance x-dir
ky = 0.065;  % Air resistance y-dir
xvel = u(2);
yvel = u(4);

V = sqrt((xvel-uw)^2 + yvel^2);   % Total velocity

F = [xvel -kx*(xvel-uw)*V yvel -9.81-ky*yvel*V];
end