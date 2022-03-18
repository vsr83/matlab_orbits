function [r_pef, v_pef] = coord_tod_pef(JD, JT, r_tod, v_tod, N)
% COORD_MOD_TOD - Convert coordinates and velocities between the MoD and 
% ToD frames.
%
% The rotation matrix between the ToD and PEF frames is the Earth Rotation
% matrix.
%
% INPUTS:
%   JD         The Julian Date.
%   JT         The Julian Time.
%   r_tod      Position in ToD frame (3 x n).
%   v_tod      Velocity in ToD frame (3 x n).
%   N          Nutation matrix (optional).
%
% OUTPUTS:
%   r_pef      Position in PEF frame (3 x n).
%   v_pef      Velocity in PEF frame (3 x n).
%
% References:
% [1] E. Suirana, J. Zoronoza, M. Hernandez-Pajares - GNSS Data Processing -
% Volume I: Fundamentals and Algorithms, ESA 2013.

if nargin < 5
    % The Nutation Matrix
    N = matrix_mod_tod(JD);
end

[R, GAST] = matrix_tod_pef(JD, JT, N);

% Alternative expression for the GMST is \sum_{i=0}^3 k_i MJD^i.
k_1 = 360.985647366;
k_2 = 2.90788e-13;
k_3 = -5.3016e-22;
MJD = JT - 2451544.5;

% Compute time-derivative of the GAST to convert velocities:
dGASTdt = (1/86400.0) * (k_1 + 2*k_2*MJD + 3*k_3*MJD*MJD);
dRdt = dGASTdt * (pi/180.0) * [-sind(GAST),  cosd(GAST), 0; ...
                               -cosd(GAST), -sind(GAST), 0; ...
                                         0,           0, 0];

r_pef = R*r_tod;
v_pef = R*v_tod + dRdt*r_pef;
