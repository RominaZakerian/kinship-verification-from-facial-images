
clc;
clear all;
close all;

fs=matfile('C:\Users\Romina\Documents\MATLAB\LBP\meta_data\fs_pairs.mat');

info_fs = whos(fs);
size_fs=info_fs.size(1)

channel1=[];
channel2=[];
channel3=[];

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

dist1_1=[];
dist1_2=[];
dist1_3=[];

dist2_1=[];
dist2_2=[];
dist2_3=[];

dist3_1=[];
dist3_2=[];
dist3_3=[];

dist4_1=[];
dist4_2=[];
dist4_3=[];

dist5_1=[];
dist5_2=[];
dist5_3=[];

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
%     HOG_Fs=[];
%     LBP_Fs=[];
%     HOG_S1=[];
%     LBP_S1=[];
    x=[];
    LBP_Fs_c1=[];
    LBP_Fs_c2=[];
    LBP_Fs_c3=[];

    LBP_S1_c1=[];
    LBP_S1_c2=[];
    LBP_S1_c3=[];
%     Dmean=0;
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
%     c1 = rgb2gray(c1);
%     [m1 , n1]=size(c1);
    imshow(im1)
%     pause(0.5)
    count=0;
    c1 = im2double(c1);
    [m1 , n1 , p1]=size(c1);
    [s1 ,s2]=size(c1(:,:,1));
    [s3 ,s4]=size(c1(:,:,2));
    [s5 ,s6]=size(c1(:,:,3));
    
    channel1=c1(:,:,1);
    channel2=c1(:,:,2);
    channel3=c1(:,:,3);
    
    
%     pause(0.5)
    count=0;
    c1 = im2double(c1);
    Blocks1 = cell(s1/4,s2/4 );
    Blocks2 = cell(s3/4,s4/4 );
    Blocks3 = cell(s5/4,s6/4 );
    
   %%%%%%%%%%%%%%%%%%channel1%%%%%%%%%%%%%%%    
    counti = 0;
    for i = 1:4:s1-3
        counti = counti + 1;
        countj = 0;
        for j = 1:4:s2-3
            countj = countj + 1;
            Blocks1{counti,countj} = channel1(i:i+3,j:j+3);
            L = extractLBPFeatures(Blocks1{counti,countj}, 'Normalization' , 'none');
            [featureVector,hogVisualization] = extractHOGFeatures(Blocks1{counti,countj},'CellSize',[2 2]);
            count=count+1;
            LBP_Fs_c1=[LBP_Fs_c1;L];
%             HOG_Fd=[HOG_Fd;featureVector];
        end
    end
%%%%%%%%%%%%%%%%channel2%%%%%%%%%%%%%%%
    counti = 0;
    %     for k=1:3
        for i = 1:4:s3-3
            counti = counti + 1;
            countj = 0;
            for j = 1:4:s4-3
                countj = countj + 1;
                Blocks2{counti,countj} = channel2(i:i+3,j:j+3);
                L = extractLBPFeatures(Blocks2{counti,countj}, 'Normalization' , 'none');
                [featureVector,hogVisualization] = extractHOGFeatures(Blocks2{counti,countj},'CellSize',[2 2]);
                count=count+1;
                LBP_Fs_c2=[LBP_Fs_c2;L];
%                 HOG_Fd=[HOG_Fd;featureVector];
            end
        end
    %%%%%%%%%%channel3%%%%%%%%%%%%%%%%%%%%%%%%%
    counti = 0;
%     for k=1:3
    for i = 1:4:s5-3
        counti = counti + 1;
        countj = 0;
        for j = 1:4:s6-3
            countj = countj + 1;
            Blocks3{counti,countj} = channel3(i:i+3,j:j+3);
            L = extractLBPFeatures(Blocks3{counti,countj}, 'Normalization' , 'none');
            [featureVector,hogVisualization] = extractHOGFeatures(Blocks3{counti,countj},'CellSize',[2 2]);
            count=count+1;
            LBP_Fs_c3=[LBP_Fs_c3;L];
%             HOG_Fd=[HOG_Fd;featureVector];
        end
    end
    
    
%%%%%%%%%%%%%%%%%%%%% son picture %%%%%%%%%%%%
    seconedcol = mrow(2);
    im2=cell2mat(seconedcol);
    c2=imread(im2);
%     c2 = rgb2gray(c2);
    [m2 , n2 , p2]=size(c2);
    [s1 ,s2]=size(c2(:,:,1));
    [s3 ,s4]=size(c2(:,:,2));
    [s5 ,s6]=size(c2(:,:,3));
    
    channel1=c2(:,:,1);
    channel2=c2(:,:,2);
    channel3=c2(:,:,3);
    imshow(im2)
%     pause(0.5)
    count=0;
    c2 = im2double(c2);
    
    Blocks1 = cell(s1/4,s2/4 );
    Blocks2 = cell(s3/4,s4/4 );
    Blocks3 = cell(s5/4,s6/4 );
