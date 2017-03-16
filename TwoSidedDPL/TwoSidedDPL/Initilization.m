function [ DataMat, DLMat, DRMat, A ] = Initilization( Data , Label, alpha, beta, gamma )
% In this intilization function, we do the following things:
% 1. Random initialization of dictioanry pair D and P for each class
% 2. Precompute the class-specific inverse matrix used in Eq. (10)
% 3. Compute matrix class-specific code matrix A by Eq. (8) 
%    with the random initilized D and P
%
% The randn seeds are setted to make sure the results in our paper are
% reproduceable. The randn seed setting can be removed, our algorithm is 
% not sensitive to the initilization of D and P. In most cases, different 
% initilization will lead to the same recognition accuracy on a wide randge
% of testing databases.


ClassNum = max(Label);
DLim      = size(Data, 1);
IL_Mat    = eye(DLim, DLim);
% IR_Mat    = eye(DRim, DRim);

for i=1:ClassNum
    TempData      = Data(:,Label==i);
    DRim(i)      = size(TempData, 2);
    DataMat{i}    = TempData;
    randn('seed', i);                        
    DLMat{i}    = normcol_equal(randn(DLim, DLim));
    randn('seed', 2*i);
    DRMat{i}      = normcol_equal(randn(DRim(i), DRim(i)));
    
end

A = UpdateA( DataMat, DLMat, DRMat,  alpha, IL_Mat );

