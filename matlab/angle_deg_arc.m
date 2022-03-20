function [deg, arcmin, arcsec] = angle_deg_arc(angle)
% ANGLE_DEG_ARC - Convert degrees to degree-arcmin-arcsec angle.
%
% Convert angle in degree to degree, arcmin, arcsec format.
%
% INPUTS:
%   angle      The angle in degrees.
%
% OUTPUTS:
%   deg        The hour angle (0-23).
%   arcmin     The minute angle (0-59).
%   arcsec     The sec angle (0-59).
%

% Limit to the interval [0, 360):
angle = mod(angle, 360.0);
deg = floor(angle);
arcmin = floor((angle - deg) * 60.0);
arcsec = (angle - deg - arcmin/60.0) * 3600.0;
