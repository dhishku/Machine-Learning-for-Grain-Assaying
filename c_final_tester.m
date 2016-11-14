lsdir = {'fg_good/','fp_good/'};

%         I_orig = imread('test.jpg');
%         I=I_orig(:,:,1);
%         I2 = I_orig(:,:,2);
%         I3 = I_orig(:,:,3);
%         se = strel('disk', 7);
%         b=I2;
%         b1 = ~im2bw(b,0.4);
%         b1 = imopen(b1,se);
%         b=I;
%         se = strel('disk', 3);
% 
%         b2=im2bw(b,0.4);
%         b2 = imopen(b2,se);
%         binary_image = imadd(b1,b2);
%         figure(1)
%         imshow(b1);
%         figure(2)
%         imshow(b2);
%         figure(3)
%         imshow(I);
%         figure(4)
%         imshow(binary_image);
%         imwrite(binary_image, 'test_b.jpg');


%binary_image = bwareaopen(binary_image,5000);
%----------------------------------------------------------------------------------------------------

        I_orig = imread('test.jpg');

        
        I=I_orig(:,:,1);
        I2 = I_orig(:,:,2);
        I3 = I_orig(:,:,3);
binary_image = imread('test_b.jpg');

%         se = strel('disk', 3);
%         binary_image = imopen(binary_image,se);

cc = bwconncomp(binary_image, 8); 

Iz={};
Iz1={};
Iz2={};
Iz3={};
segmented_im={};
latent_all={};

graindata = regionprops(cc,'basic');
grain_areas = [graindata.Area];
% figure
% histogram(grain_areas)
% title('Histogram of Rice Grain Area');

figure
imshow(I_orig);

num_grain=1;
for t=1:cc.NumObjects
    if grain_areas(t)>500
	A = cc.PixelIdxList{t};
	Ht = size(I,1);
	A_x = fix(A/Ht);
	A_y = rem(A,Ht);
	d_x = max(A_x) - min(A_x) + 1;
	d_y = max(A_y) - min(A_y) + 1;
	sz = size(A);
	Ayy = A_y - min(A_y) ;
	Axx = A_x - min(A_x) ;

	A_n = Axx*d_y + Ayy + 1;
    data_vector=[Axx,Ayy];
    dvshift=bsxfun(@minus, data_vector, mean(data_vector));
    [coeff,score,latent]=princomp(dvshift);
    latent_all{num_grain}=latent;
    
	Iz{num_grain} = uint8(zeros(d_y, d_x)); %this is assuming a grayscale image
   Iz{num_grain}(A_n)=I(A);
   Iz1{num_grain} = uint8(zeros(d_y, d_x)); %this is assuming a grayscale image
   Iz1{num_grain}(A_n)=I2(A);
   Iz2{num_grain} = uint8(zeros(d_y, d_x)); %this is assuming a grayscale image
   Iz2{num_grain}(A_n)=I3(A);
   Iz_new{num_grain}=cat(3,Iz{num_grain},Iz1{num_grain},Iz2{num_grain});
    num_grain=num_grain+1;
    end
end

segmented_grain={};
t=1;
features=[];
disp('getting features');
tff = num_grain-1;
for num_grain=1:cc.NumObjects
    
    if grain_areas(num_grain) > 500
%        rectangle('Position',int32(graindata(num_grain).BoundingBox),'EdgeColor','r');
        segmented_grain{t}=Iz_new{t};
        features(t,1)=mean(mean(double(segmented_grain{t}(:,:,1)))) / 256.0;
        features(t,2)=mean(mean(double(segmented_grain{t}(:,:,2)))) / 256.0;
        features(t,3)=mean(mean(double(segmented_grain{t}(:,:,3)))) / 256.0;
        features(t,4:5)=latent_all{t}(1:2);
        features(t,6)=features(t,4)./features(t,5);
        features(t,7)=grain_areas(num_grain);
        %[coeff,score,latent]=pca(
        
        %{
        subplot(25,20,t);
        h=imshow(segmented_grain{t});
%}        
        t=t+1;
    end
	%title(num2str(num_grain));
end

num_grain_new=t-1;
mean_area = mean(features(:,7));
features(:,4:5) = features(:,4:5) / mean_area;
features(:,7) = features(:,7) / mean_area;

t=1;

features_new=bsxfun(@minus,features,mean(X_tr_s));
features_final=bsxfun(@rdivide, features_new, std(X_tr_s));
[label,score] = predict(model,features_final);

%uncomment these two for randm forest classifier
% label = cell2mat(label);
% label = str2num(label);


purarea=0;
totarea=0;



for num_grain=1:cc.NumObjects
    
    if grain_areas(num_grain) > 500
        totarea = totarea+grain_areas(num_grain);
        if label(t) == 0
            purarea=purarea+grain_areas(num_grain);
            rectangle('Position',int32(graindata(num_grain).BoundingBox),'EdgeColor','b');
        else
            rectangle('Position',int32(graindata(num_grain).BoundingBox),'EdgeColor','r');
        end
        %{
        subplot(25,20,t);
        h=imshow(segmented_grain{t});
%}        
        t=t+1;
    end
	%title(num2str(num_grain));
end

disp('Purity: ');
disp(purarea/totarea);
%for num_grain