function dq = generate_velocities( pos, points, velocities )
% dq = generate_velocities( pos, points, velocities )
% trying to create velocities for an impact
%   pos - current position
%   points - which points, n
%   velocities - velocities, 2*n, currently in x-z axis
%
%  how? grab the jacobians, pseudoinverse them
%
%  example:
%  generate_velocities( pos, [3 4 5 7], [  [0.1;0] ; [0.1;0] ; [0;0.1]; [0;0]  ]*40 )


% go around point 7 - support
%                 5 - swing


%                 q3        q4       5 swing   7 support
%  velocities = [  [0.1;0] ; [0.1;0] ; [0;0.1]; [0;0]  ]*40;

jacobians = [];
for i = 1:length( points )
	J = robot.jacobian( points(i), pos );
	jacobians = [ jacobians ; J([1,3],:) ];
end
dq = pinv(jacobians)*velocities;
