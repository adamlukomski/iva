function test( q1, q2 )

% tx = struct( 'desc', 'joint', 'u0', [], 'w', [], 'v', [], 'p0', [], 'parent', [], 'u', [], 'p', [], 'A', [] )
global eva
eva = [];
eva.name = 'planar';

fprintf( 'directory ' );
if ~exist(['+robot/+' eva.name ],'dir')
	mkdir('+robot',['+' eva.name])
end

fprintf( 'desc ' );
tx.u = [0;0;0];
tx.w = [0;0;0];
tx.p0 = [0;0;0];
tx.v = [1;0;0];
tx.m = 0;
tx.J = zeros(3);

tz.u = [0;0;0];
tz.w = [0;0;0];
tz.p0 = [0;0;0];
tz.v = [0;0;1];
%  tz.m = 0;
%  tz.J = zeros(3);
tz.m = 1;
tz.J = zeros(3);

body.u = [0;0;0];
body.w = [0;1;0];
body.p0 = [0;0;-1];
body.v = [0;0;0];
body.m = 1;
body.J = eye(3);

femur1.u = [0;0;-1];
femur1.w = [0;1;0];
femur1.p0 = [0;0;-2];
femur1.v = [0;0;0];
femur1.m = 1;
femur1.J = eye(3);

tibia1.u = [0;0;-2];
tibia1.w = [0;1;0];
tibia1.p0 = [0;0;-3];
tibia1.v = [0;0;0];
tibia1.m = 1;
tibia1.J = eye(3);

femur2.u = [0;0;-1];
femur2.w = [0;1;0];
femur2.p0 = [0;0;-2];
femur2.v = [0;0;0];
femur2.m = 1;
femur2.J = eye(3);

tibia2.u = [0;0;-2];
tibia2.w = [0;1;0];
tibia2.p0 = [0;0;-3];
tibia2.v = [0;0;0];
tibia2.m = 1;
tibia2.J = eye(3);

link(1) = tx;
link(2) = tz;
link(3) = body;
link(4) = femur1;
link(5) = tibia1;
link(6) = femur2;
link(7) = tibia2;

link(1).parent = 0;
link(2).parent = 1;
link(3).parent = 2;
link(4).parent = 3;
link(5).parent = 4;
link(6).parent = 3;
link(7).parent = 6;

link(1).children = 1:7;
link(2).children = 2:7;
link(3).children = 3:7;
link(4).children = 4:5; % !
link(5).children = 5:5; % !
link(6).children = 6:7;
link(7).children = 7:7;

link(1).ancestors = 1;
link(2).ancestors = 1:2;
link(3).ancestors = 1:3;
link(4).ancestors = 1:4;
link(5).ancestors = 1:5;
link(6).ancestors = [ 1:3 6];
link(7).ancestors = [ 1:3 6 7];

eva.limb(1).points = [ 1 2 3 4 5  ];
eva.limb(2).points = [ 1 2 3 6 7 ];

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


eva.chains(1).chain = [2 3 4 5];
eva.chains(2).chain = [3 6 7];
eva.scale = 3;

% ---

motion.kinematics
motion.dynamicsselig

save( [ '+robot/+' eva.name '/out_eva'],'eva');
