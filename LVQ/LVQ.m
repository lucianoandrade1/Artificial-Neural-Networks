%LVQ: learning vector quantization artificial neural networ implemenation
%Author: Luciano Andrade

clc;
clear all;

n = 0.05;
NClasses = 4;

trSet = csvread('trSet.csv');

trInput = trSet(:,1:6)';
trOutput = trSet(:,7)';

[N,NPatterns] = size(trInput);
W = rand(N,NClasses);
previousW = zeros(N,NClasses);

while norm(W - previousW) > 10^-7
    previousW = W;
    for k = 1:NPatterns          
        for j = 1:NClasses
            lvqNorm(j) = norm(trInput(:,k) - W(:,j));
        end
        j = min(find((lvqNorm==min(lvqNorm))));
        
        if j==trOutput(k)
            W(:,j) = W(:,j) + n * (trInput(:,k) - W(:,j));
        else
            W(:,j) = W(:,j) - n * (trInput(:,k) - W(:,j));
        end    
    end
end

samples = csvread('TestSet.csv')';

[lin,NPatterns] = size(samples);

for k = 1:NPatterns
    for j = 1:NClasses
        lvqNorm(j) = norm(samples(:,k) - W(:,j));
    end
    j = min(find((lvqNorm==min(lvqNorm))));
    out(k) = j;
end


disp('Final classification of LVQ.');
disp(out);

