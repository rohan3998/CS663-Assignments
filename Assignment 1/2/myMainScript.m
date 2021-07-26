%% MyMainScript

tic;
%% Your code here
img1 = imread('grass.png');
img2 = imread('honeyCombReal.png');
img3 = load('barbara.mat');

img3=struct2array(img3);
img3 = uint8(img3);
sg=0.6;
si=3;
sw=5;
myBilateralFiltering(img1,sg,si,sw);
myBilateralFiltering(img2,sg,si,sw);
myBilateralFiltering(img3,sg,si,sw);

toc;

