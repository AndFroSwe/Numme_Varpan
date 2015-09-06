function [bana] = RKode(alfa,v,uw,h)

kx = 0.020;   %Air resistance x
ky = 0.065;   %Air resistance y
k = [kx ky];  %Air resistance vector
x0 = 0;        %Initial x-value
xend = 20;       %Desired end x-value
y0 = 1.5;      %Initial height
yend  = 0;       %Desired end y-value
t0 = 0 ;         %Initial time
t = t0;
tid = [];

% Starting values
alfa_rad = alfa*pi/180;     %Deg to radians
u = [x0 v*cos(alfa_rad) y0 v*sin(alfa_rad)];   %Vector with 
bana = [u];
tid = [t0];

while u((3)) >=0;
    k1 = h*F(u,k,uw);
    k2 = h*F(u+h*k1/2,k,uw);
    k3 = h*F(u+h*k2/2,k,uw);
    k4 = h*F(u+h*k3,k,uw);

    u = u + (k1+2*k2+2*k3+k4)/6;
    t = t+h;      %Runge Kutta function, solving ODE
    
    tid = [tid; t];             %Save time (=t+step size) from RK in vector
    bana = [bana; u];            %Save trajectory and speeds in a matrix
                         
end
bana = [tid bana];    %Time x-pos x-speed y-value y-value