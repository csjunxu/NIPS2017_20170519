function [ DLMat ] = UpdateDL(  DataMat, A, DRMat, beta )
% Update DL

ClassNum = size(DataMat,2);
DLMat =  cell(ClassNum, 1);
% Compute \sum_{i=1}^{ClassNum} (Xi*Si*Si'*Xi')
SumXSStXt = zeros(size(DataMat ,1), size(DataMat ,1));
for i=1:ClassNum
    TempData    = DataMat{i};
    TempDR       = DRMat{i};
    SumXSStXt   = SumXSStXt + TempData*(TempDR*TempDR')*TempData';
end


for i=1:ClassNum
    TempData       = DataMat{i};
    TempA       = A{i};
    TempDR       = DRMat{i};
    DLMat{i}        = TempData*TempA'/(TempA*TempA'+beta*(SumXSStXt-TempData*(TempDR*TempDR')*TempData'));
end

