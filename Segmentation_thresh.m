%I_raw = imread('Grains/1950_impure/Sample 3/IMG_20161008_140636.jpg');
 I_raw = imread('Grains/2200_pure/IMG_20161008_141733.jpg');
I_orig = imresize(I_raw,0.4);
I_red = I_orig(:,:,1);
imshow(I_red);
%L1 = watershed(I_orig);
%L2 = watershed(I_orig, conn);
%rgb = label2rgb(L1);

%rice grain method
background = imopen(I_red,strel('disk',50));
figure(1)
surf(double(background(1:8:end,1:8:end))),zlim([0 255]);
set(gca,'ydir','reverse');
%% 
% Subtract the background approximation image, |background|, from the
% original image, |I|, and view the resulting image. After subtracting the
% adjusted background image from the original image, the resulting image
% has a uniform background but is now a bit dark for analysis
I2 = I_red - background;
imshow(I2)
%% 
% Use |imadjust| to increase the contrast of the processed image
% |I2| by saturating 1% of the data at both low and high intensities and by
% stretching the intensity values to fill the |uint8| dynamic range.
I3 = imadjust(I2);
imshow(I3);
%% 
% Create a binary version of the processed image so you can use toolbox
% functions for analysis. Use the |im2bw| function to convert the grayscale
% image into a binary image by using thresholding. The function
% |graythresh| automatically computes an appropriate threshold to use to
% convert the grayscale image to binary. Remove background noise with the
% |bwareaopen| function.
level = graythresh(I3);
bw = im2bw(I3,level);
bw = bwareaopen(bw, 50);
imshow(bw)
%% Step 3: Perform Analysis of Objects in the Image
% Now that you have created a binary version of the original image you can
% perform analysis of objects in the image.
%%
% Find all the connected components (objects) in the binary image. The
% accuracy of your results depends on the size of the objects, the
% connectivity parameter (4, 8, or arbitrary), and whether or not any
% objects are touching (in which case they could be labeled as one object).
% Some of the rice grains in the binary image |bw| are touching.
cc = bwconncomp(bw, 4);
disp(cc.NumObjects);
%% 
% View the rice grain that is labeled 50 in the image. 
grain = false(size(bw));
grain(cc.PixelIdxList{50}) = true;
figure(2)
imshow(grain);
%% 
% Visualize all the connected components in the image. First, create a
% label matrix, and then display the label matrix as a pseudocolor indexed
% image. Use |labelmatrix| to create a label matrix from the output of
% |bwconncomp| . Note that |labelmatrix| stores the label matrix in the
% smallest numeric class necessary for the number of objects. Since |bw|
% contains only 95 objects, the label matrix can be stored as |uint8| . In
% the pseudocolor image, the label identifying each object in the label
% matrix maps to a different color in an associated colormap matrix. Use
% |label2rgb| to choose the colormap, the background color, and how objects
% in the label matrix map to colors in the colormap.
labeled = labelmatrix(cc);
RGB_label = label2rgb(labeled, @spring, 'c', 'shuffle');
figure(3)
imshow(RGB_label)  
%% 
% Compute the area of each object in the image using |regionprops|. Each
% rice grain is one connected component in the |cc| structure.
graindata = regionprops(cc, 'basic');
%%
% Find the area of the 50th component, using dot notation to access the Area
% field in the 50th element of |graindata| . 
disp(graindata(50).Area);
%% 
% Create a vector |grain_areas| to hold the area measurement of each object
% (rice grain).
grain_areas = [graindata.Area];
%%
% Find the rice grain with the smallest area.
[min_area, idx] = min(grain_areas);
grain = false(size(bw));
grain(cc.PixelIdxList{idx}) = true;
figure(4)
imshow(grain);
%%
% Using the |hist| command to create a histogram of rice grain areas.
nbins = 20;
figure(5), hist(grain_areas, nbins)
title('Histogram of Rice Grain Area');


% figure(1)
% imshow(I_orig(:,:,1)); title ('Red');

% figure(1)
% subplot(2,2,1); imshow(I_orig); title ('Orig');
% subplot(2,2,2); imshow(I_orig(:,:,1)); title ('R');
% subplot(2,2,3); imshow(I_orig(:,:,2)); title ('G');
% subplot(2,2,4); imshow(I_orig(:,:,3)); title ('B');
