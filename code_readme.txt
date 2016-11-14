Please follow the given steps to run the code:

1) Download 'images.zip' required from the following link: https://drive.google.com/open?id=0B41ysiBvWu8xaGdFbDRjbGVHd1k

2) Extract the content of 'images.zip' and 'code.zip' in the same folder.

3) Run 'a_feature_extractor.m' to extract segments and their features.

4) Then run 'b_classifier_trainer.m' to train the classifier model.

5) This model then can be used to test on an image by using 'c_final_tester.m'.

6) We have also included code for level 2 segmentation (level2_watershed.m and level2_EM.m) for segmenting the overlapping grains. But we are still working on generalizing them for all kinds of segments, and hence they aren't currently plugged into the pipeline. 
