function [r_ec, v_ec] = kepler_ecliptic(JT, a, ecc, incl, L, Lperi, Omega)
% KEPLER_ECLIPTIC - Compute ecliptic coordinates from Keplerian elements.
%
% INPUTS:
%   JT         The Julian Time.
%   a          Semi-major axis (m).
%   b          Semi-minor axis (m).
%   ecc        Eccentricity.
%   incl       Inclination (degrees).
%   L          Mean longitude (degrees).
%   Lperi      Longitude of periapsis (degrees).
%   Omega      Longitude of the ascending node (degrees).
%
% OUTPUTS:
%   r_ec       Ecliptic position.
%   v_ec       Ecliptic velocity
%

au_meters = 1.495978707e11;
mu = 1.32712440018e20;

b = a * sqrt(1 - ecc * ecc);
omega = Lperi - Omega;
M = L - Lperi;

E = kepler_solve(M, ecc, 1e-8, 10);
[r_per, v_per] = kepler_perifocal(a, b, E, mu);
[r_ec, v_ec] = coord_perifocal_inertial(r_per, v_per, Omega, incl, omega);

