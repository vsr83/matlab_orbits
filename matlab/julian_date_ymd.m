function JD = julian_date(year, month, mday)
% JULIAN_DATE_YMD - Compute Julian Date
%
% INPUTS:
%   year       Year as an integer.
%   month      Month (1-12)
%   may        Day of the month (1-31)
%
% OUTPUTS:
%   JD         Julian Date

A = floor(year / 100);
B = floor(A / 4.0);
C = floor(2.0 - A + B);
E = floor(365.25 * (year + 4716.0));
F = floor(30.6001 * (month + 1));
JD = C + mday + E + F - 1524.5;

end