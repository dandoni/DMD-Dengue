function plot_modos
clc, clear all
run '../../startup'
close all
tic
load 'dengue_modos2023.hdf5'
toc
% Presentation information
latexdir = 'Dengue Modos';
filename = 'dengue_modos.tex'; 
ptitle   = 'Dengue Modos'; 
author   = 'Daniel Moraes Barbosa';

% Creating the latex directory
tex = latex_create( latexdir, filename, ptitle, author, 'beamer', 'pt' );
figure_position(1,2,2,1);



plot(f,amp)
axis([0,25,0.997,1]);
axis_setup1();
tex = latex_add_fig(tex,"Espectro de frequencias - modos", "freq1");
clf

plot(f,amp)
axis([0,25,0.98,1]);
axis_setup1();
tex = latex_add_fig(tex,"Espectro de frequencias - modos", "freq2");
clf


plot(f,ss(ind))
axis([0,25,0,0.3])
axis_setup2()
tex = latex_add_fig(tex,"Espectro de frequencias - valores singulares", "freq3");
clf

plot(f,amp2)
axis([0,25,0,1])
axis_setup1()
tex = latex_add_fig(tex,"Espectro de frequencias - modos ajustados", "freq4");
clf

##for ii =1 :length(lambdas)
##  imagesc(real(X_dmd(:,:,ii)))
##  axis_setup3()
##  title(sprintf("Informaçao gerada pelo modo %d", ii))
##  tex = latex_add_fig(tex,sprintf("Modo %d",ii), sprintf("dado_modo_%d",ii));
##  clf
##end

function axis_setup1()
ylabel("Amplitude do modo")
xlabel("Frequencia em anos")
endfunction

function axis_setup2()
  ylabel("Valor de energia")
xlabel("Frequencia em anos")
endfunction

function axis_setup3()
  colormap(cmap_wgbr)
  colorbar
  caxis([0,5])
  ylabel("Cidades")
  xlabel("t")
  
endfunction


close all
latex_compile(tex,'batchmode');
endfunction