%%%%%%%%%%%%%%%%%%%%channel1%%%%%%%%%%%%%%%%%
    counti = 0;
    for i = 1:4:s1-3
        counti = counti + 1;
        countj = 0;
        for j = 1:4:s2-3
            countj = countj + 1;
            Blocks1{counti,countj} = channel1(i:i+3,j:j+3);
            L = extractLBPFeatures(Blocks1{counti,countj}, 'Normalization' , 'none');
            [featureVector,hogVisualization] = extractHOGFeatures(Blocks1{counti,countj},'CellSize',[2 2]);
            count=count+1;
            LBP_S1_c1=[LBP_S1_c1;L];
%             HOG_D1=[HOG_D1;featureVector];
        end
    end 
    
    %%%%%%%%%%%%%%%%channel2%%%%%%%%%%%%%%%
    counti = 0;
    %     for k=1:3
        for i = 1:4:s3-3
            counti = counti + 1;
            countj = 0;
            for j = 1:4:s4-3
                countj = countj + 1;
                Blocks2{counti,countj} = channel2(i:i+3,j:j+3);
                L = extractLBPFeatures(Blocks2{counti,countj}, 'Normalization' , 'none');
                [featureVector,hogVisualization] = extractHOGFeatures(Blocks2{counti,countj},'CellSize',[2 2]);
                count=count+1;
                LBP_S1_c2=[LBP_S1_c2;L];
%                 HOG_Fd=[HOG_Fd;featureVector];
            end
        end
%%%%%%%%%%%%%%%%%channel3%%%%%%%%%%%%%%%%%%%%%%%%%
    counti = 0;
%     for k=1:3
    for i = 1:4:s5-3
        counti = counti + 1;
        countj = 0;
        for j = 1:4:s6-3
            countj = countj + 1;
            Blocks3{counti,countj} = channel3(i:i+3,j:j+3);
            L = extractLBPFeatures(Blocks3{counti,countj}, 'Normalization' , 'none');
            [featureVector,hogVisualization] = extractHOGFeatures(Blocks3{counti,countj},'CellSize',[2 2]);
            count=count+1;
            LBP_S1_c3=[LBP_S1_c3;L];
%             HOG_Fd=[HOG_Fd;featureVector];
        end
    end
    

    x1=pdist2(LBP_Fs_c1,LBP_S1_c1,'chisq');
    x2=pdist2(LBP_Fs_c2,LBP_S1_c2,'chisq');
    x3=pdist2(LBP_Fs_c3,LBP_S1_c3,'chisq');
    
    x1=reshape(x1,1,[]);
    x2=reshape(x2,1,[]);
    x3=reshape(x3,1,[]);
%     Dmean = mean(x(:));

    dist1_1=[dist1_1;x1];
    dist1_2=[dist1_2;x2];
    dist1_3=[dist1_3;x3];
    
%     LBP_all_fs=[LBP_all_fs;LBP_Fs];
%     LBP_all_fs=[LBP_all_fs;LBP_S1];
%     LBP_fs_mat1(:,:,k)=LBP_all_fs;
%     
%     HOG_all_fs=[HOG_all_fs;HOG_Fs];
%     HOG_all_fs=[HOG_all_fs;HOG_S1];
%     HOG_fs_mat1(:,:,k)=HOG_all_fs;
end

for k=1:62
    HOG_all_fs=[];
    LBP_all_fs=[];
%     HOG_Fs=[];
%     LBP_Fs=[];
%     HOG_S1=[];
%     LBP_S1=[];
    x=[];
    LBP_Fs_c1=[];
    LBP_Fs_c2=[];
    LBP_Fs_c3=[];

    LBP_S1_c1=[];
    LBP_S1_c2=[];
    LBP_S1_c3=[];
%     Dmean=0;
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
%     c1 = rgb2gray(c1);
%     [m1 , n1]=size(c1);
    imshow(im1)
%     pause(0.5)
    count=0;
    c1 = im2double(c1);
    [m1 , n1 , p1]=size(c1);
    [s1 ,s2]=size(c1(:,:,1));
    [s3 ,s4]=size(c1(:,:,2));
    [s5 ,s6]=size(c1(:,:,3));
    
    channel1=c1(:,:,1);
    channel2=c1(:,:,2);
    channel3=c1(:,:,3);
    
    
%     pause(0.5)
    count=0;
    c1 = im2double(c1);
    Blocks1 = cell(s1/4,s2/4 );
    Blocks2 = cell(s3/4,s4/4 );
    Blocks3 = cell(s5/4,s6/4 );
    
   %%%%%%%%%%%%%%%%%%channel1%%%%%%%%%%%%%%%    
    counti = 0;
    for i = 1:4:s1-3
        counti = counti + 1;
        countj = 0;
        for j = 1:4:s2-3
            countj = countj + 1;
            Blocks1{counti,countj} = channel1(i:i+3,j:j+3);
            L = extractLBPFeatures(Blocks1{counti,countj}, 'Normalization' , 'none');
            [featureVector,hogVisualization] = extractHOGFeatures(Blocks1{counti,countj},'CellSize',[2 2]);
            count=count+1;
            LBP_Fs_c1=[LBP_Fs_c1;L];
%             HOG_Fd=[HOG_Fd;featureVector];
        end
    end
