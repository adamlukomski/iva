%
%%  don't use  for analysis - not really working, matlab supplies more time points in here
%%  yeah, sometime t = [0.05 0.06 0.07] and so on
%
%  only print preview
%

function status = dyn_show( t,x,flag )

global passthrough
global plotter1
global eva

switch flag
	case 'init'
		passthrough.uall = [];
		passthrough.tall = [];
	case 'done'
		;
	case []
		passthrough.uall = [ passthrough.uall passthrough.u ];
		passthrough.tall = [ passthrough.tall t(1) ];
		draw.windowupdate( plotter1, x(1:eva.n,1) )
		subplot(plotter1.opts3.subplot)
		plot( passthrough.tall, passthrough.uall )
		subplot(plotter1.opts1.subplot) % support
		if ~isempty(eva.support)
		    plot( t(1), eva.support, '.b' )
		end
		drawnow
		if eva.dump
			eva.movie = eva.movie+1;
			print( '-dpng', '-r100', ['movie/movie' num2str(eva.movie+1000)] )
		end
%  		pause(0.01)
	otherwise
		disp('unrecognised flag in outputfun');
end

status = 0;