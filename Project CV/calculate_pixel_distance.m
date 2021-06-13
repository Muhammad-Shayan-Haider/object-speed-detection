% Assumption: I have taken here the assumption that the object is moving from
% left to right. So, for this purpose, I have to take pixel difference
% between the object in the first frame and the second frame. I am taking
% Euclidean distance between right most pixels of the object in the two frames.
function [speed] = calculate_pixel_distance(edge_detected_frame1, edge_detected_frame2, time1, time2)    
    % code for getting right most pixel of the object in frame1.
    [a, b, c] = size(edge_detected_frame1);
    right_most_x_f1 = 0;
    right_most_y_f1 = 0;
    for i = 1 : a
        for j = 1 : b
            if edge_detected_frame1(i, j) == 1
                if right_most_x_f1 < j
                    right_most_x_f1 = j;
                    right_most_y_f1 = i;
                end
            end
        end
    end
    
    % code for getting right most pixel of the object in frame1.
    [a, b, c] = size(edge_detected_frame2);
    right_most_x_f2 = 0;
    right_most_y_f2 = 0;
    for i = 1 : a
        for j = 1 : b
            if edge_detected_frame2(i, j) == 1
                if right_most_x_f2 < j
                    right_most_x_f2 = j;
                    right_most_y_f2 = i;
                end
            end
        end
    end
    
    
    disp(right_most_x_f1 + ", " + right_most_y_f1);
    disp(right_most_x_f2 + ", " + right_most_y_f2);
    
    distance = sqrt(((right_most_x_f2 - right_most_x_f1)^2) + ((right_most_y_f2 - right_most_y_f1)^2));
    disp(distance);
    speed = calculate_speed(distance, time1, time2);
    % imshowpair(edge_detected_frame1, edge_detected_frame2, 'montage'); 
end