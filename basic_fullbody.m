if exist('eva') 
	if ~strcmp( eva.name, 'fullbody' )
		clear global eva
	end
end

if ~exist('eva')
	global eva
	global passthrough
	load +robot/+fullbody/out_eva.mat
end

eva.dump = 0;
eva.movie=1;

eva.support = [ ];
eva.underactuation = 3; % x y angle
eva.supportaxis = [ 3 ];
eva.impactaxis = [ 3 1 ];

t0 = 0;
tmax = 10.0;
results_counter = 1;
results = [];
opts = odeset( 'events', @dyn_v06_ev, 'outputfcn', @dyn_show );

global plotter1
plotter1 = draw.window( 5, [] );

x0 = [ 0;6; -0.5+rand(eva.n-2,1); 0;-1; zeros(eva.n-2,1)    ; 0;6; -0.5+rand(eva.n-2,1)];

while t0<0.95*tmax
	t0
	[t,x,te,xe,ie] = ode113( @dyn_v06, t0:0.01:tmax, x0, opts );

	results(results_counter).x = x;
	results(results_counter).t = t;
	results(results_counter).support = eva.support;
	results(results_counter).u = passthrough.uall;
	results(results_counter).tu = passthrough.tall;
	results(results_counter).support = eva.support;
	
	
	results_counter = results_counter + 1;
	
	t0 = t(end);
	x0 = x(end,:);
	ie = unique(ie);
	if ie
		modules.events
	end

	if t0<3
		x0(2*eva.n+1:3*eva.n) = x0(1:eva.n);
	end
end
