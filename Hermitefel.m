function [] = Hermitefel()
% HERMITFEL plots error estimations from Hermite interpolation by only
% using half the points while interpolating

% Define parameters
global uw
uw = 0;
h = 0.01;
u = start_vec(45, 19);
bana_small = RKode(u, h);
% Only take half of the points
bana_big = struct(  'time',     bana_small.time(1:2:end),...
                    'x',        bana_small.x(1:2:end),...
                    'xvel',     bana_small.xvel(1:2:end),...
                    'y',        bana_small.y(1:2:end),...
                    'yvel',     bana_small.yvel(1:2:end));

times_big = [];
y_big = [];
times_small = [];
y_small = [];

k = 2; % Step factor
% Get interpolation for 2*h
for n = 1:length(bana_big.x) - 1 
    [time, y] = herm(bana_big, n, k);
    times_big = [times_big time];
    y_big = [y_big y];
    hold on
end

k = 1;  % Step factor
% Get interpolation for h
for n = 1:length(bana_small.x) - 1 
    [time, y] = herm(bana_small, n, k);
    times_small = [times_small time];
    y_small = [y_small y];
    hold on
end

% Plot interpolated curve
figure()
plot(times_big,y_big)
hold on
plot(times_small,y_small)
grid on
leg_big = sprintf('h=%0.3f', 2*h);
leg_small = sprintf('h=%0.3f', h);
title('Bana styckvis interpolerad med Hermite-interpolering')
legend({leg_big, leg_small})
xlabel('x [m]')
ylabel('y [m]')
hold off

err_abs = max(abs(y_big - y_small));
ind = find(max(abs(y_big - y_small)) == err_abs);
err_rel = err_abs/y_big(ind);

% Assess error from plot
fprintf('Relativt hermitefel �r: %f0.2*10^-9\n', err_rel*1e9)
