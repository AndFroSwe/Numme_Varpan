%Varpan
%Isa Nedersj�
clc, clear all, close all;    %Clear window
pm = char(177); % Define plus minus symbol
RK4_relerr = 0.200e-2;
secant_err = 0.005;
hermite_err = 0.2;
errors = struct(    'RK4', 0.2e-2,...
                    'secant', 0.005,...
                    'hermite', 0.2);
%% ---------Part 1---------

%Solve ODE for arbitrary throwing angle
v0 = 19;
alfa = 45;    %Arbitrary throwing angle
global uw
uw = 0;
h = 0.05;    %Step size RKode
u_45 = start_vec(alfa, v0);
bana = RKode(u_45, h);     %Runge Kuttas method of solving ODE. 
%Bana = Time X-pos X-speed Y-pos Y-speed
tend = LinPol2(bana.time, bana.y,0);
xend = LinPol2(bana.x, bana.y,0);
% Errors 
x_RK4_err = xend*RK4_relerr;
x_linpol_err = linpol_err(bana.x);
t_RK4_err = tend*RK4_relerr;
t_linpol_err = linpol_err(bana.time);
fprintf('--- Kast vid godycklig vinkel---\n')
fprintf('Vid kastvinkeln %i landar varpan p� %.3f%c%0.3fmeter\n',alfa, xend, pm, x_linpol_err + x_RK4_err)
fprintf('efter tiden %0.3f%c%0.3f sekunder\r\n', tend, pm, t_RK4_err + t_linpol_err) 

%% --------Part 2----------
%Find angles that give a winning throw 
%Assume that high trajectory is at >45 deg and low at <45 deg
alfa_high = alfa + 30;       %Starting value, high trajectory
alfa_low = alfa - 40;        %Starting value, low trajectory
[angle_high, n_high] = Sekant(alfa, alfa_high, v0, h); %Secant method for finding solution to high traj. n = number of iterations
[angle_low, n_low] = Sekant(alfa, alfa_low, v0, h);     %Secant method for finding solution to low traj. n = number of iterations
u_high = start_vec(angle_high, v0);
bana_high = RKode(u_high, h);       % Calculate high trajectory
u_low = start_vec(angle_low, v0);
bana_low = RKode(u_low, h);      % Calculate low trajectory
fprintf('--- Vinnande kastvinklar utan vind ---\n')
fprintf('Vinnande kastvinklar �r %0.2f%c%.3f och %0.2f%c%.3f grader.\n\n',angle_high, pm, secant_err, angle_low, pm, secant_err )

%% --------Part 3-------
%Interpolate and plot winning throws
%High throw
high_table = Metertabell(bana_high, errors);
low_table = Metertabell(bana_low, errors);
disp('High trajectory')
%disp(struct2table(high_table))
disp('Low trajectory')
%disp(struct2table(low_table))


figure(1)
h1 = plot(high_table.x, high_table.y, 'bo-');
hold on
h2 = plot(low_table.x,low_table.y, 'rx-');
plot(bana_high.x, bana_high.y)
plot(bana_low.x, bana_low.y)
legend([h1 h2],{'H�g bana', 'L�g bana'})
title('Kastbanor f�r vinnande kast')
xlabel('X-position [m]')
ylabel('Y-position [m]')
grid on

%% ---------Part 4----------
%Simulate throws in the wind
v2 = [30 35 40];       %Inital speed
uw2 = [-2 -10 -20]; %Wind speeds
fprintf('--- Vinnande kastvinklar vid olika motvind ---\n')
for i = 1:3
    uw = uw2(i);
    [angle_high, n_high] = Sekant(alfa, alfa_high, v2(i), h); %Secant method for finding solution to high traj. n = number of iterations
    [angle_low, n_low] = Sekant(alfa, alfa_low, v2(i), h);     %Secant method for finding solution to low traj. n = number of iterations
    u_high_uw = start_vec(angle_high, v2(i));
    bana_high = RKode(u_high_uw, h);
    u_low_uw = start_vec(angle_low, v2(i));
    bana_low = RKode(u_low_uw, h);
    fprintf('Vid V=%i och uw=%i �r vinnande kastvinklar �r %0.2f och %0.2f grader.\n',v2(i), uw, angle_high, angle_low)
    figure
    h1 = plot(bana_high.x,bana_high.y);
    hold on
    h2 = plot(bana_low.x,bana_low.y,'r');
    grid on;
    xlabel('X-position [m]');
    ylabel('Y-position [m]');
    legend([h1 h2],{'H�g bana', 'L�g bana'}); 
    str = sprintf('Kastbanor f�r vinnande kast vid u_w=%i',uw2(i));
    title(str)
end
fprintf('Alla vinklar har felet 0.05 och ger landning p� 20%c%0.2fm\r\n', pm, RK4_relerr*20)
%% ----- Part 5-------
% Calculate convergences and errors
%Convergence rate of Runge Kutta's Method
fprintf('--- Felskattningar ---\n')
% Repeat RK4 while halving step size
uw = 0; 
H =[];
u_test = u_45;
num_tests = 3;

for i=0:num_tests - 1
    htest = h*2^i;       %Halve step length with every iteration
    test = rkevalerror(u_test, htest);
    H(i + 1) = test.x;        %Evaluate next last value of landing x-value
end

% Get all diffs to verify results of error calc
delta = diff(H);
errors_RK4 = [];
conv_rate = delta(2)/delta(1);
rk_relerr = (H(1) - H(2))/H(1)

fprintf('Runge Kutta konvergerar med hastigheten %6.2f\r',conv_rate)
fprintf('Runge Kutta har relativt fel %6.2f\r', rk_relerr)

% Get Hermite error
Hermitefel()




