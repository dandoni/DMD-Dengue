
function tex = latex_add_fig_tex( tex, fig_title, fig_name )

% Save figure as tex file and add it to LaTeX file
%
% Usage: tex = latex_add_fig_tex( tex, fig_title, fig_name )
%

  % Setting figure properties
  %----------------------------------------------------------------------------%

  h = gcf; 
  
  set( h, 'papertype',     '<custom>'            )
  set( h, 'paperunits',    'centimeters'         )
  set( h, 'papersize',     tex.papersize         )
  set( h, 'paperposition', [ 0 0 tex.papersize ] )

  % Print figure
  %----------------------------------------------------------------------------%

  fig_file = [ fig_name '.tex' ];

  try

    old_dir = cd( tex.figsdir );
    print( fig_file, tex.device ); 
    cd( old_dir );

  catch

    cd( old_dir );
    error(['failed to print figure: ' fig_file '!'])

  end

  % Add to LaTeX
  %----------------------------------------------------------------------------%

  new_content = [ '\AddTeXFigure{' fig_title '}{' fig_name '}' endline(2) ];

  tex.latex = strrep( tex.latex, '\end{document}', [ new_content '\end{document}' ] );

end
%------------------------------------------------------------------------------%
