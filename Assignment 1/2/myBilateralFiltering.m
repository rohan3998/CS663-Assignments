function[new_img]=myBilateralFiltering(img,sa,sr,w)
[m n p]=size(img);
new_img=zeros(size(img));

noisy_img=zeros(size(img));
frac_std=0.05;
img=im2double(img);
for i=1:p
    int_range=max(max(img(:,:,i)))-min(min(img(:,:,i)));
    noisy_img(:,:,i)=img(:,:,i)+frac_std*int_range*randn(m,n);
end

[X,Y] = meshgrid(-w:w,-w:w);
spaceG = exp(-(X.^2+Y.^2)/(2*sa^2));
img=im2double(img);
for k=1:p
    for i=1:m
        for j=1:n
            imin=max(1,i-w);
            imax=min(m,i+w);
            jmin=max(1,j-w);
            jmax=min(n,j+w);
            winIm=noisy_img(imin:imax,jmin:jmax,k);
            meanIm=winIm-noisy_img(i,j,k);
            intG=exp(-(meanIm.^2/(2*sr*sr)));    %intensity Gaussian
            weights=intG.*spaceG((imin:imax)-i+w+1,(jmin:jmax)-j+w+1);
            Wp=sum(weights(:));
            new_img(i,j,k)=sum(weights(:).*winIm(:))/Wp;
        end
    end
end
figure;
subplot(1,3,1);
imshow(img),colorbar;
title("Original Image");
subplot(1,3,2);
imshow(noisy_img),colorbar;
title("Noisy Image");
subplot(1,3,3);
imshow(new_img),colorbar;
title("Filtered Image");
gaussianMask = zeros(2*w+1,2*w+1);
for r = 1:2*w+1
    for s = 1:2*w+1
        gaussianMask(r,s) = 256*exp(-((w+1-r)^2+(w+1-s)^2)/(2*sa^2));
    end
end
figure;
%gm=zeros((2*w+1)*10,(2*w+1)*10)
%gm=imresize(gaussianMask,10);
imshow(gaussianMask);
imwrite(gaussianMask,"gm.png");
end
