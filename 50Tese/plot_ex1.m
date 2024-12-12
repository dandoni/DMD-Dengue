clc, clear all
run '../../../startup'
close all
load 'ex1.hdf5'

% Presentation information
latexdir = 'exemplo_1';
filename = 'exemplo1.tex'; 
ptitle   = 'Exemplo 1'; 
author   = 'Daniel Moraes Barbosa';

% Creating the latex directory
tex = latex_create( latexdir, filename, ptitle, author, 'article', 'pt' );
  
 tex = latex_add_preamble( tex, { '\usepackage{blindtext}'
                                   '\geometry{a4paper,margin=25mm}' } );
  
  figure_position(1,2,2,1);
  
  tex = latex_figure_properties( tex, 
                                 'type',   'tex', 
                                 'device', '-dpdflatex', 
                                 'size',   [15 3] );



% Adding text for context
tex = latex_add_content( tex, '\clearpage\blindtext' );
  

plot(ss,'o')
xlabel("Valores singulares")
ylabel("Energia associada")
axis([0,100,0,1])
tex = latex_add_fig(tex,"sigmas", "exemplo_sigmas_cap2");
clf

plot(xi,sech(xi+3))
hold on
plot(xi,real(modes))
legend("$\sech(x+3)$","Modo dinamico")
axis('tight')
xlabel('x');
tex = latex_add_fig(tex,"modo", "exemplo_modo_cap2");
clf

imagesc(t,xi,real(X_dmd))
colormap(cmap_rwb),  colorbar, caxis([-1,1]);
axis('tight')
xlabel("t"), ylabel("x")
title("Valores da parte real da reconstrução via DMD") 
tex = latex_add_fig(tex,"f(t)-real", "exemplo_realrec_cap2");
clf

plot(t,real(X)(30,:), 'color', 'b' )
hold on
plot(t,real(X_dmd(30,:)),'--','color','b')
hold on
plot(t,imag(X)(30,:), 'color', 'r')
hold on
plot(t,imag(X_dmd(30,:)),'--', 'color', 'r')
legend("$\Real (f(t))$", "DMD - Parte Real", '$\Imag (f(t))$', "DMD - Parte Imaginária") ;
axis('tight')
xlabel("t")
title("Reconstrução em $x=-4,14$");
tex = latex_add_fig(tex,"f(t)-real-rec", "exemplo_reccid_cap2");
clf


  
  tex = latex_figure_properties( tex, 
                                 'type',   'tex', 
                                 'device', '-dpdflatex', 
                                 'size',   [7 3] )

imagesc(t,xi,real(X))
colormap(cmap_rwb),colorbar, caxis([-1,1]);;
axis('tight')
xlabel("t"), ylabel("x")
title("Valores da parte real da função $f(t)$") 
tex = latex_add_fig(tex,"f(t)-real", "exemplo_real_cap2");
clf

imagesc(t,xi,imag(X))
colormap(cmap_rwb), colorbar, caxis([-1,1]);
axis('tight')
xlabel("t"), ylabel("x")
title("Valores da parte imaginária da função $f(t)$") 
tex = latex_add_fig(tex,"f(t)-imag", "exemplo_imag_cap2");
clf

imagesc(t,xi,real(X_dmd))
colormap(cmap_rwb),  colorbar, caxis([-1,1]);
axis('tight')
xlabel("t"), ylabel("x")
title("Valores da parte real da reconstrução via DMD") 
tex = latex_add_fig(tex,"f(t)-real", "exemplo_realrec_cap2");
clf

plot(t,real(X)(30,:), 'color', 'b' )
hold on
plot(t,real(X_dmd(30,:)),'--','color','b')
hold on
plot(t,imag(X)(30,:), 'color', 'r')
hold on
plot(t,imag(X_dmd(30,:)),'--', 'color', 'r')
legend("$\Real (f(t))$", "DMD - Parte Real", '$\Imag (f(t))$', "DMD - Parte Imaginária") ;
axis('tight')
xlabel("t")
title("Reconstrução em $x=-4,14$");
tex = latex_add_fig(tex,"f(t)-real-rec", "exemplo_reccid_cap2");
clf



close all
latex_compile(tex,'batchmode');