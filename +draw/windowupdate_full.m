function windowupdate( w, q, dq )
global eva
for i=1:length( eva.chains )
	if eva.chains(i).chain(1) == 1
		w.links{i} = [ [0;0;0;1] robot.p( eva.chains(i).chain, q ) ];
	else
		w.links{i} = robot.p( eva.chains(i).chain, q );
	end

	for plane = w.PlanesOfMotion % sagittal, frontal, tranverse...  plane{1} unpacks the cell
		set( w.(plane{1}).plot(i), 'XData', w.links{i}(1,:), 'YData', w.links{i}(2,:), 'ZData', w.links{i}(3,:) )
		set( w.(plane{1}).plotdots(i), 'XData', w.links{i}(1,:), 'YData', w.links{i}(2,:), 'ZData', w.links{i}(3,:) )
	end
end

points = robot.p( 1:eva.n, q );
% assume mass 1
w.com = sum( points([1,2,3],:).*[eva.link.m;eva.link.m;eva.link.m], 2)./(sum([eva.link.m]));
for plane = w.PlanesOfMotion % sagittal, frontal, tranverse...  plane{1} unpacks the cell
	set( w.(plane{1}).plotcom, 'XData', w.com(1), 'YData', w.com(2), 'ZData', w.com(3) )

	if exist('dq')
		dpoints = robot.dp( 1:eva.n, q, dq );
		set( w.(plane{1}).quiver, 'XData', points(1,2:eva.n),...
					  'YData', points(2,2:eva.n),...
					  'ZData', points(3,2:eva.n),...
					  'UData', dpoints(1,2:eva.n),...
					  'VData', dpoints(2,2:eva.n),...
					  'WData', dpoints(3,2:eva.n));
	end	
	
end
%  refreshdata(w.figure,'caller')

