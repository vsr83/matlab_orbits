function [r_ecl, v_ecl] = vsop87_mars(JT)
% VSOP87_MARS - Compute ecliptic position of Mars.
%
% Compute the position of Mars using the VSOP87 trigonometric series 
% expansion.
%
% INPUTS:
%   JT         The Julian Time.
%
% OUTPUTS:
%   r_ecl      Position in Ecliptic coordinates (m).
%   v_ecl      Velocity in Ecliptic coordinates (m/s).
%
% References:
% [1] P. Bretagnon, G. Francou - Planetary theories in rectangular and spherical variables.
% VSOP87 solutions, Astron. Astrophys., 1988.


t = (JT - 2451545.0) / 365250;

load ../data/VSOP87A_mars.txt;

inds = [1410, 1411, 1412, 1413, 1414, 1415; ...
        1420, 1421, 1422, 1423, 1424, 1425; ...
        1430, 1431, 1432, 1433, 1434, 1435];

r = [0; 0; 0];
v = [0; 0; 0];
for ind_dim = 1:3
    for ind_power = 1:6
        t_power = t^(ind_power -1);

        ind = find(VSOP87A_mars(:, 1) == inds(ind_dim, ind_power));

        r(ind_dim) = r(ind_dim) + t_power * sum(VSOP87A_mars(ind, 2) ...
                   .* cos(VSOP87A_mars(ind, 3) + VSOP87A_mars(ind, 4) * t));
        v(ind_dim) = v(ind_dim) - t_power * sum(VSOP87A_mars(ind, 2) ...
                .* VSOP87A_mars(ind, 4) .* sin(VSOP87A_mars(ind, 3) + VSOP87A_mars(ind, 4) * t));
    end
end

% [v] = au / (1000 * year) = 149597870700 m / (365250 * 86400 s) = 4.740470463533349 m/s
r_ecl = 149597870700 * r;
v_ecl = 4.740470463533349 * v;