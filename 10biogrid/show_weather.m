
function show_weather

global param;

t = linspace( 0, param.Tf, 100 );

K = param.K * ( 1.0 + param.w * sin( 2 * pi * t ) );

plot( t, K, 'b', 'linewidth', 2 )

xlabel('Time in years')
ylabel('Suport')

ylim([ 0 ceil(param.K*(1.0+param.w)) ])

grid on


%------------------------------------------------------------------------------%
