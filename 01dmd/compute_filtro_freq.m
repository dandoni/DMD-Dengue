function  [ modes lambdas sigmas b r] = compute_filtro_freq(X,pc,dt,freq_high,freq_low)

if nargin == 4      
  freq_low = 0;
endif

##Opcional do Shift
##Ns = 5; %numero de shifts
##ns = Ns+1;
##Xaug = [];
##for ii=1:ns
##  Xaug = [Xaug; X(:,ii:end-ns+ii)];
##end

Xaug = X;
##Calcular DMD normalmente

X1 = Xaug(:,1:end-1);
X2 = Xaug(:,2:end);

% Perform SVD
[U, S, V] =svd(X1, 'econ'); 
sigmas = diag(S); 

if( pc < 1 )

  ss = cumsum( sigmas );
  ss = ss / ss(end);
  
  % Number of singular values to be preserved
  r = max( 1, find( ss > pc, 1 ) );

end      
 
r = min(size(U,2),r);

% Rank trunkation
U = U(:, 1:r);                         
S = S(1:r, 1:r);
V = V(:, 1:r);

% Computing Ã
InvS = diag( 1./diag(S) );           
A  = X2 * V * InvS * U';
At = U' * X2 * V * InvS;

% Computing eigenvalues and dynamic modes
[W, L1] = eig(At); 
L1 = diag( L1 );
aa = abs( L1 );
[ ll ii ] = sort( aa, 'descend' );
lambdas = L1(ii);
modes = X2 * V * InvS * W(:,ii);
omegas = log(lambdas)/dt;

%Computing coefficients
Vand = zeros(r, size(X1,2));  %Vandermonde Matrix 
for k=1:size(X:2),
  Vand(:,k) = lambdas.^(k-1);
endfor
%Jovanovic et al,2014
G = S*V';
P = (W'*W).*conj(Vand*Vand');
q = conj(diag(Vand*G'*W));
P1 = chol(P,'lower');
b = (P1')\(P1\q);


%Filter by frequencies
freqs = abs(imag(omegas)/(2*pi));   %ABS POIS VEM CONJUGADO
mymodes = find(freqs <= freq_high & freqs>= freq_low);

%Return right values
modes = modes(1:size(X,1),mymodes);         
lambdas = lambdas(mymodes);
b = b(mymodes);
sigmas = sigmas(mymodes);
r = length(sigmas);
omegas = omegas(mymodes);
end