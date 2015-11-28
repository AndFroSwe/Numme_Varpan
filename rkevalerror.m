function [bana] = rkevalerror (u, h)
% Function evaluates runge kutta för a predetermined length of time and
% returns end values.

t = 0;
t_end = 2;
y = u(3);       % Starting y
v = u;

bana = struct(  'time', t',...
                'x',    u(1)',...
                'xvel', u(2)',...
                'y',    u(3)',...
                'yvel', u(4)');
        
times = t:h:t_end;

for i = 1:length(times) - 1;
    [vut, tut] = RKstep(u, h, t);
    v = [v; vut];
    u = vut;
    t = tut;
    y = u(3);
    
end

% Save and return final values
bana.time = [tut];
bana.x = [u(1)];
bana.xvel = [u(2)];
bana.y = [u(3)];
bana.yvel = [u(4)];