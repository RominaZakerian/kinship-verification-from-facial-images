
clc;
clear all;
close all;

fd=matfile('C:\Users\Romina\Documents\MATLAB\LBP\meta_data\fd_pairs.mat');
%%%%%%%%fd_size%%%%%
info_fd = whos(fd);
size_fd=info_fd.size(1)
%%%%%%%%fs_size%%%%%%%
LBP_Fd=[];
HOG_Fd=[];
LBP_D1=[];
HOG_D1=[];


LBP_MS=[];
HOG_MS=[];
LBP_S2=[];
HOG_S2=[];

LBP_all_fd=[];
LBP_all_fs=[];

LBP_all_ms=[];

HOG_kin_fd_label=[];
HOG_notkin_fd_label=[];

LBP_kin_fd_label=[];
LBP_kin_ms_label=[];


LBP_notkin_fd_label=[];
LBP_notkin_md_label=[];
LBP_notkin_ms_label=[];


Label_Fd=[];

Label_Ms=[];

kin_pairs_fd=[];
notkin_pairs_fd=[];


kin_pairs_ms=[];
notkin_pairs_ms=[];

train_mat=[];
LBP_test=[];

LBP_test1=[];
LBP_test1=[];
counter=0;
kin_fd=0;
notkin_fd=0;



kin_ms=0;
notkin_ms=0;

kin_fs=0;
notkin_fs=0;

feature_kin=[];
feature_notkin=[];

label=[];
true_label=[];

for j=1:93
    
    label=[label;1]
end

for j=1:94
    label=[label;0]
end


for k=1:size_fd
    
    firstcol = fd.pairs(k,2);
    im1=cell2mat(firstcol);
    Label_Fd=[Label_Fd,im1];
    if (im1==1)
        kin_fd=kin_fd+1;
        kin_pairs_fd=[kin_pairs_fd;fd.pairs(k,3),fd.pairs(k,4),im1];
    else
        notkin_fd=notkin_fd+1;
        notkin_pairs_fd=[notkin_pairs_fd;fd.pairs(k,3),fd.pairs(k,4),im1];
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%
end
 
%
%%%%%%%%%%%%%%%%%%%%%kin_pairs_fd%%%%%%%%%%%%%%%%5
test1=[];
p=randperm(size(kin_pairs_fd,1),93)

for i=1:size(kin_pairs_fd,1)
    if ismember(i,p)==false
        test1=[test1,i];
    end
end

for k=1:93
    HOG_all_fd=[];
    LBP_all_fd=[];
    HOG_Fd=[];
    LBP_Fd=[];
    HOG_D1=[];
    LBP_D1=[];
    
%     ind = ceil(rand * size(kin_pairs_fd,1))
%     p(1)
    mrow = kin_pairs_fd(p(k),:)
    
    
    %%%%%%%%%%%%% father picture %%%%%%%%%%%%
    firstcol = mrow(1);
    im1=cell2mat(firstcol);
    c1=imread(im1);
    c1 = rgb2gray(c1);
    [m1 , n1]=size(c1);
    imshow(im1)
%     pause(0.5)
    count=0;
    c1 = im2double(c1);
    Blocks = cell(m1/4,n1/4);
    counti = 0;
    for i = 1:4:m1-3
        counti = counti + 1;
        countj = 0;
        for j = 1:4:n1-3
            countj = countj + 1;
            Blocks{counti,countj} = c1(i:i+3,j:j+3);
            L = extractLBPFeatures(Blocks{counti,countj}, 'Normalization' , 'none');
            [featureVector,hogVisualization] = extractHOGFeatures(Blocks{counti,countj},'CellSize',[2 2]);
            count=count+1;
            LBP_Fd=[LBP_Fd;L];
            HOG_Fd=[HOG_Fd;featureVector];
        end
    end
    
    
%     Blocks{1,1}
%     size(Blocks{4,4});
    %imshow(Blocks{4,4})
    
    %%%%%%%%%%%%% daughter picture %%%%%%%%%%%%
    seconedcol = mrow(2);
    im2=cell2mat(seconedcol);
    c2=imread(im2);
    c2 = rgb2gray(c2);
    [m2 , n2]=size(c2);
    imshow(im2)
