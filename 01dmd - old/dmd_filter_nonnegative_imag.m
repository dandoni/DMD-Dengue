
function [ new_modes new_lambdas ] = dmd_filter_nonnegative_imag( modes, lambdas );

% Select modes associated to eigenvalues with nonnegative imaginary part
%
% usage: 
%   [ new_modes new_lambdas ] = dmd_filter_nonnegative_imag( modes, lambdas )
%

%------------------------------------------------------------------------------%

ii = find( imag(lambdas) > -eps );

new_lambdas = lambdas(ii);
new_modes   = modes(:,ii);

%------------------------------------------------------------------------------%
