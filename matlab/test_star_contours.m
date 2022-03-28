function test_planet_contours(lat, lon, RA, decl, name)
% TEST_PLANET_CONTOURS - Create contour plot of a planet altitude.
%
% INPUTS:
%   lat         Observer latitude (deg)
%   lon         Observer longitude (deg)
%   RA          Right-ascension (deg)
%   decl        Declination (deg)
%   name        Name of the star.

if nargin < 5
    lat = 60; 
    lon = 24;
    RA = 279.23473479;
    decl = 38.78368896;
    name = 'Vega'
end

au_meters = 1.495978707e11;
mu = 1.32712440018e20;

DAY = 1:1:(365);
SEC = 0:300:86400;

[DD,SS] = meshgrid(SEC, DAY);
EL = 0*DD;
AZ = 0*DD;

for day = 1:length(DAY)
    for second = 1:length(SEC)
        [JT, JD] = julian_time_ymdhms(2022, 01, DAY(day), 00, 00, SEC(second));
        [kepler, indices, names] = kepler_planets(JT);
        
        num_planets = length(names);
        
        N = matrix_mod_tod(JT);
        r = 1e25;
        r_j2000 = r * [cosd(decl) * cosd(RA); ...
                       cosd(decl) * sind(RA); ...
                       sind(decl)];
        v_j2000 = 0*r_j2000;
        
        [r_mod, v_mod] = coord_j2000_mod(JT, r_j2000, v_j2000);    
        [r_tod, v_tod] = coord_mod_tod(JT, r_mod, v_mod, N);    
        [r_pef, v_pef] = coord_tod_pef(JT, r_tod, v_tod, N);
        [r_efi, v_efi] = coord_pef_efi(r_pef, v_pef, 0.0, 0.0);
        [r_enu, v_enu] = coord_efi_enu(r_efi, v_efi, lat, lon, 0);
        [az, el] = coord_enu_azel(r_enu, v_enu);

        AZ(day, second) = az;
        EL(day, second) = el;
        
    end
end

figure(1)
clf;
minel = min(min(EL));
maxel = max(max(EL));
levels = (5*(ceil(minel/5)-1)):5:((floor(maxel/5) + 1)*5);
[zz, ch] = contourf(DD/3600, SS, EL, levels, 'ShowText', 'on')
set(gca, 'XTick', 0:24);
set(gca, 'YTick', cumsum([1, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]));
yticklabels({'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'});
grid on 
title(sprintf('Altitude of %s at lat=%0.2f lon=%0.2f', name, lat, lon))
xlabel('UT1 Time (h)')
ylabel('Day of the Year');

figure(2)
clf;
[zz, ch] = contourf(DD/3600, SS, AZ, 'ShowText', 'on')
%quiver(DD/3600, SS, cosd(AZ), sind(AZ)*365/24)
set(gca, 'XTick', 0:24);
set(gca, 'YTick', cumsum([1, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]));
yticklabels({'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'});
grid on 
title(sprintf('Azimuth of %s at lat=%0.2f lon=%0.2f', name, lat, lon))
xlabel('UT1 Time (h)')
ylabel('Day of the Year')