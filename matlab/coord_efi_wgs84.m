function [lat, lon, h] = coord_efi_wgs84(r, max_iter, max_err, verbose)
% COORD_EFI_WGS84 - Compute the latitude, longitude and altitude in WGS84 
% from EFI position.
%
% INPUTS:
%   r          The position in EFI (in meters).
%   max_iter   Maximum number of iterations (default 5)
%   max_err    Maximum relative error in meters (default 1e-10)
%   verbose    Display convergence information
%
% OUTPUTS:
%   lat        Latitude in WGS84 (in degrees).
%   lon        Longitude in WGS84 (in degrees).
%   h          Altitude in WGS84 (in degrees).
%
% References:
% [1] E. Suirana, J. Zoronoza, M. Hernandez-Pajares - GNSS Data Processing -
% Volume I: Fundamentals and Algorithms, ESA 2013.

% Semi-major axis:
a = 6378137;
% Semi-minor axis:
b = 6356752.314245;
% Eccentricity sqrt(1 - (b*b)/(a*a))
ecc = 0.081819190842966;
ecc2 = ecc*ecc;

if nargin < 2
    max_iter = 5;
end
if nargin < 3
    % Less than a millimeter for LEO satellites.
    max_err = 1.0e-10;
end
if nargin < 4
    verbose = false;
end

% Longitude (B.4)
lon = atan2d(r(2), r(1));
% Initial value for latitude (B.5)
p = sqrt(r(1)*r(1) + r(2)*r(2));
lat = atand((r(3) / p) / (1 - ecc2)); 

for iter = 1:max_iter
    % Iteration (B.6)
    N = a/sqrt(1 - (ecc*sind(lat))^2);
    h = p/cosd(lat) - N;
    lat = atand((r(3)/p)/(1 - ecc2*(N/(N + h))));

    r_iter = coord_wgs84_efi(lat, lon, h);
    err = norm(r_iter - r) / norm(r);

    if verbose
        disp(sprintf("iter %d: error %g", iter, err));
    end
    if err < max_err 
        break;
    end
end

if err >= max_err
    error(sprintf('Convergence failed: num_iter=%d, error=%g>%g', ...
          max_iter, err, max_err));
end

end