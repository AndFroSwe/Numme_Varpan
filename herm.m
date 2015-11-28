function [times, y_interp_all] = herm(bana, n, k)
% Uses hermite to plot curve between interpolated points

points = 100*k;
times = [];
y_interp_all = [];
t1 = bana.time(n);
t2 = bana.time(n + 1);

% Loop over points, gradually increase t between points
for i = 1:points
    t = t1 + (t2-t1)*i/points;
    y_interp = Hermite(     t,...
                            t1, t2,...
                            bana.y(n), bana.y(n + 1),...
                            bana.yvel(n), bana.yvel(n + 1));      

    y_interp_all = [y_interp_all y_interp];
    times = [times t];
end
