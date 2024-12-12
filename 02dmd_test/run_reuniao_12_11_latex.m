##function run_reuniao_12_11_latex
close all,clear all, clc;

run '../startup'

% Presentation information
latexdir = 'Reuniao_12_11';
filename = '12_1122.tex'; 
ptitle   = 'Fase seno e filtro de freq'; 
author   = 'Daniel Moraes Barbosa';

% Creating the latex directory
tex = latex_create( latexdir, filename, ptitle, author, 'beamer', 'en' );

figure_position(1,2,2,1);

tex = latex_figure_properties( tex, 'type', 'tex', 'device', '-dpdflatex' );  %figuras geradas direto em pdf

set( 0, 'DefaultAxesFontSize', 6 );

 
#1# Explorando Fase de um Seno somente
%------------------------------------------------------------------------------%
pc = 0.96;
tex = latex_add_section(tex,"Relação fase shift de um seno"); 

% Build data
div = 100;
t = linspace(0,4*pi,div);
dt = t(2) - t(1); 
X = zeros(2,div);
X(1,:) = sin(t);

% Define parameters
nf = 100;
fases = linspace(-pi,pi,nf);

content = ['Consideramos uma malha de ' num2str(div) ' divisões com um intervalo $\delta t = ' num2str(dt) '$ \\ Além disso consideramos ' num2str(nf) ' divisões igualmente espaçadas  de fases entre $-\pi$ e $\pi$'];

tex = latex_add_content(tex,content);

% Calculating DMD for each phase shift
for ii = 1:nf
  
  fase     = fases(ii);
  X(2,:) = sin(t+fase);
  [ modes lambdas sigmas r] = compute_dmd(X,pc);
  [ X_dmd E_dmd ] = compute_dmd_reconstruction_im( X, modes, lambdas);
  X_dmd = real(X_dmd(1,:,end));
  e(ii) = norm( X_dmd - X(1,:))/ norm(X(1,:));
  
endfor

% Determining mininum error frequencies and first correct adjustment
[valor,ivalor] = min(e);
fase_min = fases(ivalor);

[correct,icorrect] = find(e<0.1);
fase_first = fases(icorrect(1));


% Generating Figures for phase error
subplot(2,1,2)
plot(fases,e);
axis([-pi,pi,0,0.05])
set(gca,'XTick',-pi:pi/4:pi)
set(gca,'XTickLabel',{'-\pi','-\pi/4','-\pi/2','0','\pi/4','\pi/2','\pi'})

subplot(2,1,1)
plot(fases,e);
axis([-pi,pi,0,1])
set(gca,'XTick',-pi:pi/4:pi)
set(gca,'XTickLabel',{'-\pi','-\pi/4','-\pi/2','0','\pi/4','\pi/2','\pi'})

tex = latex_add_fig(tex, sprintf('Relação Fases e Erro'), sprintf('fig_faseerro'));
clf

% Generate working and not working reconstructions

% Not Working
fase = fases(icorrect(1)-1);
X(2,:) = sin(t+fase);
[ modes lambdas sigmas r] = compute_dmd(X,pc);
[ X_dmd E_dmd ] = compute_dmd_reconstruction_im( X, modes, lambdas);
X_dmd = real(X_dmd(1,:,end));


f1 = subplot(2,1,1); 
plot(X(1,:));
ylabel("Posição"), title("Dados");

f2 = subplot(2,1,2);
plot(X_dmd),
ylabel("Posição");
title("Reconstrução");

tex = latex_add_fig(tex, sprintf('Reconstrução com fase que não funciona'), sprintf('fig_rec1'));
clf

% Working

fase = fases(icorrect(1));
X(2,:) = sin(t+fase);
[ modes lambdas sigmas r] = compute_dmd(X,pc);
[ X_dmd E_dmd ] = compute_dmd_reconstruction_im( X, modes, lambdas);
X_dmd = real(X_dmd(1,:,end));


f1 = subplot(2,1,1); 
plot(X(1,:));
ylabel("Posição"), title("Dados");

f2 = subplot(2,1,2);
plot(X_dmd),
ylabel("Posição");
title("Reconstrução");

tex = latex_add_fig(tex, sprintf('Reconstrução com fase que funciona'), sprintf('fig_rec2'));
clf

% Optimal

fase = fase_min;
X(2,:) = sin(t+fase);
[ modes lambdas sigmas r] = compute_dmd(X,pc);
[ X_dmd E_dmd ] = compute_dmd_reconstruction_im( X, modes, lambdas);
X_dmd = real(X_dmd(1,:,end));


f1 = subplot(2,1,1); 
plot(X(1,:));
ylabel("Posição"), title("Dados");

f2 = subplot(2,1,2);
plot(X_dmd),
ylabel("Posição");
title("Reconstrução");


tex = latex_add_fig(tex, sprintf('Reconstrução com fase otima'), sprintf('fig_rec3'));
clf


#2# Relação entre fase e dt
%------------------------------------------------------------------------------%

clearvars -except tex

tex = latex_add_section(tex,"Relação fase dt");

% Defining Parameters
pc = 0.96;
ndt = 10;
dts = linspace(1E-3,1E-1,ndt);
nf = 10;
fases = linspace(-pi,pi,nf);

content = ['Consideramos agora ' num2str(ndt) ' valores de $\delta t \in [0.001,0.1]$ com um numero fixo de snapshots'];

tex = latex_add_content(tex,content);


