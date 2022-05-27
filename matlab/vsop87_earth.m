function [r_ecl] = vsop87_earth(JT)
% VSOP87_EARTH - Compute ecliptic position of Earth.
%
% Compute the position of Earth using the VSOP87 trigonometric series 
% expansion.
%
% INPUTS:
%   JT         The Julian Time.
%
% OUTPUTS:
%   r_ecl      Position in Ecliptic coordinates.
%
% References:
% [1] P. Bretagnon, G. Francou - Planetary theories in rectangular and spherical variables.
% VSOP87 solutions, Astron. Astrophys., 1988.


t = (JT - 2451_545.0) / 365_250;

load ../data/VSOP87A_earth.txt;

inds = [1310, 1311, 1312, 1313, 1314, 1315; ...
        1320, 1321, 1322, 1323, 1324, 1325; ...
        1330, 1331, 1332, 1333, 1334, 1335];

r = [0; 0; 0];
for ind_dim = 1:3
    for ind_power = 1:6
        t_power = t^(ind_power -1);

        ind = find(VSOP87A_earth(:, 1) == inds(ind_dim, ind_power));

        r(ind_dim) = r(ind_dim) + t_power * sum(VSOP87A_earth(ind, 2) ...
                   .* cos(VSOP87A_earth(ind, 3) + VSOP87A_earth(ind, 4) * t));
    end
end

r_ecl = 149597870700 * r;
