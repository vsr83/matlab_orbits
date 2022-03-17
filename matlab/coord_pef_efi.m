function [r_efi, v_efi] = coord_pef_efi(r_pef, v_pef, xp, yp)
% COORD_PEF_EFI - Convert coordinates and velocities between the PEF and 
% EFI frames.
%
% The rotation matrix between the PEF and EFI frames is the Polar Motion 
% Matrix.
%
% INPUTS:
%   r_pef      Position in PEF frame (3 x n).
%   v_pef      Velocity in PEF frame (3 x n).
%   xp         The polar motion parameter (in degrees)
%   yp         The polar motion parameter (in degrees)
%
% OUTPUTS:
%   r_efi      Position in EFI frame (3 x n).
%   v_efi      Velocity in EFI frame (3 x n).
%
% References:
% [1] E. Suirana, J. Zoronoza, M. Hernandez-Pajares - GNSS Data Processing -
% Volume I: Fundamentals and Algorithms, ESA 2013.

RM = matrix_pef_efi(xp, yp);

r_efi = RM * r_pef;
v_efi = RM * v_pef;
