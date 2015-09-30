function x = tabell(bana)
% TABELL - Takes a trajectory and plots and displays it meter for meter
% TABELL(traj)

x = bana(1,[2 4]);
n = 1;       %Target value
m = 1;       %Index

% Search through trajectory to find even meters
while n<=20
    % Interpolate value, Hermite
    if bana(m,2)-n >= 0;
        y = herm(n, bana(m-1,2), bana(m,2), bana(m-1,4), bana(m,4), bana(m-1,5), bana(m,5));
        x = [x; n y];
        n = n+1;
        m = m+1;
    else
        m = m+1;
    end
end
