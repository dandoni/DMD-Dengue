function plot_ex1_hdf5
clc, clear all
run '../../../startup'
close all

xi = linspace(-2*pi,2*pi,100);
alfa = [0.25 + 2*i, 3*i, -0.3+4*i];
X = [e.^(alfa(1)*xi);
     exp(alfa(2)*xi);
     exp(alfa(3)*xi)];
     
% Presentation information
latexdir = 'amp_freq';
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
                                 
                                 
plot(xi,real(X(1,:)))
hold on
plot(xi,real(X(2,:)))
plot(xi,real(X(3,:)))
plot_axis_setup()
tex = latex_add_fig(tex,"modo", "amp_freq");
clf

close all
latex_compile(tex,'batchmode');    

function plot_axis_setup()
  
set (gca,'position',[0.0700   0.30000   0.90000   0.6500])  
  
h = legend('$\alpha = 0,25 + 2i$','$\alpha = 0+3i$','$\alpha = -0,3 + 4i$');  
  
set( h, 'orientation', 'horizontal',
          'position', [ 0.15 0.76 0.7 0.14 ] )  

axis([-2*pi 2*pi -6 6])
xlabel('$t$');
yticks([-6:3:6])

endfunction


      

                      

endfunction