
function [ modes lambdas sigmas r ] = compute_dmd( X, pc )

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
  
  X_mean = mean(X(:));    X = X - X_mean;
  X_max = max(abs(X(:))); X = X / X_max;
  
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
  modes = ( modes * X_max ) + X_mean;

end
%------------------------------------------------------------------------------%
