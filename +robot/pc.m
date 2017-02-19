function pos = pc( m, y )
global eva
for i=1:length(m)
	eval( [ 'pos(1:4,i) = robot.' eva.name '.out_pc' num2str(m(i)) '( y ); ' ] );
end
