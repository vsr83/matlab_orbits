function JT = julian_time_ymdhms(year, month, mday, hour, minute, second)
% JULIAN_TIME_YMDHMS - Compute Julian Time
%
% INPUTS:
%   year       Year as an integer.
%   month      Month (1-12, integer)
%   mday       Day of the month (1-31, integer)
%   hour       Hour (0-23, integer)
%   minute     Minute (0-59, integer)
%   second     Second (0-60, floating point)
%
% OUTPUTS:
%   JT         Julian Date

JD = julian_date_ymd(year, month, mday);
JT = JD + hour / 24.0 + minute/(24.0 * 60.0) + second/(24.0 * 60.0 * 60.0);

end