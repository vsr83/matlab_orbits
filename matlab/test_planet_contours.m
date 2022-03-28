function test_planet_contours(lat, lon, ind_planet)
% TEST_PLANET_CONTOURS - Create contour plot of a planet altitude.
%
% INPUTS:
%   lat         Observer latitude (deg)
%   lon         Observer longitude (deg)
%   ind_planet  The planet number

if nargin < 3
    lat = 60; 
    lon = 24;
    ind_planet = 4;
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
        [r_ec_earth, v_ec_earth] = kepler_ecliptic(JT, ...
                            kepler(indices.row_earth, indices.col_a) * au_meters, ... 
                            kepler(indices.row_earth, indices.col_e), ...
                            kepler(indices.row_earth, indices.col_i), ...
                            kepler(indices.row_earth, indices.col_L), ...
                            kepler(indices.row_earth, indices.col_lperi), ...
                            kepler(indices.row_earth, indices.col_Omega));
        r_ec_sun = [0;0;0];
        v_ec_sun = [0;0;0];
        
        [r_eq_sun, v_eq_sun] = coord_ecl_eq(JT, -r_ec_earth, -v_ec_earth);
        [r_mod, v_mod] = coord_j2000_mod(JT, r_eq_sun, v_eq_sun);
        [r_tod, v_tod] = coord_mod_tod(JT, r_mod, v_mod, N);
        [r_pef, v_pef] = coord_tod_pef(JT, r_tod, v_tod, N);
        [r_efi, v_efi] = coord_pef_efi(r_pef, v_pef, 0.0, 0.0);
        [slat, slon, sh] = coord_efi_wgs84(r_efi);
        [r_enu, v_enu] = coord_efi_enu(r_efi, v_efi, lat, lon, 0);
        [az_sun, el_sun] = coord_enu_azel(r_enu, v_enu);

        name = names{ind_planet};
        [r_ecl, v_ecl] = kepler_ecliptic(JT, ...
                            kepler(ind_planet, indices.col_a) * au_meters, ... 
                            kepler(ind_planet, indices.col_e), ...
                            kepler(ind_planet, indices.col_i), ...
                            kepler(ind_planet, indices.col_L), ...
                            kepler(ind_planet, indices.col_lperi), ...
                            kepler(ind_planet, indices.col_Omega));
        
        r_ecl_diff = r_ecl - r_ec_earth;
        v_ecl_diff = v_ecl - v_ec_earth;
        [r_eq, v_eq] = coord_ecl_eq(JT, r_ecl_diff, v_ecl_diff);
        [r_mod, v_mod] = coord_j2000_mod(JT, r_eq, v_eq);
        [r_tod, v_tod] = coord_mod_tod(JT, r_mod, v_mod, N);
        [r_pef, v_pef] = coord_tod_pef(JT, r_tod, v_tod, N);
        [r_efi, v_efi] = coord_pef_efi(r_pef, v_pef, 0.0, 0.0);
        [slat, slon, sh] = coord_efi_wgs84(r_efi);
        [r_enu, v_enu] = coord_efi_enu(r_efi, v_efi, lat, lon, 0);
        [az, el] = coord_enu_azel(r_enu, v_enu);

        if el_sun < 0
            %%el_sun = 0;
        end
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