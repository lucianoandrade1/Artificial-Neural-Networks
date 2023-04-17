%Mean squared error calculation function
%Author: Luciano Andrade
function resp = MSE(trInput, weights, trOutput, p)
                                                        
sum = 0;

for i = 1:p;
    u = trInput (i,:) * weights.';
    
    %difference between the desired and obtained outputs
    dif_du = trOutput(i) - u;                          
    dif_du = dif_du ^ 2;
    
    %sum of the average for the selected training set
    sum = sum + dif_du;                               
    i = i+1;
end

    resp = sum/p;
    return
