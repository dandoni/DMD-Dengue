
function tex = latex_add_section( tex, sec_title )

  section = [ '\section{' sec_title '}' endline(2) '\end{document}' ];
  
  tex.latex = strrep( tex.latex, '\end{document}', section );

end