%%%%%%%%%%%%%%%%channel2%%%%%%%%%%%%%%%
    counti = 0;
    %     for k=1:3
        for i = 1:4:s3-3
            counti = counti + 1;
            countj = 0;
            for j = 1:4:s4-3
                countj = countj + 1;
                Blocks2{counti,countj} = channel2(i:i+3,j:j+3);
                L = extractLBPFeatures(Blocks2{counti,countj}, 'Normalization' , 'none');
                [featureVector,hogVisualization] = extractHOGFeatures(Blocks2{counti,countj},'CellSize',[2 2]);
                count=count+1;
                LBP_Fs_c2=[LBP_Fs_c2;L];
%                 HOG_Fd=[HOG_Fd;featureVector];
            end
        end
    %%%%%%%%%%channel3%%%%%%%%%%%%%%%%%%%%%%%%%
    counti = 0;
%     for k=1:3
    for i = 1:4:s5-3
        counti = counti + 1;
        countj = 0;
        for j = 1:4:s6-3
            countj = countj + 1;
            Blocks3{counti,countj} = channel3(i:i+3,j:j+3);
            L = extractLBPFeatures(Blocks3{counti,countj}, 'Normalization' , 'none');
            [featureVector,hogVisualization] = extractHOGFeatures(Blocks3{counti,countj},'CellSize',[2 2]);
            count=count+1;
            LBP_Fs_c3=[LBP_Fs_c3;L];
%             HOG_Fd=[HOG_Fd;featureVector];
        end
    end
    
    
%%%%%%%%%%%%%%%%%%%%% son picture %%%%%%%%%%%%
    seconedcol = mrow(2);
    im2=cell2mat(seconedcol);
    c2=imread(im2);
%     c2 = rgb2gray(c2);
    [m2 , n2 , p2]=size(c2);
    [s1 ,s2]=size(c2(:,:,1));
    [s3 ,s4]=size(c2(:,:,2));
    [s5 ,s6]=size(c2(:,:,3));
    
    channel1=c2(:,:,1);
    channel2=c2(:,:,2);
    channel3=c2(:,:,3);
    imshow(im2)
%     pause(0.5)
    count=0;
    c2 = im2double(c2);
    
    Blocks1 = cell(s1/4,s2/4 );
    Blocks2 = cell(s3/4,s4/4 );
    Blocks3 = cell(s5/4,s6/4 );
%%%%%%%%%%%%%%%%%%%%channel1%%%%%%%%%%%%%%%%%
    counti = 0;
    for i = 1:4:s1-3
        counti = counti + 1;
        countj = 0;
        for j = 1:4:s2-3
            countj = countj + 1;
            Blocks1{counti,countj} = channel1(i:i+3,j:j+3);
            L = extractLBPFeatures(Blocks1{counti,countj}, 'Normalization' , 'none');
            [featureVector,hogVisualization] = extractHOGFeatures(Blocks1{counti,countj},'CellSize',[2 2]);
            count=count+1;
            LBP_S1_c1=[LBP_S1_c1;L];
%             HOG_D1=[HOG_D1;featureVector];
        end
    end 
    
    %%%%%%%%%%%%%%%%channel2%%%%%%%%%%%%%%%
    counti = 0;
    %     for k=1:3
        for i = 1:4:s3-3
            counti = counti + 1;
            countj = 0;
            for j = 1:4:s4-3
                countj = countj + 1;
                Blocks2{counti,countj} = channel2(i:i+3,j:j+3);
                L = extractLBPFeatures(Blocks2{counti,countj}, 'Normalization' , 'none');
                [featureVector,hogVisualization] = extractHOGFeatures(Blocks2{counti,countj},'CellSize',[2 2]);
                count=count+1;
                LBP_S1_c2=[LBP_S1_c2;L];
%                 HOG_Fd=[HOG_Fd;featureVector];
            end
        end
%%%%%%%%%%%%%%%%%channel3%%%%%%%%%%%%%%%%%%%%%%%%%
    counti = 0;
%     for k=1:3
    for i = 1:4:s5-3
        counti = counti + 1;
        countj = 0;
        for j = 1:4:s6-3
            countj = countj + 1;
            Blocks3{counti,countj} = channel3(i:i+3,j:j+3);
            L = extractLBPFeatures(Blocks3{counti,countj}, 'Normalization' , 'none');
            [featureVector,hogVisualization] = extractHOGFeatures(Blocks3{counti,countj},'CellSize',[2 2]);
            count=count+1;
            LBP_S1_c3=[LBP_S1_c3;L];
%             HOG_Fd=[HOG_Fd;featureVector];
        end
    end
    

    x1=pdist2(LBP_Fs_c1,LBP_S1_c1,'chisq');
    x2=pdist2(LBP_Fs_c2,LBP_S1_c2,'chisq');
    x3=pdist2(LBP_Fs_c3,LBP_S1_c3,'chisq');
    
    x1=reshape(x1,1,[]);
    x2=reshape(x2,1,[]);
    x3=reshape(x3,1,[]);
%     Dmean = mean(x(:));

    dist2_1=[dist2_1;x1];
    dist2_2=[dist2_2;x2];
    dist2_3=[dist2_3;x3];
   
%     LBP_all_fs=[LBP_all_fs;LBP_Fs];
%     LBP_all_fs=[LBP_all_fs;LBP_S1];
%     LBP_fs_mat2(:,:,k)=LBP_all_fs;
%     
%     HOG_all_fs=[HOG_all_fs;HOG_Fs];
%     HOG_all_fs=[HOG_all_fs;HOG_S1];
%     HOG_fs_mat2(:,:,k)=HOG_all_fs;
end

