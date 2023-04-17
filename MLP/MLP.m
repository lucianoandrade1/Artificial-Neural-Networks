%MLP: Multi-layer perceptron artificial neural networ implemenation
%Author: Luciano Andrade

clear all;
clc;

tr = csvread('TrainingSet.csv');

trInputs = tr(1:end,1:4);
trOutputs = tr(1:end,5);

W1 = rand (10,4);
W2 = rand (1,10);

disp('------------------------------------------------------------------');
disp('W1 vector of weights');
disp(W1);

disp('------------------------------------------------------------------');
disp('W2 vector of weights');
disp(W2);

sizeTrInputs = size(trInputs,1);
v_MSE= 1:1:1;
currentMSE = 1000;  
previousMSE = 0;
epochs = 0;   %number of training epochs
n = 0.1;    %learning ratio

precision = 0.0000001;   %training precision

while(abs(currentMSE - previousMSE) > precision)
    previousMSE = currentMSE;
    epochs = epochs + 1;
    for k = 1:sizeTrInputs
        %Forward
        I1 = zeros(10,1);
        I2 = 0;
        for j = 1:10
            for i = 1:4
                I1(j) = I1(j) + trInputs(k,i) * W1(j,i);
            end
        end
        Y1 = Logistic(I1)';
        for i = 1:10
            I2 = I2 + W2(i) * Y1(i);
        end
        Y2 = Logistic(I2)';
    
        %Backward
        delta2 = (trOutputs(k) - Y2) * DLogistic(I2);
        for i = 1:10
            W2(i) = W2(i) + n * delta2 * Y1(i);
        end
        for j = 1:10
            delta1(j) = delta2 * W2(j) * DLogistic(I1(j));
            for i = 1:4
                W1(j,i) = W1(j,i) + n * delta1(j) * trInputs(k,i);
            end
        end
            E(k) = 0.5 * ((trOutputs(k) - Y2)^2);  
            
            
    end     

    currentMSE = MSE(E);
    v_MSE(epochs) = currentMSE;
    
end

disp('------------------------------------------------------------------');
disp('Mean squared error');
disp(currentMSE);

disp('------------------------------------------------------------------');
disp('Number of epochs');
disp(epochs);

figure; 
axes;
hold on;
title('MSE x Epochs');
xlabel('Epochs'); ylabel('Mean squared error');
v_epochs = 1:1:epochs;
plot(v_epochs, v_MSE);

%-------------------------------------------------------------------------
%------------------------------TESTE--------------------------------------

test = csvread('TestSet.csv');

testInputs = test(1:end,1:4)';

I1 = W1 * testInputs;
Y1 = Logistic(I1);
I2 = W2 * Y1;
Y2 = Logistic(I2);

disp('------------------------------------------------------------------');
disp('MLP output');
disp(Y2);

sizeY2 = length(Y2);

testOutputs = test(1:end,5)';

RE=0
MRE=0;
variance = 0;

for i = 1:sizeY2
    RE = RE + (abs(Y2(i) - testOutputs(i))); 
    variance = variance + ((Y2(i) - testOutputs(i))^2);
end

MRE = (RE / sizeY2) * 100;
variance = (variance / sizeY2) * 100;

disp('------------------------------------------------------------------');
disp('Mean relative error');
disp(MRE);

disp('------------------------------------------------------------------');
disp('Variance');
disp(variance);

