
function run_frequency_exploration 

run '../startup'
close all

  % Presentation information
  latexdir = 'latex_frequency_exploration';
  filename = 'frequency_exploration.tex'; 
  ptitle   = 'Frequency Exploration'; 
  author   = 'Luis D''Afonseca';

  % Creating the latex directory
  tex = latex_create( latexdir, filename, ptitle, author, 'beamer', 'en' );

  tex = latex_add_preamble( tex, { '\DeclareMathOperator{\real}{real}' 
                                   '\DeclareMathOperator{\imag}{imag}' } );

  %----------------------------------------------------------------------------%

  tex = latex_add_section( tex, 'Introduction' );

  %----------------------------------------------------------------------------%

  stitle  = 'Frequency $\times$ Angular Frequency';
  content = { '\[ \omega = \frac{2\pi}{T} = 2\pi f \]'
              'where'
              '\begin{description}'
              '\item[$\omega$] is the angular frequency (radians per second)'
              '\item[$T$]      is the period (seconds)'
              '\item[$f$]      is the ordinary frequency (hertz)'
              '\end{description}' };

  tex = latex_add_content( tex, stitle, content );

  %----------------------------------------------------------------------------%

  stitle  = 'Sinusoids';
  content = { 'Sine and Cosine formula'
              '\[ x(t) = a\cos(\, 2\pi f t \,) + b \sin(\, 2\pi f t \,) \]'
              'Amplitude, $A$, and Phase, $\varphi$, formula'
              '\[ x(t) = A\cos(\, 2\pi f t - \varphi \,) \]'
              '\[ A = \sqrt{a^2 + b^2\,} \qquad \varphi = \arctan\left(\frac{\,b\,}{a}\right) \]'
              '\[ a = A \cos(\varphi) \qquad b = A \sin(\varphi) \]' };

  tex = latex_add_content( tex, stitle, content );

  %----------------------------------------------------------------------------%

  stitle  = 'Euler Formula';
  content = { 'Euler Formula'
              '\[ e^{i \, \omega t} = \cos(\omega t) + i\sin(\omega t) \]'
              'or'
              '\[ e^{i \, 2\pi f t} = \cos(2\pi f t) + i\sin(2\pi f t) \]' };

  tex = latex_add_content( tex, stitle, content );

  %----------------------------------------------------------------------------%

  tex = latex_add_section( tex, 'Complex Recurrence Relation' );

  %----------------------------------------------------------------------------%

  stitle  = 'Recurrence Relation';
  content = { 'Complex Recurrence Relation'
              '\[x(k) = \lambda^k\]'
              'where'
              '\begin{description}'
              '\item[$\lambda = a + ib$] is a complex number'
              '\item[$k$]       is an integer number'
              '\end{description}' };

  tex = latex_add_content( tex, stitle, content );

  %----------------------------------------------------------------------------%

  n = 20;

  ii = 1;

  lambda = [ 0.8 1.0 1.2 ];
  plot_recurrence( lambda, n )
  tex = latex_add_fig( tex, 'Complex Recurrence', sprintf('fig_complex_recurrence_%02d', ii ) );
  ii = ii + 1;

  lambda = [ 0.8 1.0 1.2 ] + 0.1i;
  plot_recurrence( lambda, n )
  tex = latex_add_fig( tex, 'Complex Recurrence', sprintf('fig_complex_recurrence_%02d', ii ) );
  ii = ii + 1;

  lambda = [ 0.8 1.0 1.2 ] + 0.2i;
  plot_recurrence( lambda, n )
  tex = latex_add_fig( tex, 'Complex Recurrence', sprintf('fig_complex_recurrence_%02d', ii ) );
  ii = ii + 1;

  lambda = [ 0.8 1.0 1.2 ] + 0.3i;
  plot_recurrence( lambda, n )
  tex = latex_add_fig( tex, 'Complex Recurrence', sprintf('fig_complex_recurrence_%02d', ii ) );
  ii = ii + 1;

  lambda = 0.8 + [ 0.1i 0.2i 0.3i ];
  plot_recurrence( lambda, n )
  tex = latex_add_fig( tex, 'Complex Recurrence', sprintf('fig_complex_recurrence_%02d', ii ) );
  ii = ii + 1;

  lambda = 1.0 + [ 0.1i 0.2i 0.3i ];
  plot_recurrence( lambda, n )
  tex = latex_add_fig( tex, 'Complex Recurrence', sprintf('fig_complex_recurrence_%02d', ii ) );
  ii = ii + 1;

  lambda = 1.2 + [ 0.1i 0.2i 0.3i ];
  plot_recurrence( lambda, n )
  tex = latex_add_fig( tex, 'Complex Recurrence', sprintf('fig_complex_recurrence_%02d', ii ) );
  ii = ii + 1;

  %----------------------------------------------------------------------------%

  tex = latex_add_section( tex, 'Real Part of a Recurrence Relation' );

  %----------------------------------------------------------------------------%

  stitle  = 'Real Part of a Complex Recurrence Relation';
  content = { 'Recurrence Relation on time'
              '\[x(t_k) = \real\left(\lambda^k\right)\]'
              '\[t_k = k\,dt \]' };

  tex = latex_add_content( tex, stitle, content );

  %----------------------------------------------------------------------------%

  ii = 1;

  lambda_abs  = 0.98;
  lambda_imag = [ 0.1 0.2 0.3 ];
  lambda_real = sqrt( lambda_abs.^2 - lambda_imag.^2 );
  lambda = lambda_real + lambda_imag * i;

  plot_recurrence_real( lambda )
  tex = latex_add_fig( tex, 'Real Part of Complex Recurrence', sprintf('fig_real_complex_recurrence_%02d', ii ) );
  ii = ii + 1;

  lambda_abs  = 1.0;
  lambda_imag = [ 0.1 0.2 0.3 ];
  lambda_real = sqrt( lambda_abs.^2 - lambda_imag.^2 );
  lambda = lambda_real + lambda_imag * i;

  plot_recurrence_real( lambda )
  tex = latex_add_fig( tex, 'Real Part of Complex Recurrence', sprintf('fig_real_complex_recurrence_%02d', ii ) );
  ii = ii + 1;

  lambda_abs  = 1.02;
  lambda_imag = [ 0.1 0.2 0.3 ];
  lambda_real = sqrt( lambda_abs.^2 - lambda_imag.^2 );
  lambda = lambda_real + lambda_imag * i;

  plot_recurrence_real( lambda )
  tex = latex_add_fig( tex, 'Real Part of Complex Recurrence', sprintf('fig_real_complex_recurrence_%02d', ii ) );
  ii = ii + 1;

  %----------------------------------------------------------------------------%

  close all; 
  latex_compile( tex );

