function [RA, decl, dist] = position_moon(JT)
% POSITION_MOON - Compute Keplerian elements of planets in the solar
% system.
%
% Compute the position of the Moon.
%
% INPUTS:
%   JT         The Julian Time.
%
% OUTPUTS:
%   RA         Right-ascension of the center of the Moon.
%   decl       Declination of the center of the Moon.
%   dist       Distance of the Moon.
%
% References:
% [1] Meeus - Astronomical algorithms 1998.

% Julian centuries after J2000.0 epoch.
T = (JT - 2451545.0) / 36525.0;

T2 = T .* T;
T3 = T2 .* T;
T4 = T3 .* T;

% Meeus - Astronomical Algorithms 1998 Chapter 47.
% Mean longitude of the Moon.
Lm = 218.3164477 + 481267.88123421 * T - 0.0015786 * T2 + T3 / 538841.0 - T4 / 65194000.0;
% Mean elongation of the Moon from the Sun.
D  = 297.8501921 + 445267.11140340 * T - 0.0018819 * T2 + T3 / 545868.0 - T4 / 113065000.0;
% Mean anomaly of the Sun (Earth).
Ms = 357.5291092 + 35999.050290900 * T - 0.0001536 * T2 + T3 / 24490000.0;
% Mean anomaly of the Moon:
Mm = 134.9633964 + 477198.86750550 * T + 0.0087414 * T2 + T3 / 69699.0 - T4 / 14712000.0;
% Moon's argument of latitude:
F  =  93.2720950 + 483202.01752330 * T - 0.0036539 * T2 - T3 / 3526000.0 + T4 / 863310000.0;

A1 = 119.75 + 131.849 * T;
A2 =  53.09 + 479264.290 * T;
A3 = 313.45 + 481266.484 * T;

% Compute periodic terms for longitude, latitude and distance.
[sigma_L, sigma_R, sigma_B] = position_moon_sigma(D, Ms, Mm, F, T);

sigma_L = sigma_L + 3958*sind(A1) + 1962*sind(Lm - F) + 318*sind(A2);
sigma_B = sigma_B - 2235*sind(Lm) + 382*sind(A3)      + 175*sind(A1 - F) ... 
        +  175*sind(A1 + F) + 127*sind(Lm - Mm) - 115*sind(Lm + Mm);

% Ecliptic longitude, latitude and distance.
lambda = Lm + sigma_L / 1000000.0;
beta   = sigma_B / 1000000.0;
dist  = 385000.56 + sigma_R/1000.0;

[eps, deps, dpsi] = nutation_iau1980(JT);

lambda = lambda + dpsi;
eps = 23.4392911111 + deps;

% Apparent Right-Ascension and declination.
RA = atan2d(sind(lambda) .* cosd(eps) - tand(beta) .* sind(eps), cosd(lambda));
decl = asind(sind(beta) .* cosd(eps) + cosd(beta) .* sind(eps) .* sind(lambda));
