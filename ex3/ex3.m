clc; clear; close all;

img = imread('IMG_0821.JPG'); % JPG-Datei einlesen
img2 = imread('IMG_0822.JPG'); % JPG-Datei einlesen
img = im2double(img);
img2 = im2double(img2);

x1 = [10.5 12.5 224 223.5] * 10;
x2 = [224 223.5 347.5 347.5];
x2 = x2 * 10;
y = [20 97 20 97] * 10;



% Pixels for 1st picture
scale2 = 1;
xp1 = [335  401 3100 3103] / scale2;
yp1 = [443 1443  404 1425] / scale2;

xp2 = [1471 1443 3097 3059];
yp2 = [ 451 1447  439 1487];

% Plakat
% dx = 500;
% dy = 1000;
% xv = [0+dx 420+dx];
% y = [0+dy 594+dy];
% xp1 = [ 478  529 1258 1258 ];
% yp1 = [1194 2247 1199 2247 ];

newM = zeros(3000, 14000, 3);
newM = rectification2(x1, xp1, y, yp1, img, newM, 1, 1);
newM = rectification2(x2, xp2, y, yp2, img2, newM, 1, 1);

imshow(newM);   % Bild darstellen
% imshow(newM2);   % Bild darstellen
% imshow(img2);