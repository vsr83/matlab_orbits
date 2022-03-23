function E = kepler_solve(M, ecc, tolerance, max_iterations)
% SOLVE_KEPLER - Solve the Kepler equation
%   
% INPUTS: 
%   M              The Mean Anomaly (in degrees).
%   ECC            The orbit eccentricity (0 < ECC < 1).
%   TOLERANCE      The tolerance.
%   MAX_ITERATIONS The maximum number of iterations.
% OUTPUTS:
%   E              The Eccentric Anomaly (in degrees).

iteration_count = 0;
error = tolerance + 1.0;

E = M;

% M = E - e sind E
% <=> E - e sind E - 0 = 0
% f = E - e sind E - M
% df/dE = 1 - e (dF/dE) sin(2 * pi * E / 360.0)
%       = 1 - (2*pi*e/360.0) * cosd(E)

while (error > tolerance)
    iteration_count = iteration_count + 1;

    if (iteration_count > max_iterations)
        error("Convergence failed");
    end

    % Newton-Raphson iteration:
    a = pi / 180.0;
    E = E - (M - E + (ecc/a) * sind(E))/(ecc * cosd(E) - 1);

    error = abs(sind(M) - sind(E - (ecc/a) * sind(E))) + ...
            abs(cosd(M) - cosd(E - (ecc/a) * sind(E)));
end

E = mod(E, 360.0);