clc, clear all
#run '../../../startup'
close all
cd '../'

load dados_ordenados

## Classe Cid para os dados relacionados a uma cidade s�

cid.ind(1) = find ( cod == 313670 ); % Juiz de Fora
cid.ind_o(1) = find (cod_o == 313670 );
cid.ind_oc(1) = find ( cod_oc == 313670 );

cid.ind(2) = find ( cod == 355030 ); % SP
cid.ind_o(2) = find ( cod_o == 355030 );

cid.ind(3) = find ( cod == 330455 ); % RJ
cid.ind_o(3) = find ( cod_o == 330455 );

cid.ind(4) = find ( cod == 310620 ); % BH
cid.ind_o(4) = find ( cod_o == 310620 );

cid.X = X(cid.ind,:);
cid.X_o = X_o(cid.ind_o,:);
cid.ordem = ["JF", "SP" , "RJ" , "BH" ];



## Casos Totais Brasil

brasil.X = sum(X,1);
brasil.Xc = sum(X_c,1);


## DMD


Y = compute_complex_data(X);
Y_c = compute_complex_data(X_c);
Y_o = compute_complex_data(X_o);
Y_oc = compute_complex_data(X_oc);


[ modes lambdas sigmas ] = compute_dmd_r( Y_o,157);
[ X_dmd b]  = compute_dmd_reconstruction_im_t2_ns( Y_o, modes, lambdas ,size(X,2));
freq = imag(log(lambdas)*52/2/pi); % EM ANOS

b= b';
b = repmat( b , length(cod) , 1 );
coef = b.*modes;
fase = imag(log(coef));

##  for ii =1 :n
##tic
##[ modes lambdas sigmas ] = compute_dmd_r( Y,157);
##[ X_dmd ]  = compute_dmd_reconstruction_im_t( Y, modes, lambdas );
##time(ii) = toc;
##e = abs(real(X_dmd) - X);
##erro_max(:,ii) = max(e,[],2);
##erro_med(:,ii) = mean(e,2);
##  end

cd '99Plots'
save 'dengue_proj.hdf5' '-hdf5'





