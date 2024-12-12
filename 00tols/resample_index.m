
function ii = resample_index( jj, nn )

% RESAMPLE_INDEX - Resample nn elements of index jj
%
% usage: ii = resample_index( jj, nn )
%
%  jj - Original index vector or the size of a vector like 1:jj
%  nn - Number of elements to be sampled
%
%  ii - New index vector with nn elements

% Luis Alberto D'Afonseca
% Since: Aug, 05, 2003
% $Id$

%------------------------------------------------------------------------------%

Nj = length( jj );

if( Nj == 1 )
  
  Nj = round(jj);
  jj = 1:Nj;
  
end;

if( Nj <= nn )
  
  ii = jj;
  
elseif( nn == 1 )
  
  ii = jj( round(end/2) );
  
else
  
  ii = jj( round( linspace(1,Nj,nn) ));
    
end;

%------------------------------------------------------------------------------%
