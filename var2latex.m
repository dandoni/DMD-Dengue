
function tex = var2latex( V )

% Convert variabel to LaTeX code
%
% usage: tex = var2latex( V )

  if( ~exist('V') ), error('missing parameter!');
  elseif( isempty   ( V ) ),          tex = '';
  elseif( iscell    ( V ) ),          tex = cell2latex    ( V );
  elseif( isstruct  ( V ) ),          tex = struct2latex  ( V );
  elseif( isnumeric ( V ) ),          tex = numeric2latex ( V );
  elseif( ischar    ( V ) ),          tex = V;
  elseif( islogical ( V ) ),          tex = numeric2latex ( V );
  elseif( isa(V,'function_handle') ), tex = function2latex( V );
  else, tex = 'Unkown variable type';
  end

  tex = [ tex endline ];

end

%------------------------------------------------------------------------------%
function tex = cell2latex( V )

  if( iscellstr( V ) && isvector( V ) )

    tex = '';
    for ii = 1:length(V) 
      tex = [ tex sprintf( '%s\n', V{ii} ) ];
    end

  elseif( isscalar( V ) )

    tex = var2latex( V{1} );

  else

    switch( ndims(V) )
      case 2; tex = cell22latex( V );
      case 3; tex = cell32latex( V );
      case 4; tex = cell42latex( V );
      otherwise; 
        tex = 'Cell with more than 4 dimensions are not implemented yet';
    end

  end

end

%------------------------------------------------------------------------------%
function tex = cell22latex( V )

  [ nl nc ] = size( V );
  
  tex = [ '\begin{tabular}{|' repmat('c|',1,nc) '}\hline' endline ];
  for   ii = 1:nl, tex = [ tex ' '  var2latex(V{ii,1 }) ' ' ];
    for jj = 2:nc, tex = [ tex '& ' var2latex(V{ii,jj}) ' ' ];
    end
    tex = [ tex '\\\hline' endline ];
  end
  tex = [ tex '\end{tabular}' ];

end

%------------------------------------------------------------------------------%
function tex = cell32latex( V )

  nn = size( V, 3 );
  
  tex = [ '\begin{tabular}{|c|} \hline' endline ];
  for ii = 1:nn
    tex = [ tex  cell22latex(squeeze(V(:,:,ii))) '\\ \hline' endline ];
  end
  tex = [ tex '\end{tabular}' ];

end

%------------------------------------------------------------------------------%
function tex = cell42latex( V )

  nl = size( V, 3 );
  nc = size( V, 4 );
  
  tex = [ '\begin{tabular}{|' repmat('c|',1,nc) '} \hline' endline ];
  for   ii = 1:nl, tex = [ tex ' '  cell22latex(squeeze(V(:,:,ii,1 ))) ' ' ];
    for jj = 2:nc, tex = [ tex '& ' cell22latex(squeeze(V(:,:,ii,jj))) ' ' ];
    end
    tex = [ tex '\\ \hline' endline ];
  end
  tex = [ tex '\end{tabular}' ];

end

%------------------------------------------------------------------------------%
function tex = struct2latex( V )

  names = fieldnames( V );

  tex = ['\begin{description}' endline ];
  for ii = 1:length(names)

    val = getfield(V,names{ii});

    if( isstruct(val) ), sep = '\hspace{1pt}';
    else,                sep = ' ';
    end

    tex = [ tex '\item[' fancyfieldname(names{ii}) ':]' sep var2latex(val) endline ];

  end
  tex = [ tex '\end{description}' ];

end

