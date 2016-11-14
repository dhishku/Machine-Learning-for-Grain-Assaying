## How to run the code

Please follow the given steps to run the code:

1) Download '<b>images.zip</b>' required from the following <a href="https://drive.google.com/open?id=0B41ysiBvWu8xaGdFbDRjbGVHd1k">link <\a>. 

2) Extract the content of 'images.zip' and the code in the same folder.

3) Run '<b>a_feature_extractor.m</b>' to extract segments and their features.

4) Then run '<b>b_classifier_trainer.m</b>' to train the classifier model.

5) This model then can be used to test on an image by using '<b>c_final_tester.m</b>'.

6) We are also working on code for level 2 segmentation (level2_watershed.m and level2_EM.m) for segmenting the overlapping grains. But we are still working on generalizing them for all kinds of segments, and hence they aren't currently plugged into the pipeline, and hence not included here. If you are interested in that just email me: ankuprk@gmail.com 
