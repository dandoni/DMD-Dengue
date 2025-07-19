 function [ modes lambdas sigmas r b ] = compute_dmd_b2_r( X, pc)
 
 
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
    r = 50;
  
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

%Power of modes
  Vand = zeros(r, (Ns-1));  %Vandermonde Matrix 
  
  for k=1:Ns-1,
    Vand(:,k) = lambdas.^(k-1);
  endfor
 
  


    
##   for ii = 1:(Ns-1)
##     Va = Vand(:,1:ii);
##     P = W2.*conj(Va*Va');
##     q = conj(diag(Va*G'*W));
##     P1 = chol(P,'lower');
##     b(:,ii) = (P1')\(P1\q);
##   end
##    

##    for ii = 1:(Ns-2)
##     Y = X(:,1:ii);
##     Va = Vand(:,1:ii);
##     H = modes \ Y;
##     b(:,ii) = diag(H/Va);
##     end
## 

 %Linhas do artivo Jovanovic et al,2014
    for ii=1:size(V,1)
      V2 = V(1:ii,:);
      Va = Vand(:,1:ii);
      G = S*V2';
      P = (W'*W).*conj(Va*Va');
      q = conj(diag(Va*G'*W));
      P1 = chol(P,'lower');
      b(:,ii)  = (P1')\(P1\q);
   end
   
   endfunction
    
    