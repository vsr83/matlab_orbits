timestamp_utc = '2022-03-18 13:45:15';
[JT, JD] = julian_time_ts(timestamp_utc)
JT = 2459657.104767767;

r_j2000 = [-4085945.50066, 1140337.14234, 5304544.78721]';
v_j2000 = [-2785.2583, -7109.16792, -614.92828]';

N = matrix_mod_tod(JD);
[r_mod, v_mod] = coord_j2000_mod(JD, r_j2000, v_j2000)
[r_tod, v_tod] = coord_mod_tod(JD, r_mod, v_mod, N)
[r_pef, v_pef] = coord_tod_pef(JD, JT, r_tod, v_tod, N)
[r_efi, v_efi] = coord_pef_efi(r_pef, v_pef, 0.0, 0.0)
[r_pef2, v_pef2] = coord_efi_pef(r_efi, v_efi, 0.0, 0.0)
[r_tod2, v_tod2] = coord_pef_tod(JD, JT, r_pef2, v_pef2, N)
[r_mod2, v_mod2] = coord_tod_mod(JD, r_tod2, v_tod2, N)
[r_j20002, v_j20002] = coord_mod_j2000(JD, r_mod2, v_mod2)

