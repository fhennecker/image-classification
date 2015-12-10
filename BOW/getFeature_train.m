function words_train = getFeature_train(path,classes,images, patchSize)

%get patch features from every image and save them into a .mat file

%patch_all = zeros(patchSize*patchSize, )
patch_all_name = 'data/patchFeatures_train.mat';
column = 1;
N = length(images);
for class = {classes.name}
 if ~strncmpi(class, '.', 1) % ignoring '.', '..', '.DS_Store', ...
    class = class{1};
  for i = 1:N
    p = fullfile(path,class,images{i});
    img = imread(p);
    [high, width] = size(img);
    k = 1;
    j = 1;
    while (j <= high - patchSize)
        while (k <= width - patchSize)
           
            features = img(j:j+patchSize-1,k:k+patchSize-1);
            feature_vector = reshape(features',1,[]);%every column will be a patch featrue
            patch_all(:,column) = [feature_vector'];
            column = column +1;
            k = k+48; %maybe leave some space between every patch(4 patch every x or y)
        end
        k = 1;
        j = j + 48;
    end
  end
  features;
  save(patch_all_name,'patch_all');
 end
end
patch_all = single(patch_all);%I don't know why it has to be single..if not there wil be an error..
save(patch_all_name,'patch_all');

%patch_all = single(patch_all);
%%K-means

%k = 500; %not sure about the k value, will test different value of k later
%[C,~] = vl_kmeans(patch_all,k);
%words = C;

end
%I need to save a .mat for storing the name of these features

            