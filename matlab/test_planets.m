[JD, JT] = julian_time_ymdhms(2022, 03, 22, 00, 00, 00);
[kepler, indices, names] = kepler_planets(JT);

num_planets = length(names);
au_meters = 1.495978707e11;

for ind_planet = 3:3
    name = names(ind_planet)
    elem = kepler(ind_planet, :);

    % Semi-major axis
    a = elem(indices.col_a) * au_meters
    % Eccentricity
    ecc = elem(indices.col_e)
    % Inclination
    incl = elem(indices.col_i)
    % Mean longitude
    L = elem(indices.col_L)
    % Longitude of perihelion
    Lperi = elem(indices.col_lperi)
    % Longitude of the ascending node
    Omega = elem(indices.col_Omega)

    b = a * sqrt(1 - ecc * ecc)
    omega = Lperi - Omega;
    M = L - Lperi;
    mu = 1.32712440018e20;

    E = kepler_solve(M, ecc, 1e-8, 10);
    [r_per, v_per] = kepler_perifocal(a, b, E, mu);
    [r_ecl, v_ecl] = coord_perifocal_inertial(r_per, v_per, Omega, incl, omega);
    [r_eq, v_eq] = coord_ecl_eq(JT, r_ecl, v_ecl);
end