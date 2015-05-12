function w = miniwindow()

w = [];
w.type = 'mini';


global eva
hold off
plot( 0, 0 );
hold on
xlabel('x')
ylabel('y')
zlabel('z')


w.view = [0,0];
view( w.view ) % sagittal
%  view( w.camera )

w.xlimit = [ -0.3 1.1 ].*eva.scale;
w.ylimit = [ -0.7 0.7 ].*eva.scale;
w.zlimit = [ -0.2 1.2 ].*eva.scale;

axis square

q = zeros( eva.n, 1 );
dq = zeros( eva.n, 1 );

% biped only! pendulum is missing [0,0,0,1]' point!

p = robot.p( 1:eva.n, q );
dp = robot.dp( 1:eva.n, q, dq );


for i=1:length( eva.chains )
	current = p( 1:3, eva.chains(i).chain );
	w.plot(i) = plot3( 0,0,0 );
	w.plotdots(i) = plot3( 0,0,0,'.' );
%  	set( w.plot(i), 'XData', current(1,:), 'YData', current(2,:), 'ZData', current(3,:) );
%  	set( w.plotdots(i), 'XData', current(1,:), 'YData', current(2,:), 'ZData', current(3,:) );
end

axis( [w.xlimit, w.ylimit, w.zlimit] )
w.plotcom = plot3( 0,0,0,'.r' );
grid on
w.quiver = quiver3( 0,0,0,0,0,0 );
set( w.quiver, 'Color', 'g');



%  for i=1:length( eva.chains )
%  	if eva.chains(i).chain(1) == 1
%  		current = [ [0;0;0;1] robot.p( eva.chains(i).chain, q ) ];
%  	else
%  		current = robot.p( eva.chains(i).chain, q );
%  	end
%  
%  	for plane = w.PlanesOfMotion % sagittal, frontal, tranverse...  plane{1} unpacks the cell
%  		subplot( w.(plane{1}).subplot )
%  		w.(plane{1}).plot(i) = plot3( 0,0,0 );
%  		w.(plane{1}).plotdots(i) = plot3( 0,0,0,'.' );
%  		set( w.(plane{1}).plot(i), 'XData', current(1,:), 'YData', current(2,:), 'ZData', current(3,:) )
%  		set( w.(plane{1}).plotdots(i), 'XData', current(1,:), 'YData', current(2,:), 'ZData', current(3,:) )
%  	end
%  end