for k=1:62
    HOG_all_fs=[];
    LBP_all_fs=[];
%     HOG_Fs=[];
%     LBP_Fs=[];
%     HOG_S1=[];
%     LBP_S1=[];
    x=[];
    LBP_Fs_c1=[];
    LBP_Fs_c2=[];
    LBP_Fs_c3=[];

    LBP_S1_c1=[];
    LBP_S1_c2=[];
    LBP_S1_c3=[];
%     Dmean=0;
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
%     c1 = rgb2gray(c1);
%     [m1 , n1]=size(c1);
    imshow(im1)
%     pause(0.5)
    count=0;
    c1 = im2double(c1);
    [m1 , n1 , p1]=size(c1);
    [s1 ,s2]=size(c1(:,:,1));
    [s3 ,s4]=size(c1(:,:,2));
    [s5 ,s6]=size(c1(:,:,3));
    
    channel1=c1(:,:,1);
    channel2=c1(:,:,2);
    channel3=c1(:,:,3);
    
    
%     pause(0.5)
    count=0;
    c1 = im2double(c1);
    Blocks1 = cell(s1/4,s2/4 );
    Blocks2 = cell(s3/4,s4/4 );
    Blocks3 = cell(s5/4,s6/4 );
    
   %%%%%%%%%%%%%%%%%%channel1%%%%%%%%%%%%%%%    
    counti = 0;
    for i = 1:4:s1-3
        counti = counti + 1;
        countj = 0;
        for j = 1:4:s2-3
            countj = countj + 1;
            Blocks1{counti,countj} = channel1(i:i+3,j:j+3);
            L = extractLBPFeatures(Blocks1{counti,countj}, 'Normalization' , 'none');
            [featureVector,hogVisualization] = extractHOGFeatures(Blocks1{counti,countj},'CellSize',[2 2]);
            count=count+1;
            LBP_Fs_c1=[LBP_Fs_c1;L];
%             HOG_Fd=[HOG_Fd;featureVector];
        end
    end
%%%%%%%%%%%%%%%%channel2%%%%%%%%%%%%%%%
    counti = 0;
    %     for k=1:3
        for i = 1:4:s3-3
            counti = counti + 1;
            countj = 0;
            for j = 1:4:s4-3
                countj = countj + 1;
                Blocks2{counti,countj} = channel2(i:i+3,j:j+3);
                L = extractLBPFeatures(Blocks2{counti,countj}, 'Normalization' , 'none');
                [featureVector,hogVisualization] = extractHOGFeatures(Blocks2{counti,countj},'CellSize',[2 2]);
                count=count+1;
                LBP_Fs_c2=[LBP_Fs_c2;L];
%                 HOG_Fd=[HOG_Fd;featureVector];
            end
        end
    %%%%%%%%%%channel3%%%%%%%%%%%%%%%%%%%%%%%%%
    counti = 0;
%     for k=1:3
    for i = 1:4:s5-3
        counti = counti + 1;
        countj = 0;
        for j = 1:4:s6-3
            countj = countj + 1;
            Blocks3{counti,countj} = channel3(i:i+3,j:j+3);
            L = extractLBPFeatures(Blocks3{counti,countj}, 'Normalization' , 'none');
            [featureVector,hogVisualization] = extractHOGFeatures(Blocks3{counti,countj},'CellSize',[2 2]);
            count=count+1;
            LBP_Fs_c3=[LBP_Fs_c3;L];
%             HOG_Fd=[HOG_Fd;featureVector];
        end
    end
    
    
%%%%%%%%%%%%%%%%%%%%% son picture %%%%%%%%%%%%
    seconedcol = mrow(2);
    im2=cell2mat(seconedcol);
    c2=imread(im2);
%     c2 = rgb2gray(c2);
    [m2 , n2 , p2]=size(c2);
    [s1 ,s2]=size(c2(:,:,1));
    [s3 ,s4]=size(c2(:,:,2));
    [s5 ,s6]=size(c2(:,:,3));
    
    channel1=c2(:,:,1);
    channel2=c2(:,:,2);
    channel3=c2(:,:,3);
    imshow(im2)
%     pause(0.5)
    count=0;
    c2 = im2double(c2);
    
    Blocks1 = cell(s1/4,s2/4 );
    Blocks2 = cell(s3/4,s4/4 );
    Blocks3 = cell(s5/4,s6/4 );
%%%%%%%%%%%%%%%%%%%%channel1%%%%%%%%%%%%%%%%%
    counti = 0;
    for i = 1:4:s1-3
        counti = counti + 1;
        countj = 0;
        for j = 1:4:s2-3
            countj = countj + 1;
            Blocks1{counti,countj} = channel1(i:i+3,j:j+3);
            L = extractLBPFeatures(Blocks1{counti,countj}, 'Normalization' , 'none');
            [featureVector,hogVisualization] = extractHOGFeatures(Blocks1{counti,countj},'CellSize',[2 2]);
            count=count+1;
            LBP_S1_c1=[LBP_S1_c1;L];
