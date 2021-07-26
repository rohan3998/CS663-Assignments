function y = myHarrisCornerDetector(img)
m1 = max(max(img));
m2 = min(min(img));
[m,n] = size(img);
eig_small = zeros(m,n);
eig_large = zeros(m,n);
img2 = zeros(m,n);
for i =1:m
    for j = 1:n
        img2(i,j) = (img(i,j)-m2)/(m1-m2);
    end
end
%%
% $\sigma_{x}$ = 0.4
% $\sigma_{y}$ = 0.4
% k = 0.1
sigma_x = 0.4;
sigma_y = 0.4;
key = 0.10;

%%
[grad_x,grad_y] = imgradientxy(img2);
figure(1),
    imshow(grad_x);
    colorbar;
    title('I_x');
    axis on;
figure(2),
    imshow(grad_y);
    colorbar;
    axis on;
    title('I_y');
    
 %%
eigen_small = zeros(m,n);
eigen_large = zeros(m,n);
partial = zeros(2,2);
A = zeros(2,2);
cornerness = zeros(m,n);
output = zeros(m,n);
for i = 1:m
    for j = 1:n
        for k = max(i-1,1):min(i+1,m)
            for l = max(j-1,1):min(j+1,n)
                partial = (1/(2*pi))*(1/sigma_x)*(1/sigma_y)*exp(-0.5*(i-k)^2/(sigma_x)^2)*exp(-0.5*(j-l)^2/(sigma_y)^2).*[grad_x(k,l)*grad_x(k,l), grad_x(k,l)*grad_y(k,l);grad_x(k,l)*grad_y(k,l), grad_y(k,l)*grad_y(k,l)];
                A = A+ partial;
            end
        end
        eigen_value = eig(A);   
        eigen_small(i,j) = eigen_value(1,1);
        eigen_large(i,j) = eigen_value(2,1);
        cornerness(i,j) = det(A) - key*(trace(A)^2);
        A = zeros(2,2);
        if(cornerness(i,j) < 0)
            cornerness(i,j) = 0;
        else
            cornerness(i,j) = 50*cornerness(i,j);
        end
    end
end
[r,c] = find(cornerness > 0.8);
mark = cat(2,c,r);
output = img2;
%output = insertMarker(img2,mark,'color','red','size',4); 
% cornerness = cornerness>0;
%%
figure(3),
    imshow(eigen_small);
    colorbar;
    axis on;
    title('Small Eigen Value');
figure(4),
    imshow(eigen_large);
    colorbar;
    axis on;
    title('Large Eigen Value');
    %%
figure(5),
    imshow(cornerness);
    colorbar;
    axis on;
    title('Corners');

figure(6),
    imshow(output);
    colorbar;
    axis on;
    hold on;
    for x=1:247
                plot(mark(x,1),mark(x,2),'r+','MarkerSize',5);
    end
    
    title('Corner Detector');
    