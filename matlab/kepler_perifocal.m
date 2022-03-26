function [r_per, v_per] = kepler_perifocal(a, b, E, mu)
% KEPLER_PERIFOCAL - Convert Kepler elements to position and velocity in
% perifocal frame.
%
% INPUTS:
%   a          The semi-major axis (1 x n)
%   b          The semi-minor axis (1 x n)
%   E          The eccentric anomaly (degrees, 1 x n).
%   mu         Gravitational parameter.
%
% OUTPUTS:
%   r_per      Position in perifocal frame (3 x n).
%   v_per      Velocity in perifocal frame (3 x n).
%
% References:
% [1] H. Karttunen - Johdatus Taivaanmekaniikkaan, Ursa, 2001.

% Compute eccentricity:
ecc = sqrt(1 - (b./a).^2);
% Orbital period from Kepler's third law:
T = sqrt(4*pi*pi.*a.*a.*a./mu);
% Mean angular motion (angle per second).
n = 360.0 ./ T;

dim = length(ecc);

% Expression of the position in the perifocal frame (2.51):
r_per = [a .* (cosd(E) - ecc); b .* sind(E); zeros(1, dim)];
% Velocity vector is just the time-derivative of the above:
%mult = (2*pi/360.0) * n ./ (1 - ecc * (2*pi/360.0) .* cosd(E));
%v_per = [-a .* mult .* sind(E); b .* mult .* cosd(E); zeros(1, dim)];


dEdt = n ./ (1 - ecc .* cosd(E));
v_per = [-a .* dEdt .* sind(E); ...
          b .* dEdt .* cosd(E); ...
          zeros(1, dim)] * (pi/180);