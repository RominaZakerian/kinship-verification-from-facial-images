
clc;
clear all;
close all;

fs=matfile('C:\Users\Romina\Documents\MATLAB\LBP\meta_data\fs_pairs.mat');

info_fs = whos(fs);
size_fs=info_fs.size(1)

Label_Fs=[];
kin_fs=0;
notkin_fs=0;
kin_pairs_fs=[];
notkin_pairs_fs=[];
matfile1=[];
matfile2=[];
matfile3=[];
matfile4=[];
matfile5=[];
LBP_fs_mat1=[];
HOG_fs_mat1=[];

LBP_fs_mat2=[];
HOG_fs_mat2=[];

LBP_fs_mat3=[];
HOG_fs_mat3=[];

LBP_fs_mat4=[];
HOG_fs_mat4=[];

LBP_fs_mat5=[];
HOG_fs_mat5=[];

feature1=[];
feature2=[];
feature3=[];
feature4=[];
feature5=[];

label1=[];
label2=[];
label3=[];
label4=[];
label5=[];

true_label=[];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for k=1:size_fs
    %%%%%%%%%%Labels%%%%%%%%%
    
    firstcol = fs.pairs(k,2);
    im1=cell2mat(firstcol);
    Label_Fs=[Label_Fs,im1];
    if (im1==1)
        kin_fs=kin_fs+1;
        kin_pairs_fs=[kin_pairs_fs;fs.pairs(k,3),fs.pairs(k,4),im1];
    else
        notkin_fs=notkin_fs+1;
        notkin_pairs_fs=[notkin_pairs_fs;fs.pairs(k,3),fs.pairs(k,4),im1];
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%
end

%%%%%%%%%%%%%%%%matfile1%%%%%%%%%%%%%
for k=1:31
    
    matfile1=[matfile1;kin_pairs_fs(k,:)];
    
end

for k=1:31
    
    matfile1=[matfile1;notkin_pairs_fs(k,:)];
    
end
%%%%%%%%%%%%%%%matfile2%%%%%%%%%%%

for k=1:31
    
    matfile2=[matfile2;kin_pairs_fs(k+25,:)];
    
end

for k=1:31
    
    matfile2=[matfile2;notkin_pairs_fs(k+26,:)];
    
end

%%%%%%%%%%%%%%%matfile3%%%%%%%%%%%

for k=1:31
    
    matfile3=[matfile3;kin_pairs_fs(k+50,:)];
    
end

for k=1:31
    
    matfile3=[matfile3;notkin_pairs_fs(k+52,:)];
    
end

%%%%%%%%%%%%%%%matfile4%%%%%%%%%%%

for k=1:31
    
    matfile4=[matfile4;kin_pairs_fs(k+76,:)];
    
end

for k=1:32
    
    matfile4=[matfile4;notkin_pairs_fs(k+77,:)];
    
end

%%%%%%%%%%%%%%%matfile5%%%%%%%%%%%

for k=1:32
    
    matfile5=[matfile5;kin_pairs_fs(k+102,:)];
    
end

for k=1:31
    
    matfile5=[matfile5;notkin_pairs_fs(k+102,:)];
    
end


for k=1:62
    HOG_all_fs=[];
    LBP_all_fs=[];
    HOG_Fs=[];
    LBP_Fs=[];
    HOG_S1=[];
    LBP_S1=[];
    
%     ind = ceil(rand * size(kin_pairs_fd,1))
%     p(1)
    mrow = matfile1(k,:)
    thirdcol = mrow(3);
    im2=cell2mat(thirdcol);
    label1=[label1;im2];
    
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
            LBP_Fs=[LBP_Fs;L];
            HOG_Fs=[HOG_Fs;featureVector];
        end
    end
    
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
            LBP_S1=[LBP_S1;L];
            HOG_S1=[HOG_S1;featureVector];
        end
    end 
    size(LBP_S1);
    LBP_all_fs=[LBP_all_fs;LBP_Fs];
    LBP_all_fs=[LBP_all_fs;LBP_S1];
    LBP_fs_mat1(:,:,k)=LBP_all_fs;
    
    HOG_all_fs=[HOG_all_fs;HOG_Fs];
    HOG_all_fs=[HOG_all_fs;HOG_S1];
    HOG_fs_mat1(:,:,k)=HOG_all_fs;
end

for k=1:62
    HOG_all_fs=[];
    LBP_all_fs=[];
    HOG_Fs=[];
    LBP_Fs=[];
    HOG_S1=[];
    LBP_S1=[];
    
%     ind = ceil(rand * size(kin_pairs_fd,1))
%     p(1)
    mrow = matfile2(k,:)
    thirdcol = mrow(3);
    im2=cell2mat(thirdcol);
    label2=[label2;im2];
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
            LBP_Fs=[LBP_Fs;L];
            HOG_Fs=[HOG_Fs;featureVector];
        end
    end
    
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
            LBP_S1=[LBP_S1;L];
            HOG_S1=[HOG_S1;featureVector];
        end
    end 
    size(LBP_S1);
    LBP_all_fs=[LBP_all_fs;LBP_Fs];
    LBP_all_fs=[LBP_all_fs;LBP_S1];
    LBP_fs_mat2(:,:,k)=LBP_all_fs;
    
    HOG_all_fs=[HOG_all_fs;HOG_Fs];
    HOG_all_fs=[HOG_all_fs;HOG_S1];
    HOG_fs_mat2(:,:,k)=HOG_all_fs;
