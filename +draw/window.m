function w = window( n, opts )
% create a window

global eva

w = [];

w.n = n;
w.type = 'full'; % full plots

w.PlanesOfMotion = {'spatial','sagittal','frontal','transverse'};
w.geo = [ 3, 5 ];


% full reset, not only clf
figure( n )
close( n )
w.figure = figure(n);
%  set( w.figure, 'menubar', 'none', 'position', [0 600 1000 300])
set( w.figure, 'position', [10 477 755 615])


w.spatial.subplot = subplot( w.geo(1), w.geo(2), 1 );
hold on
xlabel('x')
ylabel('y')
zlabel('z')

w.sagittal.subplot = subplot( w.geo(1), w.geo(2), [2 3] );
hold on
xlabel('sagittal plane, x')
ylabel('y')
zlabel('z')

w.frontal.subplot = subplot( w.geo(1), w.geo(2), 4 );
hold on
xlabel('x')
ylabel('frontal plane, y')
zlabel('z')

w.transverse.subplot = subplot( w.geo(1), w.geo(2), 5 );
hold on
xlabel('transverse plane, x')
ylabel('y')
zlabel('z')

w.opts1.subplot = subplot( w.geo(1), w.geo(2), 6:7 ); % support points
plot( 0, 0, '.b' )
ylim([ 0 eva.n+1] )
hold on
xlabel('contact points, t')
ylabel('p')

w.opts2.subplot = subplot( w.geo(1), w.geo(2), 8 );
w.opts3.subplot = subplot( w.geo(1), w.geo(2), 9:10 );

%  w.opts4.subplot = subplot( w.geo(1), w.geo(2), 8 );

%  w.feetcom.subplot = subplot( w.geo(1), w.geo(2), 5 );

w.spatial.camera = [60, 24];
w.sagittal.camera = [0, 0];
w.frontal.camera = [90, 0];
w.transverse.camera = [0, 90];

xlimit = [ -0.6 0.6 ].*eva.scale*2+2;
ylimit = [ -0.6 0.6 ].*eva.scale;
zlimit = [ -0.05 1.3 ].*eva.scale;

%  draw.windowupdate( w, zeros( eva.n, 1 ) );
q = zeros( eva.n, 1 );

for i=1:length( eva.chains )
	if eva.chains(i).chain(1) == 1
		w.links{i} = [ [0;0;0;1] robot.p( eva.chains(i).chain, q ) ];
	else
		w.links{i} = robot.p( eva.chains(i).chain, q );
	end

	for plane = w.PlanesOfMotion % sagittal, frontal, tranverse...  plane{1} unpacks the cell
		% subplot( w.spatial.subplot )
		subplot( w.(plane{1}).subplot )
		% w.spatial.line(i) = line( 'XData', w.links{i}(1,:), 'YData', w.links{i}(2,:), 'ZData', w.links{i}(3,:) );
		w.(plane{1}).plot(i) = plot3( 0,0,0 );
		w.(plane{1}).plotdots(i) = plot3( 0,0,0,'.' );
%  		set( w.(plane{1}).plot(i), 'XDataSource', 'w.links{i}(1,:)', 'YDataSource', 'w.links{i}(2,:)', 'ZDataSource', 'w.links{i}(3,:)' )
%  		set( w.(plane{1}).plotdots(i), 'XDataSource', 'w.links{i}(1,:)', 'YDataSource', 'w.links{i}(2,:)', 'ZDataSource', 'w.links{i}(3,:)' )
		set( w.(plane{1}).plot(i), 'XData', w.links{i}(1,:), 'YData', w.links{i}(2,:), 'ZData', w.links{i}(3,:) )
		set( w.(plane{1}).plotdots(i), 'XData', w.links{i}(1,:), 'YData', w.links{i}(2,:), 'ZData', w.links{i}(3,:) )
	end
end

for plane = w.PlanesOfMotion % sagittal, frontal, tranverse...
	subplot( w.(plane{1}).subplot );
	axis( [xlimit, ylimit, zlimit] )
	view( w.(plane{1}).camera )
	w.(plane{1}).plotcom = plot3( 0,0,0,'.r' );
	grid on
	w.(plane{1}).quiver = quiver3( 0,0,0,0,0,0 );
	set( w.(plane{1}).quiver, 'Color', 'g');
end




%  refreshdata(w.figure,'caller')



