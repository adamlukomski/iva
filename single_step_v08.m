function [t0,x0,t,x] = single_step( t0, x0, sup )

global eva
global plotter1

% if this is immediately after an impact/lift-off event
% the control system might have changed and may push a point
% below the ground
%
% check it:
%

if t0 == eva.lastimpact.t
	eva.support = eva.lastimpact.supportCHECK;
	fprintf('checking: %d\n', eva.support')
	[dx] = dyn_v08( t0, x0 );
	[val,term,dir] = dyn_v08_ev( t0, x0 );
	for lifti=1+eva.n:2*eva.n
		if val(lifti)<0
			eva.support = unique([ eva.support; lifti-eva.n ]);
			fprintf( 'new control sys, grounded: %i\n', lifti-eva.n );
		end
	end
end

eva.support = sup;
fprintf('sim start: t0=%f\n',t0);
opts = odeset( 'events', @dyn_v08_ev );
[t,x,te,xe,ie] = ode45( @dyn_v08, t0:0.01:t0+eva.controlsys.tmax, x0, opts );

for i=1:length(t)
	[dx,other] = dyn_v08( t(i), x(i,:) );
	draw.window( x(i,1:eva.n), 0, [x(i,1:3) other.yr'] )
	pause(0.01)
end

t0 = t(end);
x0 = x(end,:); % must be before impact
ie = unique(ie);
if ie
	modules.events_v08
end


nextstep = 0;
try
	if sup~=eva.support
		nextstep = 1;
	end
catch err
	if isempty(sup) & ~isempty(eva.support)
		nextstep = 1;
	end
	if ~isempty(sup) & isempty(eva.support)
		nextstep = 1;
	end
end
