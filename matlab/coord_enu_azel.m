function [az, el, dazdt, deldt] = coord_enu_azel(r_enu, v_enu)
% COORD_EFI_ENU - Convert coordinates and velocities between the ENU and 
% EFI frames.
%
% INPUTS:
%   r_enu      The position in ENU (3 x n).
%   v_enu      The velocity in ENU (3 x n).
%
% OUTPUTS:
%   az         Azimuth (in degrees).
%   el         Elevation (in degrees).
%   dazdt      Time-derivative of azimuth (in degrees/s).
%   deldt      Time-derivative of elevation (in degrees/s).
%
% References:
% [1] E. Suirana, J. Zoronoza, M. Hernandez-Pajares - GNSS Data Processing -
% Volume I: Fundamentals and Algorithms, ESA 2013.

% Compute norm for every column:
norm_r_enu = sqrt(r_enu(1, :).^2 + r_enu(2, :).^2 + r_enu(3, :).^2);
norm_r_enu = [norm_r_enu; norm_r_enu; norm_r_enu];

ru_enu = r_enu ./ norm_r_enu;
az = atan2d(ru_enu(1, :), ru_enu(2, :));
el = asind(ru_enu(3, :));

% TODO
dazdt = 0;
deldt = 0;