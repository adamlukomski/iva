function impact( results, whichresults )

% plot starting positions of both - before and after
% animate left - before
% get to the impact
% show forces and misc data
% animate right - after

% repeat

global eva
eva.movie = 1;
%  eva.dump = 0; % enable draw.save % not here!

figure(1); close(1); figure(1);

subplot( 1,2, 1 )
w1 = draw.miniwindow
subplot( 1,2, 2 )
w2 = draw.miniwindow

for current = whichresults
	q1 = results(current).x(:,1:eva.n);
	q2 = results(current+1).x(:,1:eva.n);
	dq1 = results(current).x(:,eva.n+1:2*eva.n);
	dq2 = results(current+1).x(:,eva.n+1:2*eva.n);

	% begin
	draw.miniwindowupdate( w1, q1(1,:), dq1(1,:) );
	draw.miniwindowupdate( w2, q2(1,:), dq2(1,:) );

	% animate
	for ti=1:length(results(current).t)
		draw.miniwindowupdate( w1, q1(ti,:), dq1(ti,:), num2str(dq1(ti,:),'%f,\n') );
		draw.save( 'impact' )
		pause(0.01);
	end

	pause(3.0)
	draw.save( 'impact', 100 )
	
	% add description now
	draw.miniwindowupdate( w2, q2(1,:), dq2(1,:), num2str(dq2(1,:),'%f,\n ') );

	pause(3.0)
	draw.save( 'impact', 100 )

	% animate
	for ti=1:length( results(current+1).t)
		draw.miniwindowupdate( w2, q2(ti,:), dq2(ti,:), num2str(dq2(ti,:)','%f,\n') );
		draw.save( 'impact' )
		pause(0.01);
	end

	pause(3.0)
	draw.save( 'impact', 100 )

end