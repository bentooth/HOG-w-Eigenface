

function SVM = trainsvm(IMGDB)

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~        
options = optimset('maxiter',100000);
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

fprintf('Creating & training the machine ->\n');

T = cell2mat(IMGDB(2,:));
P = cell2mat(IMGDB(3,:));
svm = svmtrain(P',T','Kernel_Function','linear','Polyorder',2,'quadprog_opts',options);
%net = svmtrain(P',T','Kernel_Function','quadratic','Polyorder',4,'quadprog_opts',options);
%fprintf('done. \n');
fprintf('Number of Support Vectors: %d\n',size(svm.SupportVectors,1));


save SVMtrain.mat svm;

% Added by Qi:  Move this section to main function
% Load in two new pictures for testing
% use the moving window concept in HOG to create windows of different sizes to scan possible
% areas in the image
% remember your window location, the size.
% After testing, I know which window contains the face and where
% classes = svmclassify(svm,P');
% fprintf('done. %d \n',sum(abs(classes-T')));
% save svm svm
% SVM = svm;