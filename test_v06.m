if ~exist('eva')
	global eva
	global passthrough
	load +robot/+fullbody/out_eva.mat
end

opts = odeset( 'events', @dyn_v06_ev, 'outputfcn', @dyn_show );
t0 = 0;
results = [];
results_counter = 1;

eva.movie=1;
eva.dump = 0;
eva.support = [ ];
eva.underactuation = 3; % x y first angle
eva.supportaxis = [ 3 ]
eva.impactaxis = [ 3 ]

% throw the robot down with a high initial speed
x0 = [ 0;6; -0.5+rand(eva.n-2,1); 0;-1; zeros(eva.n-2,1)    ; 0;6; -0.5+rand(eva.n-2,1)];


global plotter1
plotter1 = draw.window( 5, [] );

tmax = 10.0;
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

	% overwrite r
	if t0<3
		x0(2*eva.n+1:3*eva.n) = x0(1:eva.n);
	end
end

disp('yeah, finished, wanna see fluent one? any key, mate')
pause
draw.anim

