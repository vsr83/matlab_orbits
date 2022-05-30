function JD = julian_date_ymd(year, month, mday)
% JULIAN_DATE_YMD - Compute Julian Date from date.
%
% INPUTS:
%   year       Year as an integer.
%   month      Month (1-12)
%   may        Day of the month (1-31)
%
% OUTPUTS:
%   JD         Julian Date

if month < 3
    year = year - 1;
    month = month + 12;
end

A = floor(year / 100);
B = floor(A / 4.0);
C = floor(2.0 - A + B);
E = floor(365.25 * (year + 4716.0));
F = floor(30.6001 * (month + 1));
JD = C + mday + E + F - 1524.5;

end