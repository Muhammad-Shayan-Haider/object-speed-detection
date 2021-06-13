% This function preprocesses the frames. Preprocessing done is the
% binarization and edge detection of the two frames. 
% Assumption: I have assumed that there is only one object in the video.
function [speed] = frames_processing(frame1, frame2, time1, time2)
    [a, b, c] = size(frame1);
    [x, y, z] = size(frame2);
    
    if c == 3
        frame1 = rgbtogray(frame1);        
    end
    frame1 = ~imbinarize(frame1);
    
    if z == 3
        frame2 = rgbtogray(frame2);        
    end
    frame2 = ~imbinarize(frame2);
    
    edge_detected_frame1 = frame1; %edge(frame1, 'canny');
    edge_detected_frame2 = frame2; %edge(frame2, 'canny');    
    speed = calculate_pixel_distance(edge_detected_frame1, edge_detected_frame2, time1, time2);
    disp(frame1);
    % imshowpair(frame1, frame2, 'montage');
end