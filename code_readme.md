## How to run the code

Please follow the given steps to run the code:

1) Download <b>images.zip</b> required from the following <a href="https://drive.google.com/open?id=0B41ysiBvWu8xaGdFbDRjbGVHd1k">link</a>. 

2) Extract the content of <b>images.zip</b> and the code in the same folder.

3) Run '<b>a_feature_extractor.m</b>' to extract segments and their features.

4) Then run '<b>b_classifier_trainer.m</b>' to train the classifier model.

5) This model then can be used to test on an image by using '<b>c_final_tester.m</b>'.

P.S. We are also working on code for level 2 segmentation (level2_watershed.m and level2_EM.m) for segmenting the touching grains. But we are still working on generalizing them for all kinds of segments, and hence they aren't currently plugged into the pipeline, and hence not included here. If you are interested in that just email Prakhar Kulshreshtha: ankuprk@gmail.com 

P.S.2: We improved the system using Instance Segmentation system, and MobileNetV2 for classification which is getting good results on touching grains. The work will be published in BMVC'19. A blog detailing the work described in the paper can be accessed from here: https://medium.com/@ankuprk/quality-estimation-of-food-grains-using-computer-vision-63fd75c129a4
For any comments, feedback, suggestions, email Prakhar Kulshreshtha: ankuprk@gmail.com
