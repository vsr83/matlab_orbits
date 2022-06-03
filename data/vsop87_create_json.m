% Export VSOP87A coefficients to a JSON file.

inds_mercury = [1110, 1111, 1112, 1113, 1114, 1115; ...
                1120, 1121, 1122, 1123, 1124, 1125; ...
                1130, 1131, 1132, 1133, 1134, 1135];
inds_venus   = inds_mercury + 100;
inds_earth   = inds_mercury + 200;
inds_mars    = inds_mercury + 300;
inds_jupiter = inds_mercury + 400;
inds_saturn  = inds_mercury + 500;
inds_uranus  = inds_mercury + 600;
inds_neptune = inds_mercury + 700;

filename = 'vsop87a.json';

if exist(filename) > 0
    delete(filename);
end

fid = fopen(filename, 'w');

fprintf(fid, '{\n');
fprintf(fid, '"mercury": ');
vsop87_parse_file('VSOP87A_mercury.txt', inds_mercury, fid);
fprintf(fid, ',');
fprintf(fid, '"venus": ');
vsop87_parse_file('VSOP87A_venus.txt', inds_venus, fid);
fprintf(fid, ',');
fprintf(fid, '"earth": ');
vsop87_parse_file('VSOP87A_earth.txt', inds_earth, fid);
fprintf(fid, ',');
fprintf(fid, '"mars": ');
vsop87_parse_file('VSOP87A_mars.txt', inds_mars, fid);
fprintf(fid, ',');
fprintf(fid, '"jupiter": ');
vsop87_parse_file('VSOP87A_jupiter.txt', inds_jupiter, fid);
fprintf(fid, ',');
fprintf(fid, '"saturn": ');
vsop87_parse_file('VSOP87A_saturn.txt', inds_saturn, fid);
fprintf(fid, ',');
fprintf(fid, '"uranus": ');
vsop87_parse_file('VSOP87A_uranus.txt', inds_uranus, fid);
fprintf(fid, ',');
fprintf(fid, '"neptune": ');
vsop87_parse_file('VSOP87A_neptune.txt', inds_neptune, fid);
fprintf(fid, '}');

fclose(fid);
