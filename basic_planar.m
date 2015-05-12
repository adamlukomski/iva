if exist('eva') 
	if ~strcmp( eva.name, 'planar' )
		clear global eva
	end
end

if ~exist('eva')
	global eva
	global passthrough
	load +robot/+planar/out_eva.mat
end

eva.dump = 0;
eva.movie=1;
eva.support = [ ];
eva.underactuation = 3; % x y first angle
eva.supportaxis = [ 3 1 ];
eva.impactaxis = [ 3 1 ];

x0 = [ 0;6;-0.3; -0.5+rand(eva.n-3,1); 0;-1; zeros(eva.n-2,1)    ; 0;6;0; -0.5+rand(eva.n-3,1)];
t0 = 0;
tmax = 10.0;
opts = odeset( 'events', @dyn_v06_ev, 'outputfcn', @dyn_show );
results = [];
results_counter = 1;

global plotter1
%  plotter1 = draw.window( 5, [] );
figure(1);close(1);figure(1)
plotter1 = draw.miniwindow();

while t0<0.95*tmax
	fprintf('sim start: t0=%f\n',t0);
	[t,x,te,xe,ie] = ode113( @dyn_v06, t0:0.01:tmax, x0, opts );

	results(results_counter).x = x;
	results(results_counter).t = t;
	results(results_counter).support = eva.support;
	results(results_counter).u = eva.B0 * passthrough.uall;
	results(results_counter).tu = passthrough.tall;
	results(results_counter).support = eva.support;

	results(results_counter).te = te;
	results(results_counter).xe = xe;
	results(results_counter).ie = ie;
	
	
	t0 = t(end);
	x0 = x(end,:); % must be before impact
	ie = unique(ie);
	if ie
		modules.events
	end

	if t0<3
		x0(2*eva.n+1:3*eva.n) = x0(1:eva.n);
	end
	
	results_counter = results_counter + 1;
end

