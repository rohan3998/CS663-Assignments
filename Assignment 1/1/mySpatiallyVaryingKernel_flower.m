function[new_img] = mySpatiallyVaryingKernel_flower(img)
img = imresize(img,0.5);
gray = rgb2gray(img);
% figure,
% imshow(gray);
 n = ones(3);
 filter = stdfilt(gray,n);
% imshow(filter);
binary1 = filter>7.5;
binary1= imfill(binary1,'holes');
binary1= bwareafilt(binary1,1);
%  figure(1),
%   imshow(binary1);
%   title('mask');

 [x y z]=size(img);
 img_b = img;
 img_c = img;
 for i=1:z
     for j=1:x
         for k=1:y
             if(binary1(j,k)==0)
                 img_b(j,k,i) = 0;
             end
             if(binary1(j,k)~=0)
                 img_c(j,k,i) = 0;
         end
     end
     end
 end
% figure,
%  imshow(img_b);
%  title('bpart');
% figure,
%  imshow(img_c);
%  title('cpart');
figure(5);
subplot(1,3,1);
imshow(binary1);
axis on
colorbar;
%caxis([0 255]);
title("mask");
subplot(1,3,2);
imshow(img_b);
axis on;
colorbar;
caxis([0 255]);
title("foreground");
subplot(1,3,3);
imshow(img_c);
axis on;
colorbar;
caxis([0 255]);
title("background");
 
                 

dist = bwdist(binary1);
int8(dist);


[m n] =size(dist);
for i=1:m
    for j=1:n
        if(dist(i,j)>40)
            dist(i,j)=40;
        end
    end
end
figure(6),
contour(dist);


sum1 = uint64(0);
sum2 = uint64(0);
sum3 = uint64(0);
count = uint64(0);


img3=img;
 kernel1 = zeros(2*8+1,2*8+1,3);
 kernel2 = zeros(2*16+1,2*16+1,3);
 kernel3 = zeros(2*24+1,2*24+1,3);
 kernel4 = zeros(2*32+1,2*32+1,3);
 kernel5 = zeros(2*40+1,2*40+1,3);
 
     for j=1:x
         for k=1:y
             if(dist(j,k)~=0)
                 sum=uint64(0);
                 sum1 = uint64(0);
                 sum2 = uint64(0);
                 sum3 = uint64(0);

                 count=uint64(0);
%                   d1=min(dist(j,k),x-j);
%                   d2=min(dist(j,k),y-k);
%                   d3=min(dist(j,k),j-1);
%                   d4=min(dist(j,k),k-1);

                for j1=j-dist(j,k):j+dist(j,k)
                    for k1=k-dist(j,k):k+dist(j,k)
                       d=sqrt((j-j1)^2 + (k-k1)^2);
                       if(d<dist(j,k) && j1>=1 && j1<=x && k1>=1 && k1<=y)
                          
                           if(dist(j,k)==8)
                               kernel1(j1-j+dist(j,k)+1,k1-k+dist(j,k)+1,1)=img(uint16(j1),uint16(k1),1);
                               kernel1(j1-j+dist(j,k)+1,k1-k+dist(j,k)+1,2)=img(uint16(j1),uint16(k1),2);
                               kernel1(j1-j+dist(j,k)+1,k1-k+dist(j,k)+1,3)=img(uint16(j1),uint16(k1),3);
                           end
                           if(dist(j,k)==16)
                               kernel2(j1-j+dist(j,k)+1,k1-k+dist(j,k)+1,1)=img(uint16(j1),uint16(k1),1);
                               kernel2(j1-j+dist(j,k)+1,k1-k+dist(j,k)+1,2)=img(uint16(j1),uint16(k1),2);
                               kernel2(j1-j+dist(j,k)+1,k1-k+dist(j,k)+1,3)=img(uint16(j1),uint16(k1),3);
                           end
                           if(dist(j,k)==24)
                               kernel3(j1-j+dist(j,k)+1,k1-k+dist(j,k)+1,1)=img(uint16(j1),uint16(k1),1);
                               kernel3(j1-j+dist(j,k)+1,k1-k+dist(j,k)+1,2)=img(uint16(j1),uint16(k1),2);
                               kernel3(j1-j+dist(j,k)+1,k1-k+dist(j,k)+1,3)=img(uint16(j1),uint16(k1),3);
                           end
                               if(dist(j,k)==32)
                               kernel4(j1-j+dist(j,k)+1,k1-k+dist(j,k)+1,1)=img(uint16(j1),uint16(k1),1);
                               kernel4(j1-j+dist(j,k)+1,k1-k+dist(j,k)+1,2)=img(uint16(j1),uint16(k1),2);
                               kernel4(j1-j+dist(j,k)+1,k1-k+dist(j,k)+1,3)=img(uint16(j1),uint16(k1),3);
                               end
                               if(dist(j,k)==40)
                               kernel5(j1-j+dist(j,k)+1,k1-k+dist(j,k)+1,1)=img(uint16(j1),uint16(k1),1);
                               kernel5(j1-j+dist(j,k)+1,k1-k+dist(j,k)+1,2)=img(uint16(j1),uint16(k1),2);
                               kernel5(j1-j+dist(j,k)+1,k1-k+dist(j,k)+1,3)=img(uint16(j1),uint16(k1),3);
                               end
                           sum1=sum1+uint64(img(uint16(j1),uint16(k1),1));
                           sum2=sum2+uint64(img(uint16(j1),uint16(k1),2));
                           sum3=sum3+uint64(img(uint16(j1),uint16(k1),3));
                           count=count+1;
                            end
                       
                                      end
                       
                end
                    sum1 = sum1/count;
                sum2 = sum2/count;
                sum3 = sum3/count;
                img3(j,k,1)=sum1;
                img3(j,k,2)=sum2;
                img3(j,k,3)=sum3;
                
                end
                
             end
            
         end
     
 figure(7);
subplot(2,3,1);
imshow(kernel1);
axis on;
colorbar;
caxis([0 255]);
title("0.2*threshold");
subplot(2,3,2);
imshow(kernel2);
axis on;
colorbar;
caxis([0 255]);
title("0.4*threshold");
subplot(2,3,3);
imshow(kernel3);
axis on;
colorbar;
caxis([0 255]);
title("0.6*threshold");
subplot(2,3,4);
imshow(kernel4);
axis on;
colorbar;
caxis([0 255]);
title("0.8*threshold");
subplot(2,3,5);
imshow(kernel5);
axis on;
colorbar;
caxis([0 255]);
title("threshold");

 
 figure(8);
 imshow(img3);
 axis on;
colorbar;
caxis([0 255]);
 
 title('blurred image');
% contour(dist);
% figure(2),
%imshow(contour);
% [x y z] = size(img);
% dist = zeros(x,y,z);
% max_dist = sqrt(x^2 + y^2);
% for i=1:z
%     for j=1:x
%         for k=1:y
end       

