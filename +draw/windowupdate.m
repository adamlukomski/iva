function windowupdate( w, q, dq )

switch w.type
	case 'full'
		draw.windowupdate_full( w,q,dq )
	case 'mini'
		draw.miniwindowupdate( w,q,dq )
	otherwise
		fprintf('unrecognised windowupdate type\n')
end