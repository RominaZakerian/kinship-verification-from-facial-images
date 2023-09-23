clc;
clear all;
close all;

fd=matfile('C:\Users\Romina\Documents\MATLAB\LBP\meta_data\fd_pairs.mat');

info_fd = whos(fd);
size_fd=info_fd.size(1)

channel1=[];
channel2=[];
channel3=[];

Label_Fd=[];
kin_fd=0;
notkin_fd=0;
kin_pairs_fd=[];
notkin_pairs_fd=[];
matfile1=[];
matfile2=[];
matfile3=[];
matfile4=[];
matfile5=[];
LBP_fd_mat1=[];
HOG_fd_mat1=[];

LBP_fd_mat2=[];
HOG_fd_mat2=[];

LBP_fd_mat3=[];
HOG_fd_mat3=[];

LBP_fd_mat4=[];
HOG_fd_mat4=[];

LBP_fd_mat5=[];
HOG_fd_mat5=[];

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

mean_Fd=[];
mean_D1=[];

svm_mean1=[];
svm_mean2=[];
svm_mean3=[];
svm_mean4=[];
svm_mean5=[];

true_label=[];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for k=1:size_fd
    %%%%%%%%%%Labels%%%%%%%%%
    
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

%%%%%%%%%%%%%%%%matfile1%%%%%%%%%%%%%
for k=1:27
    
    matfile1=[matfile1;kin_pairs_fd(k,:)];
    
end

for k=1:27
    
    matfile1=[matfile1;notkin_pairs_fd(k,:)];
    
end
%%%%%%%%%%%%%%%matfile2%%%%%%%%%%%

for k=1:27
    
    matfile2=[matfile2;kin_pairs_fd(k+27,:)];
    
end

for k=1:27
    
    matfile2=[matfile2;notkin_pairs_fd(k+27,:)];
    
end

%%%%%%%%%%%%%%%matfile3%%%%%%%%%%%

for k=1:27
    
    matfile3=[matfile3;kin_pairs_fd(k+54,:)];
    
end

for k=1:27
    
    matfile3=[matfile3;notkin_pairs_fd(k+54,:)];
    
end

%%%%%%%%%%%%%%%matfile4%%%%%%%%%%%

for k=1:27
    
    matfile4=[matfile4;kin_pairs_fd(k+81,:)];
    
end

for k=1:26
    
    matfile4=[matfile4;notkin_pairs_fd(k+81,:)];
    
end

%%%%%%%%%%%%%%%matfile5%%%%%%%%%%%

for k=1:26
    
    matfile5=[matfile5;kin_pairs_fd(k+108,:)];
    
end

for k=1:27
    
    matfile5=[matfile5;notkin_pairs_fd(k+107,:)];
    
end


for k=1:54
%     mean_all=[];
%     mean_Fd=[];
%     mean_D1=[];
%     HOG_all_fd=[];
    LBP_all_fd=[];
%     HOG_Fd=[];
%     HOG_D1=[];
    LBP_Fd_c1=[];
    LBP_Fd_c2=[];
    LBP_Fd_c3=[];

    LBP_D1_c1=[];
    LBP_D1_c2=[];
    LBP_D1_c3=[];
    x=[];
    
    mrow = matfile1(k,:)
    thirdcol = mrow(3);
    im=cell2mat(thirdcol);
    label1=[label1;im];
    
    %%%%%%%%%%%%% father picture %%%%%%%%%%%%
    firstcol = mrow(1);
    im1=cell2mat(firstcol);
    c1=imread(im1);
    imshow(im1)
%     c1 = rgb2gray(c1);
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
            LBP_Fd_c1=[LBP_Fd_c1;L];
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
                LBP_Fd_c2=[LBP_Fd_c2;L];
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
            LBP_Fd_c3=[LBP_Fd_c3;L];
%             HOG_Fd=[HOG_Fd;featureVector];
        end
    end
    
    %%%%%%%%%%%%% daughter picture %%%%%%%%%%%%
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
            LBP_D1_c1=[LBP_D1_c1;L];
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
                LBP_D1_c2=[LBP_D1_c2;L];
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
            LBP_D1_c3=[LBP_D1_c3;L];
%             HOG_Fd=[HOG_Fd;featureVector];
        end
    end
    

    x1=pdist2(LBP_Fd_c1,LBP_D1_c1,'chisq');
    x2=pdist2(LBP_Fd_c2,LBP_D1_c2,'chisq');
    x3=pdist2(LBP_Fd_c3,LBP_D1_c3,'chisq');
    
    x1=reshape(x1,1,[]);
    x2=reshape(x2,1,[]);
    x3=reshape(x3,1,[]);
%     Dmean = mean(x(:));

    dist1_1=[dist1_1;x1];
    dist1_2=[dist1_2;x2];
    dist1_3=[dist1_3;x3];
    
 
