function parse_hipparchus(output_path, mag_limit)
% PARSE_HIPPARCHUS - Generate JSON file from Hipparchus dataset.
%
% The Extended Hipparcos Compilation (XHIP) catalog can be found from:
% http://cdsarc.u-strasbg.fr/ftp/V/137D/ReadMe
% http://cdsarc.u-strasbg.fr/ftp/V/137D/biblio.dat.gz
% http://cdsarc.u-strasbg.fr/ftp/V/137D/photo.dat.gz
% http://cdsarc.u-strasbg.fr/ftp/V/137D/main.dat.gz
% 
% The files must be uncompressed before running of this script.
%
% INPUTS:
%    output_path    Output file path for the JSON.
%    mag_limit      Upper limit for magnitude included in the generated
%                   JSON.
%

if nargin < 2
    mag_limit = 6;
end
if nargin < 1
    output_path = 'hipparchus_reduced.json';
end

if exist(output_path) > 0
    delete(output_path);
end

fid = fopen(output_path, 'wt');

lines_biblio = readlines('biblio.dat');
lines_photo = readlines("photo.dat");
lines_data = readlines('main.dat');

num_lines = length(lines_biblio);

disp(sprintf('Parsing %d items:', num_lines));
fprintf(fid, '{\n');
first = true;

for ind_item = 1:num_lines-1
    elems_biblio = split(lines_biblio(ind_item), '|');
    elems_photo = split(lines_photo(ind_item), '|');
    elems_data = split(lines_data(ind_item), '|');

    id_biblio = str2num(elems_biblio(1));
    id_photo = str2num(elems_photo(1));
    id_data = str2num(elems_data(1));

    % Right ascension (ICRS, Epoch=J1991.25), degrees.
    RAdeg_1991 = str2double(elems_data(5));
    % Declination (ICRS, Epoch=J1991.25), degrees.
    DEdeg_1991 = str2double(elems_data(6));
    % Proper motion in RA*cos(DEdeg), mas/yr.
    RA_proper = str2double(elems_data(9));
    % Proper motion in Declination, mas/yr.
    decl_proper = str2double(elems_data(10));
    % Heliocentric distance, pc.
    dist = str2double(elems_data(19));
    % Median magnitude in Hipparchos system, mag.
    HPmag = str2double(elems_photo(2));
    % Star name(s)
    name = strip(elems_biblio(6));

    if strlength(name) == 0
        name = sprintf('XHIP %d', id_data);
    end

    if HPmag < mag_limit
        if ~first 
            fprintf(fid, ',\n');
        end

        fprintf(fid, '"%s" : {"RA":%12f, "DE":%12f, "RA_delta":%11f, "DE_delta":%11f, "mag":%8f}', ...
            name, RAdeg_1991, DEdeg_1991, RA_proper, decl_proper, HPmag);
        if ind_item == (num_lines - 1)
            disp(sprintf('%d/%d - END', ind_item, num_lines - 1));
        else
            disp(sprintf('%d/%d', ind_item, num_lines - 1));
        end
        
        first = false;
    end

    if (id_biblio ~= id_photo) || (id_photo ~= id_data )
        error 'Invalid data'
    end
end
fprintf(fid, '\n}');

fclose(fid);