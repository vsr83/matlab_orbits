function GAST = sidereal_time_gast(JD, JT, N)
% SIDEREAL_TIME_GAST - Compute Greenwich Apparent Sidereal Time (GAST)
%
% INPUTS:
%   JD         UT1 Julian Date
%   JT         UT1 Julian Time
%   N          Nutation Matrix
%
% OUTPUTS:
%   GAST       GAST in degrees

GMST = sidereal_time_gmst(JD, JT);

% Nutation parameter for the difference between hour angles of true and 
% apparent equinox.
alpha_E = atand(N(1, 2) / N(1, 1));
% Greenwich Apparent Sidereal Time (GAST) 
GAST = GMST + alpha_E;
