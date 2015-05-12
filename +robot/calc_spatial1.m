function test( )

% tx = struct( 'desc', 'joint', 'u0', [], 'w', [], 'v', [], 'p0', [], 'parent', [], 'u', [], 'p', [], 'A', [] )
global eva
eva = [];
eva.name = 'spatial';

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

ty.u = [0;0;0];
ty.w = [0;0;0];
ty.p0 = [0;0;0];
ty.v = [0;1;0];
ty.m = 0;
ty.J = zeros(3);


tz.u = [0;0;0];
tz.w = [0;0;0];
tz.p0 = [0;0;0];
tz.v = [0;0;1];
%  tz.m = 0;
%  tz.J = zeros(3);
tz.m = 0;
tz.J = zeros(3);

bodyx.u = [0;0;0];
bodyx.w = [1;0;0];
bodyx.p0 = [0;0;0];
bodyx.v = [0;0;0];
bodyx.m = 0;
bodyx.J = zeros(3);

bodyz.u = [0;0;0];
bodyz.w = [0;0;1];
bodyz.p0 = [0;0;0];
bodyz.v = [0;0;0];
bodyz.m = 0;
bodyz.J = zeros(3);

body.u = [0;0;0];
body.w = [0;1;0];
body.p0 = [0;0;-1];
body.v = [0;0;0];
body.m = 1;
body.J = eye(3);

femur1.u = [0;0;-1];
femur1.w = [0;1;0];
femur1.p0 = [0;0.1;-2];
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
femur2.p0 = [0;-0.1;-2];
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
link(2) = ty;
link(3) = tz;
link(4) = bodyx;
link(5) = bodyz;
link(6) = body;
link(7) = femur1;
link(8) = tibia1;
link(9) = femur2;
link(10) = tibia2;

link(1).parent = 0;
link(2).parent = 1;
link(3).parent = 2;
link(4).parent = 3;
link(5).parent = 4;
link(6).parent = 5; % body
link(7).parent = 6;
link(8).parent = 7;
link(9).parent = 6;
link(10).parent = 9;


link(1).children = 1:10;
link(2).children = 2:10;
link(3).children = 3:10;
link(4).children = 4:10;
link(5).children = 5:10;
link(6).children = 6:10; % body
link(7).children = 7:8;
link(8).children = 8:8;
link(9).children = 9:10;
link(10).children = 10:10;

link(1).ancestors = 1;
link(2).ancestors = 1:2;
link(3).ancestors = 1:3;
link(4).ancestors = 1:4;
link(5).ancestors = 1:5;
link(6).ancestors = 1:6;
link(7).ancestors = 1:7;
link(8).ancestors = 1:8;
link(9).ancestors = [ 1:6 9 ];
link(10).ancestors = [ 1:6 9 10];

eva.limb(1).points = [ 1 2 3 4 5 6 7 8 ];
eva.limb(2).points = [ 1 2 3 4 5 6 9 10 ];

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


eva.chains(1).chain = [5 6 7 8];
eva.chains(2).chain = [6 9 10];
eva.scale = 3;

% ---

motion.kinematics
motion.dynamicsselig

save( [ '+robot/+' eva.name '/out_eva'],'eva');