%     pause(0.5)
    count=0;
    c2 = im2double(c2);
    Blocks = cell(m2/4,n2/4);
    counti = 0;
    for i = 1:4:m2-3
        counti = counti + 1;
        countj = 0;
        for j = 1:4:n2-3
            countj = countj + 1;
            Blocks{counti,countj} = c2(i:i+3,j:j+3);
            L = extractLBPFeatures(Blocks{counti,countj}, 'Normalization' , 'none');
            [featureVector,hogVisualization] = extractHOGFeatures(Blocks{counti,countj},'CellSize',[2 2]);
            count=count+1;
            LBP_D1=[LBP_D1;L];
            HOG_D1=[HOG_D1;featureVector];
        end
    end 
    size(LBP_D1);
    LBP_all_fd=[LBP_all_fd;LBP_Fd];
    LBP_all_fd=[LBP_all_fd;LBP_D1];
    LBP_kin_fd_label(:,:,k)=LBP_all_fd;
    
    HOG_all_fd=[HOG_all_fd;HOG_Fd];
    HOG_all_fd=[HOG_all_fd;HOG_D1];
    HOG_kin_fd_label(:,:,k)=HOG_all_fd;
end



%%%%%%%%%%%%%%%%notkin_pairs_fd%%%%%%%%%%%%%%%%%
p=randperm(size(notkin_pairs_fd,1),94)

for i=1:size(notkin_pairs_fd,1)
    if ismember(i,p)==false
        test1=[test1,i];
    end
end



for k=1:94
    HOG_all_fd=[];
    LBP_all_fd=[];
    HOG_Fd=[];
    LBP_Fd=[];
    HOG_D1=[];
    LBP_D1=[];
    
%     ind = ceil(rand * size(kin_pairs_fd,1))
%     
    mrow = notkin_pairs_fd(p(k),:)
    
    %%%%%%%%%%%%% father picture %%%%%%%%%%%%
    firstcol = mrow(1);
    im1=cell2mat(firstcol);
    c1=imread(im1);
    c1 = rgb2gray(c1);
    [m1 , n1]=size(c1);
    imshow(im1)
%     pause(0.5)
    count=0;
    c1 = im2double(c1);
    Blocks = cell(m1/4,n1/4);
    counti = 0;
    for i = 1:4:m1-3
        counti = counti + 1;
        countj = 0;
        for j = 1:4:n1-3
            countj = countj + 1;
            Blocks{counti,countj} = c1(i:i+3,j:j+3);
            L = extractLBPFeatures(Blocks{counti,countj}, 'Normalization' , 'none');
            [featureVector,hogVisualization] = extractHOGFeatures(Blocks{counti,countj},'CellSize',[2 2]);
            count=count+1;
            LBP_Fd=[LBP_Fd;L];
            HOG_Fd=[HOG_Fd;featureVector];
        end
    end
    
%     Blocks{1,1}
%     size(Blocks{4,4});
    %imshow(Blocks{4,4})
    
    %%%%%%%%%%%%% daughter picture %%%%%%%%%%%%
    seconedcol = mrow(2);
    im2=cell2mat(seconedcol);
    c2=imread(im2);
    c2 = rgb2gray(c2);
    [m2 , n2]=size(c2);
    imshow(im2)
%     pause(0.5)
    count=0;
    c2 = im2double(c2);
    Blocks = cell(m2/4,n2/4);
    counti = 0;
    for i = 1:4:m2-3
        counti = counti + 1;
        countj = 0;
        for j = 1:4:n2-3
            countj = countj + 1;
            Blocks{counti,countj} = c2(i:i+3,j:j+3);
            L = extractLBPFeatures(Blocks{counti,countj}, 'Normalization' , 'none');
            [featureVector,hogVisualization] = extractHOGFeatures(Blocks{counti,countj},'CellSize',[2 2]);
            count=count+1;
            LBP_D1=[LBP_D1;L];
            HOG_D1=[HOG_D1;featureVector];
        end
    end 
    size(LBP_D1);
    LBP_all_fd=[LBP_all_fd;LBP_Fd];
    LBP_all_fd=[LBP_all_fd;LBP_D1];
    LBP_notkin_fd_label(:,:,k)=LBP_all_fd;
    
    HOG_all_fd=[HOG_all_fd;HOG_Fd];
    HOG_all_fd=[HOG_all_fd;HOG_D1];
    HOG_notkin_fd_label(:,:,k)=HOG_all_fd;
