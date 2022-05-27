function [r_ecl] = vsop87_neptune(JT)
% VSOP87_NEPTUNE - Compute ecliptic position of Neptune.
%
% Compute the position of Neptune using the VSOP87 trigonometric series 
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

load ../data/VSOP87A_neptune.txt;

inds = [1810, 1811, 1812, 1813, 1814, 1815; ...
        1820, 1821, 1822, 1823, 1824, 1825; ...
        1830, 1831, 1832, 1833, 1834, 1835];

r = [0; 0; 0];
for ind_dim = 1:3
    for ind_power = 1:6
        t_power = t^(ind_power -1);

        ind = find(VSOP87A_neptune(:, 1) == inds(ind_dim, ind_power));

        r(ind_dim) = r(ind_dim) + t_power * sum(VSOP87A_neptune(ind, 2) ...
                   .* cos(VSOP87A_neptune(ind, 3) + VSOP87A_neptune(ind, 4) * t));
    end
end

r_ecl = 149597870700 * r;
