function [lat, lon, dist] = coord_efi_sph(r)
% COORD_EFI_SPH - Compute the latitude, longitude and altitude on a sphere 
% from EFI position.
%
% INPUTS:
%   r          The position in EFI (in meters).
%
% OUTPUTS:
%   lat        Latitude on a sphere (in degrees).
%   lon        Longitude on a sphere (in degrees).
%   dist       Distance from center of the sphere (in meters).
%
% References:

lon = atan2d(r(2), r(1));
lat = asind(r(3) / norm(r));
dist = norm(r);

end