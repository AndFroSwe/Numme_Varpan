% ODE for use in function RK
function F = F (t, u)

global uw
kx = 0.020;  % Air resistance x-dir
ky = 0.065;  % Air resistance y-dir
V = sqrt(u(2)^2 + u(4)^2);   % Total velocity

F = [u(2) -kx*(u(2)-uw)*V u(4) -9.81-ky*u(4)*V];
end