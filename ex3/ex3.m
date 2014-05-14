clc; clear; close all;

img = imread('IMG_0813.JPG'); % JPG-Datei einlesen
img2 = imread('2.JPG'); % JPG-Datei einlesen
img = im2double(img);
img2 = im2double(img2);

dx = 381;
dy = 108;

% All X coordinates for passpoints
xv = [0 350 7 10.5 13.5];

% All Y coordinates for passpoints
y = [0 600];


% Pixels for 1st picture
s = 3;
xp1 = [381/s  548/s 2316/s 2284/s];
yp1 = [108/s 2829/s   74/s 2829/s];

% % Small pic
% xp1 = [30  33 143 141];
% yp1 = [ 5 174   5 173];

% Plakat
% dx = 500;
% dy = 1000;
% xv = [0+dx 420+dx];
% y = [0+dy 594+dy];
% xp1 = [ 478  529 1258 1258 ];
% yp1 = [1194 2247 1199 2247 ];

newM = rectification([xv(1) xv(1) xv(2) xv(2)], xp1, [y(1) y(2) y(1) y(2)], yp1, img);

imshow(newM);   % Bild darstellen
% imshow(img);