function [R, GAST] = matrix_tod_pef(JT, N)
% MATRIX_TOD_PEF - Compute the rotation matrix between the ToD and PEF
% frames.
%
% The rotation matrix between the ToD and PEF frames is the Earth Rotation
% Matrix.
%
% INPUTS:
%   JT         The Julian UT1 Time
%   N          Nutation Matrix
%
% OUTPUTS:
%   R          The Earth Rotation Matrix
%   GAST       Greenwich Apparent Sidereal Time (in degrees)
%
% References:
% [1] E. Suirana, J. Zoronoza, M. Hernandez-Pajares - GNSS Data Processing -
% Volume I: Fundamentals and Algorithms, ESA 2013.

if nargin < 3
    N = matrix_mod_tod(JT);
end

GAST = sidereal_time_gast(JT, N);
R = matrix_rot3d(GAST);

end