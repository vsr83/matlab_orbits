function JD = julian_date_ts(ts, ts_format)
% JULIAN_DATE_TS - Compute Julian Date from timestamp.
%
% INPUTS:
%   ts         Date in the format YYYY-MM-DD
%   ts_format  Optional format. Default '%d-%d-%d'
%
% OUTPUTS:
%   JD         Julian Date

if nargin == 1
    ts_format = '%d-%d-%d';
end

if iscell(ts)
    num_timestamps = length(ts);
    YMD = zeros(num_timestamps, 3);
    for ind_timestamp = 1:num_timestamps
        YMD(ind_timestamp, :) = sscanf(ts{ind_timestamp}, ts_format)';
    end
    JD = julian_date_ymd(YMD(:, 1), YMD(:, 2), YMD(:, 3));
else
    YMD = sscanf(ts, ts_format);
    JD = julian_date_ymd(YMD(1), YMD(2), YMD(3));
end

end