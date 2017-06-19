tic
% load in a picture
warning off; 
image = imread('im1.jpg');
% Added by Dr. Qi

%  image = rgb2gray(image);
image = double(image) ;


imageWidth = size(image, 2);
imageHeight = size(image, 1);


windowWidth = 18;
windowHeight = 27;

k = 1;
l = 1;
count = 0;
blockNum = 1 ;
[C, meanFeatures] = Eigen() ;
% while (windowWidth <= windowWidth*2 && windowHeight <= windowHeight*2)
    

% obtain the blocks

    for j = 1:windowWidth/2:imageHeight - windowHeight + 1
        for i = 1:windowWidth/2:imageWidth - windowWidth + 1
            window = image(j:j + windowHeight - 1, i:i + windowWidth - 1, :); %window creation
            
            % modified by Dr. Qi
            HOGFeature = HOG(window) ;                                          %Extracts HOG features from a given window
            B = imresize(window, [18 27]) ;
            %B = window(:) ;
            %B = imresize(B, [1 486]);
            B = reshape(B', 18*27, 1) ;
            EigenFeature = C*(B-meanFeatures);
                
           
            G{k, 1} = [HOGFeature ; EigenFeature] ;
            G{k, 2} = [windowWidth, windowHeight] ;
            G{k, 4} = [j, i]; 
            G{k, 5} = blockNum;
            k = k + 1; 
        end
    end
    
    
%      blockNum = blockNum + 1; 
%      windowWidth = windowWidth + 2 ;
%      windowHeight = windowHeight + 2 ;
%      
% end

a = G(:, 1) ;

P = zeros([], []) ;
for i = 1 : length(a)
    P(i, :) = a{i}' ;
end

load SVMtrain.mat
classes = svmclassify(svm,P);

%ones counter and labels the G cell
%while classes(1:length(classes))
% for i = 1 : length(classes)
%     if classes(i) == 1 
%         G{i, 3} = 1; 
%         count = count + 1;       
%     else
%         G{i, 3} = -1;        
%     end
% end

faceId = find(classes == 1) ;
image = imread('im1.jpg');


MergeResults = [] ;
FaceResults = [] ;
flag = 0;

numfaces = length(faceId);

for i = 1 : numfaces - 1
    for j = i + 1 : numfaces
        iDA = faceId(i) ;
        winInfoA = G{iDA, 2} ;
        startPosA = G{iDA, 4} ;
        
           
        iDB = faceId(j) ;
        winInfoB = G{iDB, 2} ;
        startPosB = G{iDB, 4} ;
        
        
        [startPosC, winInfoC, flag] = VerifyOverlapping(startPosA , winInfoA, startPosB, winInfoB);
        
        
        imshow(image);
        
        if flag == 1
            hold on ;
            rectangle('position',[startPosA(2) startPosA(1) winInfoA(1) winInfoA(2)], 'LineWidth', 1.5, 'EdgeColor' , 'b');
%             pause ;
            rectangle('position',[startPosB(2) startPosB(1) winInfoB(1) winInfoB(2)], 'LineWidth', 1.5, 'EdgeColor' , 'b');
%             pause ;
            rectangle('position',[startPosC(1) startPosC(2) winInfoC(1) winInfoC(2)], 'LineWidth', 1.5, 'EdgeColor' , 'r');
%             pause ;
            MergeResults = [MergeResults; startPosC(1) startPosC(2) winInfoC(1) winInfoC(2)];
        else
            FaceResults = [FaceResults; startPosA(2) startPosA(1) winInfoA(1) winInfoA(2)];
        end
        
        
    end
end


for i = 1 : length(FaceResults)
    
    hold on;
    rectangle('position',[FaceResults(i , 1 ) FaceResults(i, 2) FaceResults(i, 3) FaceResults(i, 4)] , 'LineWidth', 1.5, 'EdgeColor' , 'g');
end

figure; imshow(image);
hold on ;
for i = 1 : length(MergeResults)
    rectangle('position',[MergeResults(i , 1 ) MergeResults(i, 2) MergeResults(i, 3) MergeResults(i, 4)] , 'LineWidth', 1.5, 'EdgeColor' , 'r'); 
end


toc;






















































% % % % % % frame/idea for window merging % % % % % %  
% 
% % winmer1 is the first window dected at point x,y 
% % now I loop through to create a cell which has all coordinates of that window
% % I do the same for the second window that detects a face. (winmer2)
% % Vectorize winmer1 and 2 respectively to w1 & w2
% 
% % I use the intersection function to create winmar3 which contains the
% % intersection of w1 & w2. however I only want the values that are size 1x2
% % (the matching x,y between w1 and w2). I break out of the intersection
% % loop when 1/4 the number of window size is stored in winmer3, which means
% % around 1/4 of the windows are overlapping.
% 
% % next step: create a flag that goes off once this overlapping is
% % calculated and create a new rectangle of size m x n. I would still have
% % calculate each window with eachother to see if the overlap flag will
% % raise. I will continue to work on this aspect. 
% 
% 
% 
% 
% 
% winmer1 = cell([],[]);       
% k = 1;
% for j = 10:28
%         for i = 100:125
%          winmer1{k} = [j,i]; 
%          k =  k + 1;
%         end
% end
% 
% k = 1;
% winmer2 = cell([],[]); 
% for j = 10:28
%         for i = 91:116
%          winmer2{k} = [j,i]; 
%          k =  k + 1;
%         end
% end
% 
% 
% w1 = winmer1(:);
% w2 = winmer2(:);
% 
% b = floor((windowWidth * windowHeight)/4); 
% 
% k = 1;
% winmer3 = cell([],[]); 
% for j = 1:300
%         for i = 1:300
%          winmer3{k} = intersect(w1{i,1}, w2{j,1});
%          k =  k + 1;
%          if b > k  %break out of loop after 1/4 of the window size is overlapped.
%              break;
%          end
%         end
% end
% 
% winmer3(cellfun(@(winmer3) isempty(winmer3),winmer3))=[]; %get rid of empty cells
% winmer3(cellfun('size',winmer3,2)==1) = []; %get ride of cells not size 1x2
% 
% 
% 
% 
% % window4 = cell([],[]);       
% % k = 1;
% % for j = positionInfo(1):lrPos(1)
% %         for i = positionInfo(2):lrPos(2)
% %  
% %          window4{k} = [j,i]; %window creation
% %          k =  k + 1;
% %         end
% % end







