function [ d ] = extract_patches( image )
%EXTRACT_PATCHES extract 8x8 pixel patches every 4 pixels

    d = zeros(64, 4000)
    p_nbr = 0
    for l=1:4:size(image, 1)-8
        for c=1:4:size(image, 2)-8
            p_nbr = p_nbr+1;
            patch = image(l:l+7, c:c+7);
            patch = reshape(patch.', 1, []);
            
            % normalising patch
            patch = patch-mean(patch);
            patch = patch/std(patch);
            patch = patch';
            
            d(:, p_nbr) = patch;
        end
    end

    d = d(:, 1:p_nbr)
    ii = randperm(size(d, 2));
    d = d(:, ii(1:1000))

end

