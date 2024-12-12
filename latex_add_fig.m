
function tex = latex_add_fig( tex, fig_title, fig_name, varargin )

% Save figure to format defined on tex structure and add it to LaTeX file
%
% Usage: tex = latex_add_fig( tex, fig_title, fig_name, options );
%
%  tex       - tex structure created by latex_create
%  fig_title - Figure title os caption
%  fig_name  - Figure file name
%
% Options
%  'box' - draw a box (fbox) around figure 'on' or 'off' (default)
%
% See also: latex_figure_properties
%

  % Parsing parameters
  %----------------------------------------------------------------------------%

  [ reg, box ] = parseparams( varargin, 'box', 'off' );

  boxed = strcmp( box,         'on'  );
  istex = strcmp( tex.figtype, 'tex' );

  % Figure file name
  %----------------------------------------------------------------------------%

  switch( tex.figtype )
    case 'png', fig_file = [ tex.figsdir '/' fig_name '.png' ];
    case 'jpg', fig_file = [ tex.figsdir '/' fig_name '.jpg' ];
    case 'tex', fig_file = [ fig_name '.tex' ];
    otherwise
      error(['invalid figure type:' tex.figtype '!'])
  end

  % Setting figure properties
  %----------------------------------------------------------------------------%

  set( gcf, 'papertype',     '<custom>'            )
  set( gcf, 'paperunits',    'centimeters'         )
  set( gcf, 'papersize',     tex.papersize         )
  set( gcf, 'paperposition', [ 0 0 tex.papersize ] )

  % Printing the figure
  %----------------------------------------------------------------------------%

  try

    switch( tex.figtype )
      case 'png', print( fig_file, '-dpng', '-r900' )
      case 'jpg', print( fig_file, '-djpg', '-r900' )
      case 'tex'
        old_dir = cd( tex.figsdir );
        print( fig_file, tex.device ); 
        cd( old_dir );
    end

  catch

    if( istex ), cd( old_dir ); end

    error(['failed to print figure: ' fig_file '!'])

  end

  % Add to LaTeX
  %----------------------------------------------------------------------------%

  if( boxed ) 
    if( istex ), texcommand = '\AddBoxedTeXFigure';
    else,        texcommand = '\AddBoxedRasterFigure';
    end
  else
    if( istex ), texcommand = '\AddTeXFigure';
    else,        texcommand = '\AddRasterFigure';
    end
  end

  new_content = [ texcommand '{' fig_title '}{' fig_name '}' endline(2) ];

  tex.latex = strrep( tex.latex, '\end{document}', [ new_content '\end{document}' ] );

end
%------------------------------------------------------------------------------%