end

LBP_kin_fd_label=reshape(LBP_kin_fd_label,1,30208,93);
LBP_kin_fd_label=reshape(LBP_kin_fd_label,30208,93);
LBP_kin_fd_label=LBP_kin_fd_label';
% size(LBP_kin_fd_label)

HOG_kin_fd_label=reshape(HOG_kin_fd_label,1,18432,93);
HOG_kin_fd_label=reshape(HOG_kin_fd_label,18432,93);
HOG_kin_fd_label=HOG_kin_fd_label';

feature_kin=[LBP_kin_fd_label,HOG_kin_fd_label];

LBP_notkin_fd_label=reshape(LBP_notkin_fd_label,1,30208,94);
LBP_notkin_fd_label=reshape(LBP_notkin_fd_label,30208,94);
LBP_notkin_fd_label=LBP_notkin_fd_label';

HOG_notkin_fd_label=reshape(HOG_notkin_fd_label,1,18432,94);
HOG_notkin_fd_label=reshape(HOG_notkin_fd_label,18432,94);
HOG_notkin_fd_label=HOG_notkin_fd_label';

feature_notkin=[LBP_notkin_fd_label,HOG_notkin_fd_label];

train_mat=[feature_kin;feature_notkin];

%%%%%%%%%%%%%%%%%%test_matrix%%%%%%%%%%%%%%%%%%

for k=1:41
    LBP_test1_fd=[];
    HOG_test1_fd=[];
    HOG_Fd=[];
    HOG_D1=[];
    LBP_test1=[];
    LBP_test2=[];
    true_label=[true_label;1];
    
%     ind = ceil(rand * size(kin_pairs_fd,1))
%     
    mrow = kin_pairs_fd(test1(k),:)
    
    %%%%%%%%%%%%% father picture %%%%%%%%%%%%
    firstcol = mrow(1);
    im1=cell2mat(firstcol);
    c1=imread(im1);
    c1 = rgb2gray(c1);
    [m1 , n1]=size(c1);
    count=0;
    c1 = im2double(c1);
    Blocks = cell(m1/4,n1/4);
    counti = 0;
    for i = 1:4:m1-3
        counti = counti + 1;
        countj = 0;
        for j = 1:4:n1-3
            countj = countj + 1;
            Blocks{counti,countj} = c1(i:i+3,j:j+3);
            L = extractLBPFeatures(Blocks{counti,countj}, 'Normalization' , 'none');
            [featureVector,hogVisualization] = extractHOGFeatures(Blocks{counti,countj},'cellsize',[2 2]);
            count=count+1;
            LBP_test1=[LBP_test1;L];
            HOG_Fd=[HOG_Fd;featureVector];
        end
    end
    
%     Blocks{1,1}
%     size(Blocks{4,4});
    %imshow(Blocks{4,4})
    
    %%%%%%%%%%%%% daughter picture %%%%%%%%%%%%
    seconedcol = mrow(2);
    im2=cell2mat(seconedcol);
    c2=imread(im2);
    c2 = rgb2gray(c2);
    [m2 , n2]=size(c2);
    
    count=0;
    c2 = im2double(c2);
    Blocks = cell(m2/4,n2/4);
    counti = 0;
    for i = 1:4:m2-3
        counti = counti + 1;
        countj = 0;
        for j = 1:4:n2-3
            countj = countj + 1;
            Blocks{counti,countj} = c2(i:i+3,j:j+3);
            L = extractLBPFeatures(Blocks{counti,countj}, 'Normalization' , 'none');
            [featureVector,hogVisualization] = extractHOGFeatures(Blocks{counti,countj},'cellsize',[2 2]);
            count=count+1;
            LBP_test2=[LBP_test2;L];
            HOG_D1=[HOG_D1;featureVector];
        end
    end 
    HOG_test1_fd=[HOG_test1_fd;HOG_Fd];
    HOG_test1_fd=[HOG_test1_fd;HOG_D1];
    HOG_test_kin(:,:,k)=HOG_test1_fd;
    
    LBP_test1_fd=[LBP_test1_fd;LBP_test1];
    LBP_test1_fd=[LBP_test1_fd;LBP_test2];
    LBP_test_kin(:,:,k)=LBP_test1_fd;
