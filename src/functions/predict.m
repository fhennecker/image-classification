function [ output_args ] = predict( output_file, classes, w, C, type, param_name, param_value, hkm)
%PREDICT Write the results of our prediction to an output file

    if nargin == 7
        hkm = 0;
    end

    images = dir(sprintf('../images/testing/*.jpg'));
    for image={images.name}
        image = image{1};
        I = imread(sprintf('../images/testing/%s', image));
        f = [];
        d = [];
        if type == 'phow'
            [f, d] = vl_phow(single(I), param_name, param_value);
        elseif type == 'sift'
            [f, d] = vl_sift(single(I), param_name, param_value);
        end

        % building histogram
        hist = zeros(1, size(C, 2)); 
        for descriptor=1:size(d, 2)
            % quantize descriptor
            repid = quantizevec(d(:, descriptor), C);
            hist(repid) = hist(repid)+1;
        end
        
        if hkm == 1
            hist = vl_homkermap(hist', 2)';
        end

        ccount = zeros(1, size(w, 2));
        for c=1:size(w, 2)
            val = hist*w(:, c);
            if val > 0
                ccount(c) = ccount(c)+val;
            else
                ccount = ccount -val;
                ccount(c) = ccount(c)+val;
            end
        end
        [M, predicted] = max(ccount);
        fprintf(output_file, '%s %s\n', image, classes(predicted).name);
    end
end

