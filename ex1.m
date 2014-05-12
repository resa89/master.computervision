alpha = 30;

%img = imread('gletscher.jpg');
img = imread('ambassadors.jpg');

%img = rgb2gray(img);
img = im2double(img);

A = [cosd(alpha) -sind(alpha); sind(alpha) cosd(alpha)];
%A = transpose(A);

%which transfrom % shows if string is a variable or function
newM = zeros(m*3, n*3, o);
abc = transfrom(A, img, [0,0], 0, newM);

imshow(abc);   % Bild darstellen