%% MyMainScript


%% Your code here
tic;
img1=imread('bird.jpg');
img2=imread('flower.jpg');
mySpatiallyVaryingKernel(img1);
mySpatiallyVaryingKernel_flower(img2);
toc;