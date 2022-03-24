[JT, JD] = julian_time_ymdhms(2022, 03, 23, 23, 13, 00);
[kepler, indices, names] = kepler_planets(JT);

num_planets = length(names);
au_meters = 1.495978707e11;
mu = 1.32712440018e20;
lat = 60.205490;
lon = 24.0206;

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
[r_mod, v_mod] = coord_j2000_mod(JT, r_eq_sun, v_eq_sun)
[r_tod, v_tod] = coord_mod_tod(JT, r_mod, v_mod, N)
[r_pef, v_pef] = coord_tod_pef(JT, r_tod, v_tod, N)
[r_efi, v_efi] = coord_pef_efi(r_pef, v_pef, 0.0, 0.0)
[slat, slon, sh] = coord_efi_wgs84(r_efi)
[r_enu, v_enu] = coord_efi_enu(r_efi, v_efi, lat, lon, 0)
[az, el] = coord_enu_azel(r_enu, v_enu)

% a: 1.00000009888798, 
% e: 0.016701765975159436, 
% i: -0.00004970292602429137, 
% Omega: -0.21617530588158512, 
% lP: 1.79805851019971, 
% mL: 141.38876142392894 

for ind_planet = 1:num_planets
    if ind_planet == 3
        continue;
    end

    name = names{ind_planet}
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
    [az, el] = coord_enu_azel(r_enu, v_enu)
end