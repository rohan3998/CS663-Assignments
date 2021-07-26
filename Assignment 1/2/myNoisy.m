function[new_img]=myNoisy(img)
[m n p]=size(img);
new_img=zeros(size(img));
frac_std=0.05;
img=im2double(img);
for i=1:p
    int_range=max(max(img(:,:,i)))-min(min(img(:,:,i)));
    new_img(:,:,i)=img(:,:,i)+frac_std*int_range*randn(m,n);
end
imwrite(new_img,"noisyhoneycombreal.png");
figure(1)
imshow(img);
figure(2)
imshow(new_img);
end