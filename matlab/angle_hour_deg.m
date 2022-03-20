function [angle] = angle_hms_deg(hour, minute, sec)
% ANGLE_HMS_DEG - Convert between hour:
%
% Convert angle in the hour, minute, sec format to degrees.
%
% INPUTS:
%   hour       The hour angle.
%   minute     The minute angle.
%   sec        The sec angle.
%
% OUTPUTS:
%   angle      The angle in degrees.
%

angle = 360 * (hour/24 + minutes/(24*60) + sec/(24*60*60));