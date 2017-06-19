
% % This implementation idea came from Robust Human Detection Under Occlusion by Integrating Face and Person Detectors 
% % and eigenfaces vs. fisherfaces recognition using class specific linear projection.
% % Also my interest in video processing led me to be intrigued by this kind of computer vision project. 
% % The biggest failure of this implementation was the dataset used. 
% % The sizes of the photos in the dataset are small and reduce the applicability of my implementation. 
% % If we can implement a better data set and thoroughly test the framework with challenging images, 
% % and still retain its speed in which it detects faces, this framework has the possibility to become relevant in the world of computer vision.  

tic
% Item 1:
% added by Qi:  

% Modify this code without menu 
% load in images and extract features 
% perform training -- SVM
% perform testing  -- Scanning


if exist('imgdb.mat','file')
    load imgdb;
else
    IMGDB = cell (3,[]);
    [C, meanFeatures] = Eigen() ;
    
    eigenFeatures = [] ;

    for j = 1 : 69
        name = strcat('face\', num2str(j), '.png') ;
        image = double(imread(name)) ;
        [m n] = size(image);
        
        
        HOGFeature = HOG(image) ;               

        % modified by Dr. Qi
        temp=reshape(image', m*n, 1);
        eigenFeatures = C*(temp - meanFeatures) ;
               
        IM{1} = [HOGFeature ; eigenFeatures] ;
        
        
        % modified by Dr. Qi
        A = fliplr(image) ;
        HOGFeature = HOG(A) ;
        temp = reshape(A', m*n, 1) ;
        eigenFeatures = C*(temp - meanFeatures) ;
        IM{2} = [HOGFeature ; eigenFeatures] ; 
        
        
        % modified by Dr. Qi
        A = circshift(image,1) ;
        HOGFeature = HOG(A) ;
        temp = reshape(A', m*n, 1) ;
        eigenFeatures = C*(temp - meanFeatures) ;
        IM{3} = [HOGFeature ; eigenFeatures] ;
        
        A = circshift(image,-1) ;
        HOGFeature = HOG(A) ;     
        temp = reshape(A', m*n, 1) ;
        eigenFeatures = C*(temp - meanFeatures) ;
        IM{4} = [HOGFeature ; eigenFeatures] ;
        
        
        A = circshift(image,[0 1]) ;
        HOGFeature = HOG(A) ;
        temp = reshape(A', m*n, 1) ;
        eigenFeatures = C*(temp - meanFeatures) ;
        IM{5} = [HOGFeature ; eigenFeatures] ;
        
        A = circshift(image,[0 -1]) ;
        HOGFeature = HOG(A) ;
        temp = reshape(A', m*n, 1) ;
        eigenFeatures = C*(temp - meanFeatures) ;
        IM{6} = [HOGFeature ; eigenFeatures] ;
        
        A = circshift(fliplr(image),1) ;
        HOGFeature = HOG(A);
        temp = reshape(A', m*n, 1) ;
        eigenFeatures = C*(temp - meanFeatures) ;
        IM{7} = [HOGFeature ; eigenFeatures] ;
        
        A = circshift(fliplr(image),-1) ;
        HOGFeature = HOG(A);
        temp = reshape(A', m*n, 1) ;
        eigenFeatures = C*(temp - meanFeatures) ;
        IM{8} = [HOGFeature ; eigenFeatures] ;
       
        
        A = circshift(fliplr(image),[0 1]);
        HOGFeature = HOG(A);
        temp = reshape(A', m*n, 1) ;
        eigenFeatures = C*(temp - meanFeatures) ;
        IM{9} = [HOGFeature ; eigenFeatures] ;
        
        A = circshift(fliplr(image),[0 -1]) ;
        HOGFeature = HOG(A);
        temp = reshape(A', m*n, 1) ;
        eigenFeatures = C*(temp - meanFeatures) ;
        IM{10} = [HOGFeature ; eigenFeatures] ;
               
        
        for i=1:10
            IMGDB {1,end+1}= name;
            IMGDB {2,end} = 1 ;
            IMGDB (3,end) = {IM{i}};
        end    

    end
    
% Modified by Dr. Qi

    for k = 1 : 55
        name = strcat('non-face\', num2str(k), '.png') ;
        image = double(imread(name)) ;
        [m n] = size(image); 
        
        HOGFeature = HOG (image);
        temp=reshape(image', m*n, 1);
        %qComp = C*(B(1,:)- meanFeatures)';
        eigenFeatures = C*(temp - meanFeatures) ;
        IM {1} = [HOGFeature ; eigenFeatures] ;
        
        A = fliplr(image) ;
        HOGFeature = HOG (A);
        temp = reshape(A', m*n, 1) ;
        eigenFeatures = C*(temp - meanFeatures) ;
        IM {2} = [HOGFeature ; eigenFeatures];
        
        A = flipud(image);
        HOGFeature = HOG (A);
        temp = reshape(A', m*n, 1) ;
        eigenFeatures = C*(temp - meanFeatures) ;
        IM {3} = [HOGFeature ; eigenFeatures];
        
        A = flipud(fliplr(image)) ;
        HOGFeature = HOG (A);
        temp = reshape(A', m*n, 1) ;
        eigenFeatures = C*(temp - meanFeatures) ;
        IM {4} = [HOGFeature ; eigenFeatures];
        
        
        for i=1:4
            IMGDB {1,end+1}= name;
            IMGDB {2,end} = -1;
            IMGDB (3,end) = {IM{i}};
        end    
    end
   
    fprintf('\n');
    save imgdb.mat IMGDB;
end
toc;

tic
trainsvm(IMGDB);
toc;


