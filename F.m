function F = F(u,k,uw)
% ODE for use in function RK
F = [u(2) -k(1)*(u(2)-uw)*sqrt((u(2)-uw)^2+u(4)^2) u(4) -9.81-k(2)*u(4)*sqrt((u(2)-uw)^2+u(4)^2)];
end