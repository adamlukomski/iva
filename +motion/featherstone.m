function  [H,C] = featherstone

global eva
n = eva.n;

q = eva.q;
dq = eva.dq;

grav = [ 0 ; 0 ; 0 ; 0 ; 0 ; 9.81 ];


for i=1:n
%  	S{i} = [eva.link(i).w ; eva.link(i).v];
%  	S{i} = eva(i).s0;
%  	if isa(q(1),'double')
%  		XJ = inv(lie.adj(expm( lie.hat(S{i})*q(i) )));
%  	else
		XJ = simplify(inv(lie.adj(expm( lie.hat(S{i})*q(i) ))));
		XJ = lie.Adinv( eva.link(i).A );
%  	end
%  	XJ = [ aXJ(1:3,1:3) zeros(3) ; lie.hat(aXJ(1:3,4)) aXJ(1:3,1:3) ];
	vJ = eva.link(i).s*dq(i);
	
	if eva.link(i).parent ~= 0
		Xtree{i} = lie.Ad( [ eye(3) -eva.link(i-1).p ; 0 0 0 1 ] );
	else
		Xtree{i} = lie.Ad( eye(4) );
	end

	Xup{i} = XJ * Xtree{i};

	if eva.link(i).parent == 0
		v{i} = vJ;
		avp{i} = Xup{i} * grav;
	else
		v{i} = Xup{i}*v{eva.link(i).parent} + vJ;
		avp{i} = Xup{i}*avp{eva.link(i).parent} + lie.crm(v{i})*vJ;
	end
	fvp{i} = eva.link(i).M * avp{i} + lie.crf(v{i})*eva.link(i).M*v{i};

end

for i=n:-1:1
	C(i,1) = S{i}' * fvp{i};
	if eva.link(i).parent ~= 0
		fvp{eva.link(i).parent} = fvp{eva.link(i).parent} + Xup{i}' * fvp{i};
		if i==1
		  fvp{eva.link(i).parent}
		end
	end
end

for i=1:n
	IC{i} = eva.link(i).M;
end

for i=n:-1:1
	if eva.link(i).parent ~= 0
		IC{eva.link(i).parent} = IC{eva.link(i).parent} + Xup{i}' * IC{i} * Xup{i};
	end
end

if isa(q(1),'double')
	H = zeros(n);
else
	H = sym(zeros(n));
end

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
