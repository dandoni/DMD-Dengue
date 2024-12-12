 function [ modes lambdas sigmas r b ] = compute_dmd2( X, pc ,param )
 
 
% Function to compute the DMD from data X
%
% usage: 
%   [ modes lambdas sigmas r ] = compute_dmd( X, pc )
%
% X     - Data matrix
% pc    - Percentage of singular values to preserve
% 
% modes   - Dynamic Modes
% lambdas - Eigenvalues 
% sigmas  - Singular values of X1
% r       - Reduced rank
%

  if( ~isvarname( 'pc' ) ); pc = 1; end
  
  % Normalization of dataset - This operation will be undone on the modes
  %------------------------------------------------------------------------------%
  
##  X_mean = mean(X(:));    X = X - X_mean;
##  X_max = max(abs(X(:))); X = X / X_max;
##  
  %------------------------------------------------------------------------------%
  
  Ns = size( X, 2 );
  
  X1 = X( :, 1:end-1 );
  X2 = X( :, 2:end   );
  
  % Decomposing X1, building A and At
  %------------------------------------------------------------------------------%
  
  [ U S V ] = svd( X1, 'econ' );
  
  sigmas = diag(S);
  r = length(sigmas);
  
  if( pc < 1 )
  
    ss = cumsum( sigmas );
    ss = ss / ss(end);
    
    % Number of singular values to be preserved
    r = max( 1, find( ss > pc, 1 ) );
  
    U = U( 1:end, 1:r );
    S = S( 1:r,   1:r );
    V = V( 1:end, 1:r );
  
  end
  
  InvS = diag( 1./diag(S) );
  
  A  = X2 * V * InvS * U';
  
  At = U' * X2 * V * InvS;
  
  % Computing eigenvalues and dynamic modes
  %------------------------------------------------------------------------------%
  
  [ W L ] = eig( At );
  
  L = diag( L );
  aa = abs( L );
  
  [ ll ii ] = sort( aa, 'descend' );
  
  lambdas = L(ii);
  
  modes = X2 * V * InvS * W(:,ii);
##  modes = ( modes * X_max ) + X_mean;
## 
 
 
 %Power of modes
  Vand = zeros(r, size(X1,2));  %Vandermonde Matrix 
  
  for k=1:size(X:2),
    Vand(:,k) = lambdas.^(k-1);
  endfor
  
  %Linhas do artivo Jovanovic et al,2014
    G = S*V';
    P = (W'*W).*conj(Vand*Vand');
    q = conj(diag(Vand*G'*W));
    P1 = chol(P,'lower');
    b(:,1) = (P1')\(P1\q);  %Optimal Vecotr of amplitudes b   
    
       L = repmat (lambdas', size(modes)(1),1);
   L = 1./L;
   for ii = 1:param.nb
     b(:,ii+1) = (L.^(ii-1)).*modes \ X(:,ii);
   end
    
    