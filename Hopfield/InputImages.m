%Function of input 45-bit vectors representing transmitted images.
%Author: Luciano Andrade
function Imagens = InputImages()
    Imagens{1} = [-1 -1  1  1 -1 -1  1  1  1 -1 -1 -1  1  1 -1 -1 -1  1  1 -1 -1 -1  1  1 -1 -1 -1  1  1 -1 -1 -1  1  1 -1 -1 -1  1  1 -1 -1 -1  1  1 -1]'; 
    Imagens{2} = [ 1  1  1  1  1  1  1  1  1  1 -1 -1 -1  1  1 -1 -1 -1  1  1  1  1  1  1  1  1  1 -1 -1 -1  1  1 -1 -1 -1  1  1  1  1  1  1  1  1  1  1 ]';
    Imagens{3} = [ 1  1  1  1  1  1  1  1  1  1 -1 -1 -1  1  1 -1 -1 -1  1  1  1  1  1  1  1 -1 -1 -1  1  1 -1 -1 -1  1  1  1  1  1  1  1  1  1  1  1  1 ]';
    Imagens{4} = [ 1  1 -1  1  1  1  1 -1  1  1  1  1 -1  1  1  1  1  1  1  1  1  1  1  1  1 -1 -1 -1  1  1 -1 -1 -1  1  1 -1 -1 -1  1  1 -1 -1 -1  1  1 ]';
end
