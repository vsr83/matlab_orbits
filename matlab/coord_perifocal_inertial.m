function [r_in, v_in] = coord_perifocal_inertial(r_per, v_per, Omega, incl, omega)
% COORD_PERIFOCAL_INERTIAL - Convert perifocal coordinates to inertial
% system.
%
% INPUTS:
%   r_per      Position in the perifocal frame (3 x n)
%   v_per      Velocity in the perifocal frame (3 x n)
%   Omega      The longitude of the ascending node (degrees)
%   incl       The inclination (degrees)
%   omega      The argument of periapsis (degrees)
%
% OUTPUTS:
%   r_in       Position in inertial frame (3 x n).
%   v_in       Velocity in inertial frame (3 x n).
%
% References:
% [1] H. Karttunen - Johdatus Taivaanmekaniikkaan, Ursa, 2001.

% (2.57)
T = matrix_rot3d(-Omega) * matrix_rot1d(-incl) * matrix_rot3d(-omega);

r_in = T * r_per;
v_in = T * v_per;