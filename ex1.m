alpha = 30;

im_uint8 = imread('gletscher.jpg'); % JPG-Datei einlesen
gray = rgb2gray(im_uint8);
%imagesc(gray);   % Bild darstellen

A = [cosd(alpha) -sind(alpha) 0; sind(alpha) cosd(alpha) 0; 0 0 1];
A = transpose(A);

%which transfrom % shows if string is a variable or function
abc = transfrom(A, gray);

imshow(abc);   % Bild darstellen