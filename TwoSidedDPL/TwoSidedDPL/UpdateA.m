function [ A ] = UpdateA( Data, DLMat, DRMat,  alpha, IL_Mat )
% Update A 

ClassNum = size(Data,2);
A = cell(ClassNum, 1);
for i=1:ClassNum
    TempDL       = DLMat{i};
    TempDR       = DRMat{i};
    TempData       = Data{i};
    A{i}        = (TempDL'*TempDL+alpha*IL_Mat)\(TempDL'*TempData+alpha*TempData*TempDR);
end


