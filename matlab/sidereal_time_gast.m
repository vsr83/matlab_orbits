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

% Nutation parameter for the difference between hour angles of true and 
% apparent equinox is given by the Equation of Equinoxes. It seems that [1] 
% has a sign error in the formula.
% in terms of the Nutation Matrix corresponds to:
%    atand(-cosd(eps + deps)*sind(dpsi) / cosd(dpsi)),
% which is approximately equal to -dpsi * cosd(eps + deps). However, the 
% classical equation of the equinoxes is [2]:
%    dpsi * cosd(eps + deps).

% Equation 
alpha_E = -atand(N(1, 2) / N(1, 1));
% Greenwich Apparent Sidereal Time (GAST) 
GAST = mod(GMST + alpha_E, 360.0);
