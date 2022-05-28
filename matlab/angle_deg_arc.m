function [deg, arcmin, arcsec] = angle_deg_arc(angle)
% ANGLE_DEG_ARC - Convert degrees to degree-arcmin-arcsec angle.
%
% Convert angle in degree to degree, arcmin, arcsec format.
%
% INPUTS:
%   angle      The angle in degrees.
%
% OUTPUTS:
%   deg        The hour angle (Integer).
%   arcmin     The minute angle (Integer).
%   arcsec     The sec angle (Floating point).
%

% Limit to the interval [0, 360):
angle = mod(angle, 360.0);
deg = floor(angle);
arcmin = floor((angle - deg) * 60.0);
arcsec = (angle - deg - arcmin/60.0) * 3600.0;
