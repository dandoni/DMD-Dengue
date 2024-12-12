 run '../startup' 

 tic
 
 csv = 'DadosDengueMunicipio.csv';                  % Nome da planilha de dados

 x = dlmread(csv,";",0,0);
 
 x = x';
 
 x = x(1:5571,:);
  
 cod = x(2:end,1);
 
 sem = x(1,2:end);
 
 X = x(2:end,2:end);
 
 save dataMun
 
 toc