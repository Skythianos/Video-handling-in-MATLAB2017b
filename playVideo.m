function [] = playVideo(fname, frames, display)

    if nargin < 2 || isempty( frames ), frames = [1, double( intmax( 'int64' ) )];
    elseif numel( frames ) < 2, frames( 2 ) = double( intmax( 'int64' ) );
    end
    
    vid=VideoReader(fname);
    vid.CurrentTime=( double(frames(1))-1 ) / vid.FrameRate;
    rgb=readFrame(vid);
    fig = figure;

    for frame = frames(1) : frames(2)
    
        imshow(rgb)
        % wait and handle key press
        if playbackkeyhandler( fig, frame, display.wait, display.close )
            display.close( end+1 ) = false;
            break;
        end
	
        % read next frame or exit
        if hasFrame( vid )
            rgb = readFrame( vid );
        else
            disp( ['Video ended at frame ', num2str(frame)] );
            break;
        end
    end

    display.close( end+1 ) = true;
    if display.close( 1 ) && isvalid( fig )
        close( fig );
    end

end

