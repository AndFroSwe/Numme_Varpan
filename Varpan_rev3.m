%Varpan rev3
%Andreas Fröderberg och Isa Nedersjö
%Edited 2014-10-31 AF
clc, clear all, close all;    %Clear window

%% ---------Part 1---------
%Solve ODE for arbitrary throwing angle
v0 = 19;
alfa = 45;    %Arbitrary throwing angle
uw1 = 0;
h = 0.005;    %Step size RKode
bana = RKode(alfa,v0,uw1,h);     %Runge Kuttas method of solving ODE. 

%Bana = Time X-pos X-speed Y-pos Y-speed
tend = LinPol2(bana(:,1),bana(:,4),0);
xend = LinPol2(bana(:,2),bana(:,4),0);
sprintf('Vid kastvinkeln %i landar varpan på %.3f meter efter tiden %.3f.',alfa,xend,tend) %Display results

%% --------Part 2----------
%Find angles that give a winning throw 
%Assume that high trajectory is at >45 deg and low at <45 deg
alfa_high = alfa + 30;       %Starting value, high trajectory
alfa_low = alfa - 30;        %Starting value, low trajectory
[angle_high, n_high] = Sekant(alfa, alfa_high,v0,uw1,h); %Secant method for finding solution to high traj. n = number of iterations
[angle_low, n_low] = Sekant(alfa, alfa_low,v0,uw1,h);     %Secant method for finding solution to low traj. n = number of iterations
bana_high = RKode(angle_high,v0,uw1,h);
bana_low = RKode(angle_low,v0,uw1,h);
sprintf('Vinnande kastvinklar är %0.2f och %0.2f grader.',angle_high,angle_low)

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
v1 = 100;       %Inital speed
uw2 = [2 10 20]; %Wind speeds
for i = 1:3
    [angle_high, n_high] = Sekant(alfa, alfa_high,v0,uw2(i),h); %Secant method for finding solution to high traj. n = number of iterations
    [angle_low, n_low] = Sekant(alfa, alfa_low,v0,uw2(i),h);     %Secant method for finding solution to low traj. n = number of iterations
    bana_high = RKode(angle_high,v0,uw2(i),h);
    bana_low = RKode(angle_low,v0,uw2(i),h);
    sprintf('Vid uw = %i är vinnande kastvinklar är %0.2f och %0.2f grader.',uw2(i),angle_high,angle_low)
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

%% ----- Part 5-------
%Convergence rate of Runge Kutta's Method

H =[];

for i=1:3
    htest = 0.1/(2^(i-1));       %Halve step length with every iteration
    test = RKode(alfa,v0,uw1,htest);
    H(i) = test(end-1,2);        %Evaluate next last value of landing x-value
end

delta = diff(H);
kvot = delta(1)/delta(2);
fprintf('Runge Kutta konvergerar med hastigheten %6.2f\r\n',kvot)






