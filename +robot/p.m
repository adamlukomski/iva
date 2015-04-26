function pos = p( m, y )
global eva
for i=1:length(m)
	eval( [ 'pos(1:4,i) = robot.' eva.name '.out_p' num2str(m(i)) '( y ); ' ] );
end
