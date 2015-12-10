function [ id ] = quantizevec( input, representatives )
%QUANTIZE quantize input to the (euclidean) closest representative vector
% id is the line id of the closest representative
    id = 1;
    input = single(input);
    best_distance = norm(input-representatives(:, 1));
    for i=2:size(representatives, 2)
        distance = norm(input-representatives(:, i));
        if distance < best_distance
            id = i;
            best_distance = distance;
        end
    end
end

