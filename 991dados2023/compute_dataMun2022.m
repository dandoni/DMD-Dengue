
 tic
 
 csv = 'Dengue2022mun.csv';                  % Nome da planilha de dados

 x = dlmread(csv,";",0,0);
 
 x = x';
 
 cod2022 = x(1:end,1);

 X2022 = x(1:end,2:end-1);
 
 save dataMun2022.hdf5
 
 toc
 
