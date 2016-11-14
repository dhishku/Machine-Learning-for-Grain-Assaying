lsdir = {'fg_good/','fp_good/'};

% for i=1:1:2
%     for j=1:1:14
%         I_orig = imread(strcat(lsdir{i},num2str(j),'.jpg'));
%         I=I_orig(:,:,1);
%         I2 = I_orig(:,:,2);
%         I3 = I_orig(:,:,3);
%         b=I;
%         binary_image=im2bw(b);
%         se = strel('disk', 3);
%         binary_image = imopen(binary_image,se);
%         imwrite(binary_image, strcat(lsdir{i},num2str(j),'_b.jpg'));
%     end
% end


%binary_image = bwareaopen(binary_image,5000);
%----------------------------------------------------------------------------------------------------

X_fp = [];
X_fg = [];

t_fp = 1;
t_fg = 1;

for i=1:1:2
    for j=1:1:14

disp([i j]);

        I_orig = imread(strcat(lsdir{i},num2str(j),'.jpg'));

        
        I=I_orig(:,:,1);
        I2 = I_orig(:,:,2);
        I3 = I_orig(:,:,3);
binary_image = imread(strcat(lsdir{i},num2str(j),'_b.jpg'));

        se = strel('disk', 3);
        binary_image = imopen(binary_image,se);

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

% X_fg = features;
% Y_fg = linspace(0,0,num_grain_new).';
length=size(features,1);
disp(length);

if i==1
    X_fg(t_fg:t_fg+length-1,:) = features;
    t_fg = t_fg+length
    disp(size(X_fg));
else
    X_fp(t_fp:t_fp+length-1,:) = features;
    t_fp = t_fp+length
    disp(size(X_fp));
end
disp('done...');
    end
end

l_fg = linspace(0,0,size(X_fg,1)).';
l_fp = linspace(1,1,size(X_fp,1)).';

save('X_fg.mat','X_fg');
save('X_fp.mat','X_fp');
save('l_fg.mat','l_fg');
save('l_fp.mat','l_fp');
