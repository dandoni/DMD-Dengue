
function [ new_modes new_lambdas ] = dmd_filter_growing_modes( modes, lambdas );

% Select modes associated to eigenvalues with real part larger than 1.0
%
% usage: 
%   [ new_modes new_lambdas ] = dmd_filter_growing_modes( modes, lambdas )
%

%------------------------------------------------------------------------------%

tol = 1e-6;

ii = find( real(lambdas) > 1+tol );

new_lambdas = lambdas(ii);
new_modes   = modes(:,ii);

%------------------------------------------------------------------------------%
