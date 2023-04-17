%function implementation for forward backpropagation
%Author: Luciano Andrade
function [I1, Y1, I2, Y2] = Forward(X, W1, W2, k, Y2)
    I1 = zeros(15,1);
    I2 = zeros(3,1);
    for j = 1:15
        for i = 1:5
            I1(j) = I1(j) + X(i,k) * W1(j,i);
        end
    end
    Y1 = Logistic(I1)';
    
    for j = 1:3
        for i = 1:15
            I2(j) = I2(j) + Y1(i) * W2(j,i);
        end
    end
    
    tmp = Logistic(I2)';
    
    for i=1:3
       Y2(i,k)=tmp(i);
    end

end