end


for k=1:40
    LBP_test2_fd=[];
    HOG_test2_fd=[];
    HOG_Fd=[];
    HOG_D1=[];
    LBP_test1=[];
    LBP_test2=[];
    true_label=[true_label;0];
    
%     ind = ceil(rand * size(kin_pairs_fd,1))
%     
    mrow = notkin_pairs_fd(test1(k),:)
    
    %%%%%%%%%%%%% father picture %%%%%%%%%%%%
    firstcol = mrow(1);
    im1=cell2mat(firstcol);
    c1=imread(im1);
    c1 = rgb2gray(c1);
    [m1 , n1]=size(c1);
    count=0;
    c1 = im2double(c1);
    Blocks = cell(m1/4,n1/4);
    counti = 0;
    for i = 1:4:m1-3
        counti = counti + 1;
        countj = 0;
        for j = 1:4:n1-3
            countj = countj + 1;
            Blocks{counti,countj} = c1(i:i+3,j:j+3);
            L = extractLBPFeatures(Blocks{counti,countj}, 'Normalization' , 'none');
            [featureVector,hogVisualization] = extractHOGFeatures(Blocks{counti,countj},'cellsize',[2 2]);
            count=count+1;
            LBP_test1=[LBP_test1;L];
            HOG_Fd=[HOG_Fd;featureVector];
        end
    end
    
%     Blocks{1,1}
%     size(Blocks{4,4});
    %imshow(Blocks{4,4})
    
    %%%%%%%%%%%%% daughter picture %%%%%%%%%%%%
    seconedcol = mrow(2);
    im2=cell2mat(seconedcol);
    c2=imread(im2);
    c2 = rgb2gray(c2);
    [m2 , n2]=size(c2);
    count=0;
    c2 = im2double(c2);
    Blocks = cell(m2/4,n2/4);
    counti = 0;
    for i = 1:4:m2-3
        counti = counti + 1;
        countj = 0;
        for j = 1:4:n2-3
            countj = countj + 1;
            Blocks{counti,countj} = c2(i:i+3,j:j+3);
            L = extractLBPFeatures(Blocks{counti,countj}, 'Normalization' , 'none');
            [featureVector,hogVisualization] = extractHOGFeatures(Blocks{counti,countj},'cellsize',[2 2]);
            count=count+1;
            LBP_test2=[LBP_test2;L];
            HOG_D1=[HOG_D1;featureVector];
        end
    end 
    
    HOG_test2_fd=[HOG_test2_fd;HOG_Fd];
    HOG_test2_fd=[HOG_test2_fd;HOG_D1];
    HOG_test_notkin(:,:,k)=HOG_test2_fd;
    
    LBP_test2_fd=[LBP_test2_fd;LBP_test1];
    LBP_test2_fd=[LBP_test2_fd;LBP_test2];
    LBP_test_notkin(:,:,k)=LBP_test2_fd;
end

HOG_test_kin=reshape(HOG_test_kin,1,18432,41);
HOG_test_kin=reshape(HOG_test_kin,18432,41);
HOG_test_kin=HOG_test_kin';

LBP_test_kin=reshape(LBP_test_kin,1,30208,41);
LBP_test_kin=reshape(LBP_test_kin,30208,41);
LBP_test_kin=LBP_test_kin';

HOG_test_notkin=reshape(HOG_test_notkin,1,18432,40);
HOG_test_notkin=reshape(HOG_test_notkin,18432,40);
HOG_test_notkin=HOG_test_notkin';

LBP_test_notkin=reshape(LBP_test_notkin,1,30208,40);
LBP_test_notkin=reshape(LBP_test_notkin,30208,40);
LBP_test_notkin=LBP_test_notkin';


feature_test=[LBP_test_kin,HOG_test_kin;LBP_test_notkin,HOG_test_notkin];
%%%%%%%%%%%%%%%train_svm%%%%%%%%%%%%%%%
options.MaxIter = 100000;
svmstruct=fitcsvm(train_mat,label);

true_label

Group = predict(svmstruct,feature_test)

for i=1:size(true_label)
    if true_label(i)==Group(i)
        counter=counter+1;
    end
end
x=size(Group,1);
rate=counter/x

        








