
function latex_semilogy_annotations( A, B )

% Set the annotations of a semilogy plot to propripriated LaTeX formating
%
% Usage:  latex_semilogy_annotations( h, P )
%
% h - axis handle, if not provided uses handle to the current axes object
% P - optional parameter giving the powers of y for the axis ticks
%

  switch( nargin )

    case 0
      h = gca;
      P = latex_semilogy_annotations_default_powers( h );

    case 1
      if( ishandle( A ) )
        h = A; 
        P = latex_semilogy_annotations_default_powers( h );
      else
        h = gca;
	P = A;
      end

    case 2
      h = A;
      P = B;

    otherwise
      error('too many parameters!')

  end

  ytick      = 10.^P;
  yticklabel = strsplit( sprintf( '1e%d\n', P ), '\n');

  set( h,'ytick',      ytick,
         'yticklabel', yticklabel,
         'yminortick','off',
         'xgrid','on',
         'ygrid','on')

end

%------------------------------------------------------------------------------%
function P = latex_semilogy_annotations_default_powers( h )

  ll = ylim( h );
 
  pmin = floor( log10( ll(1) ) );
  pmax = ceil ( log10( ll(2) ) );

  P = round( linspace( pmin, pmax, 5 ));

end

%------------------------------------------------------------------------------%
