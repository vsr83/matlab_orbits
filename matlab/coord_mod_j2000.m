function [r_j2000, v_j2000] = coord_mod_j2000(JD, r_mod, v_mod)
% COORD_MOD_J2000 - Convert coordinates and velocities between the MoD 
% and J2000 frames.
%
% The rotation matrix between the J2000 and MOD frames is the Precession
% Matrix.
%
% INPUTS:
%   JD         The Julian Date.
%   r_mod      Position in MoD frame (3 x n).
%   v_mod      Velocity in MoD frame (3 x n).
%
% OUTPUTS:
%   r_j2000    Position in J2000 frame (3 x n).
%   v_j2000    Velocity in J2000 frame (3 x n).
%
% References:
% [1] E. Suirana, J. Zoronoza, M. Hernandez-Pajares - GNSS Data Processing -
% Volume I: Fundamentals and Algorithms, ESA 2013.

% The Precession Matrix
P = matrix_j2000_mod(JD);
r_j2000 = P' * r_mod;
v_j2000 = P' * v_mod;
