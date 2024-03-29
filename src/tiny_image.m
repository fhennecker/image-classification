addpath('functions');

% feature vectors
X = [];

% targets (classes)
T = [];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TRAINING

classes = dir('../images/training/');
cid = 1; % class index
i = 1; % current training image index
for class={classes.name}
    class = class{1};

    if ~strncmpi(class, '.', 1) % ignoring '.', '..', '.DS_Store', ...

        disp(sprintf('Training with class %s', class));

        images = dir(sprintf('../images/training/%s/*.jpg', class));
        for image={images.name}
            image = image{1};
            timg = make_tiny_image(sprintf('../images/training/%s/%s', class, image));
            vector = reshape(timg.', 1, []);
            %imshow(mat2gray(timg), 'InitialMagnification', 1000);
            X(i+1, :) = vector;
            T(i+1) = cid;
            i = i+1;
        end

    end
    cid = cid+1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PREDICTION

img = imread('../images/testing/0.jpg');
imshow(img)
timg = make_tiny_image('../images/testing/0.jpg');
vector = reshape(timg.', 1, []);
class_index = knn(X, T, vector, 5);
class = classes(class_index).name
