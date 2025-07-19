
function [ X_ls E_ls A sigma r ] = compute_least_squares( X, pc )

% Function to compute Least Square aproximation of data
%
% usage: 
%   [ X_ls E_ls ] = compute_least_squares( X, pc )
%
% X  - Data matrix
% pc - Percentage of singular values to preserve (default = 1)
% 
% X_ls - Reconstructed data from least squares aproximation
% E_ls - Approximantion error 

  if( ~isvarname( 'pc' ) ); pc = 1; end

  % Normalization of dataset - This operation will be undone on the modes
  %------------------------------------------------------------------------------%
  
  X_mean = mean(X(:));    X = X - X_mean;
  X_max = max(abs(X(:))); X = X / X_max;

  %------------------------------------------------------------------------------%
  
  Ns = size( X, 2 );
  
  X1 = X( :, 1:end-1 );
  X2 = X( :, 2:end   );
  
  % Decomposing X1 and building A
  %------------------------------------------------------------------------------%
  
  [ U S V ] = svd( X1, 'econ' );
  
  sigma = diag(S);
  r = length(sigma);
  
  if( pc < 1 )
  
    ss = cumsum( sigma );
    ss = ss / ss(end);
    
    % Number of singular values to be preserved
    r = max( 1, find( ss > pc, 1 ) );
  
    U = U( 1:end, 1:r );
    S = S( 1:r,   1:r );
    V = V( 1:end, 1:r );
  
  end
  
  InvS = diag( 1./diag(S) );
  
  A  = X2 * V * InvS * U';
  
  % Reconstructing X by A
  %------------------------------------------------------------------------------%
  
  X_ls = zeros(size(X));
  X_ls(:,1) = X(:,1);
  
  for ii = 2:Ns
  
    X_ls(:,ii) = A * X_ls(:,ii-1);
  
  end
  
  E_ls = X - X_ls;

  X_ls = ( real( X_ls ) * X_max ) + X_mean;
  E_ls = ( real( E_ls ) * X_max );

end
%------------------------------------------------------------------------------%
