function parse_vsop87(input_file, inds, fid)
% PARSE_VSOP87 - Generate JSON file for VSOP87 planet.
%
% INPUTS:
%    input_file     The input file.
%    inds           Indices for the polynomial coefficients of each 
%                   Cartesian coordinate (3x6).
%    fid            File identifier used for writing.
%    

lines = readlines(input_file);
num_lines = length(lines);
disp(sprintf('Parsing %d items from %s:', num_lines, input_file));

first = true;

names = string(zeros(num_lines - 1, 1));
data = zeros(num_lines-1, 5);
num_final = 0;

data = zeros(num_lines-1, 4);
for ind_item = 1:num_lines-1
    line = lines(ind_item);
    index = str2num(line{1}(1:4));
    coeff1 = str2double(line{1}(6:18));
    coeff2 = str2double(line{1}(20:32));
    coeff3 = str2double(strip(line{1}(34:end)));

    data(ind_item, :) = [index, coeff1, coeff2, coeff3];
end

fprintf(fid, '[\n');
for ind_dim = 1:3
    fprintf(fid, '[\n');
    for ind_polyn = 1:6
        fprintf(fid, '  [\n');

        coeff_inds = find(data(:, 1) == inds(ind_dim, ind_polyn));

        for ind_coeff = 1:length(coeff_inds)
            coeff_ind = coeff_inds(ind_coeff);
            fprintf(fid, '[%.10f, %.10f, %.10f]', data(coeff_ind, 2), ...
                data(coeff_ind, 3), data(coeff_ind, 4));
            if ind_coeff ~= length(coeff_inds) 
                fprintf(fid, ',\n');
            else
                fprintf(fid, '\n');
            end
        end

        if ind_polyn ~= 6
            fprintf(fid, '  ],\n');
        else
            fprintf(fid, '  ]\n');
        end
    end
    if ind_dim ~= 3
        fprintf(fid, '],\n');
    else
        fprintf(fid, ']\n');
    end
end
fprintf(fid, ']\n');
