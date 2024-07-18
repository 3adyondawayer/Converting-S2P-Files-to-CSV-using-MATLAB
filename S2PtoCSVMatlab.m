selectedPath = uigetdir;
% Change the current working directory to the selected path
cd(selectedPath);

% Prompt user to select the S-parameter file
[fileName, pathName] = uigetfile('*.s2p', 'Select the S-parameter file');

% Check if a file was selected
if isequal(fileName, 0)
    error('No file selected');
end

try
    % Create the sparameters object
    OBJ_UCFT2_F1 = sparameters(fullfile(pathName, fileName));

    figure(1);
    rfplot(OBJ_UCFT2_F1, 1, 1)

    % Use file name without extension for title and CSV file name
    [~, fileNameNoExt, ~] = fileparts(fileName);

    title('OBJ_UCFT2_F1', 'FontSize', 18, 'FontWeight', 'bold', 'FontName', 'Courier New');
    xlabel('Frequency (GHz)', 'FontSize', 18, 'FontName', 'Courier New', 'FontWeight', 'bold');
    ylabel('Magnitude ', 'FontSize', 18, 'FontName', 'Courier New', 'FontWeight', 'bold');

    h = gcf;  % Get handle to the current figure
    lineObj = findobj(h, 'Type', 'Line');  % Find the line object in the figure
    xData = get(lineObj, 'XData');  % Extract XData
    yData = get(lineObj, 'YData');  % Extract YData
    dataMatrix = [xData', yData'];  % Combine xData and yData

    % Save the data to a CSV file with the same name as the input file
    csvFileName = [fileNameNoExt, '.csv'];
    csvwrite(csvFileName, dataMatrix);
catch ME
    warning('File %s is not a valid Touchstone file or contains errors: %s', fileName, ME.message);
end
