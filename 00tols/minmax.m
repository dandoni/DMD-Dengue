
function [ M1, M2 ] = minmax( X );

% MINMAX Minimum and maximum element of an array of any rank
%
% usage:         M = minmax( X )
%    or: [min max] = minmax( X )

% Luis Alberto D'Afonseca
% Since: Aug, 12, 2003
% $Id$

%------------------------------------------------------------------------------%

m1 = min( X(:) );
m2 = max( X(:) );

if( nargout == 2 )

  M1 = m1;
  M2 = m2;

else           

  M1 = [ m1 m2 ];

end;

%------------------------------------------------------------------------------%
