function [hour, minute, sec] = angle_deg_hms(angle)
% ANGLE_DEG_HMS - Convert hour-minute-second angle to degrees.
%
% Convert angle in the hour, minute, sec format to degrees.
%
% INPUTS:
%   angle      The angle in degrees.
%
% OUTPUTS:
%   hour       The hour angle (Integer, 0-23).
%   minute     The minute angle (Integer, 0-59).
%   sec        The sec angle (Floating point, 0-59).
%

hour_size = 360.0 / 24.0;
minute_size = hour_size / 60.0;
second_size = minute_size / 60.0;

% Limit to [0, 360):
angle = mod(angle, 360.0);

hour = floor(angle/hour_size);
minute = floor((angle - hour * 15.0)/minute_size);
sec = (angle - hour*hour_size - minute*minute_size)/second_size;