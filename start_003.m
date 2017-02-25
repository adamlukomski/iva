if ~exist('eva')
	global eva
	global passthrough
	global plotter1
	load +robot/+planar/out_eva.mat
end

eva.support = [ ];
eva.underactuation = 3; % x y angle
eva.supportaxis = [ 1 3 ];
eva.impactaxis = [1 3];


eva.anim = 1;
eva.dump = 0; % dump all screens and movies to figs/ and movie/
eva.poincare = 0;

pos = tools.generate_double_support( 0.3, 0.6, 0.99 )
dq = tools.generate_velocities( pos, [3 4 5 7], [  [0.1;0] ; [0.1;0] ; [0;0.1]; [0;0]  ]*20 )
x0 = [pos; dq];

eva.control = 'holdr';
eva.controlsys.ep = 1;
eva.controlsys.yr = pos( [6 7 4 5] );
eva.controlsys.tmax = 1; % maximum time for a single step phase
eva.controlsys.supportchange_tmax = 1; % maximum time between changing support points
eva.controlsys.supportchange_tlast = 0; % last time the support point was changed

t1 = 0;
x1 = [pos;dq]
eva.support = 7;

step = [];
poincare = [];

eva.lastimpact.t = 0;
eva.lastimpact.supportCHECK = 7;

pos_mid = tools.generate_double_support( 0.1, 0.9, 0.99 );

figure, plot( 0,0, 'Tag', 'poincare' )

for substep=1:50
	step(end+1).x0 = x1;
	step(end).t0 = t1;
	step(end).support = eva.support;
	step(end).supportcheck = eva.lastimpact.supportCHECK;
	
	eva.controlsys.ep = 0.7;
	eva.controlsys.tmax = 0.5;

	if eva.support == 7
		eva.controlsys.yr = pos( [ 6 7 4 5 ] );
		if t1-eva.lastimpact.t < 0.05
			eva.controlsys.yr = [1.5*pos_mid(6); 3*pos_mid(7); pos_mid(6:7)];
			eva.controlsys.tmax = 0.05;
		end
		
	else
		eva.controlsys.yr = pos( [ 4 5 6 7 ] );
		if t1-eva.lastimpact.t < 0.05
			eva.controlsys.yr = [pos_mid(6:7); 1.5*pos_mid(6); 3*pos_mid(7)];
			eva.controlsys.tmax = 0.05;
		end
	end

	[t1, x1, t, x] = single_step_v08( t1, x1, eva.support );

	step(end).t = t;
	step(end).x = x;
	
	% dive check
	if sum(sum(robot.p( 1:7, x1 ) < -0.05))
		fprintf('diving!\n');
		break
	end
	
  	if eva.lastimpact.t == t1
  		poincare(end+1).x1 = x1;
  		poincare(end).t1 = t1;
  		poincare(end).steplength = norm( robot.p(5, x1) - robot.p(7, x1) );
  		
  		
  		if length(poincare)>1
  			poincare(end).sectiondistance = norm( poincare(end).x1( [3 4 5 6 7, 10 11 12 13 14] ) - poincare(end-1).x1( [3 6 7 4 5, 10 13 14 11 12] ) );
  			set( findobj('tag','poincare'), 'XData', 1:length(poincare)-1, 'YData', [poincare.sectiondistance] )
  		end
  	end
end
