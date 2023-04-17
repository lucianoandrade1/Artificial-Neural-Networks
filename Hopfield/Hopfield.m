%Hopfield: Hopfield recurrent artificial neural network  implemenation
%Author: Luciano Andrade

clc; 
clear all; 

imageID = 1;% 2 3 4
Npatterns = 4;
NBits = 45;
noisePercentage = 0.2;

originalImage = InputImages;

%Algorithm for generating of noise
for k=1:Npatterns
        noisyImage{k} = originalImage{k};
        noise = round(NBits * rand(round(noisePercentage * NBits),1) + 0.5);
        for i=1:size(noise,1)
           noisyImage{k}(noise(i)) = -1 * noisyImage{k}(noise(i));
        end
end
    
W = zeros(NBits);

for k=1:Npatterns
    W = W + originalImage{k} * originalImage{k}';
end

W = (1/NBits) * W - Npatterns / NBits * eye(NBits);
W = TGH(W,1000);

currentV = noisyImage{imageID};
previousV = zeros(NBits,1);

while (currentV ~= previousV)
    previousV = currentV;
    u = W * previousV;
    currentV = TGH(u,20);
end

    %function that converts the bit vector into images for presentation.
    ImgTrans = ImageProcessing(originalImage{imageID}, 9, 5, 5);
    ImgRuido = ImageProcessing(noisyImage{imageID}, 9, 5, 5);
    ImgLimpa = ImageProcessing(currentV, 9, 5, 5);

    figure;
    subplot(1,3,1), imshow(-1 * ImgTrans);
    subplot(1,3,2), imshow(-1 * ImgRuido);
    subplot(1,3,3), imshow(-1 * ImgLimpa);

    
