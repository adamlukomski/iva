% the collection of most used options for simulations
%
% copy from here to launch scripts when needed
%

if ~exist('eva')
	global eva
	global passthrough
	load +robot/+fullbody/out_eva.mat
end

eva.support = [ ];
eva.underactuation = 3; % x y angle
eva.supportaxis = [ 3 ]
eva.impactaxis = [1 3]

if ~exist('x0initial')
% above the ground
	x0 = [1.6073    3.0312   -0.0622    0.3000    0.3000   -0.0000   -0.3000    0.3000   -0.0000    0.0378   -0.1622]';
	x0 = [x0; zeros(eva.n,1)]; % dq
	x0 = [x0; zeros(eva.n,1)]; % r
	x0initial = x0;
end

% every simulation:

eva.movie=1;
t0 = 0;
results = [];

eva.dump = 1; % dump all screens and movies to figs/ and movie/



%  x0 = [	0; 4.0000; -0.3810; -0.0016; 0.4597; -0.1596; 0.0853; ...
%  	0; 0; zeros(5,1) ];

%  x0 = [ 1;4; zeros(5,1); 0;0; zeros(5,1) ];
%  x0 = [ 0;4; -0.5+rand(5,1); 0;0; zeros(5,1) ];

%  x0initial =
%    Columns 1 through 11
%     -0.1523    2.8911    0.1869    0.0963    0.3242    0.0816   -0.5632    0.5840   -0.2311    0.1523   -0.0185
%    Columns 12 through 22
%     -1.4306    0.2022   -1.3247    1.2237    0.1223   -0.4099    1.1986    0.1143   -0.4291   -1.0428   -1.2209
%    Columns 23 through 33
%     -0.1523    2.8911    0.1869    0.0963    0.3242    0.0816   -0.5632    0.5840   -0.2311    0.1523   -0.0185



%  if ~exist('x0initial')
%  %  	x0 = [ 0;6; -0.5+rand(eva.n-2,1); 0;-8; zeros(eva.n-2,1)    ; 0;6; -0.5+rand(eva.n-2,1)];
%  %  	x0 = [ 3;2; 1.5; -0.5+rand(eva.n-5,1)/4; 1.5;1.5;               0;0; zeros(eva.n-2,1)    ; 0;0; -0.5+rand(eva.n-2,1)]; % flat fall
%  
%  %    	x0 = [ 3;3.5; 0.1; 0.3;0.3;0;-0.3;0.3;0;0.1;-0.1;              0;0; zeros(eva.n-2,1)    ; 0;0; -0.5+rand(eva.n-2,1)]; % small drop
%  	x0 = [1.6073    3.0312   -0.0622    0.3000    0.3000   -0.0000   -0.3000    0.3000   -0.0000    0.0378   -0.1622]';
%  	x0 = [x0; zeros(eva.n,1)]; % dq
%  	x0 = [x0; zeros(eva.n,1)]; % r
%  
%  
%  
%  	x0initial = x0;
%  else
%  	x0 = x0initial;
%  end