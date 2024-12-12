clear all, clc

load dengue_proj2023.hdf5
for ii=1:1:4
  cid.rec(ii,:) = X_dmd(cid.ind_o(ii),:);
  cid.dados(ii,:)= X_o(cid.ind_o(ii),:);
endfor

clearvars -except cid num_sem

save 'cidadesrec2023.hdf5'