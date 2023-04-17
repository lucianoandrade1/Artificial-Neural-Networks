%Mean squared error calculation function
%Author: Luciano Andrade
function res = MSE(d,Y2)
    res = 0;
    sizeD = size(d,1) * size(d,2);

    for i = 1:size(d,2)
        for j=1:size(d,1)
            res = res + 0.5 * (d(j,i)- Y2(j,i))^2; 
        end
    end
    
    res = res / sizeD;
    
end
