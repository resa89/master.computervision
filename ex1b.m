alpha = 45;
scale = 0.7;

A = [cosd(alpha) -sind(alpha) 0; sind(alpha) cosd(alpha) 0; 0 0 1];
A = transpose(A);

img = imread('ambassadors.jpg'); % JPG-Datei einlesen
%gray = rgb2gray(im_uint8);
imgD = im2double(img);
%imagesc(gray);   % Bild darstellen

img = imresize(grayD, scale);

[m,n] = size(img);
n = n * 0.8;
n = floor(n);
img = imresize(img, [m, n]);


[m,n] = size(img);
m = m * 1.2;
m = floor(m);
img = imresize(img, [m, n]);


%which transfrom % shows if string is a variable or function
img = transfrom(A, img, [0,0,0], 0);


[m,n] = size(img);
n = n * 0.5;
n = floor(n);
img = imresize(img, [m, n]);


[m,n] = size(img);
m = m * 1.5;
m = floor(m);
img = imresize(img, [m, n]);

alpha = -15;
A = [cosd(alpha) -sind(alpha) 0; sind(alpha) cosd(alpha) 0; 0 0 1];
A = transpose(A);
img = transfrom(A, img, [0,0,0], 0);

imshow(img);   % Bild darstellen