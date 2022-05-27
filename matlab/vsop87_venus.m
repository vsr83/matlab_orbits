function [r_ecl] = vsop87_venus(JT)
% VSOP87_VENUS - Compute ecliptic position of Venus.
%
% Compute the position of Venus using the VSOP87 trigonometric series 
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

load ../data/VSOP87A_venus.txt;

inds = [1210, 1211, 1212, 1213, 1214, 1215; ...
        1220, 1221, 1222, 1223, 1224, 1225; ...
        1230, 1231, 1232, 1233, 1234, 1235];

r = [0; 0; 0];
for ind_dim = 1:3
    for ind_power = 1:6
        t_power = t^(ind_power -1);

        ind = find(VSOP87A_venus(:, 1) == inds(ind_dim, ind_power));

        r(ind_dim) = r(ind_dim) + t_power * sum(VSOP87A_venus(ind, 2) ...
                   .* cos(VSOP87A_venus(ind, 3) + VSOP87A_venus(ind, 4) * t));
    end
end

r_ecl = 149597870700 * r;
