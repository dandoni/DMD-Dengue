clc, clear all
#run '../../startup'
close all

load dados_ordenados2025.hdf5


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
save 'dengue_rotina2025'
