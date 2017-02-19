function out = Ad(g)

switch size(g,1)
	case 6
		R = lie.hat( g(1:3) );
		T = lie.hat( g(4:6) );
	case 4
		R = g(1:3,1:3);
		T = lie.hat( g(1:3,4) );
	otherwise
		fprintf( ['Ad, size [' size(g) '] not supported\n' ]);
		R = [];
		T = [];
end

out = [ R, zeros(3) ; T*R, R ];