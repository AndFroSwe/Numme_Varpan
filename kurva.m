% Print nice Hermite curve between 2 points
clear all, close all, clc

% Define parameters
global uw
uw = 0;
h = 0.005;
u = start_vec(45, 19);
bana_big = RKode(u, h*2);
bana_small = RKode(u, h);

x1 = [];
y1 = [];
x2 = [];
y2 = [];

% Get interpolation for 2*h
for n = 1:length(bana_big.x) - 1 
    [x, y] = herm(bana_big, n);
    x1 = [x1 x];
    y1 = [y1 y];
    hold on
end

plot(x1,y1)
hold on

% Get interpolation for h
for n = 1:length(bana_small.x) - 1 
    [x, y] = herm(bana_small, n);
    x2 = [x2 x];
    y2 = [y2 y];
    hold on
end

plot(x2,y2)
grid on
leg_big = sprintf('h=%0.3f', 2*h);
leg_small = sprintf('h=%0.3f', h);
title('Bana stycvis interpolerad med Hermite-interpolering')
legend({leg_big, leg_small})
xlabel('x [m]')
ylabel('y [m]')
