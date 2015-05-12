function save( name, counter )

if ~exist( 'name' )
	name = 'anim';
end
if ~exist( 'counter' )
	counter = 1;
end

global eva
if eva.dump
	for i=1:counter
		print( '-dpng', '-r100', ['movie/' name num2str(eva.movie+1000)] );
		eva.movie = eva.movie + 1;
	end
end

