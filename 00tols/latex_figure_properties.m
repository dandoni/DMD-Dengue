
function tex = latex_figure_properties( tex, varargin )

% Set properties for print ingfigures
%
% Usage: 
%   tex = latex_figure_properties( tex, property1, value1, property2, value2, ... )
% 
% tex - LaTeX structure defined created by latex_create
%
% properties:
% 'type'   - Figure type: 'png', 'jpg', or 'tex' (default 'tex')
%            Setting the figure type resets papersize to default
%
% 'size'   - Two elements vector [ width  heigth ] with figure paper size in centimeters
%
% 'device' - Device option to print command for 'tex' figures (default '-dtex')
%            This opition is used only for tex figures
%
% If a property is passed more than once, the last entry overwrites the previous
%

% Checking and initialization
%------------------------------------------------------------------------------%

  % Consistency check
  if( ~isfield( tex, 'class' ) )
    error('parameter tex must be a struct created by function latex_create!')
  end

  if( ~ismember( tex.class, { 'beamer' 'article' } ) )
    error(['invalid LaTeX class: ' tex.class '!'])
  end
  
  % If tex dont have figure fields add them
  if( ~isfield( tex, 'figtype' ) )
    tex.figtype   = 'tex';
    tex.device    = '-dtex';
    tex.papersize = default_papersize( tex );
  end

% Parsing properties
%------------------------------------------------------------------------------%

  [ reg prop ] = parseparams( varargin );

  if( ~isempty( reg ) )
    error('wrong property parameters!')
  end

  if( ~isempty( prop ) )

    N = length( prop );

    for ii = 1:2:N

      P = prop{ii};
      V = prop{ii+1};

      switch( P )

        case 'type'
      
          if( ~ischar(V) )
            error('figure type must be a string!')
          elseif( ~ismember( V, { 'png' 'jpg' 'tex' } ) )
            error(['invalid figure type: ' V '!'])
          end
      
          tex.figtype   = V;
          tex.papersize = default_papersize( tex );
        
        case 'device'
      
          if( ~ischar(V) )
            error('device must be a string!')
          end
      
          tex.device = V;
        
        case 'size'
      
          if( ~isnumeric( V ) || length(V) ~= 2 )
            error('size must be a numeric verctor of length 2!')
          end
      
          tex.papersize = V;
      
        otherwise
          error(['invalid property: ' P '!'])
      end

    end

  end

end

%------------------------------------------------------------------------------%
function papersize = default_papersize( tex )

  switch( tex.class )

    case 'beamer'
      switch( tex.figtype )
        case 'tex'; papersize = [ 15.5 7 ]; 
        case 'png'; papersize = [ 15.5 7 ]; 
        otherwise; error(['invalid figure type: ' tex.figtype '!' ])
      end

    case 'article'
      switch( tex.figtype )
        case 'tex'; papersize = [ 14 7 ]; 
        case 'png'; papersize = [ 14 7 ]; 
        otherwise; error(['invalid figure type: ' tex.figtype '!' ])
      end

    otherwise; error(['invalid LaTeX class: ' class '!'])

  end

end

%------------------------------------------------------------------------------%
