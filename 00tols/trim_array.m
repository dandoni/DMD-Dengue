
function B = trim_array( A, x );

% TRIM_ARRAY Trim array values larger than x in modulus
%
% usage: B = trim_array( A, x )
%
%  if abs(A(i)) <= abs(x)
%  then B(i) = A(i)
%  else B(i) = sign(A(i)) * abs(x)

% Luis Alberto D'Afonseca
% Since: Nov, 18, 2003
% $Id$

%------------------------------------------------------------------------------%

x = abs(x);

B = A;

B( find( B > x ) ) =  x;
B( find( B <-x ) ) = -x;

%------------------------------------------------------------------------------%
