function [JT, JD] = julian_time_ts(ts, ts_format)
% JULIAN_DATE_TS - Compute Julian Time from timestamps.
%
% INPUTS:
%   ts         Date in the format YYYY-MM-DD HH:MM:SS[.ssssss]
%   ts_format  Optional format. Default '%d-%d-%d %d:%d:%f'
%
% OUTPUTS:
%   JT         Julian Time
%   JD         Julian Date

if nargin == 1
    ts_format = '%d-%d-%d %d:%d:%f';
end

if iscell(ts)
    num_timestamps = length(ts);
    YMDhms = zeros(num_timestamps, 6);
    for ind_timestamp = 1:num_timestamps
        YMDhms(ind_timestamp, :) = sscanf(ts{ind_timestamp}, ts_format)';
    end
    JT = julian_time_ymdhms(YMDhms(:, 1), YMDhms(:, 2), YMDhms(:, 3), YMDhms(:, 4), YMDhms(:, 5), YMDhms(:, 6));
    JD = julian_date_ymd(YMDhms(:, 1), YMDhms(:, 2), YMDhms(:, 3));
else
    YMDhms = sscanf(ts, ts_format);
    JT = julian_time_ymdhms(YMDhms(1), YMDhms(2), YMDhms(3), YMDhms(4), YMDhms(5), YMDhms(6));
    JD = julian_date_ymd(YMDhms(1), YMDhms(2), YMDhms(3));
end

end