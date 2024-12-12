clc, clear all
run '../../../startup'
close all

load dados_ordenados

## Classe Cid para os dados relacionados a uma cidade só

cid.ind(1) = find ( cod == 313670 ); % Juiz de Fora
cid.ind_o(1) = find (cod_o == 313670 );
cid.ind_oc(1) = find ( cod_oc == 313670 );

cid.ind(2) = find ( cod == 355030 ); % SP
cid.ind_o(2) = find ( cod_o == 355030 );

cid.ind(3) = find ( cod == 330455 ); % RJ
cid.ind_o(3) = find ( cod_o == 330455 );

cid.ind(4) = find ( cod == 520870 ); % Goiania
cid.ind_o(4) = find ( cod_o == 520870 );

cid.X = X(cid.ind,:);
cid.X_o = X_o(cid.ind_o,:);
cid.ordem = ["JF", "SP" , "RJ" , "Goiania" ];



## Casos Totais Brasil

brasil.X = sum(X,1);
brasil.Xc = sum(X_c,1);


## DMD

Y_o = compute_complex_data(X_o);


n = min(size(X));  %Tstar com todos possivei valores singulares

 for ii =1 :n-1
 tic
[ modes lambdas sigmas ] = compute_dmd_r( Y_o,ii);
[ X_dmd ]  = compute_dmd_reconstruction_im_t( Y_o, modes, lambdas );
time(ii) = toc; 
e = abs(real(X_dmd) - X_o);
erro_max(ii) = max(max(e,[],2));
erro_med(ii) = mean(mean(e,2));
  end

cd ../Plots
save 'dengue_rotina'





