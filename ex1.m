alpha = 30;

%im_uint8 = imread('gletscher.jpg');
im_uint8 = imread('ambassadors.jpg');

gray = rgb2gray(im_uint8);
grayD = im2double(im_uint8);

A = [cosd(alpha) -sind(alpha) 0; sind(alpha) cosd(alpha) 0; 0 0 1];
A = transpose(A);

%which transfrom % shows if string is a variable or function
abc = transfrom(A, grayD, [0,0,0], 0);

imshow(abc);   % Bild darstellen