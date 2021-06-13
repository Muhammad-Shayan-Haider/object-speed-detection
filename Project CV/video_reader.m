% This function is responsible for taking video as input and extracting
% the frames of interest from it for calculating pixel difference between the
% same object in two different frames.
function [frames, i, speed] = video_reader(video_path)    
    video = VideoReader(video_path); 
    curr_frame = 1;        
    frames = {};
    i = 1;
    frameno1 = 30;
    frameno2 = 40;
    
    time = [];
    while hasFrame(video)
        curr_image = readFrame(video);
        curr_frame = curr_frame + 1;
        if curr_frame == frameno1 || curr_frame == frameno2
            frames{i} = curr_image;
            time(i) = video.CurrentTime; 
            i = i + 1;            
        end               
    end
    
    speed = frames_processing(frames{i - 2}, frames{i - 1}, time(i - 2), time(i - 1));
end