clc; close all; clear all;
uw = 0;
u = [0   13.4350    1.5000   13.4350];

a = RKode(u, 0.1);

plot(a.x, a.y);
subplot(2,1,1)
plot(a.xvel)
subplot(2,2,1)