%     mean_Fd = mean(LBP_Fd);
%     mean_D1 = mean(LBP_D1);
%     mean_all=[mean_Fd;mean_D1];
%     mean_all=reshape(mean_all.',1,[]); 
%     mean_all=[mean_all,Dmean];
%     svm_mean1=[svm_mean1;mean_all]
    
%     LBP_all_fd=[LBP_all_fd;LBP_Fd];
%     LBP_all_fd=[LBP_all_fd;LBP_D1];
%     LBP_fd_mat1(:,:,k)=LBP_all_fd;
%     
%     HOG_all_fd=[HOG_all_fd;HOG_Fd];
%     HOG_all_fd=[HOG_all_fd;HOG_D1];
%     HOG_fd_mat1(:,:,k)=HOG_all_fd;
end

for k=1:54
%     mean_all=[];
%     mean_Fd=[];
%     mean_D1=[];
%     HOG_all_fd=[];
    LBP_all_fd=[];
%     HOG_Fd=[];
    LBP_Fd_c1=[];
    LBP_Fd_c2=[];
    LBP_Fd_c3=[];
%     HOG_D1=[];
    LBP_D1_c1=[];
    LBP_D1_c2=[];
    LBP_D1_c3=[];
    Dmean=0;
    x=[];
    
%     ind = ceil(rand * size(kin_pairs_fd,1))
%     p(1)
    mrow = matfile2(k,:)
    thirdcol = mrow(3);
    im=cell2mat(thirdcol);
    label2=[label2;im];
    %%%%%%%%%%%%% father picture %%%%%%%%%%%%
    firstcol = mrow(1);
    im1=cell2mat(firstcol);
    c1=imread(im1);
%     c1 = rgb2gray(c1);
    [m1 , n1 , p1]=size(c1);
    [s1 ,s2]=size(c1(:,:,1));
    [s3 ,s4]=size(c1(:,:,2));
    [s5 ,s6]=size(c1(:,:,3));
    
    channel1=c1(:,:,1);
    channel2=c1(:,:,2);
    channel3=c1(:,:,3);
    
    imshow(im1)
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
            LBP_Fd_c1=[LBP_Fd_c1;L];
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
                LBP_Fd_c2=[LBP_Fd_c2;L];
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
            LBP_Fd_c3=[LBP_Fd_c3;L];
%             HOG_Fd=[HOG_Fd;featureVector];
        end
    end
    
    %%%%%%%%%%%%% daughter picture %%%%%%%%%%%%
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
            LBP_D1_c1=[LBP_D1_c1;L];
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
                LBP_D1_c2=[LBP_D1_c2;L];
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
            LBP_D1_c3=[LBP_D1_c3;L];
%             HOG_Fd=[HOG_Fd;featureVector];
        end
    end
    

    x1=pdist2(LBP_Fd_c1,LBP_D1_c1,'chisq');
    x2=pdist2(LBP_Fd_c2,LBP_D1_c2,'chisq');
    x3=pdist2(LBP_Fd_c3,LBP_D1_c3,'chisq');
    
    x1=reshape(x1,1,[]);
    x2=reshape(x2,1,[]);
    x3=reshape(x3,1,[]);
%     Dmean = mean(x(:));

    dist2_1=[dist2_1;x1];
    dist2_2=[dist2_2;x2];
    dist2_3=[dist2_3;x3];
    
%     mean_Fd = mean(LBP_Fd);
%     mean_D1 = mean(LBP_D1);
%     mean_all=[mean_Fd;mean_D1];
%     mean_all=reshape(mean_all.',1,[]); 
%     mean_all=[mean_all,Dmean];
%     svm_mean2=[svm_mean2;mean_all]
%     
%     LBP_all_fd=[LBP_all_fd;LBP_Fd];
%     LBP_all_fd=[LBP_all_fd;LBP_D1];
%     LBP_fd_mat2(:,:,k)=LBP_all_fd;
%     
%     HOG_all_fd=[HOG_all_fd;HOG_Fd];
%     HOG_all_fd=[HOG_all_fd;HOG_D1];
%     HOG_fd_mat2(:,:,k)=HOG_all_fd;
end

for k=1:54
%     mean_all=[];
%     mean_Fd=[];
%     mean_D1=[];
%     HOG_all_fd=[];
    LBP_all_fd=[];
%     HOG_Fd=[];
    LBP_Fd_c1=[];
    LBP_Fd_c2=[];
    LBP_Fd_c3=[];
%     HOG_D1=[];
    LBP_D1_c1=[];
    LBP_D1_c2=[];
    LBP_D1_c3=[];
    x=[];
    
%     ind = ceil(rand * size(kin_pairs_fd,1))
%     p(1)
    mrow = matfile3(k,:)
    thirdcol = mrow(3);
    im=cell2mat(thirdcol);
    label3=[label3;im];
    
    %%%%%%%%%%%%% father picture %%%%%%%%%%%%
    firstcol = mrow(1);
    im1=cell2mat(firstcol);
    c1=imread(im1);
%     c1 = rgb2gray(c1);
    [m1 , n1 , p1]=size(c1);
    [s1 ,s2]=size(c1(:,:,1));
    [s3 ,s4]=size(c1(:,:,2));
    [s5 ,s6]=size(c1(:,:,3));
    
    channel1=c1(:,:,1);
    channel2=c1(:,:,2);
    channel3=c1(:,:,3);
    
    imshow(im1)
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
            LBP_Fd_c1=[LBP_Fd_c1;L];
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
                LBP_Fd_c2=[LBP_Fd_c2;L];
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
            LBP_Fd_c3=[LBP_Fd_c3;L];
%             HOG_Fd=[HOG_Fd;featureVector];
        end
    end
    
    %%%%%%%%%%%%% daughter picture %%%%%%%%%%%%
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
            LBP_D1_c1=[LBP_D1_c1;L];
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
                LBP_D1_c2=[LBP_D1_c2;L];
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
            LBP_D1_c3=[LBP_D1_c3;L];
%             HOG_Fd=[HOG_Fd;featureVector];
        end
    end
    

    x1=pdist2(LBP_Fd_c1,LBP_D1_c1,'chisq');
    x2=pdist2(LBP_Fd_c2,LBP_D1_c2,'chisq');
    x3=pdist2(LBP_Fd_c3,LBP_D1_c3,'chisq');
    
    x1=reshape(x1,1,[]);
    x2=reshape(x2,1,[]);
    x3=reshape(x3,1,[]);
%     Dmean = mean(x(:));

    dist3_1=[dist3_1;x1];
    dist3_2=[dist3_2;x2];
    dist3_3=[dist3_3;x3];
    
    
%     mean_Fd = mean(LBP_Fd);
%     mean_D1 = mean(LBP_D1);
%     mean_all=[mean_Fd;mean_D1];
%     mean_all=reshape(mean_all.',1,[]); 
%     mean_all=[mean_all,Dmean];
%     svm_mean3=[svm_mean3;mean_all]
    
%     LBP_all_fd=[LBP_all_fd;LBP_Fd];
%     LBP_all_fd=[LBP_all_fd;LBP_D1];
%     LBP_fd_mat3(:,:,k)=LBP_all_fd;
%     
%     HOG_all_fd=[HOG_all_fd;HOG_Fd];
%     HOG_all_fd=[HOG_all_fd;HOG_D1];
%     HOG_fd_mat3(:,:,k)=HOG_all_fd;
end

for k=1:53
%     mean_all=[];
%     mean_Fd=[];
%     mean_D1=[];
%     HOG_all_fd=[];
    LBP_all_fd=[];
%     HOG_Fd=[];
    LBP_Fd_c1=[];
    LBP_Fd_c2=[];
    LBP_Fd_c3=[];
%     HOG_D1=[];
    LBP_D1_c1=[];
    LBP_D1_c2=[];
    LBP_D1_c3=[];
    x=[];
    
%     ind = ceil(rand * size(kin_pairs_fd,1))
%     p(1)
    mrow = matfile4(k,:)
    thirdcol = mrow(3);
    im=cell2mat(thirdcol);
    label4=[label4;im];
    
    %%%%%%%%%%%%% father picture %%%%%%%%%%%%
    firstcol = mrow(1);
    im1=cell2mat(firstcol);
    c1=imread(im1);
%       c1 = rgb2gray(c1);
    [m1 , n1 , p1]=size(c1);
    [s1 ,s2]=size(c1(:,:,1));
    [s3 ,s4]=size(c1(:,:,2));
    [s5 ,s6]=size(c1(:,:,3));
    
    channel1=c1(:,:,1);
    channel2=c1(:,:,2);
    channel3=c1(:,:,3);
    
    imshow(im1)
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
            LBP_Fd_c1=[LBP_Fd_c1;L];
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
                LBP_Fd_c2=[LBP_Fd_c2;L];
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
            LBP_Fd_c3=[LBP_Fd_c3;L];
%             HOG_Fd=[HOG_Fd;featureVector];
        end
    end
    
    %%%%%%%%%%%%% daughter picture %%%%%%%%%%%%
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
            LBP_D1_c1=[LBP_D1_c1;L];
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
                LBP_D1_c2=[LBP_D1_c2;L];
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
            LBP_D1_c3=[LBP_D1_c3;L];
%             HOG_Fd=[HOG_Fd;featureVector];
        end
    end
    

    x1=pdist2(LBP_Fd_c1,LBP_D1_c1,'chisq');
    x2=pdist2(LBP_Fd_c2,LBP_D1_c2,'chisq');
    x3=pdist2(LBP_Fd_c3,LBP_D1_c3,'chisq');
    
    x1=reshape(x1,1,[]);
    x2=reshape(x2,1,[]);
    x3=reshape(x3,1,[]);
%     Dmean = mean(x(:));

    dist4_1=[dist4_1;x1];
    dist4_2=[dist4_2;x2];
    dist4_3=[dist4_3;x3];
    
    
%     mean_Fd = mean(LBP_Fd);
%     mean_D1 = mean(LBP_D1);
%     mean_all=[mean_Fd;mean_D1];
%     mean_all=reshape(mean_all.',1,[]); 
%     mean_all=[mean_all,Dmean];
%     svm_mean4=[svm_mean4;mean_all]
    
%     LBP_all_fd=[LBP_all_fd;LBP_Fd];
%     LBP_all_fd=[LBP_all_fd;LBP_D1];
%     LBP_fd_mat4(:,:,k)=LBP_all_fd;
%     
%     HOG_all_fd=[HOG_all_fd;HOG_Fd];
%     HOG_all_fd=[HOG_all_fd;HOG_D1];
%     HOG_fd_mat4(:,:,k)=HOG_all_fd;
end

for k=1:53
%     mean_all=[];
%     mean_Fd=[];
%     mean_D1=[];
%     HOG_all_fd=[];
    LBP_all_fd=[];
%     HOG_Fd=[];
    LBP_Fd_c1=[];
    LBP_Fd_c2=[];
    LBP_Fd_c3=[];
%     HOG_D1=[];
    LBP_D1_c1=[];
    LBP_D1_c2=[];
    LBP_D1_c3=[];
    x=[];
    
%     ind = ceil(rand * size(kin_pairs_fd,1))
%     p(1)
    mrow = matfile5(k,:)
    thirdcol = mrow(3);
    im=cell2mat(thirdcol);
    label5=[label5;im];
    %%%%%%%%%%%%% father picture %%%%%%%%%%%%
    firstcol = mrow(1);
    im1=cell2mat(firstcol);
    c1=imread(im1);
%        c1 = rgb2gray(c1);
    [m1 , n1 , p1]=size(c1);
    [s1 ,s2]=size(c1(:,:,1));
    [s3 ,s4]=size(c1(:,:,2));
    [s5 ,s6]=size(c1(:,:,3));
    
    channel1=c1(:,:,1);
    channel2=c1(:,:,2);
    channel3=c1(:,:,3);
    
    imshow(im1)
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
            LBP_Fd_c1=[LBP_Fd_c1;L];
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
                LBP_Fd_c2=[LBP_Fd_c2;L];
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
            LBP_Fd_c3=[LBP_Fd_c3;L];
%             HOG_Fd=[HOG_Fd;featureVector];
        end
    end
    
    %%%%%%%%%%%%% daughter picture %%%%%%%%%%%%
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
            LBP_D1_c1=[LBP_D1_c1;L];
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
                LBP_D1_c2=[LBP_D1_c2;L];
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
            LBP_D1_c3=[LBP_D1_c3;L];
%             HOG_Fd=[HOG_Fd;featureVector];
        end
    end
    

    x1=pdist2(LBP_Fd_c1,LBP_D1_c1,'chisq');
    x2=pdist2(LBP_Fd_c2,LBP_D1_c2,'chisq');
    x3=pdist2(LBP_Fd_c3,LBP_D1_c3,'chisq');
    
    x1=reshape(x1,1,[]);
    x2=reshape(x2,1,[]);
    x3=reshape(x3,1,[]);
%     Dmean = mean(x(:));

    dist5_1=[dist5_1;x1];
    dist5_2=[dist5_2;x2];
    dist5_3=[dist5_3;x3];
    
    
%     mean_Fd = mean(LBP_Fd);
%     mean_D1 = mean(LBP_D1);
%     mean_all=[mean_Fd;mean_D1];
%     mean_all=reshape(mean_all.',1,[]); 
%     mean_all=[mean_all,Dmean];
%     svm_mean5=[svm_mean5;mean_all];
    
%     LBP_all_fd=[LBP_all_fd;LBP_Fd];
%     LBP_all_fd=[LBP_all_fd;LBP_D1];
%     LBP_fd_mat5(:,:,k)=LBP_all_fd;
%     
%     HOG_all_fd=[HOG_all_fd;HOG_Fd];
%     HOG_all_fd=[HOG_all_fd;HOG_D1];
%     HOG_fd_mat5(:,:,k)=HOG_all_fd;
end

% dist1=[dist1_1,dist1_2,dist1_3;dist2_1,dist2_2,dist2_3;dist3_1,dist3_2,dist3_3;dist4_1,dist4_2,dist4_3];

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