function [res] = rgbtogray(image)
    [x, y, z] = size(image);
    res = zeros(x, y);
    if z == 3        
        res = (image(:, :, 1) + image(:, :, 2) + image(:, :, 3)) / 3;
    else
        res = image;
    end    
end