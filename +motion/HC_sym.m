function  HC_sym

%  c(1)     = struct( 'w', [0;1;0], 'p', [0;0;1], 'r', [0;0;0.5], 'v', [0;0;0], 'chain', [ 1 ] ); % ankle 1
%  c(end+1) = struct( 'w', [1;0;0], 'p', [0;0;1], 'r', [0;0;0.5], 'v', [0;0;0], 'chain', meshgrid(1:length(c)+1,1) ); % knee 1
%  c(end+1) = struct( 'w', [1;0;0], 'p', [0;0;1], 'r', [0;0;0.5], 'v', [0;0;0], 'chain', meshgrid(1:length(c)+1,1) ); % knee 1
%  c(end+1) = struct( 'w', [1;0;0], 'p', [0;0;1], 'r', [0;0;0.5], 'v', [0;0;0], 'chain', meshgrid(1:length(c)+1,1) ); % knee 1
%  c(end+1) = struct( 'w', [0;1;0], 'p', [0;0;1], 'r', [0;0;0.5], 'v', [0;0;0], 'chain', meshgrid(1:length(c)+1,1) ); % knee 1
%  c(end+1) = struct( 'w', [0;0;1], 'p', [1;0;0], 'r', [0.5;0;0], 'v', [0;0;0], 'chain', meshgrid(1:length(c)+1,1) ); % knee 1
%  c(end+1) = struct( 'w', [0;0;1], 'p', [0;0;-1], 'r', [0;0;-0.5], 'v', [0;0;0], 'chain', meshgrid(1:length(c)+1,1) ); % knee 1
%  c(end+1) = struct( 'w', [0;1;0], 'p', [0;0;-1], 'r', [0;0;-0.5], 'v', [0;0;0], 'chain', meshgrid(1:length(c)+1,1) ); % knee 1
%  c(end+1) = struct( 'w', [1;0;0], 'p', [0;0;-1], 'r', [0;0;-0.5], 'v', [0;0;0], 'chain', meshgrid(1:length(c)+1,1) ); % knee 1
%  c(end+1) = struct( 'w', [1;0;0], 'p', [0;0;-1], 'r', [0;0;-0.5], 'v', [0;0;0], 'chain', meshgrid(1:length(c)+1,1) ); % knee 1
%  c(end+1) = struct( 'w', [1;0;0], 'p', [0;0;-1], 'r', [0;0;-0.5], 'v', [0;0;0], 'chain', meshgrid(1:length(c)+1,1) ); % knee 1
%  c(end+1) = struct( 'w', [0;1;0], 'p', [0;0;-1], 'r', [0;0;-0.5], 'v', [0;0;0], 'chain', meshgrid(1:length(c)+1,1) ); % knee 1
%  
%  n = length(c);
%  for i=1:n
%  	c(i).parent = i-1;
%  	c(i).m = 1;
%  	c(i).I = diag([1,1,1]);
%  	m(i) = c(i).m;
%  end
%  
%  
%  for i=1:n
%  	c(i).M = [ c(i).I zeros(3) ; zeros(3) m(i)*eye(3) ];
%  	c(i).M = inv(a_adj( [eye(3) c(i).r ; 0 0 0 1] ))' * c(i).M * inv(a_adj([eye(3) c(i).r ; 0 0 0 1] ));
%  end

global eva
n = eva.n;
a_grav = sym([ 0 ; 0 ; 0 ; 0 ; 0 ; 9.81 ]);

[q,dq] = robot.q;

for i=1:n
	S{i} = [-eva.link(i).w ; eva.link(i).v];
%    	S{i} = eva.link(i).s;
	aXJ = simplify(expm( lie.hat( S{i} )*q(i) ));
	XJ = [ aXJ(1:3,1:3) zeros(3) ; lie.hat(aXJ(1:3,4)) aXJ(1:3,1:3) ];
	vJ = S{i}*dq(i);
	
	
%  	[ XJi, Si ] = jcalc( model3.jtype{i}, q(i) );
%  	[ XJ, S{i} ] - [XJi, Si]
	
	if eva.link(i).parent > 1
%  		try 
			Xtree{i} = sym(lie.Ad( [ eye(3) -eva.link(eva.link(eva.link(i).parent).parent).p0+eva.link(eva.link(i).parent).p0; 0 0 0 1 ] )); % yes, the result is negative, -length
%  			Xtree{i} = lie.Adinv( [ eye(3) eva.link(eva.link(eva.link(i).parent).parent).p0-eva.link(eva.link(i).parent).p0; 0 0 0 1 ] ); % yes, the result is negative, -length
%  			Xtree{i} = lie.Ad( [ eye(3) eva.link(eva.link(i).parent).p0-eva.link(i).p0; 0 0 0 1 ] ); % yes, the result is negative, -length
%  		catch err
%  			Xtree{i} = lie.Ad( [ eye(3) eva.link(i-1).p0-eva.link(i).p0; 0 0 0 1 ] ); % yes, the result is negative, -length
%  		end
	else
		Xtree{i} = sym(lie.Ad( eye(4) ));
%  		Xtree{i} = lie.Ad( [ eye(3) -eva.link(i).p0+eva.link(i).c ; 0 0 0 1 ] );
	end

	Xup{i} = XJ * Xtree{i};

	if eva.link(i).parent == 0
		v{i} = vJ;
		avp{i} = Xup{i} * -a_grav;
	else
		v{i} = Xup{i}*v{eva.link(i).parent} + vJ;
		avp{i} = Xup{i}*avp{eva.link(i).parent} + feather_crm(v{i})*vJ;
%  		avp{i} = Xup{i}*avp{eva.link(i).parent} + lie.ad(v{i})*vJ;
	end
	fvp{i} = eva.link(i).Nnormal * avp{i} + feather_crf(v{i})*eva.link(i).Nnormal*v{i};
%  	fvp{i} = eva.link(i).Nnormal * avp{i} + -lie.ad(v{i})'*eva.link(i).Nnormal*v{i};
%  	pause

end

for i=n:-1:1
	C(i,1) = S{i}' * fvp{i};
	if eva.link(i).parent ~= 0
		fvp{eva.link(i).parent} = fvp{eva.link(i).parent} + Xup{i}' * fvp{i};
	end
end

for i=1:n
	IC{i} = sym(eva.link(i).Nnormal);
%  	IC{i} = [eva.link(i).J, eva.link(i).m*lie.hat(eva.link(i).c); eva.link(i).m*lie.hat(eva.link(i).c)', eye(3)*eva.link(i).m ];
end

for i=n:-1:1
	if eva.link(i).parent ~= 0
		IC{eva.link(i).parent} = IC{eva.link(i).parent} + Xup{i}' * IC{i} * Xup{i};
	end
end

H = sym(zeros(n));
%  H = zeros(n);

for i=1:n
	fh = IC{i} * S{i};
	H(i,i) = S{i}' * fh;
	j = i;
	while eva.link(j).parent > 0
		fh = Xup{j}' * fh;
		j = eva.link(j).parent;
		H(i,j) = S{j}' * fh;
		H(j,i) = H(i,j);
	end
end
C=-C;

tools.write_full( [ '+robot/+' eva.name '/out_featherD.m'],{'q'},[eva.list_q],{H,'D'});
tools.write_full( [ '+robot/+' eva.name '/out_featherC.m'],{'q','dq'},[eva.list_q;eva.list_dq],{C,'C'});

%  H
%  C
%  robot.planar.out_lieD( q )