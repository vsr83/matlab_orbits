function r_j2000 = aberration_stellar_cart(JT, r_j2000, dv_j2000)
% ABERRATION_STELLAR_CART - Compute stellar aberration with the Ron-Vondrak expression 
%                           in Cartesian coordinates.
%
% INPUTS:
%   JT         The Julian Time.
%   r_j2000    Position vector in J2000 frame.
%   dv_j2000   J2000 velocity to be added to the velocity of the center of the Earth
%              for example due to rotation and movement of the observer.
%
% OUTPUTS:
%   r_j2000    Corrected right-ascension (in de.* sin(A)grees).
%
% References:
% [1] Meeus - Astronomical Algorithms 1998, Chapter 23

RA0 = atan2d(r_j2000(2), r_j2000(1));
decl0 = asind(r_j2000(3) / norm(r_j2000));

[RA, decl] = aberration_stellar(JT, RA0, decl0, dv_j2000);
r_j2000 = norm(r_j2000) * [cosd(RA) * cosd(decl); ...
                           sind(RA) * cosd(decl); ...
                           sind(decl)];