end

for k=1:62
    HOG_all_fs=[];
    LBP_all_fs=[];
    HOG_Fs=[];
    LBP_Fs=[];
    HOG_S1=[];
    LBP_S1=[];
    
%     ind = ceil(rand * size(kin_pairs_fd,1))
%     p(1)
    mrow = matfile3(k,:)
    thirdcol = mrow(3);
    im2=cell2mat(thirdcol);
    label3=[label3;im2];
    
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
            LBP_Fs=[LBP_Fs;L];
            HOG_Fs=[HOG_Fs;featureVector];
        end
    end
    
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
            LBP_S1=[LBP_S1;L];
            HOG_S1=[HOG_S1;featureVector];
        end
    end 
    size(LBP_S1);
    LBP_all_fs=[LBP_all_fs;LBP_Fs];
    LBP_all_fs=[LBP_all_fs;LBP_S1];
    LBP_fs_mat3(:,:,k)=LBP_all_fs;
    
    HOG_all_fs=[HOG_all_fs;HOG_Fs];
    HOG_all_fs=[HOG_all_fs;HOG_S1];
    HOG_fs_mat3(:,:,k)=HOG_all_fs;
end

for k=1:63
    HOG_all_fs=[];
    LBP_all_fs=[];
    HOG_Fs=[];
    LBP_Fs=[];
    HOG_S1=[];
    LBP_S1=[];
    
%     ind = ceil(rand * size(kin_pairs_fd,1))
%     p(1)
    mrow = matfile4(k,:)
    thirdcol = mrow(3);
    im2=cell2mat(thirdcol);
    label4=[label4;im2];
    
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
            LBP_Fs=[LBP_Fs;L];
            HOG_Fs=[HOG_Fs;featureVector];
        end
    end
    
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
            LBP_S1=[LBP_S1;L];
            HOG_S1=[HOG_S1;featureVector];
        end
    end 
    size(LBP_S1);
    LBP_all_fs=[LBP_all_fs;LBP_Fs];
    LBP_all_fs=[LBP_all_fs;LBP_S1];
    LBP_fs_mat4(:,:,k)=LBP_all_fs;
    
    HOG_all_fs=[HOG_all_fs;HOG_Fs];
    HOG_all_fs=[HOG_all_fs;HOG_S1];
    HOG_fs_mat4(:,:,k)=HOG_all_fs;
end

for k=1:63
    HOG_all_fs=[];
    LBP_all_fs=[];
    HOG_Fs=[];
    LBP_Fs=[];
    HOG_S1=[];
    LBP_S1=[];
    
%     ind = ceil(rand * size(kin_pairs_fd,1))
%     p(1)
    mrow = matfile5(k,:)
    thirdcol = mrow(3);
    im2=cell2mat(thirdcol);
    label5=[label5;im2];
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
            LBP_Fs=[LBP_Fs;L];
            HOG_Fs=[HOG_Fs;featureVector];
        end
    end
    
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
            LBP_S1=[LBP_S1;L];
            HOG_S1=[HOG_S1;featureVector];
        end
    end 
    size(LBP_S1);
    LBP_all_fs=[LBP_all_fs;LBP_Fs];
    LBP_all_fs=[LBP_all_fs;LBP_S1];
    LBP_fs_mat5(:,:,k)=LBP_all_fs;
    
    HOG_all_fs=[HOG_all_fs;HOG_Fs];
    HOG_all_fs=[HOG_all_fs;HOG_S1];
    HOG_fs_mat5(:,:,k)=HOG_all_fs;
end

LBP_fs_mat1=reshape(LBP_fs_mat1,1,30208,62);
LBP_fs_mat1=reshape(LBP_fs_mat1,30208,62);
LBP_fs_mat1=LBP_fs_mat1';
% size(LBP_kin_fd_label)

HOG_fs_mat1=reshape(HOG_fs_mat1,1,18432,62);
HOG_fs_mat1=reshape(HOG_fs_mat1,18432,62);
HOG_fs_mat1=HOG_fs_mat1';

feature1=[LBP_fs_mat1,HOG_fs_mat1];

%%%%%%%%%mat2%%%%%%%%%

LBP_fs_mat2=reshape(LBP_fs_mat2,1,30208,62);
LBP_fs_mat2=reshape(LBP_fs_mat2,30208,62);
LBP_fs_mat2=LBP_fs_mat2';
% size(LBP_kin_fd_label)

HOG_fs_mat2=reshape(HOG_fs_mat2,1,18432,62);
HOG_fs_mat2=reshape(HOG_fs_mat2,18432,62);
HOG_fs_mat2=HOG_fs_mat2';

