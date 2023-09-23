
clc;
clear all;
close all;

ms=matfile('C:\Users\Romina\Documents\MATLAB\LBP\meta_data\ms_pairs.mat');

info_ms = whos(ms);
size_ms=info_ms.size(1)

LBP_Ms=[];
HOG_Ms=[];
LBP_S2=[];
HOG_S2=[];

LBP_all_ms=[];

LBP_kin_ms_label=[];
Label_Ms=[];

kin_pairs_ms=[];
notkin_pairs_ms=[];

true_label=[];

counter=0;

kin_ms=0;
notkin_ms=0;

feature_kin=[];
feature_notkin=[];

label=[];

for j=1:81
    
    label=[label;1]
end

for j=1:81
    label=[label;0]
end


for k=1:size_ms
    %%%%%%%%%%Labels%%%%%%%%%
    
    firstcol = ms.pairs(k,2);
    im1=cell2mat(firstcol);
    Label_Ms=[Label_Ms,im1];
    if (im1==1)
        kin_ms=kin_ms+1;
        kin_pairs_ms=[kin_pairs_ms;ms.pairs(k,3),ms.pairs(k,4),im1];
    else
        notkin_ms=notkin_ms+1;
        notkin_pairs_ms=[notkin_pairs_ms;ms.pairs(k,3),ms.pairs(k,4),im1];
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%
end


%%%%%%%%%%%%%%%%%%%%%kin_pairs_md%%%%%%%%%%%%%%%%5
test1=[];

p=randperm(size(kin_pairs_ms,1),81)

for i=1:size(kin_pairs_ms,1)
    if ismember(i,p)==false
        test1=[test1,i];
    end
end

for k=1:81
    HOG_all_ms=[];
    LBP_all_ms=[];
    HOG_Ms=[];
    LBP_Ms=[];
    HOG_S2=[];
    LBP_S2=[];
    
    mrow = kin_pairs_ms(p(k),:)
    
%%%%%%%%%%%%%%%%%%mother_picture%%%%%%%%%%%%%%%%%%%    
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
            LBP_Ms=[LBP_Ms;L];
            HOG_Ms=[HOG_Ms;featureVector];
        end
    end
% %     Blocks{1,1}
% %     size(Blocks{4,4});
%     %imshow(Blocks{4,4})
%     
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
            LBP_S2=[LBP_S2;L];
            HOG_S2=[HOG_S2;featureVector];
        end
    end
    
    LBP_all_ms=[LBP_all_ms;LBP_Ms];
    LBP_all_ms=[LBP_all_ms;LBP_S2];
    LBP_kin_ms_label(:,:,k)=LBP_all_ms;
    
    HOG_all_ms=[HOG_all_ms;HOG_Ms];
    HOG_all_ms=[HOG_all_ms;HOG_S2];
    HOG_kin_ms_label(:,:,k)=HOG_all_ms;

end

%%%%%%%%%%%%%%%%%%%%%notkin_pairs_md%%%%%%%%%%%%%%%%5

p=randperm(size(notkin_pairs_ms,1),81)

for i=1:size(notkin_pairs_ms,1)
    if ismember(i,p)==false
        test1=[test1,i];
    end
end

for k=1:81
    HOG_all_ms=[];
    LBP_all_ms=[];
    HOG_Ms=[];
    LBP_Ms=[];
    HOG_S2=[];
    LBP_S2=[];
    
    mrow = notkin_pairs_ms(p(k),:)
    
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
            LBP_Ms=[LBP_Ms;L];
            HOG_Ms=[HOG_Ms;featureVector];
        end
    end
% %     Blocks{1,1}
% %     size(Blocks{4,4});
%     %imshow(Blocks{4,4})
%     
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
            LBP_S2=[LBP_S2;L];
            HOG_S2=[HOG_S2;featureVector];
        end
    end
    
    LBP_all_ms=[LBP_all_ms;LBP_Ms];
    LBP_all_ms=[LBP_all_ms;LBP_S2];
    LBP_notkin_ms_label(:,:,k)=LBP_all_ms;

    HOG_all_ms=[HOG_all_ms;HOG_Ms];
    HOG_all_ms=[HOG_all_ms;HOG_S2];
    HOG_notkin_ms_label(:,:,k)=HOG_all_ms;
