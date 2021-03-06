function test_sun_altitude(lat, lon)
% TEST_SUN_ALTITUDE - Create contour plot of the Sun altitude.
%
% INPUTS:
%   lat         Observer latitude (deg)
%   lon         Observer longitude (deg)
%

if nargin < 2
    lat = 60.205490; 
    lon = 24.0206;
end

au_meters = 1.495978707e11;
mu = 1.32712440018e20;

DAY = 1:1:(365);
SEC = 0:300:86400;

[DD,SS] = meshgrid(SEC, DAY);
EL = 0*DD;
AZ = 0*DD;

for day = 1:length(DAY)
day
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

        if el_sun < 0
            %%el_sun = 0;
        end
        if az_sun < 0
            %az_sun = az_sun + 360;
        end
        AZ(day, second) = az_sun;
        EL(day, second) = el_sun;
        
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
title(sprintf('Altitude of the Sun at lat=%0.2f lon=%0.2f', lat, lon))
xlabel('UT1 Time (h)')
ylabel('Day of the Year');
colorbar

figure(2)
clf;
[zz, ch] = contourf(DD/3600, SS, AZ, 'ShowText', 'on')
%quiver(DD/3600, SS, cosd(AZ), sind(AZ)*365/24)
set(gca, 'XTick', 0:24);
set(gca, 'YTick', cumsum([1, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]));
yticklabels({'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'});
grid on 
title(sprintf('Azimuth of the Sun at lat=%0.2f lon=%0.2f', lat, lon))
xlabel('UT1 Time (h)')
ylabel('Day of the Year')
colorbar
