alpha = 30;

%img = imread('gletscher.jpg');
img = imread('ambassadors.jpg');

%img = rgb2gray(img);
imgD = im2double(img);

A = [cosd(alpha) -sind(alpha) 0; sind(alpha) cosd(alpha) 0; 0 0 1];
A = transpose(A);

%which transfrom % shows if string is a variable or function
abc = transfrom(A, imgD, [0,0,0], 0);

imshow(abc);   % Bild darstellen