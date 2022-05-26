load ../data/vega_twodays.txt
vega = vega_twodays;
clf

timestamps_utc = {...
    "2022-03-19 00:00:00"; ...
    "2022-03-19 01:00:00"; ...
    "2022-03-19 02:00:00"; ...
    "2022-03-19 03:00:00"; ...
    "2022-03-19 04:00:00"; ...
    "2022-03-19 05:00:00"; ...
    "2022-03-19 06:00:00"; ...
    "2022-03-19 07:00:00"; ...
    "2022-03-19 08:00:00"; ...
    "2022-03-19 09:00:00"; ...
    "2022-03-19 10:00:00"; ...
    "2022-03-19 11:00:00"; ...
    "2022-03-19 12:00:00"; ...
    "2022-03-19 13:00:00"; ...
    "2022-03-19 14:00:00"; ...
    "2022-03-19 15:00:00"; ...
    "2022-03-19 16:00:00"; ...
    "2022-03-19 17:00:00"; ...
    "2022-03-19 18:00:00"; ...
    "2022-03-19 19:00:00"; ...
    "2022-03-19 20:00:00"; ...
    "2022-03-19 21:00:00"; ...
    "2022-03-19 22:00:00"; ...
    "2022-03-19 23:00:00"; ...
    "2022-03-20 00:00:00"; ...
    "2022-03-20 01:00:00"; ...
    "2022-03-20 02:00:00"; ...
    "2022-03-20 03:00:00"; ...
    "2022-03-20 04:00:00"; ...
    "2022-03-20 05:00:00"; ...
    "2022-03-20 06:00:00"; ...
    "2022-03-20 07:00:00"; ...
    "2022-03-20 08:00:00"; ...
    "2022-03-20 09:00:00"; ...
    "2022-03-20 10:00:00"; ...
    "2022-03-20 11:00:00"; ...
    "2022-03-20 12:00:00"; ...
    "2022-03-20 13:00:00"; ...
    "2022-03-20 14:00:00"; ...
    "2022-03-20 15:00:00"; ...
    "2022-03-20 16:00:00"; ...
    "2022-03-20 17:00:00"; ...
    "2022-03-20 18:00:00"; ...
    "2022-03-20 19:00:00"; ...
    "2022-03-20 20:00:00"; ...
    "2022-03-20 21:00:00"; ...
    "2022-03-20 22:00:00"; ...
    "2022-03-20 23:00:00"};

% Stellarium
% 23:00 66.039222 31.59958
%       66.036393 31.59787

% 23:00 65 56'36".9 , 31 31'49.2 ~ 65.943583 , 31.530333 
% 23:00 65 56'36".9 , 31 33'26.6 ~ 65.943583 , 31.557389 
%                                  66.036393 , 31.597871

% Astropy
% 23:00 66.0383108          31.59653856          (Astropy)
%       66.0383973 (8.6e-5) 31.59649665 (4.2e-5) (Computed, ToD injection)
%       66.0389210 (6.1e-4) 31.59450692 (2.0e-3) (Computed, MoD injection)
%       66.0340005 (4.3e-3) 31.59996221 (3.4e-3) (Computed)


% Mean-of-Date - Normalized Cartesian
% 23:00 0.12757323 -0.76886036 0.62656111 (Astropy)
%       0.12756479 -0.76878556 0.62665459 (Computed)
% RA error 2.88e-4, decl error 0.006872

% True-of-Date
%                 RA        DECL
% 23:00 279.41739755 38.79686077 (Astropy)
%       279.41870807 38.80185705 (Computed)
% 


results = [];
[JTs, JDs] = julian_time_ts(timestamps_utc);

% UT1-UTC difference:
JTs = JTs - 0.09982/86400;

% Stellarium:
%RA = 279.23416667;
%decl = 38.7808055;
% Astropy:
RA0 = 279.23473479;
decl0 = 38.78368896;

lat = 60.205490;
lon = 24.0206;


JT = JTs(1);
[kepler, indices, names] = kepler_planets(JT);

num_planets = length(names);
au_meters = 1.495978707e11;
mu = 1.32712440018e20;
lat = 60.205490;
lon = 24.0206;

vega_computed = [];

for ind_JT = 1:length(JTs)
    JT = JTs(ind_JT);
    JD = JDs(ind_JT);
    N = matrix_mod_tod(JT);

    % Compute speed in J2000 due to rotation of the Earth:
    r_obs_efi = coord_wgs84_efi(lat, lon, 0);
    [r_obs_pef, v_obs_pef] = coord_efi_pef(r_obs_efi, 0*r_obs_efi, 0, 0);
    [r_obs_tod, v_obs_tod] = coord_pef_tod(JT, r_obs_pef, v_obs_pef);
    [r_obs_mod, v_obs_mod] = coord_tod_mod(JT, r_obs_tod, v_obs_tod, N);
    [r_obs_j2000, v_obs_j2000] = coord_mod_j2000(JT, r_obs_mod, v_obs_mod);
    v_obs_j2000


    [RA, decl] = aberration_stellar(JT, RA0, decl0, v_obs_j2000)
    r = 1e25;
    r_j2000 = r * [cosd(decl) * cosd(RA); ...
                cosd(decl) * sind(RA); ...
                sind(decl)];
    v_j2000 = 0 * r_j2000;
    
    [r_mod, v_mod] = coord_j2000_mod(JT, r_j2000, v_j2000);    
    [r_tod, v_tod] = coord_mod_tod(JT, r_mod, v_mod, N);
    [r_pef, v_pef] = coord_tod_pef(JT, r_tod, v_tod, N);
    [r_efi, v_efi] = coord_pef_efi(r_pef, v_pef, 0.0335/3600, 0.4062/3600);
    [r_enu, v_enu] = coord_efi_enu(r_efi, v_efi, lat, lon, 0);
    [az, el] = coord_enu_azel(r_enu, v_enu);

    if az < 0
        az = az + 360;
    end

    vega_computed = [vega_computed; az, el];
end

subplot(2, 2, 1);
plot(0:47, vega_computed(:, 1), 'b.-', 'LineWidth', 2);
hold on
plot(0:47, vega(:, 1), 'rx', 'LineWidth', 2);
grid on
xlim([0, 47]);
title 'Azimuth of Vega'
xlabel 'Hour (UTC)'
ylabel 'Azimuth (degrees)'

subplot(2, 2, 2);
plot(0:47, vega_computed(:, 2), 'b.-', 'LineWidth', 2);
hold on
plot(0:47, vega(:, 2), 'rx', 'LineWidth', 2);
grid on
xlim([0, 47]);
title 'Altitude of Vega'
xlabel 'Hour (UTC)'
ylabel 'Altitude (degrees)'

subplot(2, 2, 3);
plot(0:47, (vega_computed(:, 1) - vega(:, 1))*3600, 'bo-', 'LineWidth', 2);
hold on
grid on
xlim([0, 47]);
title 'Absolute error in the azimuth of Vega'
xlabel 'Hour (UTC)'
ylabel 'Absolute Error (arcseconds)'

subplot(2, 2, 4);
plot(0:47, (vega_computed(:, 2) - vega(:, 2))*3600, 'bo-', 'LineWidth', 2);
hold on
grid on 
xlim([0, 47]);
title 'Absolute error in the elevation of Vega'
xlabel 'Hour (UTC)'
ylabel 'Absolute Error (arcseconds)'
