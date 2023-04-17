%function implementation for logistic ativation function (backward)
%Author: Luciano Andrade
function res = DLogistic(I)
    Nrows = size(I,1);
    Ncols = size(I,2);
        
    for j = 1:Ncols
        for i = 1:Nrows
            res(i,j) = (0.5 * exp(-0.5*I(i,j))) / (1 + (exp(-0.5*I(i,j))))^2;
        end
    end
end
