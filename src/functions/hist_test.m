function [ accuracies ] = hist_test( classes, images, C, w, type, param_name, param_value, hkm )
%HIST_TEST Summary of this function goes here
%   Detailed explanation goes here

    if nargin == 7
        hkm = 0;
    end
        
    cid = 1; % class index
    i = 1; % current training image index
    for class={classes.name}
        class = class{1};
        
        total = 0;
        correct = 0;
    
        for image=images
            
            I = imread(sprintf('../images/training/%s/%d.jpg', class, image));
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
            
            % classifying with 1vsAll
            ccount = zeros(1, size(w, 2));
            for c=1:size(w,2)
                val = hist*w(:, c);
                if val > 0
                    ccount(c) = ccount(c)+val;
                else
                    ccount = ccount -val;
                    ccount(c) = ccount(c)+val;
                end
            end
            [M, predicted] = max(ccount);
            
            total = total+1;
            if predicted == cid
                correct = correct+1;
            end
            i = i+1;
        end
        disp(sprintf('%d correct out of %d', correct, total))
        accuracies(cid) = correct/total;
        cid = cid+1;
    end

end

