function [r_mod, v_mod] = coord_tod_mod(r_tod, v_tod, JD, N)
% COORD_TOD_MOD - Convert coordinates and velocities between the ToD and 
% MoD frames.
%
% The rotation matrix between the MoD and ToD frames is the Nutation
% Matrix.
%
% INPUTS:
%   r_tod      Position in ToD frame (3 x n).
%   v_tod      Velocity in ToD frame (3 x n).
%   JD         The Julian Date.
%   N          Nutation matrix (optional).
%
% OUTPUTS:
%   r_mod      Position in MoD frame (3 x n).
%   v_mod      Velocity in MoD frame (3 x n).
%
% References:
% [1] E. Suirana, J. Zoronoza, M. Hernandez-Pajares - GNSS Data Processing -
% Volume I: Fundamentals and Algorithms, ESA 2013.

if nargin < 2
    % The Nutation Matrix
    N = matrix_mod_tod(JD);
end
r_mod = N' * r_tod;
v_mod = N' * v_tod;
