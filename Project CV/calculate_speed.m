function [speed] = calculate_speed(distance, time1, time2)    
    speed = distance / (time2 - time1);
    disp(speed + " pixels / sec");
    disp(speed * 0.02 + " cm / sec");
end


% 20 pixels = 0.4 cm
% 1 pixel = 0.4 / 20 cm
% 1 pixel = 0.02 cm