%             HOG_D1=[HOG_D1;featureVector];
        end
    end 
    
    %%%%%%%%%%%%%%%%channel2%%%%%%%%%%%%%%%
    counti = 0;
    %     for k=1:3
        for i = 1:4:s3-3
            counti = counti + 1;
            countj = 0;
            for j = 1:4:s4-3
                countj = countj + 1;
                Blocks2{counti,countj} = channel2(i:i+3,j:j+3);
                L = extractLBPFeatures(Blocks2{counti,countj}, 'Normalization' , 'none');
                [featureVector,hogVisualization] = extractHOGFeatures(Blocks2{counti,countj},'CellSize',[2 2]);
                count=count+1;
                LBP_S1_c2=[LBP_S1_c2;L];
%                 HOG_Fd=[HOG_Fd;featureVector];
            end
        end
%%%%%%%%%%%%%%%%%channel3%%%%%%%%%%%%%%%%%%%%%%%%%
    counti = 0;
%     for k=1:3
    for i = 1:4:s5-3
        counti = counti + 1;
        countj = 0;
        for j = 1:4:s6-3
            countj = countj + 1;
            Blocks3{counti,countj} = channel3(i:i+3,j:j+3);
            L = extractLBPFeatures(Blocks3{counti,countj}, 'Normalization' , 'none');
            [featureVector,hogVisualization] = extractHOGFeatures(Blocks3{counti,countj},'CellSize',[2 2]);
            count=count+1;
            LBP_S1_c3=[LBP_S1_c3;L];
%             HOG_Fd=[HOG_Fd;featureVector];
        end
    end
    

    x1=pdist2(LBP_Fs_c1,LBP_S1_c1,'chisq');
    x2=pdist2(LBP_Fs_c2,LBP_S1_c2,'chisq');
    x3=pdist2(LBP_Fs_c3,LBP_S1_c3,'chisq');
    
    x1=reshape(x1,1,[]);
    x2=reshape(x2,1,[]);
    x3=reshape(x3,1,[]);
%     Dmean = mean(x(:));

    dist3_1=[dist3_1;x1];
    dist3_2=[dist3_2;x2];
    dist3_3=[dist3_3;x3];
   
%     LBP_all_fs=[LBP_all_fs;LBP_Fs];
%     LBP_all_fs=[LBP_all_fs;LBP_S1];
%     LBP_fs_mat3(:,:,k)=LBP_all_fs;
%     
%     HOG_all_fs=[HOG_all_fs;HOG_Fs];
%     HOG_all_fs=[HOG_all_fs;HOG_S1];
%     HOG_fs_mat3(:,:,k)=HOG_all_fs;
end

for k=1:63
    HOG_all_fs=[];
    LBP_all_fs=[];
%     HOG_Fs=[];
%     LBP_Fs=[];
%     HOG_S1=[];
%     LBP_S1=[];
    x=[];
    LBP_Fs_c1=[];
    LBP_Fs_c2=[];
    LBP_Fs_c3=[];

    LBP_S1_c1=[];
    LBP_S1_c2=[];
    LBP_S1_c3=[];
%     Dmean=0;
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
%     c1 = rgb2gray(c1);
%     [m1 , n1]=size(c1);
    imshow(im1)
%     pause(0.5)
    count=0;
    c1 = im2double(c1);
    [m1 , n1 , p1]=size(c1);
    [s1 ,s2]=size(c1(:,:,1));
    [s3 ,s4]=size(c1(:,:,2));
    [s5 ,s6]=size(c1(:,:,3));
    
    channel1=c1(:,:,1);
    channel2=c1(:,:,2);
    channel3=c1(:,:,3);
    
    
%     pause(0.5)
    count=0;
    c1 = im2double(c1);
    Blocks1 = cell(s1/4,s2/4 );
    Blocks2 = cell(s3/4,s4/4 );
    Blocks3 = cell(s5/4,s6/4 );
    
   %%%%%%%%%%%%%%%%%%channel1%%%%%%%%%%%%%%%    
    counti = 0;
    for i = 1:4:s1-3
        counti = counti + 1;
        countj = 0;
        for j = 1:4:s2-3
            countj = countj + 1;
            Blocks1{counti,countj} = channel1(i:i+3,j:j+3);
            L = extractLBPFeatures(Blocks1{counti,countj}, 'Normalization' , 'none');
            [featureVector,hogVisualization] = extractHOGFeatures(Blocks1{counti,countj},'CellSize',[2 2]);
            count=count+1;
            LBP_Fs_c1=[LBP_Fs_c1;L];
%             HOG_Fd=[HOG_Fd;featureVector];
        end
    end
%%%%%%%%%%%%%%%%channel2%%%%%%%%%%%%%%%
    counti = 0;
    %     for k=1:3
        for i = 1:4:s3-3
            counti = counti + 1;
            countj = 0;
            for j = 1:4:s4-3
                countj = countj + 1;
                Blocks2{counti,countj} = channel2(i:i+3,j:j+3);
                L = extractLBPFeatures(Blocks2{counti,countj}, 'Normalization' , 'none');
                [featureVector,hogVisualization] = extractHOGFeatures(Blocks2{counti,countj},'CellSize',[2 2]);
                count=count+1;
                LBP_Fs_c2=[LBP_Fs_c2;L];
