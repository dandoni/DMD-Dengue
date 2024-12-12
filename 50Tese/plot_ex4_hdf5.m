function plot_ex4_hdf5
clc, clear all
run '../../../startup'
close all

load 'ex4.hdf5'

% Presentation information
latexdir = 'exemplo4';
filename = 'exemplo4.tex'; 
ptitle   = 'Exemplo 4'; 
author   = 'Daniel Moraes Barbosa';

% Creating the latex directory
tex = latex_create( latexdir, filename, ptitle, author, 'article', 'pt' );
figure_position(1,2,2,1);
  
tex = latex_add_preamble( tex, { '\usepackage{blindtext}'
                                   '\geometry{a4paper,margin=25mm}' } );
                                   
 
%FIGURAS DE 1 PAGINA
                                   
tex = latex_figure_properties( tex, 'type', 'tex',
                                    'device', '-dpdflatex' ,
                                    'size',   [15 4] );

                                    
plot(t(50:150),X(50:150),'linewidth',0.2)
hold on
plot(t(50:150),real(Z)(50:150), '--', 'color', 'b')
plot(t(50:150),imag(Z)(50:150), '--', 'color', 'r')
plot_axis_setup();

h = legend("$f(t)$","Complexificado - Real", "Complexificado - Imag");
set( h, 'position', [ 0.67 0.6 0.3 0.35 ]) 

tex = latex_add_fig(tex,"Dado Obtido","ex4_dado");
clf                                    


plot(t(50:150),X(50:150),'linewidth',0.5)
hold on
plot(t(50:150),real(X_dmd)(50:150),'--','color','b')
plot_axis_setup();
h = legend("$f(t)$", "DMD") ;
set( h, 'position', [ 0.77 0.6 0.2 0.35 ]) 

tex = latex_add_fig(tex,"Parte Real", "ex4_rec");
clf      
      
 
% Figuras pra meia pagina

tex = latex_figure_properties( tex, 
                                 'type',   'tex', 
                                 'device', '-dpdflatex', 
                                 'size',   [7 3.5] );  
y = y./200;                                 
plot(f, y)
axis([-8,8,0,1])
plot_axis_setup2()
tex = latex_add_fig(tex,"Freq1","ex4_freq1");
clf


y2 = y2./200;
plot(f, y2)
axis([-8,8,0,1])
plot_axis_setup2()
tex = latex_add_fig(tex,"Freq2","ex4_freq2");
clf


plot(t(50:150),X(50:150))
plot_axis_setup();
tex = latex_add_fig(tex,"dado meia","ex4_dado_meia",'box', 'on');
clf


plot(t(50:150),real(Z)(50:150),  'color', 'b')
hold on
plot(t(50:150),imag(Z)(50:150),  'color', 'r')
plot_axis_setup();

h = legend("Real", "Imaginária");
set( h, 'orientation', 'horizontal',
        'position', [ 0.15 0.9 0.7 0.1 ]) 
tex = latex_add_fig(tex,"dado meia 2","ex4_dado_meia2",'box', 'on');
clf

function plot_axis_setup()
  set (gca,'position',[0.0700   0.30000   0.90000   0.6500])
  xlabel('$t$')  
  axis([-pi, pi,-1.1,1.1] )
  yticks([-1:1:1])

  
endfunction  

function plot_axis_setup2()
set (gca,'position',[0.0700   0.30000   0.90000   0.6500])  ;
xlabel('Frequências')
ylabel('Amplitude') 
endfunction  
close all
latex_compile(tex,'batchmode');
endfunction