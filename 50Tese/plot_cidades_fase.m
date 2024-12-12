%------------------------------------------------------------------------------%
function plot_cidades

run '../../../startup'

load 'dengue.hdf5'

ano1 = 152;

modo = modes(:,ano1);
lambda = lambdas(ano1);
b_certo = b(:,ano1);
coef = coef(:,ano1);
fase = arg(coef);
fase = fase .+ pi;
fase = fase ./(2*pi);
[fase_ord ij] = sort(fase);
ind_v = sort(ij);
X_dmdf = X_dmd(ij,:);
X_dmd1 = X_dmdf(1:3906,:); X_dmd2 =  X_dmdf(3907:5402,:);X_dmd3 =  X_dmdf(5403:5501,:);X_dmd4 =  X_dmdf(5502:end,:);


%------------------------------------------------------------------------------%

  % Presentation information
  latexdir = 'cidades fase';
  filename = 'cidades.tex'; 
  ptitle   = 'cidades'; 
  author   = 'Daniel Moraes Barbosa e Luis D''Afonseca';
  
  % Creating the latex directory
  tex = latex_create( latexdir, filename, ptitle, author, 'article', 'pt' );
  
  tex = latex_add_preamble( tex, { '\usepackage{blindtext}'
                                   '\geometry{a4paper,margin=25mm}' } );
  
  figure_position(1,1,2,2);
  clf
  
  tex = latex_figure_properties( tex, 
                                 'type',   'tex', 
                                 'device', '-dpdflatex', 
                                 'size',   [15 9] );
  
  tex = latex_add_content( tex, '\clearpage\blindtext' );
  
  %----------------------------------------------------------------------------%

  plot_cid( 1, X_dmd1 ); 
  plot_cid( 2, X_dmd2 ); 
  plot_cid( 3, X_dmd3 ); 
  plot_cid( 4, X_dmd4 ); 

  tex = latex_add_fig( tex, 'Evolução da Dengue em algumas cidades em milhares de casos.', 
                            'dengue_fase_faixa' );
  
  %----------------------------------------------------------------------------%
  
  tex = latex_add_content( tex, '\blindtext' );
  
  latex_compile(tex,'batchmode');

end

%------------------------------------------------------------------------------%
function plot_cid( N, Y )

  xo = 0.05;
  ww = 0.92;
  yo = 0.10;
  hh = 0.215; % 0.15251;
  dh = 0.22;

  subplot( 'position', [ xo  yo+dh*(4-N)  ww  hh ] ); 

  imagesc(real(Y))

  xlim  ( [ 1 313 ] )
  xticks( [ 1     53    105    157    209    261    313  ] ) 
  caxis ( [ 0 50 ] )
  
   if( N == 1)
   caxis ([0,10])
   end
    
  if( N == 4 ), xticklabels( { '2014' '2015' '2016' '2017' '2018' '2019' '2020' } ) 
  else,         xticklabels( {} )
  end

  % ylabel( 'Milhares de casos' )

 
  name = { '  mai/jun/jul                '
           '  ago/set/out               '
           '  nov/dez/jan               '
           '  fev/mar/abr               ' };
##name = { '  mai-jul  '
##           '  ago-out  '
##           '  nov-jan  '
##           '  fev-abr  ' };


  h = text( 0.6, 0.2, name{5-N},  'units', 'normalized' );
  set( h, 'horizontalalignment', 'left',
          'edgecolor',           'k',
          'backgroundcolor',     'w',
         'fontsize',           5,
        'margin', 1      )
end

%------------------------------------------------------------------------------%
