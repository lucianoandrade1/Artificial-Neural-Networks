%Hyperbolic tangent function
%Author: Luciano Andrade
function tgh = TGH(u, beta)
    
    tgh = (exp(beta * u) - exp(-beta * u))./(exp(beta * u) + exp(-beta * u));
    
end