% Computing DMD and errors
for jj = 1:ndt
  dt =dts(jj);
  div = 100;
  t = 0:dt:(div-1)*dt; 
  X = zeros(2,div);
  X(1,:) = sin(t);
  
  for ii = 1:nf
    
    fase     = fases(ii);
    X(2,:) = sin(t+fase);
    [ modes lambdas sigmas r] = compute_dmd(X,pc);
    [ X_dmd E_dmd ] = compute_dmd_reconstruction_im( X, modes, lambdas);
    X_dmd = real(X_dmd(1,:,end));
    e(ii) = norm( X_dmd - X(1,:))/ norm(X(1,:));
    
  endfor
  
  [valor,ivalor] = min(e);
  fase_min(jj) = fases(ivalor);
  [correct,icorrect] = find(e<0.1);
  fase_first(jj) = fases(icorrect(1));
  
endfor

raz1 = dts./fase_min;
raz2 = dts.*fase_min;

raz3 = dts./fase_first;
raz4 = dts.*fase_first;

subplot(2,2,1)
plot(dts,raz1)
xlabel("dt") , ylabel("dt/fase otima");
subplot(2,2,2)
plot(dts,raz2)
xlabel("dt") , ylabel("dt*fase otima");
subplot(2,2,3)
plot(dts,raz3)
xlabel("dt") , ylabel("dt/fase");
subplot(2,2,4)
plot(dts,raz4)
xlabel("dt") , ylabel("dt*fase");

tex = latex_add_fig(tex, sprintf('Algumas Razoes'), sprintf('fig_razoes'));
clf

subplot(2,1,1)
plot(dts,fase_min)
axis([1E-3,1E-1,-pi,pi])
set(gca,'YTick',-pi:pi/4:pi)
set(gca,'YTickLabel',{'-\pi','-3\pi/4','-\pi/2','-\pi/4','0','\pi/4','\pi/2','3\pi/4','\pi'})
xlabel("dt") , ylabel("fase otima");

subplot(2,1,2)
plot(dts,fase_first)
xlabel("dt"), ylabel("fase minima");
axis([1E-3,1E-1,-pi,pi])
set(gca,'YTick',-pi:pi/4:pi)
set(gca,'YTickLabel',{'-\pi','-3\pi/4','-\pi/2','-\pi/4','0','\pi/4','\pi/2','3\pi/4','\pi'})

tex = latex_add_fig(tex, sprintf('Fase por dt'), sprintf('fig_fasedt'));
clf


#3# Seno Composto
%------------------------------------------------------------------------------%

##tex = latex_add_section("Composição de senos");

clearvars -except tex

pc = 0.96;
div = 100;
t = linspace(0,4*pi,div);
dt = t(2) - t(1); 
X = zeros(2,div);
X(1,:) = sin(t)+sin(4*t);
nf = 100;
fases = linspace(-pi,pi,nf);

for ii = 1:nf
  
  fase     = fases(ii);
  X(2,:) = sin(t+fase)+sin(4*t+4*fase);   %4 fase pois o shift nao considera o que é fase ou nao
  [ modes lambdas sigmas r] = compute_dmd(X,pc);
  [ X_dmd E_dmd ] = compute_dmd_reconstruction_im( X, modes, lambdas);
  X_dmd = real(X_dmd(1,:,end));
  e(ii) = norm( X_dmd - X(1,:))/ norm(X(1,:));
  
endfor

[valor,ivalor] = min(e);
fase_min = fases(ivalor);
% Generating Figures for phase error
subplot(2,1,2)
plot(fases,e);
axis([-pi,pi,0.8,1.3])
set(gca,'XTick',-pi:pi/4:pi)
set(gca,'XTickLabel',{'-\pi','-\pi/4','-\pi/2','0','\pi/4','\pi/2','\pi'})

subplot(2,1,1)
plot(fases,e);
axis([-pi,pi,0,1.3])
set(gca,'XTick',-pi:pi/4:pi)
set(gca,'XTickLabel',{'-\pi','-\pi/4','-\pi/2','0','\pi/4','\pi/2','\pi'})

tex = latex_add_fig(tex, sprintf('Relação Fases e Erro'), sprintf('fig_faseerro10'));
clf

fase = fase_min;
X(2,:) = sin(t+fase);
[ modes lambdas sigmas r] = compute_dmd(X,pc);
[ X_dmd E_dmd ] = compute_dmd_reconstruction_im( X, modes, lambdas);
X_dmd = real(X_dmd(1,:,end));


f1 = subplot(2,1,1); 
plot(X(1,:));
ylabel("Posição"), title("Dados");

f2 = subplot(2,1,2);
plot(X_dmd),
ylabel("Posição");
title("Reconstrução");


tex = latex_add_fig(tex, sprintf('Reconstrução com fase otima'), sprintf('fig_rec10'));
clf

Y = X(1,:);
Y = [Y(1:end-1); Y(2:end)];
[ modes lambdas sigmas r] = compute_dmd(Y,pc);
[ Y_dmd E_dmd ] = compute_dmd_reconstruction_im( Y, modes, lambdas);
Y_dmd = real(Y_dmd(1,:,end));

plot(X_dmd)
hold on
plot(Y_dmd)
hold on
plot(X(1,:), '--')
legend("Dmd com fase otima", "Shift", "Real");

tex = latex_add_fig(tex, sprintf('Comparação com shift'), sprintf('fig_rec11'));
clf


close all; 
latex_compile( tex , 'batchmode'); 



