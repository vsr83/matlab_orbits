function GMST = sidereal_time_gmst(JT)
% SIDEREAL_TIME_GMST - Compute Greenwich Mean Sidereal Time (GMST)
%
% INPUTS:
%   JT         UT1 Julian Time
%
% OUTPUTS:
%   GMST       GMST in degrees

% For computation of the UT1 time.
JDmin = floor(JT) - 0.5;
JDmax = floor(JT) + 0.5;
JD0 = 0;
if JT > JDmin
    JD0 = JDmin;
end
if JT > JDmax
    JD0 = JDmax;
end

% Julian time at 2000-01-01 12:00:00 UT1
epochJ2000 = 2451545.0;
% UT1 time
H = (JT - JD0) * 24.0;
UT1 = H * 15.0;
% Julian centuries of UT1 date (A.36)
T = (JD0 - epochJ2000) / 36525.0;

% Greenwich Mean Sidereal Time (GMST) at 0h UT1 (A.35)
theta_G0 = 100.460618375 + 36000.77005360834 * T + 3.879333333333333e-04 * T*T - 2.583333333333333e-08 *T*T*T;

% GMST(A.34)
GMST = mod(1.002737909350795 * UT1 + theta_G0, 360);
