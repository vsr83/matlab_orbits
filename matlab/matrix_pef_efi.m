function RM = matrix_pef_efi(xp, yp)
% MATRIX_PEF_TO_EFI - Compute the rotation matrix between the PEF and EFI
% frames.
%
% The rotation matrix between the PEF and EFI frames is the Polar Motion
% Matrix.
%
% INPUTS:
%   xp         The polar motion parameter (in degrees)
%   yp         The polar motion parameter (in degrees)
%
% OUTPUTS:
%   RM         Polar Motion Matrix
%
% References:
% [1] E. Suirana, J. Zoronoza, M. Hernandez-Pajares - GNSS Data Processing -
% Volume I: Fundamentals and Algorithms, ESA 2013.

RM = matrix_rot2d(-xp) * matrix_rot1d(-yp);

end