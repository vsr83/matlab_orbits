function [r_mod, v_mod] = coord_tod_mod(JD, r_tod, v_tod, N)
% COORD_TOD_MOD - Convert coordinates and velocities between the ToD and 
% MoD frames.
%
% The rotation matrix between the MoD and ToD frames is the Nutation
% Matrix.
%
% INPUTS:
%   JD         The Julian Date.
%   r_tod      Position in ToD frame (3 x n).
%   v_tod      Velocity in ToD frame (3 x n).
%   N          Nutation matrix (optional).
%
% OUTPUTS:
%   r_mod      Position in MoD frame (3 x n).
%   v_mod      Velocity in MoD frame (3 x n).
%
% References:
% [1] E. Suirana, J. Zoronoza, M. Hernandez-Pajares - GNSS Data Processing -
% Volume I: Fundamentals and Algorithms, ESA 2013.

if nargin < 4
    % The Nutation Matrix
    N = matrix_mod_tod(JD);
end
r_mod = N' * r_tod;
v_mod = N' * v_tod;
