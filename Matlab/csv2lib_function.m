%% csv2lib_function

% Convert a .csv file exported from Virtuoso_ADE-L simulation in a matrix
% ready to be put in a liberty file.
% destination file matrix will have in each cell the data corresponding to
% the intersection between a precise tr/tf and a capacitance. On rows we
% will have constant capacitances, on columns constant tr/tf.

% INPUT %
% fTag = identifier to identify the kth-matrix
% fInPath = path of the current csv file
% fOutID = ID of the output file
% timeUoM = Unit of Measurement for time measures

function csv2lib(fTag, fInPath, fOutID, timeUoM)

%% Import data

% read data from CSV file from the second row (the first contains only indexes)
mtx_tmp = csvread(fInPath, 1, 0);

%% Elaborate the matrix

% delete x-axis informations
mtx = mtx_tmp(:, 2:2:end);

% convert (time) data to the right output-format (normalize to the UoM specified in the liberty file index)
mtx_norm = mtx * 10^(-timeUoM);

% MIC: swap rows and columns in order to have constant tr/tf on the same
% row and constant load capacitance on the same column
mtx_norm = mtx_norm';

%% Write current matrix on the new file

% specify the string and write it on the output file

tagStr = fTag + "\n";
fprintf(fOutID, tagStr);

begStr = 'values ("%1.8f,%1.8f,%1.8f,%1.8f,%1.8f,%1.8f,%1.8f", \\\n';
fprintf(fOutID, begStr, mtx_norm(1, :));

formatSpec = '        "%1.8f,%1.8f,%1.8f,%1.8f,%1.8f,%1.8f,%1.8f", \\\n';
fprintf(fOutID, formatSpec, mtx_norm(2:end-1, :));

endStr = '        "%1.8f,%1.8f,%1.8f,%1.8f,%1.8f,%1.8f,%1.8f");';
fprintf(fOutID, endStr, mtx_norm(end, :));

% space for the new csv
fprintf(fOutID, "\n\n");

