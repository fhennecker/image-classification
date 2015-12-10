function [ accuracies ] = cross_validation( H, T, classes, C, type, param_name, param_value, hkm )
%CROSS_VALIDATION 10-fold cross-validation
       
    if nargin == 7
        hkm = 0;
    end
    
    for i=0:10:99
        disp(sprintf('Cross-validation with test images %d-%d', i, i+9));
        training = [];
        for j=0:size(classes, 1)-1
            cm = j*100; % class multiplier
            training = [training [cm+1:cm+i cm+i+11:cm+100]];
        end
        
        test = [i:i+9]; % image names are 0-based
        
        w = one_vs_all(H(:, training), T(training), hkm);
        accuracies(i/10+1, :) = hist_test(classes, test, C, w, type, param_name, param_value, hkm);
    end
end

