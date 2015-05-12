function miniwindowupdate( w, q, dq, txt )

global eva

p = robot.p( 1:eva.n, q );
dp = robot.dp( 1:eva.n, q, dq );

for i=1:length( eva.chains )
	current = p( 1:3, eva.chains(i).chain );
	set( w.plot(i), 'XData', current(1,:), 'YData', current(2,:), 'ZData', current(3,:) );
	set( w.plotdots(i), 'XData', current(1,:), 'YData', current(2,:), 'ZData', current(3,:) );
end

w.com = sum( p([1,2,3],:).*[eva.link.m;eva.link.m;eva.link.m], 2)./(sum([eva.link.m]));
set( w.plotcom, 'XData', w.com(1), 'YData', w.com(2), 'ZData', w.com(3) )

dpoints = unique( [eva.chains.chain] );

set( w.quiver,	'XData', p(1,dpoints),...
		'YData', p(2,dpoints),...
		'ZData', p(3,dpoints),...
		'UData', dp(1,dpoints),...
		'VData', dp(2,dpoints),...
		'WData', dp(3,dpoints));

if exist('txt')
%  	xlabel( txt ) % too simple, sorry
	set(get(get(w.plot(1), 'parent'),'xlabel'),'string',txt) % yeah, that will SURELY work, not worries, mate...
end