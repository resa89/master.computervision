clc; clear; close all;

img = imread('IMG_0821.JPG'); % JPG-Datei einlesen
img2 = imread('IMG_0822.JPG'); % JPG-Datei einlesen
img3 = imread('IMG_0823.JPG'); % JPG-Datei einlesen
img4 = imread('IMG_0824.JPG'); % JPG-Datei einlesen

img = im2double(img);
img2 = im2double(img2);
img3 = im2double(img3);
img4 = im2double(img4);

x1 = [10.5 12.5 224 223.5] * 10;
x2 = [224 223.5 347.5 347.5]* 10;
x3 = [347.5 347.5 413.5 413.5] * 10;
x4 = [413.5 413.5 566 566]* 10;

y = [20 97 20 97] * 10;



% Pixels for 1st picture
scale2 = 1;
xp1 = [335  401 3100 3103] / scale2;
yp1 = [443 1443  404 1425] / scale2;
xp2 = [1471 1443 3097 3059];
yp2 = [ 451 1447  439 1487];

xp3 = [969  974 1960 1952] / scale2;
yp3 = [389 1561  381 1566] / scale2;
xp4 = [259  263 2754 2759] / scale2;
yp4 = [363 1655  353 1659] / scale2;

% Plakat
% dx = 500;
% dy = 1000;
% xv = [0+dx 420+dx];
% y = [0+dy 594+dy];
% xp1 = [ 478  529 1258 1258 ];
% yp1 = [1194 2247 1199 2247 ];

newM = zeros(3000, 14000, 4);
newM = rectification2(x1, xp1, y, yp1, img, newM, 0, 0);
newM = rectification2(x2, xp2, y, yp2, img2, newM, 0, 0);
newM = rectification2(x3, xp3, y, yp3, img3, newM, 0, 0);
newM = rectification2(x4, xp4, y, yp4, img4, newM, 0, 0);

imshow(newM(:,:,1:3));   % Bild darstellen
% imshow(newM2);   % Bild darstellen
%  imshow(img4);