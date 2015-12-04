function [ tiny_image ] = make_tiny_image( filename, s )
%make_tiny_image Create a s by s zero-mean unit-length centered crop thumb.

    % default value for s
    if nargin < 2
        s = 16;
    end

    original = imread(filename);
    tiny_image = zeros(s);
    
    [h, w] = size(original);
    [top, bot, left, right] = deal(1, h, 1, w);
    square_size = floor(w/s);
    if (w < h)
        % portrait image, cropping
        top = round((h-w)/2);
        bot = bot - round((h-w)/2);
    elseif (w > h)
        % landscape image, cropping
        left = round((w-h)/2);
        right = right - round((w-h)/2);
        square_size = floor(h/s);
    end
    
    
    ty = 1;
    tx = 1;
    for w_start=left:square_size:right
        for h_start=top:square_size:bot
            w_end = min(w, w_start+s-1);
            h_end = min(h, h_start+s-1);
            % w_start, h_start, w_end and h_end define the square of the
            % original image to be averaged in one pixel of tiny_image
            
            total = sum(sum(original(h_start:h_end, w_start:w_end)));
            divider = (w_end-w_start)*(h_end-h_start);
            
            tiny_image(ty, tx) = total/divider;
            % unit-length, zero-centered
            %tiny_image(ty, tx) = tiny_image(ty, tx)/255 - 0.5
            ty = ty+1;
        end
        ty = 1;
        tx = tx+1;
    end
    
end

