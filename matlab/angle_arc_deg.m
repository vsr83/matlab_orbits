function [angle] = angle_arc_deg(deg, arcmin, arcsec)
% ANGLE_ARC_DEG - Convert degree-arcmin-arcsec angle to degrees.
%
% Convert angle in the degree, arcmin, arcsec format to degrees.
%
% INPUTS:
%   deg        The hour angle (0-23).
%   arcmin     The minute angle (0-59).
%   arcsec     The sec angle (0-59).
%
% OUTPUTS:
%   angle      The angle in degrees.
%

angle = deg + arcmin/60.0 + arcsec/3600.0;