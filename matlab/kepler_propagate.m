function [M_prop, E_prop] = kepler_propagate(delta_JT, M, a, ecc_norm, mu)
% KEPLER_PROPAGATE - Propagate mean and eccentric anomalies.
%   
% INPUTS: 
%   delta_JT       Time difference in Julian time.
%   M              Mean anomaly (in degrees).
%   a              Semi-major axis (in meters).
%   ecc_norm       Eccentricity.
%   mu             The standard gravitational parameter (in m^3/s^2).
%                  If not filled, parameter for Sun is assumed.
%                  For Earth, use 3.986004418e14.
% OUTPUTS:
%   E              The Eccentric Anomaly (in degrees).

if nargin < 5
    % Standard gravitational parameter for Sun (m^3/s^2).
    mu = 1.32712440018e20;
end


NR_max_iterations = 10;
NR_tolerance = 1e-10;

if a == 0
    error 'Semi-major axis cannot be zero!';
end

% The time difference in seconds.
delta_seconds = delta_JT * 86400;

% Orbital period in seconds from Kepler's third law.
period_seconds = 2 * pi * sqrt(a * a * a / mu);

% Propagate mean anomaly according to the computed difference and solve natural anoamaly.
M_prop = M + 360.0 * delta_seconds / period_seconds;
E_prop = kepler_solve(M_prop, ecc_norm, NR_tolerance, NR_max_iterations);
