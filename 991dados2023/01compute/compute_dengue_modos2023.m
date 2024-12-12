clc, clear all
run '../../../startup'
close all

load 'dengue_proj2023.hdf5'

[f ind] = sort(freq);
amp = vecnorm(modes)(ind);
amp = amp./max(amp);
ss = sigmas./sum(sigmas);
amp2 = vecnorm(coef)(ind);
amp2 = amp2./max(amp2);

h = waitbar (0, '0%');
for ii = 1:length(lambdas)
    p = ii/length(lambdas);
      waitbar (p, h, sprintf ('%.2f%%', p*100));
    modes_t = modes(:,ii);
    lambda_t = lambdas(ii);
    b_t = b(1,ii);
    X_dmd(:,:,ii) = compute_dmd_reconstruction_im_b(Y_o,modes_t,lambda_t,b_t);
end  
close(h)

save 'dengue_modos2023.hdf5' '-hdf5'