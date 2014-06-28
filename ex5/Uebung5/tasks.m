clear; clc; close all;
load('flow.mat');
% pic3 = pic1; pic1 = pic2; pic2 = pic3;
% load('flowtest1.mat');
% load('flowtest2.mat');
% load('flowtest3.mat');

% figure('name','Image 1','NumberTitle','off');
% show_img(pic1);

[flow, flow_ortho] = optical_flow(pic1, pic2, 0.001);

% figure('name','Image 2','NumberTitle','off');
% show_img(pic2);
figure;
quiver(flow(1,:), flow(2,:), flow(3,:), flow(4,:),0);
figure;
quiver(flow_ortho(1,:), flow_ortho(2,:), flow_ortho(3,:), flow_ortho(4,:),0);
% flow_ortho