end

LBP_kin_ms_label=reshape(LBP_kin_ms_label,1,30208,81);
LBP_kin_ms_label=reshape(LBP_kin_ms_label,30208,81);
LBP_kin_ms_label=LBP_kin_ms_label';
% size(LBP_kin_fd_label)

HOG_kin_ms_label=reshape(HOG_kin_ms_label,1,18432,81);
HOG_kin_ms_label=reshape(HOG_kin_ms_label,18432,81);
HOG_kin_ms_label=HOG_kin_ms_label';

feature_kin=[LBP_kin_ms_label,HOG_kin_ms_label];

LBP_notkin_ms_label=reshape(LBP_notkin_ms_label,1,30208,81);
LBP_notkin_ms_label=reshape(LBP_notkin_ms_label,30208,81);
LBP_notkin_ms_label=LBP_notkin_ms_label';

HOG_notkin_ms_label=reshape(HOG_notkin_ms_label,1,18432,81);
HOG_notkin_ms_label=reshape(HOG_notkin_ms_label,18432,81);
HOG_notkin_ms_label=HOG_notkin_ms_label';


feature_notkin=[LBP_notkin_ms_label,HOG_notkin_ms_label];

train_mat=[feature_kin;feature_notkin]; 


for k=1:35
    LBP_test1_ms=[];
    HOG_test1_ms=[];
    HOG_MS=[];
    HOG_S2=[];
    LBP_test1=[];
    LBP_test2=[];
    true_label=[true_label;1];
    
%     ind = ceil(rand * size(kin_pairs_fd,1))
%     
    mrow = kin_pairs_ms(test1(k),:)
    
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
            HOG_MS=[HOG_MS;featureVector];
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
            LBP_test2=[LBP_test2;L];
            HOG_S2=[HOG_S2;featureVector];
        end
    end 
    HOG_test1_ms=[HOG_test1_ms;HOG_MS];
    HOG_test1_ms=[HOG_test1_ms;HOG_S2];
    HOG_test_kin(:,:,k)=HOG_test1_ms;
    
    LBP_test1_ms=[LBP_test1_ms;LBP_test1];
    LBP_test1_ms=[LBP_test1_ms;LBP_test2];
    LBP_test_kin(:,:,k)=LBP_test1_ms;
end


for k=1:35
    LBP_test2_ms=[];
    HOG_test2_ms=[];
    HOG_MS=[];
    HOG_S2=[];
    LBP_test1=[];
    LBP_test2=[];
    true_label=[true_label;0];
    
%     ind = ceil(rand * size(kin_pairs_fd,1))
%     
    mrow = notkin_pairs_ms(test1(k),:)
    
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
            HOG_MS=[HOG_MS;featureVector];
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
            LBP_test2=[LBP_test2;L];
            HOG_S2=[HOG_S2;featureVector];
        end
    end 
    
    HOG_test2_ms=[HOG_test2_ms;HOG_MS];
    HOG_test2_ms=[HOG_test2_ms;HOG_S2];
    HOG_test_notkin(:,:,k)=HOG_test2_ms;
    
    LBP_test2_ms=[LBP_test2_ms;LBP_test1];
    LBP_test2_ms=[LBP_test2_ms;LBP_test2];
    LBP_test_notkin(:,:,k)=LBP_test2_ms;
end

HOG_test_kin=reshape(HOG_test_kin,1,18432,35);
HOG_test_kin=reshape(HOG_test_kin,18432,35);
HOG_test_kin=HOG_test_kin';

LBP_test_kin=reshape(LBP_test_kin,1,30208,35);
LBP_test_kin=reshape(LBP_test_kin,30208,35);
LBP_test_kin=LBP_test_kin';

HOG_test_notkin=reshape(HOG_test_notkin,1,18432,35);
HOG_test_notkin=reshape(HOG_test_notkin,18432,35);
HOG_test_notkin=HOG_test_notkin';

LBP_test_notkin=reshape(LBP_test_notkin,1,30208,35);
LBP_test_notkin=reshape(LBP_test_notkin,30208,35);
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

