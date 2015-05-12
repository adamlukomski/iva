%  plotter1 = draw.window( 5, [] );
figure(1)
plotter1 = draw.miniwindow( );



x=[];
t=[];
tu = [];
u = [];
support = [];
for i=1:length( results )
	x = [x ; results(i).x];
	t = [t ; results(i).t];
%  	tu = [tu  results(i).tu];
%  	u = [u  results(i).u];
%  	subplot(plotter1.opts1.subplot)
%  	if ~isempty(results(i).support)
%  	    plot( [results(i).t(1) results(i).t(end)], [ results(i).support results(i).support]', 'b' )
%  	end
end


%  subplot(plotter1.opts3.subplot)
%  plot( tu, u )
%  title('input signals')
%  xlabel('t')
%  ylabel('u')

for i=1:1:length(t)
%  	draw.windowupdate_shadow( plotter1, x(i,1:eva.n)+[(i-60)/15/10;0;0; 0;0;0; 0;0;0; 0;0]' ) % space it out a little
%  	draw.windowupdate_shadow( plotter1, x(i,1:eva.n) )

	draw.windowupdate( plotter1, x(i,1:eva.n), x(i,eva.n+1:2*eva.n) )
	drawnow
%  	pause(0.01)  % if too fast

	% save to file
  	if eva.dump
		print( '-dpng', '-r100', ['movie/anim' num2str(i+1000)] )
	end

end
