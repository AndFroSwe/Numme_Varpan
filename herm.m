function [xpos, v] = herm(bana, n)

points = 100;
xpos = [];
v = [];
x1 = bana.x(n);
x2 = bana.x(n + 1);


for i = 1:points
    x = x1 + (x2-x1)*i/points;
    p = Hermite(    x,...
                    x1, x2,...
                    bana.y(n), bana.y(n + 1),...
                    bana.yvel(n), bana.yvel(n + 1));
    v = [v p];
    xpos = [xpos x];
end

