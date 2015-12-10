function predicted_categories = svm_classify(train_features, test_features, label)

iterations = 1000;

N = length(label);

%test_number = size(features);


categories = unique(label);
%num_categories = length(categories);

lambda = 1e-06;
y = [];

for i = 1:15
   
   
    match_label = strcmp(categories(i) , label);
    match_label = double(match_label);
    
    for j = 1: size(label, 1)
        if(match_label(j) == 0)
            match_label(j) = -1;
        end
    end
    
    
    [w, b] = vl_svmtrain(train_features', match_label, lambda);
    
    y = [y; (w' * test_features' + b) ];
    i
    
end
y

[max_values, max_indices] = max(y)
predicted_categories = categories(max_indices');

    