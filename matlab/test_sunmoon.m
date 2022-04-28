JT = julian_time_ymdhms(2009, 7, 22, 2, 0, 0);

au_meters = 1.495978707e11;
mu = 1.32712440018e20;

[RA_moon, decl_moon, dist_moon] = position_moon(JT);
N = matrix_mod_tod(JT);

dist_moon = dist_moon * 1000;

% Position of the Moon in J2000.
r_tod_moon = dist_moon * [cosd(decl_moon) * cosd(RA_moon); ...
                          cosd(decl_moon) * sind(RA_moon); ...
                          sind(decl_moon)]
v_tod_moon = 0 * r_tod_moon;

[r_pef_moon, v_pef_moon] = coord_tod_pef(JT, r_tod_moon, v_tod_moon, N);
[r_efi_moon, v_efi_moon] = coord_pef_efi(r_pef_moon, v_pef_moon, 0.0, 0.0);

[kepler, indices, names] = kepler_planets(JT);
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
[r_mod_sun, v_mod_sun] = coord_j2000_mod(JT, r_eq_sun, v_eq_sun);
[r_tod_sun, v_tod_sun] = coord_mod_tod(JT, r_mod_sun, v_mod_sun, N)
[r_pef_sun, v_pef_sun] = coord_tod_pef(JT, r_tod_sun, v_tod_sun, N)
[r_efi_sun, v_efi_sun] = coord_pef_efi(r_pef_sun, v_pef_sun, 0.0, 0.0)

LON = -180:0.5:180;
LAT = -90:0.5:90;

[GLAT,GLON] = meshgrid(LON, LAT);
DIST = 0 * GLON;

for ind_lon = 1:length(LON)
    for ind_lat = 1:length(LAT)
        lon = LON(ind_lon);
        lat = LAT(ind_lat);

        r_obs = coord_wgs84_efi(lat, lon, 0);
        r_S = 6.96340e8;
        dist_obs_sun = norm(r_efi_sun - r_obs);
        angular_diam_sun = 2 * atand(r_S / dist_obs_sun); 

        r_M = 1737400;
        dist_obs_moon = norm(r_efi_moon - r_obs);
        angular_diam_moon = 2 * atand(r_M / dist_obs_moon); 

        [r_enu_moon, v_enu_moon] = coord_efi_enu(r_efi_moon, v_efi_moon, lat, lon, 0);
        [r_enu_sun, v_enu_sun] = coord_efi_enu(r_efi_sun, v_efi_sun, lat, lon, 0);

        dist = acosd(dot(r_enu_moon, r_enu_sun)/(norm(r_enu_moon) * norm(r_enu_sun)));

        limit_partial = 0.5 * (angular_diam_sun + angular_diam_moon);
        limit_full = 0.5 * (angular_diam_moon - angular_diam_sun);

        img_x = min(floor((lon + 180) * 2048 / 360) + 1, 2048);
        img_y = min(floor((lat + 90) * 1024 / 180) + 1, 1024);

        if dist < limit_full && r_enu_sun(3) > 0
            DIST(ind_lat, ind_lon) = 0.0;
        elseif dist < limit_partial && r_enu_sun(3) > 0
            DIST(ind_lat, ind_lon) = 0.5;
        else 
            DIST(ind_lat, ind_lon) = 1.0;%img(img_y, img_x, 1);
        end
    end
    lon
end

clf
contourf(GLAT, GLON, DIST, 3)
