function GAST = sidereal_time_gast(JT, N)
% SIDEREAL_TIME_GAST - Compute Greenwich Apparent Sidereal Time (GAST)
%
% INPUTS:
%   JT         UT1 Julian Time
%   N          Nutation Matrix
%
% OUTPUTS:
%   GAST       GAST in degrees
%
% References:
% [1] E. Suirana, J. Zoronoza, M. Hernandez-Pajares - GNSS Data Processing -
% Volume I: Fundamentals and Algorithms, ESA 2013.
% [2] IERS Technical Note No. 36
%
if nargin < 3
    N = matrix_mod_tod(JT);
end

GMST = sidereal_time_gmst(JT);

% Equations (A.37)
alpha_E = atand(N(1, 2) / N(1, 1));
% Greenwich Apparent Sidereal Time (GAST) 
% Equations (A.1)
GAST = mod(GMST - alpha_E, 360.0);
