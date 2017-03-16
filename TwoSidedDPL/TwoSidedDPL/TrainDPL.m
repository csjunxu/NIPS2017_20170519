function [ DLMat, DRMat ] = TrainDPL( Data, Label, alpha, beta, gamma )
% This is the DPL training function

DLdim      = size(Data, 1);
IL_Mat    = eye(DLdim, DLdim);

% Initilize D and P, precompute the inverse matrix used in Eq. (10), update A for one time
[ DataMat, DLMat, DRMat, A ] = Initilization( Data , Label, alpha, beta, gamma );

%     TempDataC     = Data(:,Label~=i);
%     DataInvMat{i} = inv(alpha*TempData*TempData'+beta*TempDataC*TempDataC'+gamma*IL_Mat);

% Alternatively update P, D and A
for i=1:20
    [ DLMat ] = UpdateDL( DataMat, A, DRMat, beta);
    [ DRMat ]   = UpdateDR( DataMat, A, DLMat, alpha, gamma );
    [ A ] = UpdateA(  DataMat, DLMat, DRMat,  alpha, IL_Mat );
end

% Reorganize the P matrix to make the classification fast
for i=1:size(DRMat,1)
    DRdim      = size(DRMat{i}, 1);
    EncoderMat((i-1)*DRdim+1:i*DRdim,:) = DRMat{i};
end


