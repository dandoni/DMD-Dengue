
function plot_ex1_hdf5
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
  
 


% Adding text for context
tex = latex_add_content( tex, '\clearpage\blindtext' );
  

% Figures that go alone  
  
tex = latex_figure_properties( tex, 
                                 'type',   'tex', 
                                 'device', '-dpdflatex', 
                                 'size',   [15 3] );
 

semilogy(ss)
plot_axis_setup_log()
tex = latex_add_fig(tex,"sigmas", "exemplo_sigmas_cap2");
clf

plot(xi,sech(xi+3))
hold on
plot(xi,real(modes))
plot_axis_setup_modo()

tex = latex_add_fig(tex,"modo", "exemplo_modo_cap2");
clf

plot(xi,fase)
set (gca,'position',[0.0700   0.30000   0.90000   0.6500]) 
xlabel('$x$');
ylabel('$\varphi_\phi$','rotation',0)
yticks([-2:1:1])
grid on
tex = latex_add_fig(tex,"fase", "fase");
clf

% Figuras pra meia pagina
  
tex = latex_figure_properties( tex, 
                                 'type',   'tex', 
                                 'device', '-dpdflatex', 
                                 'size',   [6.5 3] )

imagesc(t,xi,real(X))
plot_axis_setup_colormap_real();

tex = latex_add_fig(tex,"f(t)-real", "exemplo_real_cap2");
clf

imagesc(t,xi,imag(X))
plot_axis_setup_colormap_imag();

tex = latex_add_fig(tex,"f(t)-imag", "exemplo_imag_cap2");
clf


imagesc(t,xi,real(X_dmd))
plot_axis_setup_colormap_rec()

tex = latex_add_fig(tex,"f(t)-real", "exemplo_realrec_cap2");
clf

plot(t(50:150),real(X)(30,50:150), 'color', 'b' ,'linewidth',0.2)
hold on
plot(t(50:150),real(X_dmd(30,50:150)),'--','color','b')
plot(t(50:150),imag(X)(30,50:150), 'color', 'r','linewidth',0.2)
plot(t(50:150),imag(X_dmd(30,50:150)),'--', 'color', 'r')
plot_axis_setup_cid_rec()

tex = latex_add_fig(tex,"f(t)-real-rec", "exemplo_reccid_cap2");
clf


close all
latex_compile(tex,'batchmode');

endfunction

function plot_axis_setup_log()


axis([1,100,0,1])
set(gca,'ytick',[10.^[0:-8:-16]])
set(gca,'yminortick', 'off') 
grid on
set(gca, 'yminorgrid','off')

set (gca,'position',[0.0700   0.30000   0.90000   0.6500])
  
h = xlabel("Valores singulares") %, 'position', [0 -1.8 0])

  
endfunction


function plot_axis_setup_modo()
  
set (gca,'position',[0.0700   0.30000   0.90000   0.6500])  
  
h = legend("$\\sech(x+3)$","Modo dinâmico");  
  
set( h, 'orientation', 'horizontal',
          'position', [ 0.52 0.83 0.45 0.12 ] )  

axis([-10 10 -0.4 1])
xlabel('$x$');
yticks([-0.5:.5:1])
ylim([-0.5,1.1])


endfunction


function plot_axis_setup_colormap_real()
  
set (gca,'position',[0.0700   0.30000   0.90000   0.6500])  ;  
colormap(cmap_rwb);
xlabel("t");
ylabel("x")
  
endfunction

function plot_axis_setup_colormap_imag()
  
set (gca,'position',[0.0300   0.30000   0.94000   0.6500])  ;  
colormap(cmap_rwb);
xlabel("t");
colorbar, caxis([-1,1]);
set(gca,'ytick',[])
  
endfunction

function plot_axis_setup_colormap_rec()
  set (gca,'position',[0.0700   0.30000   0.89000   0.6500])  ; 
  colormap(cmap_rwb);
  colorbar, caxis([-1,1]);
  xlabel("t"), ylabel("x");
  yticks([-10:10:10])

endfunction  

function plot_axis_setup_cid_rec()
  set (gca,'position',[0.1000   0.15000   0.85000   0.6500])  
  
  axis([-pi pi -0.6 0.6])
  yticks([-0.6:0.6:0.6])
##  xlabel("t")
 title("");
  
 h = legend("Real $f(t)$", "Real DMD ", ' Imag $f(t)$', "Imag DMD" ) ;
 set( h, 'orientation', 'horizontal',
          'position', [ 0 0.9 1 0.1 ]) 
 
endfunction
