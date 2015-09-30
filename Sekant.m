function [rot, n] = Sekant(alfa1, alfa2, v, h)
%Secant method for finding winning throwing angles

% Define parameters
global uw

n = 0;
diff = 1;
f0 = Nedslag(alfa1, v, h);
target = 20;

% Secant method loop
while diff > 0.005;
  f1 = Nedslag(alfa2, v, h);
  alfa = alfa2 -(f1 - target)*(alfa2 - alfa1)/(f1 - f0);
  alfa1 = alfa2;
  alfa2 = alfa;
  f0 = f1;
  diff = abs(alfa2 - alfa1);
  n = n+1;
end;

rot = alfa;
