

run '../startup'

pc = 0.96;



div = 100;
t = linspace(0,4*pi,div);
dt = t(2) - t(1); 


X = zeros(2,div);

X(1,:) = sin(t);

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
fase_min = fases(ivalor);

plot(fases,e);
axis([-pi,pi,0,0.05])
set(gca,'XTick',-pi:pi/2:pi)
set(gca,'XTickLabel',{'-\pi','-\pi/2','0','\pi/2','\pi'})


