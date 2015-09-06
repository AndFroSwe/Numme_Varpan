function xend  = Nedslag(alfa,v,uw,h)
%Solves ODE and interpolates x-value at impact
bana = RKode(alfa,v,uw,h);
xend = LinPol2(bana(:,2),bana(:,4),0);
