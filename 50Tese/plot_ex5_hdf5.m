function plot_ex5_hdf5
clc, clear all
run '../../../startup'
close all

load 'ex5.hdf5'

% Presentation information
latexdir = 'exemplo_5';
filename = 'exemplo_5.tex'; 
ptitle   = 'Exemplo 5'; 
author   = 'Daniel Moraes Barbosa';

% Creating the latex directory
tex = latex_create( latexdir, filename, ptitle, author, 'article', 'pt' );
figure_position(1,2,2,1);
tex = latex_add_preamble( tex, { '\usepackage{blindtext}'
                                   '\geometry{a4paper,margin=25mm}' } );
 
tex = latex_figure_properties( tex, 
                                 'type',   'tex', 
                                 'device', '-dpdflatex', 
                                 'size',   [6.5 4] ) ;  

plot(t(126:375),X(126:375))
hold on
plot(t(126:375),real(X_dmd)(126:375),'--','color','b')
plot_axis_setup()
h = legend("Real $f(t)$", "Real DMD") ;
set( h, 'orientation', 'horizontal',
        'position', [ 0.15 0.9 0.77 0.1 ]) 

tex = latex_add_fig(tex,"Parte Real", "ex5_rec1_cap3");
clf

plot(t(126:375),imag(X)(126:375),'color','r')
hold on
plot(t(126:375),imag(X_dmd)(126:375),'--','color','r')
plot_axis_setup()
h = legend("Imag $f(t)$", "Imag DMD ") ;
set( h, 'orientation', 'horizontal',
        'position', [ 0.13 0.9 0.8 0.1 ]) 
tex = latex_add_fig(tex,"Parte Imaginaria", "ex5_rec2_cap3");
clf



imagesc (t(126:375),xi,real(X2)(:,126:375))
plot_axis_setup2()
ylabel("x")
tex = latex_add_fig( tex, "real X", "ex5_rec3_cap3");
clf

imagesc (t(126:375),xi,real(Y_dmd)(:,126:375))
plot_axis_setup2()
colorbar;
set(gca,'ytick',[])
tex = latex_add_fig( tex, "real rec X", "ex5_rec4_cap3");
clf

imagesc (t(126:375),xi,imag(X2)(:,(126:375)))
plot_axis_setup2()
ylabel("x")
tex = latex_add_fig( tex, "imag X", "ex5_rec5_cap3");
clf

imagesc (t(126:375),xi,imag(Y_dmd)(:,126:375))
plot_axis_setup2()
colorbar;
set(gca,'ytick',[])

tex = latex_add_fig( tex, "real rec X", "ex5_rec6_cap3");
clf


function plot_axis_setup()
 set (gca,'position',[0.0700   0.30000   0.90000   0.6500])  ;
 axis([-pi pi -2 2]) 
 xlabel("t")
 title("")
endfunction  

function plot_axis_setup2()
set (gca,'position',[0.0700   0.30000   0.90000   0.6500])  ;
colormap(cmap_rwb);
xlabel("t")
caxis([-2,2])
endfunction 

close all
latex_compile(tex,'batchmode');

endfunction