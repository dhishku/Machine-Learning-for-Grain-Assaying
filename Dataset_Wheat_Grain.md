We have created a preliminary dataset of images containing spread out Wheat grains.

The dataset is available here: https://www.dropbox.com/s/wcth3i32mpgxzgi/Wheat_Grain_Dataset_easy.zip?dl=0

The dataset contains 8 different folders for 8 different qualities of wheat grain. Each folder then has two subfolders:

1) grain_full: images of full grain

2) impurities: images of impurities (broken grain and foreign particles)

Our first task is to segment out each particle (grain/impurity) from each images. 

Next task is to train a classifier on those segments.

Segmentation method given here can also be used: https://arxiv.org/pdf/1201.3109v1.pdf

