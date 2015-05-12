for ievent = 1:length(ie)
	switch ie(ievent)
		case num2cell( 1:eva.n ) % normal impact
			% if already in support list, omit:
			if any(eva.support==ie(ievent))
				continue;
			else
				fprintf('   IMPACT  link %i time %f\n',ie(ievent),te )
				eva.support = unique([ eva.support; ie(ievent) ]);
				
				[ dqafter F ] = motion.impact( x0, ie(ievent) );
				
				results(results_counter).impact.before = x0(eva.n+1:2*eva.n);
				results(results_counter).impact.after = dqafter;
				results(results_counter).impact.F = F;
				
				x0(eva.n+1:2*eva.n) = dqafter;
				
				% maybe you wanna... lift someone?
				
				[dx] = dyn_v06( t0, x0' );
				[val,term,dir] = dyn_v06_ev( t0, x0' );
				for lifti=1+eva.n:2*eva.n
					if val(lifti)>0
						eva.support = setdiff( eva.support, lifti-eva.n );
						fprintf( 'premature lift of %i\n', lifti-eva.n );
					end
				end
			end
		case num2cell( 1+eva.n:2*eva.n ) % lift
			lift = ie(ievent)-eva.n;
			eva.support = setdiff( eva.support, lift );
			fprintf( 'yo! lifted %i\n', ie(ievent) )
		otherwise
			fprintf('unrecognised event!\n');
			return
	end % switch ievent
end % for ievent
