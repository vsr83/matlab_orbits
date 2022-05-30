% Standard gravitational parameter for Sun (m^3/s^2).
mu = 1.32712440018e20;

JT = julian_time_ymdhms(2022, 5, 30, 0, 0, 0);
[r, v] = vsop87_jupiter(JT);
ERR = [];
R = [];


for dJT = 0.1:0.1:10
    [r2, v2] = vsop87_jupiter(JT + dJT);

    [a, ecc_norm, incl, Omega, omega, E, M, f] = kepler_osculating(r, v, mu);
    b = a*sqrt(1-ecc_norm*ecc_norm);
    [M_prop, E_prop] = kepler_propagate(dJT, M, a, ecc_norm, mu);
    [r_per_prop, v_per_prop] = kepler_perifocal(a, b, E_prop, mu);
    [r_in_prop, v_in_prop] = coord_perifocal_inertial(r_per_prop, v_per_prop, Omega, incl, omega);

    ERR = [ERR; dJT, norm(r2 - r_in_prop)/norm(r2), norm(v2 - v_in_prop)/norm(v2)];
    R = [R;r_in_prop', r2'];
end

figure(1)
clf
subplot(2, 1, 1);
loglog(ERR(:, 1), ERR(:, 2));
grid on
xlabel 'Propagation (days)'
ylabel 'Relative Error in Position'

subplot(2, 1, 2);
loglog(ERR(:, 1), ERR(:, 3));
grid on
xlabel 'Propagation (days)'
ylabel 'Relative Error in Velocity'
