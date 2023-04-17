%ART: Adaptive resonance theory artificial neural networ implemenation
%Author: Luciano Andrade

clc;
clear all;

trSet = csvread('Training.csv');

vigilance = 0.8;

[Npatterns, Ninputs] = size(trSet);

for i=1:Npatterns
    for j=1:Ninputs
        Wf(j,i) = 1/(1 + Npatterns);
        Wb(i,j) = 1;        
    end
end

for i=1:Npatterns
   theta{i,1} = [];
end

for k=1:Npatterns

    for i=1:Npatterns
        u(i) = Wf(:,i)' * trSet(k,:)';
    end

    flag = 0;
    while flag==0
        
        winner = 1;
        uMax = 0;
        for i=1:Npatterns
            if u(i)>uMax
                uMax = u(i);
                winner = i;
            end
        end
        
        dividend = Wb(winner,:) * trSet(k,:)';
        divider = trSet(k,:) * trSet(k,:)';
        
        if (dividend/divider > vigilance)
            sum = Wb(winner,:) * trSet(k,:)';
            for i=1:Ninputs
                Wf(i,winner) = Wb(winner,i) * trSet(k,i) / 0.5 + sum;
                Wb(winner,i) = Wb(winner,i) * trSet(k,i);
            end
            theta{winner,1} = [theta{winner,1} k];
            flag = 1;
        else
            u(winner) = 0;
        end
    end
end

for i=1:Npatterns
  disp (theta{i});
end

