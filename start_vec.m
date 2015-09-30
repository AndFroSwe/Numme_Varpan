function v = start_vec (deg, V)
% START_VEC returns a vector with starting values for given starting
% velocity V and starting angle deg.

x = 0;
xvel = cosd(deg)*V;
y = 1.5;
yvel = sind(45)*V;

v = [x xvel y yvel];