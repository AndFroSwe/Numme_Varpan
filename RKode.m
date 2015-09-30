% Implementation of RK4
% Returns a struct with trajectory
function [bana] = RKode(u, h)

yend  = 0;       %Desired end y-value
t = 0;
y = u(3);       % Starting y
v = [u];
bana = struct(  'time', [t]',...
                'x',    [u(1)]',...
                'xvel', [u(2)]',...
                'y',    [u(3)]',...
                'yvel', [u(4)]');

% Iterate RK until varpan hits ground
while y >= yend;
    [vut, tut] = RKstep(u, h, t);
    v = [v; vut];
    u = vut;
    t = tut;
    y = u(3);
    % Update struct
    bana.time = [bana.time; tut];
    bana.x = [bana.x; u(1)];
    bana.xvel = [bana.xvel; u(2)];
    bana.y = [bana.y; u(3)];
    bana.yvel = [bana.yvel; u(4)];
end
