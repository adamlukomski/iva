function count = sketch_portrait( detA, vars, limit, drawpoints, fignr, params )

if nargin < 3
	limit = pi;
end
if nargin < 4
	drawpoints = 40;
end
if nargin < 5
	fignr = 123;
end

drawedges = 1;

% automated script

%  disp('- calc det(A)...')
%  detA = det(A);

%  s_params;
%  s_params_unpack;

syms X Y Z real
disp('- substituting det(A)...')
detA = subs( detA, {vars(1);vars(2);vars(3)}, {X,Y,Z} );

disp('- correcting det(A)...')
charA = char(detA);
lengthA = length(charA);
i = 1;
while i < lengthA
	if(charA(i) == '*' || charA(i) == '^' || charA(i) == '/' )
		charA = [ charA(1:i-1) '.' charA(i:end) ];
		lengthA = lengthA + 1;
		i = i+1;
	end
	i = i+1;
end

disp('equation:');
charA

disp('- drawing...')
drawspace = linspace(-limit,limit,drawpoints);
[Y,X,Z] = ndgrid( drawspace, drawspace, drawspace );
V = eval( charA );

figure(fignr);
clf;

p = patch(isosurface(X,Y,Z,V,0));
isonormals(X,Y,Z,V,p);
set(p,'FaceColor','b','EdgeColor','k','FaceAlpha',0.5 );
if drawedges == 0
	set(p, 'EdgeColor','none' );
end

%  daspect([1 1 1])
%  axis square;
axis( [-limit limit -limit limit -limit limit ] )

grid on;
camlight
%view(-27,46);
view(-25,25);
lighting gouraud

xlabel(char(vars(1)));
ylabel(char(vars(2)));
zlabel(char(vars(3)));

drawnow;
count = length(get(p, 'Vertices') );
get(p, 'Vertices') 
