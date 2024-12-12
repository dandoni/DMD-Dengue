##function run_fase_seno
close all,clear all, clc;

run '../startup'

pc = 0.96;

ndt = 1000;
dts = linspace(1E-3,1E-1,ndt);

for jj = 1:ndt
  dt =dts(jj);
  div = 100;
  t = 0:dt:(div-1)*dt; 
  
  
  X = zeros(2,div);
  
  X(1,:) = cos(t);
  
  nf = 100;
  fases = linspace(-pi,pi,nf);

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
  
  ##plot(fases,e);
  ##axis([-pi,pi,0,0.05])
  ##set(gca,'XTick',-pi:pi/2:pi)
  ##set(gca,'XTickLabel',{'-\pi','-\pi/2','0','\pi/2','\pi'})
  ##
endfor


figure(1)
raz = dts./fase_min;
plot(dts,raz)
xlabel("dt") , ylabel("dt/fase");
figure(2)
raz = dts.*fase_min;
plot(dts,raz)
xlabel("dt") , ylabel("dt*fase");
figure(3)
plot(dts,fase_min)
xlabel("dt") , ylabel("fase");

