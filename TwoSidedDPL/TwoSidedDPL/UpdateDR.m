function [ DRMat ] = UpdateDR(  DataMat, A, DLMat, alpha, gamma)
% Update DR 
ClassNum = size(DataMat,2);
DRMat =  cell(ClassNum, 1);
% This model assume that the number of columns of the data matrices of
% different classes are the equal to each other

% Compute \sum_{i=1}^{ClassNum} (Xi*Si*Si'*Xi')
SumXtTtTX = zeros(size(DataMat{1},2), size(DataMat{1},2));
for i=1:ClassNum
    TempData    = DataMat{i};
    TempDL       = DLMat{i};
    SumXtTtTX   = SumXtTtTX + TempData'*(TempDL'*TempDL)*TempData;
end

for i=1:ClassNum
    TempData       = DataMat{i};
    TempA       = A{i};
    TempDL       = DLMat{i};
    DRMat{i}        = (alpha*(TempData'*TempData)+gamma*(SumXtTtTX-TempData'*(TempDL'*TempDL)*TempData))\TempData'*TempA;
end