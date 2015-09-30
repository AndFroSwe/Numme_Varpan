% Print nice Hermite curve between 2 points
clear all, close all, clc

global uw
uw = 0;

h = 0.005;
u = start_vec(45, 19);
bana_big = RKode(u, h*2);
bana_small = RKode(u, h);

n = 200;
x = [];
y = [];
for n = 1:length(bana_big.x) - 1 
    [x1, y1] = herm(bana_big, n);
    plot(x1, y1)
    hold on
end

for n = 1:length(bana_small.x) - 1 
    [x1, y1] = herm(bana_small, n);
    plot(x1, y1)
    hold on
end



% [x2, y2] = herm(bana_small, n);
% 
% plot(x1, y1);
% hold on 
% plot(x1, y2);
% legend('Big', 'Small')

