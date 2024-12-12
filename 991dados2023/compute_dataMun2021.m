
 tic
 
 csv = 'Dengue2021mun.csv';                  % Nome da planilha de dados

 x = dlmread(csv,";",0,0);
 
 x = x';
 
 cod2021 = x(1:end,1);

 X2021 = x(1:end,2:end-1);
 
 save dataMun2021.hdf5
 
 toc