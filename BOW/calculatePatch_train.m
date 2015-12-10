function feature_hist_train = calculatePatch_train(words_train,words, path,classes,images,patchSize)

%load('..\data\patchFeatures.mat', patch_all);%add an if statement for test the exist of the file

histogram_name = 'data/features_histogram_train.mat';
[W,V] = size(words);%features from k-means(64*kvalue)
hist = zeros(1,V);


%the feature of test data,for every test image, should return a 1*100
%feature distance

N = length(images);%for every image in the test set
j = 1;
k = 1;
i = 1;
num = 1;
column = 1;
for class = {classes.name}
 if ~strncmpi(class, '.', 1) % ignoring '.', '..', '.DS_Store', ...
    class = class{1};
  for i = 1:N
    p = fullfile(path,class,images{i});
 %   p = fullfile(path,images{i});
    img = imread(p);
    [high, width] = size(img);
    while (j <= high - patchSize)
        while (k <= width - patchSize)
           
            features = img(j:j+patchSize-1,k:k+patchSize-1);
            feature_vector = reshape(features',1,[]);%every column will be a patch featrue
            feature(:,column) = feature_vector';
            column = column +1;
            k = k + 48; %maybe leave some space between every patch
        end
        
        k = 1;
        j = j + 48;
    end
     feature = single(feature);
     %feature_vector = reshape(features',1,[])';
     
     [x,y] = size(feature);%should be x*1
%     distances = zeros(V,1);
%     while j <= y
%         for k = 1:V;
%             feature_vector(:,j);
%             words(:,k);
%             distances(k) = vl_alldist2(feature_vector(:,j),words(:,k));
%         end
%        [~, index] = ismember(min(distances), distances);
%        % and increment it to the histogram
%        hist(index) = hist(index) + 1;
%        j = j+1;
%     end
    
%    hist = hist/norm(hist);
%feature_vector;
  % for n = 1:y
     j = 1;
    feature;
    hist_test = getHistogram(feature,words);
    feature_hist_train(num,:) = hist_test;
   %end
     num = num+1
  end
  save(histogram_name,'feature_hist_train');
 end
 
end
end





    