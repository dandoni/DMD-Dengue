 clear all

 tic


 for j = 2023:2025
   file1 = strcat("Dengue", num2str(j));
   filename = strcat(file1, "mun.csv");

   file2 = strcat("dataMun", num2str(j));
   save_file = strcat(file2, ".hdf5");

   output_file = strcat(filename, "_treated");  % same file name to overwrite

  fid_in = fopen(filename, "r");
  fid_out = fopen(output_file, "w");

while ~feof(fid_in)
  line = fgetl(fid_in);

  % Skip empty lines
  if isempty(line)
    continue;
  end

  % Remove quotes and split by semicolon
  line = strrep(line, '"', '');
  tokens = strsplit(line, ';');

  % Extract the numeric code (discard city name)
  first_field = strsplit(tokens{1});
  code = str2double(first_field{1});

  % Process remaining fields: replace '-' with '0'
  numeric_tokens = strrep(tokens(2:end), '-', '0');
  numbers = str2double(numeric_tokens);

  % Write cleaned line to file
  fprintf(fid_out, "%d", code);  % write code first
  for k = 1:length(numbers)
    fprintf(fid_out, ";%g", numbers(k));  % write each number separated by semicolon
  end
  fprintf(fid_out, "\n");  % new line for next row
end

fclose(fid_in);
fclose(fid_out);



  x = dlmread(output_file, ";", 0, 0);

  % Create temporary struct for this year
  yearData = struct();
  yearData.(sprintf('cod%d', j)) = x(:,1);
  yearData.(sprintf('X%d', j)) = x(:,2:end-1);

  % Save only this year's data
  save(save_file, '-struct', 'yearData');

  clearvars yearData
end
 #x = dlmread(output_file,";",0,0);

 #x = x';


 #cod2025 = x(1:end,1);

 #X2025 = x(1:end,2:end-1);

 #save save_file

 toc
