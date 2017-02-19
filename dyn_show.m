%
%
%%  don't use  for analysis - not really working, matlab supplies more time points in here
%%  yeah, sometime t = [0.05 0.06 0.07] and so on
%
%  only print preview
%
%
function status = dyn_show( t,x,flag )
t
global passthrough
global plotter1
global eva

switch flag
	case 'init'
		
	case 'done'
		;
	case []
		
		if eva.anim
			for i=1 %:length(t)
				draw.window( x(1:eva.n,i), x(1+eva.n:2*eva.n,i) )
				drawnow
%  				draw.save( 'movie' )
%  				rei.set( x(1:eva.n,1) );
			end
		end

		%  		subplot(plotter1.opts3.subplot)
%  		plot( passthrough.tall, passthrough.uall )
%  		subplot(plotter1.opts1.subplot) % support
%  		if ~isempty(eva.support)
%  		    plot( t(1), eva.support, '.b' )
%  		end


		pause(0.01)
		
	otherwise
		fprintf('unrecognised flag in outputfun');
end

status = 0;