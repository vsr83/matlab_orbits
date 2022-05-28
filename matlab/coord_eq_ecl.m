function [r_ecl, v_ecl] = coord_eq_ecl(JT, r_q, v_q)
% COORD_EQ_ECL - Convert coordinates from equatorial to ecliptic system.
%
% INPUTS:
%   JT         Julian Time
%   r_eq       Position in equatorial frame (3 x n).
%   v_eq       Velocity in equatorial frame (3 x n).
%
% OUTPUTS:
%   r_ecl      Position in the ecliptic frame (3 x n)
%   v_ecl      Velocity in the ecliptic frame (3 x n)
%
% References:
% [1] H. Karttunen - Johdatus Taivaanmekaniikkaan, Ursa, 2001.

% Julian centuries after J2000.0 epoch.
T = (JT - 2451545.0) / 36525.0;

%eps = 23.439279444444445 - 0.013010213611111 * T - 5.086111111111112e-08 *T*T ...
%     + 0.565e-07 * (T^3) - 1.6e-10 * (T^4) - 1.205555555555555e-11 * (T^5);

[eps, deps, dpsi] = nutation_iau1980(JT);

% (2.57)
T = matrix_rot1d(-(eps + deps));

r_ecl = T * r_q;
v_ecl = T * v_q;