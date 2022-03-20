function T = matrix_efi_to_enu(lat, lon)
% MATRIX_EFI_TO_ENU - Compute the rotation matrix between the EFI and ENU
% frames.
%
% The rotation matrix between the EFI and ENU frames is determined
% according to latitude and longitude on the WGS84 ellipsoid. The
% transformation between the EFI and topocentric frames also includes a 
% translation.
%
% INPUTS:
%   lat        Latitude (in degrees)
%   lon        Longitude (in degrees)
%
% OUTPUTS:
%   RM         Polar Motion Matrix
%
% References:
% [1] E. Suirana, J. Zoronoza, M. Hernandez-Pajares - GNSS Data Processing -
% Volume I: Fundamentals and Algorithms, ESA 2013.

% (B.10)
T = matrix_rot1d(90.0 - lat) * matrix_rot3d(90 + lon);

end