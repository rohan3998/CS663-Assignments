%% MyMainScript

tic;
%% Your code here
boat = load('boat.mat')
boat = boat.imageOrig;
%% Parameters used
% $\sigma_{x}$ = 0.4  
%
% $\sigma_{y}$ = 0.4
%
% k = 0.1
%%
myHarrisCornerDetector(boat);
toc;
