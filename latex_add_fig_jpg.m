
function tex = latex_add_fig_jpg( tex, fig_title, fig_name )

% Save figure as jpg file and add it to LaTeX file
%
% Usage: tex = latex_add_fig_jpg( tex, fig_title, fig_name )
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

  fig_file = [ tex.figsdir '/' fig_name '.jpg' ];

  try


    print( fig_file, '-djpg', '-r900' )


  catch


    error(['failed to print figure: ' fig_file '!'])

  end

  % Add to LaTeX
  %----------------------------------------------------------------------------%

  new_content = [ '\AddRasterFigure{' fig_title '}{' fig_name '}' endline(2) ];

  tex.latex = strrep( tex.latex, '\end{document}', [ new_content '\end{document}' ] );

end
%------------------------------------------------------------------------------%
