addpath('functions');

for i=0:9
    disp(sprintf('Doing image %d', i));
    name = sprintf('../images/testing/%d.jpg', i);
    img = imread(name);
    subplot(2, 10, i+1);
    imshow(img);
    timg = make_tiny_image(sprintf('../images/testing/%d.jpg', i));
    timg = mat2gray(timg);
    subplot(2, 10, i+11);
    imshow(timg);
end

