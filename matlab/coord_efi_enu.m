function [r_enu, v_enu] = coord_efi_enu(r_efi, v_efi, lat, lon, h)
% COORD_EFI_ENU - Convert coordinates and velocities between the EFI and 
% ENU frames.
%
% INPUTS:
%   r_efi      The position in EFI (3 x n).
%   v_efi      The velocity in EFI (3 x n).
%   lat        The observer latitude (in degrees).
%   lon        The observer longitude (in degrees).
%   h          The observer latitude (in degrees).
%
% OUTPUTS:
%   r_enu      The position in ENU (3 x n).
%   v_enu      The velocity in ENU (3 x n).
%   h          Altitude in WGS84 (in degrees).
%
% References:
% [1] E. Suirana, J. Zoronoza, M. Hernandez-Pajares - GNSS Data Processing -
% Volume I: Fundamentals and Algorithms, ESA 2013.

T = matrix_efi_enu(lat, lon);
% Position of the observer.
r_pefi = coord_wgs84_efi(lat, lon, h);

r_enu = T * (r_efi - r_pefi);
v_enu = T * v_efi;