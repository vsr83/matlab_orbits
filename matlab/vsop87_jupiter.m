function [r_ecl, v_ecl] = vsop87_jupiter(JT)
% VSOP87_JUPITER - Compute ecliptic position of Jupiter.
%
% Compute the position of Jupiter using the VSOP87 trigonometric series 
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


t = (JT - 2451_545.0) / 365_250;

load ../data/VSOP87A_jupiter.txt;

inds = [1510, 1511, 1512, 1513, 1514, 1515; ...
        1520, 1521, 1522, 1523, 1524, 1525; ...
        1530, 1531, 1532, 1533, 1534, 1535];

r = [0; 0; 0];
v = [0; 0; 0];
for ind_dim = 1:3
    for ind_power = 1:6
        t_power = t^(ind_power -1);

        ind = find(VSOP87A_jupiter(:, 1) == inds(ind_dim, ind_power));

        r(ind_dim) = r(ind_dim) + t_power * sum(VSOP87A_jupiter(ind, 2) ...
                   .* cos(VSOP87A_jupiter(ind, 3) + VSOP87A_jupiter(ind, 4) * t));
        v(ind_dim) = v(ind_dim) - t_power * sum(VSOP87A_jupiter(ind, 2) ...
                .* VSOP87A_jupiter(ind, 4) .* sin(VSOP87A_jupiter(ind, 3) + VSOP87A_jupiter(ind, 4) * t));
    end
end


% [v] = au / (1000 * year) = 149597870700 m / (365250 * 86400 s) = 4.740470463533349 m/s
r_ecl = 149597870700 * r;
v_ecl = 4.740470463533349 * v;