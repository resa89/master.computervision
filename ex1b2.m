img = imread('ambassadors.jpg'); % JPG-Datei einlesen
%gray = rgb2gray(im_uint8);
img = im2double(img);

neighbor = 0;

[m,n,o] = size(img);
newM = zeros(m*3, n*3, o);

imgTmp = zeros(m*3, n*3, o);
for i=1:m
    for j=1:n
        imgTmp(m+i, n+j, :) = img(i,j,:);
    end
end
img = imgTmp;


% scale x*0.8 and y*1.2
A = [0.8 0; 0 1.2];
newM = zeros(m*3, n*3, o);
img = transfrom(A, img, [0,0], neighbor, newM);

% scale diagonal*1.5 and the other diagonal *0.5
%A = [1 1.5; 0 1];
%newM = zeros(m*3, n*3, o);
%img = transfrom(A, img, [0,0], 0, newM);

%A = [1 0; 0.5 1];
%newM = zeros(m*3, n*3, o);
%img = transfrom(A, img, [0,0], 0, newM);


% rotate 45 deg to stretch the diagonals
beta = 45;
A = [cosd(beta) -sind(beta); sind(beta) cosd(beta)];
img = transfrom(A, img, [0,0], neighbor, newM);

% scale diagonale1*1.5 and diagonale2*0.5
A = [2.5 0; 0 0.5];
newM = zeros(m*3, n*3, o);
img = transfrom(A, img, [0,0], neighbor, newM);

% redo rotation for diagonal stretching
beta = -45;
A = [cosd(beta) -sind(beta); sind(beta) cosd(beta)];
img = transfrom(A, img, [0,0], neighbor, newM);
   
% rotate 30 deg & scale 0.7
alpha = 10;
A = [cosd(alpha) -sind(alpha); sind(alpha) cosd(alpha)];
% A = 0.7 * A;
img = transfrom(A, img, [0,0], neighbor, newM);

imshow(img);   % Bild darstellen