clc; clear; close all;

img = imread('IMG_0821.JPG'); % JPG-Datei einlesen
img2 = imread('IMG_0821.JPG'); % JPG-Datei einlesen
img = im2double(img);
img2 = im2double(img2);

x1 = [10.5 12.5 224 223.5] * 10;
y1 = [20 97 20 97] * 10;

% Pixels for 1st picture
scale2 = 1;
xp1 = [335  401 3100 3103] / scale2;
yp1 = [443 1443  404 1425] / scale2;

% Plakat
% dx = 500;
% dy = 1000;
% xv = [0+dx 420+dx];
% y = [0+dy 594+dy];
% xp1 = [ 478  529 1258 1258 ];
% yp1 = [1194 2247 1199 2247 ];

newM = rectification(x1, xp1, y1, yp1, img);

imshow(newM);   % Bild darstellen
% imshow(img);