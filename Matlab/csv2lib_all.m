%%------------- csv2lib_all -------------

% take all the csv files from a folder and create a file with all the
% matrices ready to be put in the liberty file

%------------- Parameters -------------

% input directory - to end with "/"
% dirInPath = "/home/matteo/git/standard-cell-design/HA_X1/simulations/schematic/25deg/S/";
dirInPath = "../HA_X1/simulations/wParasitics/25deg/S/";

% output file path
% fOutPath = "./ready2lib";
fOutPath = dirInPath + "ready2lib.txt";

% specify the Unit of Measurement for time measures (specify the value of the exponent)
timeUoM = -9; % [nano seconds]

%------------- Preliminary operations -------------

% enumerate all the csv files and check there is at least one csv
fInFolder = dir(dirInPath + "*.csv");

if (isempty(fInFolder))
    error("error : no .csv files in the specified directory");
else
    
%------------- Write the output file -------------

% obtain the ID of the output file
    fOutID = fopen(fOutPath, 'w');
    
    % check if it's opened
    if (fOutID ~= -1)
        
        % for each file, append a new matrix to the output file
        for i = 1:size(fInFolder, 1)
            fCurr = dirInPath + fInFolder(i).name;
            fTag = fInFolder(i).name(1, 1:end-4);
            csv2lib_function(fTag, fCurr, fOutID, timeUoM)
        end

        % close the output file
        fclose(fOutID);

    else
        error("output file error : can't open it");
    end

end