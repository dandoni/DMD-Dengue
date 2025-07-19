
function [ new_modes new_lambdas ] = dmd_filter_stationary_modes( modes, lambdas );

% Select modes associated to eigenvalues with real part equal to 1.0
%
% usage: 
%   [ new_modes new_lambdas ] = dmd_filter_stationary_modes( modes, lambdas )
%

%------------------------------------------------------------------------------%

tol = 1e-6;

ii = find( abs( real(lambdas) - 1.0 ) <= tol );

new_lambdas = lambdas(ii);
new_modes   = modes(:,ii);

%------------------------------------------------------------------------------%
