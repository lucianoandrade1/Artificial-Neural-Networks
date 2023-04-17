%MLP: Radial basis function artificial neural network implemenation
%Author: Luciano Andrade
clc;
clear all;

n = 10^-2;
precision = 10^-7;                  

%Number of neurons in the hidden layer
Nhidden = 15; 

%Number of neurons in the output layer
Noutput = 1; 

%file load with the patterns inputs for training
training = csvread('TrainingSet.csv');

trInputs = training(:,1:3)';

trOutputs = training(:,4)';

[N,Npatterns] = size(trInputs);
[W1,V1] = Cluster(trInputs,Nhidden); 
disp('W1 Input layer weights');
disp(W1);

W2 = rand(Noutput,Nhidden+1);
disp('W2 hidden layer wieghts');
disp(W2);

%Application of Gaussian to create the data for training the hidden layer
for k = 1:Npatterns
    Nhidden = size(W1,1);
    for j = 1:Nhidden
        tmp=0;
        for i=1:N
           tmp = tmp + (trInputs(i,k) - W1(j,i))^2; 
        end
        Utmp(j,k) = exp(-1*tmp/(2*V1(j)));
    end
end

%bias inclusion in the hidden neurons
for k=1:Npatterns
    for i=1:Nhidden+1
        if i==1
            U1(i,k) = -1;
        else
            U1(i,k) = Utmp(i-1,k);            
        end
    end
end

previsousMSE = 1000;
currentMSE = 0; 
epochs = 0;

%supervised training of the output layer
while (abs(previsousMSE - currentMSE) > precision)
    previsousMSE = currentMSE;
    
    epochs = epochs + 1;
    
    for k = 1:Npatterns
        U2=0;
        for i=1:Nhidden+1 
            U2 = U2 + W2(i) * U1(i,k);
        end
        for i=1:Nhidden+1
            W2(i) = W2(i) + n * (trOutputs(k) - U2) * U1(i,k);
        end
        
        E(k) = 0.5 * ((trOutputs(k) - U2)^2);
        
    end

    %calculation of the mean square error
    currentMSE = MSE(E);
    v_MSE(epochs) = currentMSE;  
end

disp('Number of epochs');
disp(epochs);

disp('Mean squared error');
disp(currentMSE);

figure; 
axes;
hold on;
title('MSE x Epochs');
xlabel('Epochs'); ylabel('Mean Squared Error');
v_epocas = 1:1:epochs;
plot(v_epocas, v_MSE);

Test = csvread('TestSet.csv');

testInputs = Test(:,1:3)';

[N,Npatterns] = size(testInputs);

%Gaussian application in the test data to create inputs to the output layer
for k = 1:Npatterns
    Nhidden = size(W1,1);
    for j = 1:Nhidden
        tmp=0;
        for i=1:N
           tmp = tmp + (testInputs(i,k) - W1(j,i))^2; 
        end
        Utmp(j,k) = exp(-1*tmp/(2*V1(j)));
    end
end

%addition of the bias to the output layer
for k=1:Npatterns
    for i=1:Nhidden+1
        if i==1
            U1Teste(i,k) = -1;
        else
            U1Teste(i,k) = Utmp(i-1,k);            
        end
    end
end

%creation of the obtained outputs vector
for k=1:Npatterns
U2Teste(k)=0;
   for i=1:Nhidden+1 
        U2Teste(k) = U2Teste(k) + W2(i) * U1Teste(i,k);
   end
end

disp('Output');
disp(U2Teste');

%Desired output for test
testOutputs = Test(:,4)';

MRE = 0;
VAR = 0;

%calculates mean relative error and variance
for i = 1:Npatterns
    MRE = MRE + (abs(U2Teste(i) - testOutputs(i))); 
    VAR = VAR + ((U2Teste(i) - testOutputs(i))^2);
end

MRE = (MRE / Npatterns) * 100;
VAR = (VAR / Npatterns) * 100;

disp('Mean relative error');
disp(MRE);

disp('Variance');
disp(VAR);

