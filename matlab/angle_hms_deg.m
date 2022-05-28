function [angle] = angle_hms_deg(hour, minute, sec)
% ANGLE_HMS_DEG - Convert hour-minute-second angle to degrees.
%
% Convert angle in the hour, minute, sec format to degrees.
%
% INPUTS:
%   hour       The hour angle (Integer, 0-23).
%   minute     The minute angle (Integer, 0-59).
%   sec        The sec angle (Floating point, 0-60).
%
% OUTPUTS:
%   angle      The angle in degrees.
%

angle = 360 * (hour/24 + minute/(24*60) + sec/(24*60*60));