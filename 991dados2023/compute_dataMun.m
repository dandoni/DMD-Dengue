 run '../startup' 

 tic
 
 csv = 'DadosDengueMunicipio.csv';                  % Nome da planilha de dados

 x = dlmread(csv,";",0,0);
 x = x(:,2:5571);

 x = x';
 x = sortrows(x);
 x =x'; 
 cod = x(1,1:end);
 
 
 X = x(2:end,1:end);
 
 save dataMun
 
 toc