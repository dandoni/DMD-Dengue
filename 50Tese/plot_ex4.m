% Presentation information
latexdir = 'exemplo4_latex';
filename = 'exemplo4.tex'; 
ptitle   = 'Exemplo 4'; 
author   = 'Daniel Moraes Barbosa';

% Creating the latex directory
tex = latex_create( latexdir, filename, ptitle, author, 'article', 'pt' );
figure_position(1,2,2,1);
tex = latex_figure_properties( tex, 'type', 'tex', 'device', '-dpdflatex', 'size', [14 4.5] );  %figuras geradas direto em pdf

load 'ex4'

plot(f, y)
axis('tight')
xlabel('Frequências')
ylabel('Amplitude')
tex = latex_add_fig(tex,"Freq1","ex4_freq1");
clf

plot(t(50:150),X(50:150))
hold on
plot(t(50:150),real(Z)(50:150), '--', 'color', 'b')
hold on 
plot(t(50:150),imag(Z)(50:150), '--', 'color', 'r')
legend("$f$","Dado Complexificado - Real", "Dado Complexificado - Imag");
axis('tight')
xlabel('t')
tex = latex_add_fig(tex,"Dado Obtido","ex4_dado");
clf

plot(f, y2)
axis('tight')
xlabel('Frequências')
ylabel('Amplitude')
tex = latex_add_fig(tex,"Freq2","ex4_freq2");
clf

plot(t(50:150),X(50:150))
hold on
plot(t(50:150),real(X_dmd)(50:150),'--','color','b')
legend("$f(t)$", "DMD") ;
axis('tight')
xlabel("t")
tex = latex_add_fig(tex,"Parte Real", "ex4_rec");
clf

close all
latex_compile(tex,'batchmode');