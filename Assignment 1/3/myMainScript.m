%% MyMainScript

tic;
%% Grass
img1 = imread('grass.png');
myPatchBasedFiltering(img1);
% h = 100
% Sigma = 20
% RMSD(Sigma) = 0.0382
% RMSD(0.9*Sigma) = 0.0385
% RMSD(1.1*Sigma) = 0.0387
%% HoneyComb
img2 = imread('honeyCombReal.png');
myPatchBasedFiltering(img2);
% h = 100
% Sigma = 20
% RMSD(Sigma) = 0.0384
% RMSD(0.9*Sigma) = 0.0387
% RMSD(1.1*Sigma) = 0.0387
%% Barbara
img3 = load('barbara.mat');
img3=struct2array(img3);
img3 = uint8(img3);
% i = mat2gray('3\data\barbara.mat');
% img3 = imread(i);
 myPatchBasedFiltering(img3);
%  h = 100
% Sigma = 20
% RMSD(Sigma) = 0.0297
% RMSD(0.9*Sigma) = 0.0299
% RMSD(1.1*Sigma) = 0.0297
%%
toc;
