%% csv2lib

% Convert a .csv file exported from Virtuoso_ADE-L simulation in a matrix
% ready to be put in a liberty file.
% destination file matrix will have in each cell the data corresponding to
% the intersection between a precise tr/tf and a capacitance. On rows we
% will have constant capacitances, on columns constant tr/tf.

%% Parameters

% input file path
fInPath = "./S_A-falling_B_tp_H.csv";

% output file path
fOutPath = "./S_A-falling_B_tp_H";

% specify the Unit of Measurement for time measures (specify the value of the exponent)
timeUoM = -9; % [nano seconds]

%% Import data

% read data from CSV file from the second row (the first contains only indexes)
mtx_tmp = csvread(fInPath, 1, 0);

%% Elaborate the matrix

% delete x-axis informations
mtx = mtx_tmp(:, 2:2:end);

% convert (time) data to the right output-format (normalize to the UoM specified in the liberty file index)
mtx_norm = mtx_norm * 10^(-timeUoM);

%% Write the new file

% obtain the ID of the output file
fOutID = fopen(fOutPath, 'w');

% specify the string and write it on the output file
begStr = 'values ("%1.8f,%1.8f,%1.8f,%1.8f,%1.8f,%1.8f,%1.8f", \\\n';
fprintf(fOutID, begStr, mtx_norm(1, :));

formatSpec = '        "%1.8f,%1.8f,%1.8f,%1.8f,%1.8f,%1.8f,%1.8f", \\\n';
fprintf(fOutID, formatSpec, mtx_norm(2:end-1, :));

endStr = '        "%1.8f,%1.8f,%1.8f,%1.8f,%1.8f,%1.8f,%1.8f");*/';
fprintf(fOutID, endStr, mtx_norm(end, :));

% close the file
fclose(fOutID);