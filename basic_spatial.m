if exist('eva') 
	if ~strcmp( eva.name, 'spatial' )
		clear global eva
	end
end

if ~exist('eva')
	global eva
	global passthrough
	load +robot/+spatial/out_eva.mat
end

eva.dump = 0;
eva.movie=1; % counter

eva.support = [ ];
eva.underactuation = 6; % x y z angle1 angle2 angle3
eva.supportaxis = [ 3  ];
eva.impactaxis = [ 3 ];

t0 = 0;
tmax = 10.0;
results_counter = 1;
results = [];
opts = odeset( 'events', @dyn_v06_ev, 'outputfcn', @dyn_show );

figure(5)
close(5)
figure(5)
global plotter1
plotter1 = draw.miniwindow()
%  plotter1 = draw.window( 5, [] );

%  x0 = [ 0;6; -0.5+rand(eva.n-2,1); 0;-1; zeros(eva.n-2,1)    ; 0;6; -0.5+rand(eva.n-2,1)];
x0 = [ 0;0;6; 0;0;0; rand(eva.n-6,1) ; 0;0;0; 0.3;0;0; zeros(eva.n-6,1) ; zeros(eva.n,1) ];


while t0<0.95*tmax
	fprintf('sim start: t0=%f\n',t0);
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