function [r_ecl] = vsop87_mercury(JT)
% VSOP87_MERCURY - Compute ecliptic position of Mercury.
%
% Compute the position of Mercury using the VSOP87 trigonometric series 
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

load ../data/VSOP87A_mercury.txt;

inds = [1110, 1111, 1112, 1113, 1114, 1115; ...
        1120, 1121, 1122, 1123, 1124, 1125; ...
        1130, 1131, 1132, 1133, 1134, 1135];

r = [0; 0; 0];
for ind_dim = 1:3
    for ind_power = 1:6
        t_power = t^(ind_power -1);

        ind = find(VSOP87A_mercury(:, 1) == inds(ind_dim, ind_power));

        r(ind_dim) = r(ind_dim) + t_power * sum(VSOP87A_mercury(ind, 2) ...
                   .* cos(VSOP87A_mercury(ind, 3) + VSOP87A_mercury(ind, 4) * t));
    end
end

r_ecl = 149597870700 * r;
