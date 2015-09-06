%Varpan
%Isa Nedersjö och Andreas Fröderberg

clc, clear all, close all;  %Clear window

%Define constants
kx = 0.020;   %Air resistance x
ky = 0.065;   %Air resistance y
v0 = 19;       %Initial velocity
x0 = 0;        %Initial x-value
y0 = 1.5;      %Initial height

%---------- Part 1 ---------
alpha = pi/4;   %Arbitrary throwing angle, 45 degrees
xprick0 = v0*cos(alpha);   %Initial velocity, x
yprick0 = v0*sin(alpha);    %Initial velocity, y
xprick2 = @(xprick,yprick) -kx*xprick*sqrt(power(xprick,2)+power(yprick,2)); %Define d?2/dt?2(x)
yprick2 = @(xprick,yprick) -9.81-ky*yprick*sqrt(power(xprick,2)+power(yprick,2));%Define d?2/dt?2(y)
V = @(xprick2,yprick2) sqrt(power(2,2),power(2,2))
h = 0.5 %Step size
x = [x0]
y = [y0]

%while y(end)>0
%    RK (
    
    
    
    
    
    
    
    
    
    