%------------------------------------------------------------------------------%
function tex = fancyfieldname( str )

  if( length(str) == 1 )
    tex = ['$' str '$'];
    return
  end

  switch( str )
    case 'alpha';      tex = '$\alpha$';
    case 'theta';      tex = '$\theta$';
    case 'tau';        tex = '$\tau$';
    case 'beta';       tex = '$\beta$';
    case 'vartheta';   tex = '$\vartheta$';
    case 'pi';         tex = '$\pi$';
    case 'upsilon';    tex = '$\upsilon$';
    case 'gamma';      tex = '$\gamma$';
    case 'iota';       tex = '$\iota$';
    case 'varphi';     tex = '$\varphi$';
    case 'phi';        tex = '$\phi$';
    case 'delta';      tex = '$\delta$';
    case 'kappa';      tex = '$\kappa$';
    case 'rho';        tex = '$\rho$';
    case 'varphi';     tex = '$\varphi$';
    case 'epsilon';    tex = '$\epsilon$';
    case 'lambda';     tex = '$\lambda$';
    case 'varrho';     tex = '$\varrho$';
    case 'chi';        tex = '$\chi$';
    case 'varepsilon'; tex = '$\varepsilon$';
    case 'mu';         tex = '$\mu$';
    case 'sigma';      tex = '$\sigma$';
    case 'psi';        tex = '$\psi$';
    case 'zeta';       tex = '$\zeta$';
    case 'nu';         tex = '$\nu$';
    case 'varsigma';   tex = '$\varsigma$';
    case 'omega';      tex = '$\omega$';
    case 'eta';        tex = '$\eta$';
    case 'xi';         tex = '$\xi$';
    case '\Gamma';     tex = '$\Gamma$';
    case '\Lambda';    tex = '$\Lambda$';
    case '\Sigma';     tex = '$\Sigma$';
    case '\Psi';       tex = '$\Psi$';
    case '\Delta';     tex = '$\Delta$';
    case '\Xi';        tex = '$\Xi$';
    case '\Upsilon';   tex = '$\Upsilon$';
    case '\Omega';     tex = '$\Omega$';
    case '\Theta';     tex = '$\Theta$';
    case '\Pi';        tex = '$\Pi$';
    case '\Phi';       tex = '$\Phi$';
    otherwise; tex = str;
  end

end

%------------------------------------------------------------------------------%
function tex = numeric2latex( V )

  if( isscalar( V ) ), tex = num2str( V );
  else
    switch( ndims(V) )
      case 2; tex = array22latex( V );
      case 3; tex = array32latex( V );
      case 4; tex = array42latex( V );
      otherwise; tex = 'Array with more than 4 dimensions are not implemented yet';
    end
  end

end

%------------------------------------------------------------------------------%
function tex = array22latex( V )

  [ nl nc ] = size( V );
  
  tex = [ '\begin{tabular}{|' repmat('c|',1,nc) '} \hline' endline ];
  for   ii = 1:nl, tex = [ tex ' '  num2str(V(ii,1 )) ' ' ];
    for jj = 2:nc, tex = [ tex '& ' num2str(V(ii,jj)) ' ' ];
    end
    tex = [ tex '\\ \hline' endline ];
  end
  tex = [ tex '\end{tabular}' ];

end

%------------------------------------------------------------------------------%
function tex = array32latex( V )

  nn = size( V, 3 );
  
  tex = [ '\begin{tabular}{|c|} \hline' endline ];
  for ii = 1:nn
    tex = [ tex array22latex(squeeze(V(:,:,ii))) '\\ \hline' endline ];
  end
  tex = [ tex '\end{tabular}' ];

end

%------------------------------------------------------------------------------%
function tex = array42latex( V )

  nl = size( V, 3 );
  nc = size( V, 4 );
  
  tex = [ '\begin{tabular}{|' repmat('c|',1,nc) '} \hline' endline ];
  for   ii = 1:nl, tex = [ tex ' '  array22latex(squeeze(V(:,:,ii,1 ))) ' ' ];
    for jj = 2:nc, tex = [ tex '& ' array22latex(squeeze(V(:,:,ii,jj))) ' ' ];
    end
    tex = [ tex '\\ \hline' endline ];
  end
  tex = [ tex '\end{tabular}' ];

end

%------------------------------------------------------------------------------%
function tex = function2latex( V )

  f   = functions( V ); 
  tex = str2latex( f.function) ;

end

%------------------------------------------------------------------------------%
