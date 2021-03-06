function [PredictLabel, Error] = ClassificationDPL( TestData, DLMat, DRMat )

%Projective representation coefficients estimation
ClassNum = size(DLMat,1);
DRdim        = size(DRMat{1}, 1);
TestClassNum = size(TestData,2)/DRdim;
% Class-specific reconstruction error caculation
Error = zeros(ClassNum, size(TestData,2));
for i = 1:ClassNum
    for j = 1:TestClassNum
    Error(i,(j-1)*DRdim+1:j*DRdim)= sum((TestData(:,(j-1)*DRdim+1:j*DRdim)-DLMat{i}*TestData(:,(j-1)*DRdim+1:j*DRdim)*DRMat{i}).^2);
    end
end
[Distance, PredictLabel] = min(Error);