feature2=[LBP_fs_mat2,HOG_fs_mat2];

%%%%%%%%%%%%%%%%mat3%%%%%%%%%%%%%%%%%%

LBP_fs_mat3=reshape(LBP_fs_mat3,1,30208,62);
LBP_fs_mat3=reshape(LBP_fs_mat3,30208,62);
LBP_fs_mat3=LBP_fs_mat3';
% size(LBP_kin_fd_label)

HOG_fs_mat3=reshape(HOG_fs_mat3,1,18432,62);
HOG_fs_mat3=reshape(HOG_fs_mat3,18432,62);
HOG_fs_mat3=HOG_fs_mat3';

feature3=[LBP_fs_mat3,HOG_fs_mat3];

%%%%%%%%%%%%%%%%%mat4%%%%%%%%%%%%%%%%%%%

LBP_fs_mat4=reshape(LBP_fs_mat4,1,30208,63);
LBP_fs_mat4=reshape(LBP_fs_mat4,30208,63);
LBP_fs_mat4=LBP_fs_mat4';
% size(LBP_kin_fd_label)

HOG_fs_mat4=reshape(HOG_fs_mat4,1,18432,63);
HOG_fs_mat4=reshape(HOG_fs_mat4,18432,63);
HOG_fs_mat4=HOG_fs_mat4';

feature4=[LBP_fs_mat4,HOG_fs_mat4];

%%%%%%%%%%%%%%%%%%%%%mat5%%%%%%%%%%%%%

LBP_fs_mat5=reshape(LBP_fs_mat5,1,30208,63);
LBP_fs_mat5=reshape(LBP_fs_mat5,30208,63);
LBP_fs_mat5=LBP_fs_mat5';
% size(LBP_kin_fd_label)

HOG_fs_mat5=reshape(HOG_fs_mat5,1,18432,63);
HOG_fs_mat5=reshape(HOG_fs_mat5,18432,63);
HOG_fs_mat5=HOG_fs_mat5';

feature5=[LBP_fs_mat5,HOG_fs_mat5];


trainmat1=[feature1;feature2;feature3;feature4];
testmat1=feature5;
labelmat1=[label1;label2;label3;label4];
testlabel1=label5;

trainmat2=[feature1;feature2;feature3;feature5];
testmat2=feature4;
labelmat2=[label1;label2;label3;label5];
testlabel2=label4;

trainmat3=[feature1;feature2;feature4;feature5];
testmat3=feature3;
labelmat3=[label1;label2;label4;label5];
testlabel3=label3;

trainmat4=[feature1;feature3;feature4;feature5];
testmat4=feature2;
labelmat4=[label1;label3;label4;label5];
testlabel4=label2;

trainmat5=[feature2;feature3;feature4;feature5];
testmat5=feature1;
labelmat5=[label2;label3;label4;label5];
testlabel5=label1;

svmstruct=fitcsvm(trainmat1,labelmat1,'KernelFunction', 'gaussian')

% 
Group = predict(svmstruct,testmat1)
%
counter=0;
for i=1:size(testlabel1)
    if testlabel1(i)==Group(i)
        counter=counter+1;
    end
end
x=size(Group,1);
rate1=counter/x

%%%%%%%%%%%train2%%%%%%%%%%%%%%%%

svmstruct=fitcsvm(trainmat2,labelmat2,'KernelFunction', 'gaussian')

% 
Group = predict(svmstruct,testmat2)
%
counter=0;
for i=1:size(testlabel2)
    if testlabel2(i)==Group(i)
        counter=counter+1;
    end
end
x=size(Group,1);
rate2=counter/x

%%%%%%%%%%%%%%%%%%%%train3%%%%%%%%%%%%%

svmstruct=fitcsvm(trainmat3,labelmat3,'KernelFunction', 'gaussian')

% 
Group = predict(svmstruct,testmat3)
%
counter=0;
for i=1:size(testlabel3)
    if testlabel3(i)==Group(i)
        counter=counter+1;
    end
end
x=size(Group,1);
rate3=counter/x

%%%%%%%%%%%%%%%%%train4%%%%%%%%%%%%%%%

svmstruct=fitcsvm(trainmat4,labelmat4,'KernelFunction', 'gaussian')

% 
Group = predict(svmstruct,testmat4)
%
counter=0;
for i=1:size(testlabel4)
    if testlabel4(i)==Group(i)
        counter=counter+1;
    end
end
x=size(Group,1);
rate4=counter/x

%%%%%%%%%%%%%%%train5%%%%%%%%%%%%%%%

svmstruct=fitcsvm(trainmat5,labelmat5,'KernelFunction', 'gaussian')

% 
Group = predict(svmstruct,testmat5)
%
counter=0;
for i=1:size(testlabel5)
    if testlabel5(i)==Group(i)
        counter=counter+1;
    end
end
x=size(Group,1);
rate5=counter/x


rate_all=0;
rate_all=(rate1+rate2+rate3+rate4+rate5)/5



