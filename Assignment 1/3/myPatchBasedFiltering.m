function[new_img] = myPatchBasedFiltering(img)
%read1 = imread(img);
[i,j]  = size(img);
y = double(img) + 12.75*randn(i,j);
m = i+32;
n = j+32;
a = zeros(m,n);
a1 = zeros(i,j);
for k = 1:i
    for l = 1:j
        a(16+k,16+l) = y(k,l);
    end
end

for b = 17:m-16 
    for c = 17:n-16
        totalWeight = 0;
        weightedSum = 0;
        for d = b-12:b+12
            for e = c-12:c+12
                intensityDiff = 0;
                for f = -4:+4
                    for g = -4:+4
                        intensityDiff = intensityDiff + (abs(a(b+f,c+g)-a(d+f,e+g)))^2;
                    end
                end
                intensityWeight = exp(-intensityDiff/(100^2)); % replace 100 by h
                gaussianWeight = exp(-((b-d)^2+(c-e)^2)/((2*18)^2)); % replace 10 by sigma
                totalWeight = totalWeight + intensityWeight * gaussianWeight;

                weightedSum = weightedSum + intensityWeight * gaussianWeight * a(d, e);
            end
        end
    a1(b - 16, c - 16) = weightedSum/totalWeight;
    end
end
gaussianMask = zeros(25,25);
for r = 1:25
    for s = 1:25
        gaussianMask(r,s) = 256*exp(-((12-r)^2+(12-s)^2)/(2*22.5^2)) - 1;
    end
end
  gaussianMaskResized = zeros(250,250);
  gaussianMaskResized = imresize(gaussianMask,10);
 figure, 
     imshow(uint8(gaussianMask)),colorbar;
     title('Isotropic Mask');
 figure, 
     imshow(uint8(gaussianMaskResized)),colorbar;
     title('Isotropic Mask x 10');
         
 figure,
 
     imshow(img),colorbar;
     title('Original Image');
 figure,
     imshow(uint8(a1)),colorbar;
     title('Final Image');
figure,
     imshow(uint8(y)),colorbar;
   title('Corrupted Image');
% sigma = 25
% RMSD = myRMSD(uint8(a1),img);
% RMSD

end