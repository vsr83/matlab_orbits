function [r_ecl] = vsop87_saturn(JT)
% VSOP87_SATURN - Compute ecliptic position of Saturn.
%
% Compute the position of Saturn using the VSOP87 trigonometric series 
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

load ../data/VSOP87A_saturn.txt;

inds = [1610, 1611, 1612, 1613, 1614, 1615; ...
        1620, 1621, 1622, 1623, 1624, 1625; ...
        1630, 1631, 1632, 1633, 1634, 1635];

r = [0; 0; 0];
for ind_dim = 1:3
    for ind_power = 1:6
        t_power = t^(ind_power -1);

        ind = find(VSOP87A_saturn(:, 1) == inds(ind_dim, ind_power));

        r(ind_dim) = r(ind_dim) + t_power * sum(VSOP87A_saturn(ind, 2) ...
                   .* cos(VSOP87A_saturn(ind, 3) + VSOP87A_saturn(ind, 4) * t));
    end
end

r_ecl = 149597870700 * r;