end

%------------------------------------------------------------------------------%
function plot_recurrence( lambda, n )

  m = length( lambda );
  K = repmat( (1:n)', 1, m );
  L = repmat( lambda, n, 1 );

  x = L.^K;

  clf;
  hold on
  plot_unit_circle();
  hp = plot( real(x), imag(x), '.-', 'linewidth', 1, 'markersize', 10 );
  hold off

  xlabel('$\real\left(\lambda^k\right)$')
  ylabel('$\imag\left(\lambda^k\right)$')

  grid on
  box on
  axis( 2 * [ -1 1 -1 1 ])
  axis equal

  hl = legend( hp, { [ '$\lambda = ' num2str(lambda(1),'%.3f') '$' ]
                     [ '$\lambda = ' num2str(lambda(2),'%.3f') '$' ]
                     [ '$\lambda = ' num2str(lambda(3),'%.3f') '$' ] } );
  set( hl, 'units', 'normalized',
           'position', [ 0.7 0.4 0.25 0.3] );

end

%------------------------------------------------------------------------------%
function plot_unit_circle()

  t = linspace( 0, 2*pi, 100 );

  x = cos( t );
  y = sin( t );

  plot( x, y, 'k-', 'linewidth', 0.5 )

end

%------------------------------------------------------------------------------%
function plot_recurrence_real( lambda )

  dt = 0.25;
  t = 0:dt:10;
  n = length(t);

  m = length( lambda );
  K = repmat( (1:n)', 1, m );
  L = repmat( lambda, n, 1 );

  x = L.^K;

  hp = plot( t, real(x), '.-', 'linewidth', 1, 'markersize', 10 );
  xlabel('Time')

  grid on
  axis( [ 0 10 -2 2 ])
  axis equal

  hl = legend( hp, { [ '$\lambda = ' num2str(lambda(1),'%.3f') '$' ]
                     [ '$\lambda = ' num2str(lambda(2),'%.3f') '$' ]
                     [ '$\lambda = ' num2str(lambda(3),'%.3f') '$' ] },
	       'orientation', 'horizontal' );
  set( hl, 'units', 'normalized',
           'position', [ 0.15 0.75 0.73 0.08 ]);

end

%------------------------------------------------------------------------------%

