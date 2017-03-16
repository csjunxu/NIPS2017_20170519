% The three possible extension to this model are:
% 1) Make both D and P have discriminative ability
%     (In DPL, noly P has the discriminative ability).
% 2) make D and P directly interact with each other in updating steps
% (In DPL, D and P are interacted in alternative updating steps, not directly in updating steps).
%
% 3) Make D has closed-form (analytic) solution
% (In DPL, the D is solved by ADMM algorithm which is time-consuming).



warning off
% Load training and testing data
DataPath   = '../DPL_NIPS14/YaleB_Jiang';
load(DataPath);

% Column normalization
TrData = normcol_equal(TrData);
TtData = normcol_equal(TtData);

%Parameter setting
DictSize = 30;
alpha    = 0.05;
beta = 0.003;
gamma  = 0.0001;

for alpha = [0.0001:0.0001:0.001 0.001:0.001:0.01 0.015:0.005:0.1 0.15:0.05:1]
    for beta = [0.0001:0.0001:0.001 0.001:0.001:0.01 0.015:0.005:0.1 0.15:0.05:1]
        for gamma = [0.0001:0.0001:0.001 0.002:0.001:0.01 0.015:0.005:0.1 0.15:0.05:1]
            % DPL trainig
            tic
            [ DLMat, DRMat ] = TrainDPL(  TrData, TrLabel, alpha, beta, gamma );
            TrTime = toc;
            
            %DPL testing
            tic
            [ PredictLabel, Error] = ClassificationDPL( TtData, DLMat, DRMat);
            TtTime = toc;
            
            %Show accuracy and time
            Accuracy = sum(TtLabel==PredictLabel)/size(TtLabel,2);
            name = sprintf(['TSDPL_' num2str(alpha) '_' num2str(beta) '_' num2str(gamma) '.mat']);
            save(name,'Accuracy','TrTime','TtTime');
        end
    end
end
% fprintf('\nThe running time for DPL training is : %.03f ', TrTime);
% fprintf('\nThe running time for DPL testing is : %.03f ', TtTime);
% fprintf('\nRecognition rate for DPL is : %.03f ', Accuracy);