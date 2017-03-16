function [ DLMat , EncoderMat ] = TrainDPL( Data, Label, DictSize, alpha, lambda, gamma )
% This is the DPL training function

DLim      = size(Data, 1);
IL_Mat    = eye(DLim, DLim);

% Initilize D and P, precompute the inverse matrix used in Eq. (10), update A for one time 
[ DataMat, DLMat, DRMat, DataInvMat, A ] = Initilization( Data , Label, alpha, lambda, gamma );

% Alternatively update P, D and A
for i=1:20
    [ DRMat ]   = UpdateP(  A, DataInvMat, DRMat, DataMat, alpha );
    [ DLMat ] = UpdateD(  A, DataMat, DLMat);
    [ A ] = UpdateA(  DLMat, DataMat, DRMat,  alpha, IL_Mat ); 
end

% Reorganize the P matrix to make the classification fast
for i=1:size(DRMat,2)
    EncoderMat((i-1)*DictSize+1:i*DictSize,:) = DRMat{i};
end

    
