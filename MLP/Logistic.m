%function implementation for logistic ativation function (forward)
%Author: Luciano Andrade
function res = Logistic(I)
    Nrows = size(I,1);
    Ncols = size(I,2);
    
    for j = 1:Ncols
        for i = 1:Nrows
            res(i,j) = 1 / (1 + (exp(-0.5*I(i,j))));
        end
    end
end
