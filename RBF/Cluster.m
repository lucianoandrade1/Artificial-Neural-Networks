%Function that finds N1 centroids and their variances
%Author: Luciano Andrade
function  [W1,var] = Cluster(trInputs,Nhidden)
    [N,Npatterns] = size(trInputs);

    for i=1:Nhidden
        for j=1:N
            W1(i,j) = trInputs(j,i);
        end
    end

    %Adjustment of input layer weights W1
    while true
    
        for i = 1:Nhidden
            theta{i,1} = [];
        end

        for k=1:Npatterns
            for j=1:Nhidden
                d(j,1)=0;
                for i=1:N
                    d(j,1) = d(j,1) + (W1(j,i) - trInputs(i,k))^2;
                end
                d(j,1) = sqrt(d(j,1));
            end
            theta{min(find(d == min(d))),1} = [theta{min(find(d == min(d))),1} k];
        end    
        previsousW1 = W1;
    
        sum = zeros(size(theta,1),size(trInputs,1));
        for j=1:size(theta,1)
            for i=1:N
                for n=1:size(theta{j},2)
                    pos = theta{j}(n);
                    sum(j,i) = sum(j,i) + trInputs(i,pos)';
                end
                W1(j,i) = sum(j,i)/n;
            end
        end

        %Checks whether there was no change in the weights to stop the 
        %adjustments.
        if previsousW1 == W1 
            break; 
        end
    end
    
    %Calculation of variance
    Nhidden = size(theta,1);
    N = size(trInputs,1);
    var = zeros(Nhidden,1);
    for j = 1:Nhidden
        for n = 1:size(theta{j,1},2)
            pos = theta{j,1}(n);
            tmp=0;
            for i=1:N
                tmp = tmp + (trInputs(i,pos) - W1(j,i))^2;
            end
            var(j,1) = var(j,1) + tmp;
        end
        var(j,1) = var(j,1)/n;    
    end
    
   
end

