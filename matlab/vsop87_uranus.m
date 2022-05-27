function [r_ecl] = vsop87_uranus(JT)
% VSOP87_URANUS - Compute ecliptic position of Uranus.
%
% Compute the position of Uranus using the VSOP87 trigonometric series 
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

load ../data/VSOP87A_uranus.txt;

inds = [1710, 1711, 1712, 1713, 1714, 1715; ...
        1720, 1721, 1722, 1723, 1724, 1725; ...
        1730, 1731, 1732, 1733, 1734, 1735];

r = [0; 0; 0];
for ind_dim = 1:3
    for ind_power = 1:6
        t_power = t^(ind_power -1);

        ind = find(VSOP87A_uranus(:, 1) == inds(ind_dim, ind_power));

        r(ind_dim) = r(ind_dim) + t_power * sum(VSOP87A_uranus(ind, 2) ...
                   .* cos(VSOP87A_uranus(ind, 3) + VSOP87A_uranus(ind, 4) * t));
    end
end

r_ecl = 149597870700 * r;
