
function tex = latex_add_content( tex, A, B )

  if    ( nargin <  2 ); error( 'missing parameters!' )
  elseif( nargin == 2 ); ctitle = ''; content = A; hastitle = false;
  else;                  ctitle =  A; content = B; hastitle = true;
  end

  if( ~ischar( content ) ), content = var2latex( content ); end

  switch( tex.class )
    
    case 'beamer'
      if( hastitle ), new_content = [ '\begin{frame}[c]{' ctitle '}' endline content endline '\end{frame}' ];
      else,           new_content = [ '\begin{frame}[c]'             endline content endline '\end{frame}' ];
      end
    
    case 'article'
      if( hastitle ), new_content = [ '\textbf{' ctitle '} ' content ];
      else,           new_content = content;
      end

    otherwise
      error(['invalid LaTeX class: ' tex.class '!'])

  end

  tex.latex = strrep( tex.latex, '\end{document}', [ new_content endline(2) '\end{document}' ] );

end