%                 HOG_Fd=[HOG_Fd;featureVector];
            end
        end
    %%%%%%%%%%channel3%%%%%%%%%%%%%%%%%%%%%%%%%
    counti = 0;
%     for k=1:3
    for i = 1:4:s5-3
        counti = counti + 1;
        countj = 0;
        for j = 1:4:s6-3
            countj = countj + 1;
            Blocks3{counti,countj} = channel3(i:i+3,j:j+3);
            L = extractLBPFeatures(Blocks3{counti,countj}, 'Normalization' , 'none');
            [featureVector,hogVisualization] = extractHOGFeatures(Blocks3{counti,countj},'CellSize',[2 2]);
            count=count+1;
            LBP_Fs_c3=[LBP_Fs_c3;L];
%             HOG_Fd=[HOG_Fd;featureVector];
        end
    end
    
    
%%%%%%%%%%%%%%%%%%%%% son picture %%%%%%%%%%%%
    seconedcol = mrow(2);
    im2=cell2mat(seconedcol);
    c2=imread(im2);
%     c2 = rgb2gray(c2);
    [m2 , n2 , p2]=size(c2);
    [s1 ,s2]=size(c2(:,:,1));
    [s3 ,s4]=size(c2(:,:,2));
    [s5 ,s6]=size(c2(:,:,3));
    
    channel1=c2(:,:,1);
    channel2=c2(:,:,2);
    channel3=c2(:,:,3);
    imshow(im2)
%     pause(0.5)
    count=0;
    c2 = im2double(c2);
    
    Blocks1 = cell(s1/4,s2/4 );
    Blocks2 = cell(s3/4,s4/4 );
    Blocks3 = cell(s5/4,s6/4 );
%%%%%%%%%%%%%%%%%%%%channel1%%%%%%%%%%%%%%%%%
    counti = 0;
    for i = 1:4:s1-3
        counti = counti + 1;
        countj = 0;
        for j = 1:4:s2-3
            countj = countj + 1;
            Blocks1{counti,countj} = channel1(i:i+3,j:j+3);
            L = extractLBPFeatures(Blocks1{counti,countj}, 'Normalization' , 'none');
            [featureVector,hogVisualization] = extractHOGFeatures(Blocks1{counti,countj},'CellSize',[2 2]);
            count=count+1;
            LBP_S1_c1=[LBP_S1_c1;L];
%             HOG_D1=[HOG_D1;featureVector];
        end
    end 
    
    %%%%%%%%%%%%%%%%channel2%%%%%%%%%%%%%%%
    counti = 0;
    %     for k=1:3
        for i = 1:4:s3-3
            counti = counti + 1;
            countj = 0;
            for j = 1:4:s4-3
                countj = countj + 1;
                Blocks2{counti,countj} = channel2(i:i+3,j:j+3);
                L = extractLBPFeatures(Blocks2{counti,countj}, 'Normalization' , 'none');
                [featureVector,hogVisualization] = extractHOGFeatures(Blocks2{counti,countj},'CellSize',[2 2]);
                count=count+1;
                LBP_S1_c2=[LBP_S1_c2;L];
%                 HOG_Fd=[HOG_Fd;featureVector];
            end
        end
%%%%%%%%%%%%%%%%%channel3%%%%%%%%%%%%%%%%%%%%%%%%%
    counti = 0;
%     for k=1:3
    for i = 1:4:s5-3
        counti = counti + 1;
        countj = 0;
        for j = 1:4:s6-3
            countj = countj + 1;
            Blocks3{counti,countj} = channel3(i:i+3,j:j+3);
            L = extractLBPFeatures(Blocks3{counti,countj}, 'Normalization' , 'none');
            [featureVector,hogVisualization] = extractHOGFeatures(Blocks3{counti,countj},'CellSize',[2 2]);
            count=count+1;
            LBP_S1_c3=[LBP_S1_c3;L];
%             HOG_Fd=[HOG_Fd;featureVector];
        end
    end
    

    x1=pdist2(LBP_Fs_c1,LBP_S1_c1,'chisq');
    x2=pdist2(LBP_Fs_c2,LBP_S1_c2,'chisq');
    x3=pdist2(LBP_Fs_c3,LBP_S1_c3,'chisq');
    
    x1=reshape(x1,1,[]);
    x2=reshape(x2,1,[]);
    x3=reshape(x3,1,[]);
%     Dmean = mean(x(:));

    dist4_1=[dist4_1;x1];
    dist4_2=[dist4_2;x2];
    dist4_3=[dist4_3;x3];
    
%     LBP_all_fs=[LBP_all_fs;LBP_Fs];
%     LBP_all_fs=[LBP_all_fs;LBP_S1];
%     LBP_fs_mat4(:,:,k)=LBP_all_fs;
%     
%     HOG_all_fs=[HOG_all_fs;HOG_Fs];
%     HOG_all_fs=[HOG_all_fs;HOG_S1];
%     HOG_fs_mat4(:,:,k)=HOG_all_fs;
end

for k=1:63
    HOG_all_fs=[];
    LBP_all_fs=[];
