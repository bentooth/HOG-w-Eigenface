% Modified by Dr. Qi -- There is no need to return B
function [C, meanFeatures] = Eigen()

S = [] ;
ustd=80;
um = 100 ;

M = 69 ;
N = 55;
for i=1:M
    str=strcat('face\', int2str(i),'.png');  
    img=imread(str);  
    [irow icol]=size(img);              % get the number of rows (N1) and columns (N2)
    temp=reshape(img',irow*icol,1);     %creates a (N1*N2)x1 matrix
    S=[S temp];                         %X is a N1*N2xM matrix after finishing the sequence
                                        %this is our S
end

S = double(S) ;

%Here we change the mean and std of all images. We normalize all images.
%This is done to reduce the error due to lighting conditions.
for i=1:size(S,2)
    temp=double(S(:,i));
    m=mean(temp);
    st=std(temp);
    S(:,i)=(temp-m)*ustd/st+um;
end

B = S' ;                                %Transposed set of images.
[C,V] = princomp(B);                    %V is the principle component scores
C = C(:,1:10);                          %this gives us the first 10 principle component vectors
C = C' ;
meanFeatures = mean(B);

% Added by Dr. Qi
meanFeatures = meanFeatures' ;



