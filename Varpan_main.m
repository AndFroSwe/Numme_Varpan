%Varpan
%Isa Nedersjö
clc, clear all, close all;    %Clear window
pm = char(177); % Define plus minus symbol
RK4_relerr = 0.0209e-2;
secant_err = 0.005;
%% ---------Part 1---------

%Solve ODE for arbitrary throwing angle
v0 = 19;
alfa = 45;    %Arbitrary throwing angle
global uw
uw = 0;
h = 0.005;    %Step size RKode
u_45 = start_vec(alfa, v0);
bana = RKode(u_45, h);     %Runge Kuttas method of solving ODE. 
%Bana = Time X-pos X-speed Y-pos Y-speed
tend = LinPol2(bana.time, bana.y,0);
xend = LinPol2(bana.x, bana.y,0);
% Errors 
t_err = linpol_err(bana.time);
x_RK4_err = xend*RK4_relerr;
x_linpol_err = linpol_err(bana.x);
t_RK4_err = tend*RK4_relerr;
t_linpol_err = linpol_err(bana.time);
fprintf('--- Kast vid godycklig vinkel---\n')
fprintf('Vid kastvinkeln %i landar varpan på %.3f%c%0.3fmeter\n',alfa, xend, pm, x_linpol_err + x_RK4_err)
fprintf('efter tiden %0.3f%c%0.3f sekunder\r\n', tend, pm, t_RK4_err + t_linpol_err) 

%% --------Part 2----------
%Find angles that give a winning throw 
%Assume that high trajectory is at >45 deg and low at <45 deg
alfa_high = alfa + 30;       %Starting value, high trajectory
alfa_low = alfa - 30;        %Starting value, low trajectory
[angle_high, n_high] = Sekant(alfa, alfa_high,v0,uw,h); %Secant method for finding solution to high traj. n = number of iterations
[angle_low, n_low] = Sekant(alfa, alfa_low,v0,uw,h);     %Secant method for finding solution to low traj. n = number of iterations
bana_high = RKode(angle_high,h);
bana_low = RKode(angle_low,v0,uw,h);
fprintf('--- Vinnande kastvinklar utan vind ---\n')
fprintf('Vinnande kastvinklar är %0.2f%c%.3f och %0.2f%c%.3f grader.\n\n',angle_high, pm, secant_err, angle_low, pm, secant_err )
fprintf('Alla vinklar har felet 0.05\n')

%% --------Part 3-------
%Interpolate and plot winning throws
%High throw
x_high = tabell(bana_high);
x_low = tabell(bana_low);

figure(1)
h1 = plot(x_high(:,1),x_high(:,2),'bo-');
hold on
h2 = plot(x_low(:,1),x_low(:,2),'rx-');
legend([h1 h2],{'Hög bana', 'Låg bana'})
title('Kastbanor för vinnande kast')
xlabel('X-position [m]')
ylabel('Y-position [m]')
grid on

%% ---------Part 4----------
%Simulate throws in the wind
v1 = 30;       %Inital speed
uw2 = [2 10 20]; %Wind speeds
fprintf('--- Vinnande kastvinklar vid olika motvind ---\n')
for i = 1:3
    uw = uw2(i)
    [angle_high, n_high] = Sekant(alfa, alfa_high,v0,h); %Secant method for finding solution to high traj. n = number of iterations
    [angle_low, n_low] = Sekant(alfa, alfa_low,v0,h);     %Secant method for finding solution to low traj. n = number of iterations
    bana_high = RKode(angle_high,v1, h);
    bana_low = RKode(angle_low,v1,h);
    fprintf('Vid uw = -%i är vinnande kastvinklar är %0.2f och %0.2f grader.\n',uw2,angle_high,angle_low)
    figure
    h1 = plot(bana_high(:,2),bana_high(:,4));
    hold on
    h2 = plot(bana_low(:,2),bana_low(:,4),'r');
    axis([0 21 0 12]);
    grid on;
    xlabel('X-position [m]');
    ylabel('Y-position [m]');
    legend([h1 h2],{'Hög bana', 'Låg bana'}); 
    str = sprintf('Kastbanor för vinnande kast vid u_w=-%i',uw2(i));
    title(str)
end
fprintf('\n')
%% ----- Part 5-------
% Calculate convergences and errors
%Convergence rate of Runge Kutta's Method
fprintf('--- Felskattningar ---\n')
% Repeat RK4 while halving step size
H =[];
tol = 1e-3;
for i=1:4
    htest = 0.01/(2^(i-1));       %Halve step length with every iteration
    test = RKode(alfa,v0,uw,htest);
    ind = find(abs(test(:,1)-2.0)<tol);  % Tolerance negates truncation error when finding 2.0
    H(i) = test(ind,2);        %Evaluate next last value of landing x-value
end

% Second htest = 0.005, step length used in calculations
rel_err_RK4 = 1 - H(2)/H(1);
fprintf('Relativt fel för RK4 med steglängd %0.4f är %f%%\r', h, abs(rel_err_RK4*100))
% Get all diffs to verify results of error calc
delta = diff(H);
errors_RK4 = [];
for i = 1:(length(delta)-1)
    ratio = delta(i)/delta(i+1);
    errors_RK4 = [errors_RK4 ratio];
end

deviations = errors_RK4 - mean(errors_RK4);
conv_rate = mean(errors_RK4);
fprintf('Runge Kutta konvergerar med hastigheten %6.2f\r',conv_rate)
fprintf('Konvergensberäkning har maximal avvikelse %0.2f*10^-3\r', max(abs(deviations))*1e3)





