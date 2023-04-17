%SOM: self-organizing map artificial neural networ implemenation
%Author: Luciano Andrade

clc;
clear all;

Grid{1,1} = [5 2];
Grid{2,1} = [1 3 6];
Grid{3,1} = [2 4 7];
Grid{4,1} = [3 8];
Grid{5,1} = [1 6 9];
Grid{6,1} = [2 5 7 10];
Grid{7,1} = [3 6 8 11];
Grid{8,1} = [4 7 12];
Grid{9,1} = [5 10 13];
Grid{10,1} = [6 9 11 14];
Grid{11,1} = [7 10 12 15];
Grid{12,1} = [8 11 16];
Grid{13,1} = [9 14];
Grid{14,1} = [10 13 15];
Grid{15,1} = [11 14 16];
Grid{16,1} = [12 15];

n = 0.001;
Nneurons=16;

trSet = csvread('TrainingSet.csv');

[Npatterns,N] = size(trSet);

W = rand(Nneurons,3);
previousW = zeros(Nneurons,3);

epoch=0;

while sum(sum(abs(previousW - W))) > 10^-5
    previousW = W;
    epoch = epoch + 1;
    
    for i = 1:Nneurons
         set{i,1} = [];
    end
   
    for k=1:Npatterns
        for i=1:Nneurons
           distance(i) = (W(i,:) - trSet(k,:))*(W(i,:) - trSet(k,:))'; 
        end
        
        winner = find(distance == min(distance));
        set{winner} = [set{winner} k];
        W(winner,:) = W(winner,:) + n * (trSet(k,:) - W(winner,:));
        
        for j=1:size(Grid{winner},2)
           neighbor = Grid{winner}(j);
           W(neighbor,:) = W(neighbor,:) + n * (trSet(k,:) - W(neighbor,:));
        end
    end  
    
end

disp('Neurons activated by training patterns.');
for i = 1:Nneurons
    if size(set{i},2) > 0
        disp(['Neuron number:' int2str(i)]);
    end
  disp(set{i,1});
end

sampleSet = csvread('SamplesSet.csv');

[Nsamples,N] = size(sampleSet);

for k=1:Nsamples
   for i=1:Nneurons
      distance(i) = (W(i,:) - sampleSet(k,:))*(W(i,:) - sampleSet(k,:))'; 
   end
   winner(k) = find(distance == min(distance));

end

disp('Neurons activated for new samples to be classified.');
disp(winner);


