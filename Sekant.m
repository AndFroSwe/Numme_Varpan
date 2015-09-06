function [rot,n] = Sekant(alfa1,alfa2,v,uw,h)
%Secant method for finding winning throwing angles

n=0;
diff = 1;
f0 = Nedslag(alfa1,v,uw,h);
while diff>0.005;
  f1 = Nedslag(alfa2,v,uw,h);
  alfa = alfa2-(f1-20)*(alfa2-alfa1)/(f1-f0);
  alfa1 = alfa2;
  alfa2 = alfa;
  f0 = f1;
  diff = abs(alfa2-alfa1);
  n = n+1;
end;
rot = alfa;
