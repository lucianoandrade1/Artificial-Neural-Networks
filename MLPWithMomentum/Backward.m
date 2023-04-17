%function implementation for backward backpropagation
%Author: Luciano Andrade
function [delta2, delta1, W1, W2] = Backward(W1, W2, previousW1, ...
             previousW2, I1, I2, Y1, Y2, trOutputs, n, trInputs, k, alpha)

    delta1 = zeros(15,1);
    delta2 = zeros(3,1);
    
    for i = 1:3
        delta2(i) = (trOutputs(i,k) - Y2(i,k)) * DLogistic(I2(i));
    end
    
    for j=1:3
        for i = 1:15
            temp = W2(j,i);
            W2(j,i) = W2(j,i) + n * delta2(j) * Y1(i) + alpha * (W2(j,i) - previousW2(j,i)); 
            previousW2(j,i) = temp;
        end
    end
    
    for j = 1:15
        for i = 1:3
            delta1(j) = delta1(j) + delta2(i) * W2(i,j) * DLogistic(I1(j));
        end
        for i = 1:5
            temp = W1(j,i);
            W1(j,i) = W1(j,i) + n * delta1(j) * trInputs(i,k) + alpha * (W1(j,i) - previousW1(j,i));
            previousW1(j,i) = temp;
        end
    end
end
    
