%Function that converts the bit vector into images for presentation.
%Author: Luciano Andrade
function Image = ImageProcessing(originalImage, Nrows, Ncols, imageSize)

    %Algorithm to transform the 45 bits into a matrix forming the image
    j=1;
    for k=1:Nrows
        for i=1:Ncols
            Image(k,i) = originalImage(j);
            j = j + 1;
        end
    end

    [M,N] = size(Image);
    
    biggerImage = zeros(Nrows * imageSize, Ncols * imageSize);

    %Algorithm to increase the size of the image for a better presentation.
    Prows = 1;
    Pcols = 1;
    for k=1:Nrows
        for i=1:Ncols
            for j=Prows:Prows + imageSize - 1
                for l=Pcols:Pcols + imageSize - 1
                    biggerImage(j,l) = Image(k,i);
                end
            end
            Pcols = Pcols + imageSize;
        end
        Pcols = 1;
        Prows = Prows + imageSize;
    end
    
    Image = biggerImage;
    
end