%     HOG_Fs=[];
%     LBP_Fs=[];
%     HOG_S1=[];
%     LBP_S1=[];
    x=[];
    LBP_Fs_c1=[];
    LBP_Fs_c2=[];
    LBP_Fs_c3=[];

    LBP_S1_c1=[];
    LBP_S1_c2=[];
    LBP_S1_c3=[];
%     Dmean=0;
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
%     c1 = rgb2gray(c1);
%     [m1 , n1]=size(c1);
    imshow(im1)
%     pause(0.5)
    count=0;
    c1 = im2double(c1);
    [m1 , n1 , p1]=size(c1);
    [s1 ,s2]=size(c1(:,:,1));
    [s3 ,s4]=size(c1(:,:,2));
    [s5 ,s6]=size(c1(:,:,3));
    
    channel1=c1(:,:,1);
    channel2=c1(:,:,2);
    channel3=c1(:,:,3);
    
    
%     pause(0.5)
    count=0;
    c1 = im2double(c1);
    Blocks1 = cell(s1/4,s2/4 );
    Blocks2 = cell(s3/4,s4/4 );
    Blocks3 = cell(s5/4,s6/4 );
    
   %%%%%%%%%%%%%%%%%%channel1%%%%%%%%%%%%%%%    
    counti = 0;
    for i = 1:4:s1-3
        counti = counti + 1;
        countj = 0;
        for j = 1:4:s2-3
            countj = countj + 1;
            Blocks1{counti,countj} = channel1(i:i+3,j:j+3);
            L = extractLBPFeatures(Blocks1{counti,countj}, 'Normalization' , 'none');
            [featureVector,hogVisualization] = extractHOGFeatures(Blocks1{counti,countj},'CellSize',[2 2]);
            count=count+1;
            LBP_Fs_c1=[LBP_Fs_c1;L];
%             HOG_Fd=[HOG_Fd;featureVector];
        end
    end
%%%%%%%%%%%%%%%%channel2%%%%%%%%%%%%%%%
    counti = 0;
    %     for k=1:3
        for i = 1:4:s3-3
            counti = counti + 1;
            countj = 0;
            for j = 1:4:s4-3
                countj = countj + 1;
                Blocks2{counti,countj} = channel2(i:i+3,j:j+3);
                L = extractLBPFeatures(Blocks2{counti,countj}, 'Normalization' , 'none');
                [featureVector,hogVisualization] = extractHOGFeatures(Blocks2{counti,countj},'CellSize',[2 2]);
                count=count+1;
                LBP_Fs_c2=[LBP_Fs_c2;L];
%                 HOG_Fd=[HOG_Fd;featureVector];
            end
        end
    %%%%%%%%%%channel3%%%%%%%%%%%%%%%%%%%%%%%%%
    counti = 0;
%     for k=1:3
    for i = 1:4:s5-3
        counti = counti + 1;
        countj = 0;
        for j = 1:4:s6-3
            countj = countj + 1;
            Blocks3{counti,countj} = channel3(i:i+3,j:j+3);
            L = extractLBPFeatures(Blocks3{counti,countj}, 'Normalization' , 'none');
            [featureVector,hogVisualization] = extractHOGFeatures(Blocks3{counti,countj},'CellSize',[2 2]);
            count=count+1;
            LBP_Fs_c3=[LBP_Fs_c3;L];
%             HOG_Fd=[HOG_Fd;featureVector];
        end
    end
    
    
%%%%%%%%%%%%%%%%%%%%% son picture %%%%%%%%%%%%
    seconedcol = mrow(2);
    im2=cell2mat(seconedcol);
    c2=imread(im2);
%     c2 = rgb2gray(c2);
    [m2 , n2 , p2]=size(c2);
    [s1 ,s2]=size(c2(:,:,1));
    [s3 ,s4]=size(c2(:,:,2));
    [s5 ,s6]=size(c2(:,:,3));
    
    channel1=c2(:,:,1);
    channel2=c2(:,:,2);
    channel3=c2(:,:,3);
    imshow(im2)
%     pause(0.5)
    count=0;
    c2 = im2double(c2);
    
    Blocks1 = cell(s1/4,s2/4 );
    Blocks2 = cell(s3/4,s4/4 );
    Blocks3 = cell(s5/4,s6/4 );
%%%%%%%%%%%%%%%%%%%%channel1%%%%%%%%%%%%%%%%%
    counti = 0;
    for i = 1:4:s1-3
        counti = counti + 1;
        countj = 0;
        for j = 1:4:s2-3
            countj = countj + 1;
            Blocks1{counti,countj} = channel1(i:i+3,j:j+3);
            L = extractLBPFeatures(Blocks1{counti,countj}, 'Normalization' , 'none');
            [featureVector,hogVisualization] = extractHOGFeatures(Blocks1{counti,countj},'CellSize',[2 2]);
            count=count+1;
            LBP_S1_c1=[LBP_S1_c1;L];
%             HOG_D1=[HOG_D1;featureVector];
        end
    end 
    
    %%%%%%%%%%%%%%%%channel2%%%%%%%%%%%%%%%
    counti = 0;
    %     for k=1:3
        for i = 1:4:s3-3
            counti = counti + 1;
            countj = 0;
            for j = 1:4:s4-3
                countj = countj + 1;
                Blocks2{counti,countj} = channel2(i:i+3,j:j+3);
                L = extractLBPFeatures(Blocks2{counti,countj}, 'Normalization' , 'none');
                [featureVector,hogVisualization] = extractHOGFeatures(Blocks2{counti,countj},'CellSize',[2 2]);
                count=count+1;
                LBP_S1_c2=[LBP_S1_c2;L];
