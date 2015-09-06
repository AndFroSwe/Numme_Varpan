function xut = LinPol2 (x,y,yend)
% Linear interpolation of x-value from known y-value
% Vector lin is [x1 x2 y1 y2]

x1 = x(end-1); 
x2 = x(end);
y1 = y(end-1);
y2 = y(end);

xut = LinPol(x1,x2,y1,y2,yend);
