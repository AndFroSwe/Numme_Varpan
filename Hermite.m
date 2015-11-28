function yut = Hermite(x,x1,x2,y1,y2,k1,k2)
% HERMITE(xtarget, x1, x2, y1, y2, ydot1, ydot2) - Hermite interpolation
% for point xtarget between x1 and x2.

h = x2-x1;

c1 = y1 ;
c2 = (y2-y1)/h;
c3 = (k2-c2)/h^2;
c4 = (k1-c2)/h^2;

yut = c1+c2*(x-x1)+c3*(x-x1)^2*(x-x2)+c4*(x-x1)*(x-x2)^2;
