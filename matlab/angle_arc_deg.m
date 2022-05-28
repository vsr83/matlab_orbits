function [angle] = angle_arc_deg(deg, arcmin, arcsec)
% ANGLE_ARC_DEG - Convert degree-arcmin-arcsec angle to degrees.
%
% Convert angle in the degree, arcmin, arcsec format to degrees.
%
% INPUTS:
%   deg        The degree (integer).
%   arcmin     The minute angle (integer).
%   arcsec     The sec angle (floating point).
%
% OUTPUTS:
%   angle      The angle in degrees.
%

angle = deg + arcmin/60.0 + arcsec/3600.0;