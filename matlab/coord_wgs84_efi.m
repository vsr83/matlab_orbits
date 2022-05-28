function r = coord_wgs84_efi(lat, lon, h)
% COORD_WGS84_EFI - Compute EFI position from the latitude, longitude and 
% altitude on WGS84.
%
% INPUTS:
%   lat        Latitude in WGS84 (in degrees).
%   lon        Longitude in WGS84 (in degrees).
%   h          Altitude in WGS84 (in degrees).
%
% OUTPUTS:
%   r          The position in EFI (in meters).
%
% References:
% [1] E. Suirana, J. Zoronoza, M. Hernandez-Pajares - GNSS Data Processing -
% Volume I: Fundamentals and Algorithms, ESA 2013.

% Semi-major axis:
a = 6378137;
% Eccentricity sqrt(1 - (b*b)/(a*a))
ecc = 0.081819190842966;
ecc2 = ecc*ecc;

N = a/sqrt(1 - (ecc*sind(lat))^2);
r = [(N + h) * cosd(lat)*cosd(lon); ...
     (N + h) * cosd(lat)*sind(lon); ...
     ((1 - ecc2)*N + h)*sind(lat)];

end