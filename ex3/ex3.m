clc; clear; close all;

img = imread('IMG_0813.JPG'); % JPG-Datei einlesen
img2 = imread('2.JPG'); % JPG-Datei einlesen
img = im2double(img);
img2 = im2double(img2);

dx = 500;
dy = 1000;

% All X coordinates for passpoints
xv = [0+dx 3.5+dx 7+dx 10.5+dx 13.5+dx];

% All Y coordinates for passpoints
y = [0+dy 5+dy];

% Pixels for 1st picture
% xp1 = [ 76/80  538/80 2302/80 2284/80];
% yp1 = [382/80 2836/80   64/80 2818/80];

% % Small pic
% xp1 = [30  33 143 141];
% yp1 = [ 5 174   5 173];

% Plakat
xv = [0+dx 420+dx];
y = [0+dy 594+dy];
xp1 = [ 478  529 1258 1258 ];
yp1 = [1194 2247 1199 2247 ];
newM = rectification([xv(1) xv(1) xv(2) xv(2)], xp1, [y(1) y(2) y(1) y(2)], yp1, img);

imshow(newM);   % Bild darstellen
% imshow(img);