warning off
% Load training and testing data
DataPath   = 'YaleB_Jiang';
load(DataPath);

% Column normalization
TrData = normcol_equal(TrData);
TtData = normcol_equal(TtData);

%Parameter setting
DictSize = 30;
tau    = 0.05;
lambda = 0.003;
gamma  = 0.0001;

% DPL trainig
tic
[ DictMat , EncoderMat ] = TrainDPL(  TrData, TrLabel, DictSize, tau, lambda, gamma );
TrTime = toc;

%DPL testing
tic
[ PredictLabel Error] = ClassificationDPL( TtData, DictMat, EncoderMat, DictSize);
TtTime = toc;
 
%Show accuracy and time
Accuracy = sum(TtLabel==PredictLabel)/size(TtLabel,2);
fprintf('\nThe running time for DPL training is : %.03f ', TrTime);
fprintf('\nThe running time for DPL testing is : %.03f ', TtTime);
fprintf('\nRecognition rate for DPL is : %.03f ', Accuracy);