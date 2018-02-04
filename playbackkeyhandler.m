function stop = playbackkeyhandler( fig, nframe, wait, allowclose )
%stop = playbackkeyhandler( fig, nframe, wait = [], allowclose = true )
% Pause on frame, continue or emit stop signal
% while playing back video on figure

if nargin < 3, wait = [];
end

pause( wait );
	
% pause if space key pressed
stop = false;
space = ' ' == fig.CurrentCharacter;
escape = char( 27 ) == fig.CurrentCharacter;
if space
	disp( ['Pause at frame ', num2str( nframe )] );
	figure( fig.Number );

	% wait for next key press
	fig.CurrentCharacter = char( 0 );
	pollwait = max( [wait, 0.25] );
	while isempty( fig.CurrentCharacter )
		pause( pollwait );
	end

	% check if space again
	space = ' ' == fig.CurrentCharacter;
	escape = char( 27 ) == fig.CurrentCharacter;

	% get ready to continue
	fig.CurrentCharacter = char( 0 );
	figure( fig.Number );
end

% stop if key other than space pressed
if ~space
	disp( ['Stopped at frame ', num2str( nframe )] );
	stop = true;

	% close figure on escape, or set focus
	if nargin < 4, allowclose = [];
	end
	if all( allowclose ) && escape
		close( fig );
	else
		figure( fig.Number );
	end
end
