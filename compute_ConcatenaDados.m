clearvars
load('dataMun');    % Contains X and cod
X = X';             % Ensure X is rows = features, cols = indexed entries
cod = cod(:)';

% Get number of features and indices
num_weeks = size(X, 1);
num_cities = length(cod);

for year = 2023:2025
    file = strcat('dataMun', num2str(year), '.hdf5');
    load(file);

    dataVar = strcat('X', num2str(year));
    indexVar = strcat('cod', num2str(year));

    data = eval(dataVar)';
    codNew = eval(indexVar)(:)';

    % Initialize aligned matrix with zeros
    alignedData = zeros(size(data,1), num_cities);

    % Find index positions where cod matches codNew
    [~, loc] = ismember(cod, codNew);   % Match cod to codNew
    valid = loc > 0;

    % Place matched data into correct columns
    alignedData(:, valid) = data(:, loc(valid));

    % Concatenate horizontally
    X = cat(1, X, alignedData);
end

% Optional: Save result
save('dataMun2025.mat', 'X', 'cod');

 num_sem = size(X,1);
 sem = linspace(1,num_sem,num_sem);

 save dataMun2025.hdf5
