 tex = latex_create( 'teste', 'teste.tex', 'teste', 'daniel', 'beamer', 'en' );
  tex = latex_add_section( tex, 'Teste' );
  content = ['Testando o latex_compile'];
  
  tex = latex_add_content(tex, 'Teste', content);
  
  latex_compile_test(tex);