function vel = p( m, q, dq )
global eva
for i=1:length(m)
	eval( [ 'vel(1:3,i) = robot.' eva.name '.out_dp' num2str(m(i)) '( q, dq ); ' ] );
end
