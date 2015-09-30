function xend  = Nedslag(alfa, v, h)
%Solves ODE and interpolates x-value at impact

u = start_vec(alfa, v);
bana = RKode(u, h);                 % Get trajectory
xend = LinPol2(bana.x, bana.y, 0);  % Interpolate landing
