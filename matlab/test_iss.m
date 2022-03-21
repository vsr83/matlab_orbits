timestamp_utc = '2022-03-18 20:51:56';
[JT, JD] = julian_time_ts(timestamp_utc)
JT - 2459657.369403785

r_j2000 = [-4813203.57467, -2798967.205, 3893930.04087]';
v_j2000 = [420.78954, -6450.14296, -4108.48707]';

%r_j2000 = [r_j2000, r_j2000];
%v_j2000 = [v_j2000, v_j2000];

N = matrix_mod_tod(JT);
[r_mod, v_mod] = coord_j2000_mod(JT, r_j2000, v_j2000)
[r_tod, v_tod] = coord_mod_tod(JT, r_mod, v_mod, N)
[r_pef, v_pef] = coord_tod_pef(JT, r_tod, v_tod, N)
[r_efi, v_efi] = coord_pef_efi(r_pef, v_pef, 0.0, 0.0)
[lat, lon, h] = coord_efi_wgs84(r_efi)
[r_enu, v_enu] = coord_efi_enu(r_efi, v_efi, lat, lon, 0)
[r_efi2, v_efi2] = coord_enu_efi(r_enu, v_enu, lat, lon, 0)
[r_pef2, v_pef2] = coord_efi_pef(r_efi2, v_efi2, 0.0, 0.0)
[r_tod2, v_tod2] = coord_pef_tod(JT, r_pef2, v_pef2, N)
[r_mod2, v_mod2] = coord_tod_mod(JT, r_tod2, v_tod2, N)
[r_j20002, v_j20002] = coord_mod_j2000(JT, r_mod2, v_mod2)

[az, el] = coord_enu_azel(r_enu, v_enu)
