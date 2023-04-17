%MLP: Multi-layer perceptron artificial neural networ implemenation
%Backpropagation with momentum
%Author: Luciano Andrade

clc;
clear all;

%Learning ratio
n = 0.1;

%Precision
precision = 10^-6;

%Momentum
alpha = 2*10^-4;    % 0.9;

%Load training data
trainingSet = csvread('TrainingSet.csv');

%training data inputs
trInputs = trainingSet(:,1:5)';

%training data outputs
trOuputs = trainingSet(:,6:8)';

%Load the vectors of weights 
W1 = csvread('FirstWeightsLayer.csv');

previousW1 = W1;

disp('Layer 1 Weights Vectors');
disp(W1);


W2 = csvread('SecondWeightsLayer.csv')';
previousW2 = W2;

disp('Layer 2 Weights Vectors');
disp(W2);

sizeInputs = size(trInputs,2);

v_MSE= 1:1:1;
currentMSE = 1000;  
previousMSE = 0;
epoch = 0;
Y2 = zeros(3,130);

tproc=clock;

while(abs(currentMSE - previousMSE) > precision)

    previousMSE = currentMSE;
    epoch = epoch + 1;
    
    for k = 1:sizeInputs
        %Forward
        [I1, Y1, I2, Y2] = Forward(trInputs, W1, W2, k, Y2);
        
        %Backward
        [delta2, delta1, W1, W2] = Backward(W1, W2, previousW1, previousW2, I1, I2, Y1, Y2, trOuputs, n, trInputs, k, alpha);
        
    end     

    %Current mean squared error
    currentMSE = MSE(trOuputs,Y2);
    
    %Save mean squared error in each epoch
    v_MSE(epoch) = currentMSE;
end

t = etime(clock,tproc)/60;
disp('Training time (minutes)');
disp(t);

disp('Mean squared error');
disp(currentMSE);

disp('Number of epochs');
disp(epoch);

%Plot training graph
figure; 
axes;
hold on;
title('MSE x Epochs');
xlabel('Epochs'); ylabel('Mean squared error');
v_epocas = 1:1:epoch;
plot(v_epocas, v_MSE);


%Load test data
testSet = csvread('TestSet.csv');

testInputs = testSet(:,1:5)';

I1 = W1 * testInputs;
Y1 = Logistic(I1);
I2 = W2 * Y1;
Y2 = Logistic(I2);
  
disp('Net output');
disp(Y2);

sizeY2 = length(Y2);

testOutputs = testSet(:,6:8);

MRE = 0;
VAR = 0;

%Mean relative error and variance calc
for i = 1:sizeY2
    MRE = MRE + (abs(Y2(i) - testOutputs(i))); 
    VAR = VAR + ((Y2(i) - testOutputs(i))^2);
end

MRE = (MRE / sizeY2) * 100;
VAR = (VAR / sizeY2) * 100;

disp('Mean relative error');
disp(MRE);

disp('Variance');
disp(VAR);

