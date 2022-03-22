function [kepler, indices, names] = kepler_planets(JT)
% KEPLER_PLANETS - Compute Keplerian elements of planets in the solar
% system.
%
% The Keplerian elements are obtained via an linear approximation w.r.t.
% Julian centuries after the J2000.0 epoch.
%
% INPUTS:
%   JT         The Julian Time.
%
% OUTPUTS:
%   kepler     The Keplerian elements for the planets.
%   indices    Indices of elements in the matrix.
%   names      Names of the planets.
%
% References:
% [1] https://ssd.jpl.nasa.gov/planets/approx_pos.html

% Julian centuries after J2000.0 epoch.
T = (JT - 2451545.0) / 36525.0;

%   a             e           I            L          long.peri.    long.node.
%  au, au/Cy              deg, deg/Cy  deg, deg/Cy   deg, deg/Cy   deg, deg/Cy
kepler_planets = [...
0.38709927,  0.20563593,  7.00497902, 252.25032350,  77.45779628,  48.33076593;...
0.72333566,  0.00677672,  3.39467605, 181.97909950, 131.60246718,  76.67984255;...
1.00000261,  0.01671123, -0.00001531, 100.46457166, 102.93768193,   0.0;...
1.52371034,  0.09339410,  1.84969142,  -4.55343205, -23.94362959,  49.55953891;...
5.20288700,  0.04838624,  1.30439695,  34.39644051,  14.72847983, 100.47390909;...
9.53667594,  0.05386179,  2.48599187,  49.95424423,  92.59887831, 113.66242448;...
19.18916464, 0.04725744,  0.77263783, 313.23810451, 170.95427630,  74.01692503;...
30.06992276, 0.00859048,  1.77004347, -55.12002969,  44.96476227, 131.78422574];

kepler_planets_delta = [...
 0.00000037,  0.00001906, -0.00594749,149472.67411175, 0.16047689,-0.12534081;...
 0.00000390, -0.00004107, -0.00078890, 58517.81538729, 0.00268329,-0.27769418;...
 0.00000562, -0.00004392, -0.01294668, 35999.37244981, 0.32327364, 0.0;...
 0.00001847,  0.00007882, -0.00813131, 19140.30268499, 0.44441088,-0.29257343;...
-0.00011607, -0.00013253, -0.00183714,  3034.74612775, 0.21252668, 0.20469106;...
-0.00125060, -0.00050991,  0.00193609,  1222.49362201,-0.41897216,-0.28867794;...
-0.00196176, -0.00004397, -0.00242939,   428.48202785, 0.40805281, 0.04240589;...
 0.00026291,  0.00005105,  0.00035372,   218.45945325,-0.32241464,-0.00508664];

indices = struct();
indices.row_mercury = 1;
indices.row_venus   = 2;
indices.row_earth   = 3;
indices.row_mars    = 4;
indices.row_jupiter = 5;
indices.row_saturn  = 6;
indices.row_uranus  = 7;
indices.row_neptune = 8;

% Semi-major axis
indices.col_a = 1;
% Eccentricity
indices.col_e = 2;
% Inclination
indices.col_i = 3;
% Mean longitude
indices.col_L = 4;
% Longitude of perihelion
indices.col_lperi = 5;
% Longitude of ascending node.
indices.col_Omega = 6;

names = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", ...
         "Uranus", "Neptune"];

kepler = kepler_planets + T * kepler_planets_delta;
kepler(:, 3:6) = mod(kepler(:, 3:6), 360);