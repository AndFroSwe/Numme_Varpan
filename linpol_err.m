% Function takes a vector and assesses a linear intepolation error on last
% 2 values
function [err] = linpol_err(v, col)

next_last = v(end-1, col);
last = v(end, col);

mid = mean([next_last last]);
err = abs(last - mid);

