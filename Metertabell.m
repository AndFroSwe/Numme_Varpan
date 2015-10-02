function meter_table = Metertabell(bana, errors)
% METERTABELL - Takes a trajectory builds a table meter for meter
% METERTABELL(traj)

meter_table = struct(   'x', [bana.x(1)],...
                        'y', [bana.y(1)],...
                        'err', [0]);

n = 1;       % Current meter
m = 1;       % Index

% Search through trajectory to find even meters
while n <= 20
    % Interpolate value, Hermite
    if bana.x(m) - n >= 0;
        y = Hermite(n, bana.x(m-1), bana.x(m), bana.y(m-1), bana.y(m), bana.yvel(m-1), bana.yvel(m));
        meter_table.x = [meter_table.x; n];
        meter_table.y = [meter_table.y; y];
        err_tot = y*errors.RK4 + errors.hermite;
        meter_table.err = [meter_table.err; err_tot];
        n = n + 1;
    end
    m = m + 1;
end

% Add error for linear approximation of landing to last element
meter_table.err(end) = meter_table.err(end) + linpol_err(bana.y);

