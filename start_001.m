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

eva.poincare = 0;

pos = tools.generate_double_support( 0.2, 0.6, 0.99 );
dq = tools.generate_velocities( pos, [3 4 5 7], [  [0.1;0] ; [0.1;0] ; [0;0.1]; [0;0]  ]*20 );
x0 = [pos; dq];

eva.control = 'holdr';
%  eva.controlsys.s_multiply = 6.5;
%  eva.controlsys.s_add = 0.2;
eva.controlsys.ep = 1;
eva.controlsys.yr = pos( [6 7 4 5] );
eva.controlsys.tmax = 1; % maximum time for a single step phase
eva.controlsys.supportchange_tmax = 1; % maximum time between changing support points
eva.controlsys.supportchange_tlast = 0; % last time the support point was changed
% in order to omit Zeno behaviour also check the minimum time

eva.lastimpact.t = [];
eva.lastimpact.supportCHECK = [];

%  eva.controlsys.stop = 0;
%  eva.controlsys.tcontrol = 0;
%  eva.controlsys.controlnumber = 0;

t1 = 0;
x1 = [pos;dq]
eva.support = 7;


% results:
step = [];

while 1
	step(end+1).x0 = x1;
	step(end).t0 = t1;
	step(end).support = eva.support;
	step(end).supportcheck = eva.lastimpact.supportCHECK;
	
	if eva.support == 7
		eva.controlsys.yr = pos( [ 6 7 4 5 ] );
	else
		eva.controlsys.yr = pos( [ 4 5 6 7 ] );
	end
	
	eva.controlsys.ep = 0.7;
	eva.controlsys.tmax = 0.5;
	[t1, x1] = single_step_v08( t1, x1, eva.support );

	% diving?
	if sum(sum(robot.p( 1:7, x1 ) < -0.05))
		fprintf('diving!\n');
		break
	end
end