%                 HOG_Fd=[HOG_Fd;featureVector];
            end
        end
%%%%%%%%%%%%%%%%%channel3%%%%%%%%%%%%%%%%%%%%%%%%%
    counti = 0;
%     for k=1:3
    for i = 1:4:s5-3
        counti = counti + 1;
        countj = 0;
        for j = 1:4:s6-3
            countj = countj + 1;
            Blocks3{counti,countj} = channel3(i:i+3,j:j+3);
            L = extractLBPFeatures(Blocks3{counti,countj}, 'Normalization' , 'none');
            [featureVector,hogVisualization] = extractHOGFeatures(Blocks3{counti,countj},'CellSize',[2 2]);
            count=count+1;
            LBP_S1_c3=[LBP_S1_c3;L];
%             HOG_Fd=[HOG_Fd;featureVector];
        end
    end
    

    x1=pdist2(LBP_Fs_c1,LBP_S1_c1,'chisq');
    x2=pdist2(LBP_Fs_c2,LBP_S1_c2,'chisq');
    x3=pdist2(LBP_Fs_c3,LBP_S1_c3,'chisq');
    
    x1=reshape(x1,1,[]);
    x2=reshape(x2,1,[]);
    x3=reshape(x3,1,[]);
%     Dmean = mean(x(:));

    dist5_1=[dist5_1;x1];
    dist5_2=[dist5_2;x2];
    dist5_3=[dist5_3;x3];
    
%     LBP_all_fs=[LBP_all_fs;LBP_Fs];
%     LBP_all_fs=[LBP_all_fs;LBP_S1];
%     LBP_fs_mat5(:,:,k)=LBP_all_fs;
%     
%     HOG_all_fs=[HOG_all_fs;HOG_Fs];
%     HOG_all_fs=[HOG_all_fs;HOG_S1];
%     HOG_fs_mat5(:,:,k)=HOG_all_fs;
end


trainmat1=[dist1_1,dist1_2,dist1_3;dist2_1,dist2_2,dist2_3;dist3_1,dist3_2,dist3_3;dist4_1,dist4_2,dist4_3];
testmat1=[dist5_1,dist5_2,dist5_3];
labelmat1=[label1;label2;label3;label4];
testlabel1=label5;

trainmat2=[dist1_1,dist1_2,dist1_3;dist2_1,dist2_2,dist2_3;dist3_1,dist3_2,dist3_3;dist5_1,dist5_2,dist5_3];
testmat2=[dist4_1,dist4_2,dist4_3];
labelmat2=[label1;label2;label3;label5];
testlabel2=label4;

trainmat3=[dist1_1,dist1_2,dist1_3;dist2_1,dist2_2,dist2_3;dist4_1,dist4_2,dist4_3;dist5_1,dist5_2,dist5_3];
testmat3=[dist3_1,dist3_2,dist3_3];
labelmat3=[label1;label2;label4;label5];
testlabel3=label3;

trainmat4=[dist1_1,dist1_2,dist1_3;dist3_1,dist3_2,dist3_3;dist4_1,dist4_2,dist4_3;dist5_1,dist5_2,dist5_3];
testmat4=[dist2_1,dist2_2,dist2_3];
labelmat4=[label1;label3;label4;label5];
testlabel4=label2;

trainmat5=[dist2_1,dist2_2,dist2_3;dist3_1,dist3_2,dist3_3;dist4_1,dist4_2,dist4_3;dist5_1,dist5_2,dist5_3];
testmat5=[dist1_1,dist1_2,dist1_3];
labelmat5=[label2;label3;label4;label5];
testlabel5=label1;

svmstruct=fitcsvm(trainmat1,labelmat1)

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


svmstruct=fitcsvm(trainmat2,labelmat2)

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

svmstruct=fitcsvm(trainmat3,labelmat3)

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


svmstruct=fitcsvm(trainmat4,labelmat4)

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

svmstruct=fitcsvm(trainmat5,labelmat5)

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

function D = distChiSq( X, Y )

%%% supposedly it's possible to implement this without a loop!
m = size(X,1);  n = size(Y,1);
mOnes = ones(1,m); D = zeros(m,n);
for i=1:n
  yi = Y(i,:);  yiRep = yi( mOnes, : );
  s = yiRep + X;    d = yiRep - X;
  D(:,i) = sum( d.^2 ./ (s+eps), 2 );
end
D = D/2;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function D = pdist2( X, Y, metric )

if( nargin<3 || isempty(metric) ); metric=0; end;

switch metric
  case {0,'sqeuclidean'}
    D = distEucSq( X, Y );
  case 'euclidean'
    D = sqrt(distEucSq( X, Y ));
  case 'L1'    
    D = distL1( X, Y );
  case 'cosine'
    D = distCosine( X, Y );
  case 'emd'
    D = distEmd( X, Y );
  case 'chisq'
    D = distChiSq( X, Y );
  otherwise
    error(['pdist2 - unknown metric: ' metric]);
end
end



