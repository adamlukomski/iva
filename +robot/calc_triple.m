function test()

% tx = struct( 'desc', 'joint', 'u0', [], 'w', [], 'v', [], 'p0', [], 'parent', [], 'u', [], 'p', [], 'A', [] )
global eva
eva = [];
eva.name = 'triple';

fprintf( 'directory ' );
if ~exist(['+robot/+' eva.name ],'dir')
	mkdir('+robot',['+' eva.name])
end

fprintf( 'desc ' );


body.u = [0;0;0];
body.w = [0;1;0];
body.p0 = [0;0;1];
body.v = [0;0;0];
body.m = 1;
body.J = 1/3*eye(3);

femur1.u = [0;0;1];
femur1.w = [0;1;0];
femur1.p0 = [0;0;2];
femur1.v = [0;0;0];
femur1.m = 1;
femur1.J = 1/3*eye(3);

tibia1.u = [0;0;2];
tibia1.w = [0;1;0];
tibia1.p0 = [0;0;3];
tibia1.v = [0;0;0];
tibia1.m = 1;
tibia1.J = 1/3*eye(3);


link(1) = body;
link(2) = femur1;
link(3) = tibia1;

n = length(link);

link(1).parent = 0;
link(2).parent = 1;
link(3).parent = 2;


link(1).children = 1:3;
link(2).children = 2:3;
link(3).children = 3:3;

link(1).ancestors = 1;
link(2).ancestors = 1:2;
link(3).ancestors = 1:3;

eva.limb(1).points = [ 1 2 3 ];

eva.link = link;
n = length(link);
eva.n = n;

fprintf( 'chains ');
for i=1:n
	if eva.link(i).parent == 0
		eva.link(i).chain = i;
	else
		eva.link(i).chain = [ eva.link( eva.link(i).parent ).chain i ];
	end
end

fprintf( 'sym ' );
n = length(link);
q = sym( 'q%d', [n 1] );
q = sym( q, 'real' );
dq = sym( 'dq%d', [n 1] );
dq = sym( dq, 'real' );

eva.q = q;
eva.dq = dq;


eva.chains(1).chain = [1 2 3];
eva.scale = 3;

% ---

motion.kinematics
motion.dynamicsselig

save( [ '+robot/+' eva.name '/out_eva'],'eva');
