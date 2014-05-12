clc; clear; close all;

img = imread('1.JPG'); % JPG-Datei einlesen
img2 = imread('2.JPG'); % JPG-Datei einlesen
img = im2double(img);
img2 = im2double(img2);

dx = 100;
dy = 100;

% All X coordinates for passpoints
xv = [0+dx 3.5+dx 7+dx 10.5+dx 13.5+dx];

% All Y coordinates for passpoints
y = [0+dy 5+dy];

% Pixels for 1st picture
xp1 = [ 76  538 2302 2284];
yp1 = [382 2836   64 2818];

newM = rectification([xv(1) xv(1) xv(2) xv(2)], xp1, [y(1) y(2) y(1) y(2)], yp1, img);

imshow(newM);   % Bild darstellen
% imshow(img);