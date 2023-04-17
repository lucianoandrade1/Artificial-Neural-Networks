%ADALINE single-layer artificial neural networ implemenation
%Author: Luciano Andrade

clear all;
clc;

tr = csvread('TrainingSet.csv');

trInput = tr(1:end,1:5);

trOutput = tr(1:end,6);

weights = rand (1,5);

disp('---------------------------------------------------------------------');
disp('Initial list of weights:');
disp(weights);

p = 35;                     %number of training inputs
epochs = 0;                  %number of training epochs
n = 0.0025;                 %learning ratio
i = 1;                      
v_MSE= 1:1:1;
dif = 1;                    %exit condition
precision = 0.000001;        %training precision

    while (dif > precision);
        
        %mean squared error calculation function
        mse_ant = MSE(trInput, weights, trOutput, p); 
        
        epochs = epochs + 1;
        
        for i = 1:p;
            u = trInput (i,:) * weights.';
            weights = weights + n * (trOutput(i) - u) * trInput (i,:);   
            i = i+1;
        end
        
        %mean squared error calculation function
        current_mse = MSE(trInput, weights, trOutput, p);  
        
        v_MSE(epochs) = current_mse;
        
        %difference between mean squared error for weights before and after training
        dif = abs(current_mse - mse_ant);
        
    end      
    
   disp('Final list of weights:');
   disp (weights);
   disp('Epochs:');
   disp(epochs);
   disp('---------------------------------------------------------------------');
   
    v_epocas = 1:1:epochs;
    plot (v_epocas, v_MSE)  %curve of mean square error for each training epoch
    
