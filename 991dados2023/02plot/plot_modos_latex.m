function plot_modos_latex
clc, clear all
run '../../startup'
close all
##tic
load 'dengue_modos2023.hdf5'
##toc

% Presentation information
latexdir = 'Dengue Modos Freq';
filename = 'exemplo_1_latex.tex'; 
ptitle   = 'Dengue'; 
author   = 'Daniel Moraes Barbosa';

% Creating the latex directory
tex = latex_create( latexdir, filename, ptitle, author, 'article', 'pt' );
figure_position(1,2,2,1);
tex = latex_add_preamble( tex, { '\usepackage{blindtext}'
                                   '\geometry{a4paper,margin=25mm}' } );
 
tex = latex_figure_properties( tex, 
                                 'type',   'tex', 
                                 'device', '-dpdflatex', 
                                 'size',   [15 4] );

 
b_v = b(1,ind)';
lambdas_v = lambdas(ind); 
e1 = real(lambdas_v).*abs(b_v); 
e2 = abs(real(lambdas_v).*real(b_v));

for jj =1:num_sem
 erro(:,jj) = abs(real(lambdas_v.^jj).*b_v);

end 
 e3 = max(erro,[],2);
 e3 = e3./max(e3);
g = 1./f(2:end); 
 ii = 68; 
 kk=76;
 
##plot_bar(g(1:ii-1),e1(2:ii));hold on; plot(g(ii:end),e1(ii+1:end),'bo'); hold off
##ylim([0,0.2])
##xlabel("Período em anos");
##ylabel("$\\gamma$");
##set (gca,'position',[0.100   0.30000   0.85000   0.6500]) 
##tex = latex_add_fig(tex,"freq", "dengue_freq1",'box','on');
##clf
##  
##  plot_bar(g(1:ii-1),e2(2:ii));hold on; plot(g(ii:end),e2(ii+1:end),'bo'); hold off
##ylim([0,0.2])
##xlabel("Período em anos");
##ylabel("$\\gamma$");
##set (gca,'position',[0.100   0.30000   0.85000   0.6500]) 
##tex = latex_add_fig(tex,"dengue dadofinal", "dengue_freq2");
##clf
  
plot_bar(g(ii:kk),e3(ii+1:kk+1))%,'bo','markersize',0.5) ;%hold on;  plot_bar(g(1:ii-1),e3(2:ii)); hold off
hold on;
plot(g(kk+1:end),e3(kk+2:end),'bo','markersize',0.5);
hold off;
ylim([0,1.0005])
set(gca,'ytick',0:0.5:1)
set(gca,'xtick',0:1:12)
grid on
xlabel("Período em anos");
ylabel("$\\gamma$");
set (gca,'position',[0.0800   0.30000   0.88000   0.6500]) 
tex = latex_add_fig(tex,"dengue dadofinal", "dengue_freq3", 'box','on');
clf
  
close all
latex_compile(tex,'batchmode');
endfunction  

