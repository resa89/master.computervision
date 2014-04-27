img = imread('ambassadors.jpg'); % JPG-Datei einlesen
%gray = rgb2gray(im_uint8);
img = im2double(img);

[m,n,o] = size(img);
newM = zeros(m*3, n*3, o);

imgTmp = zeros(m*3, n*3, o);
for i=1:m
    for j=1:n
        imgTmp(m+i, n+j, :) = img(i,j,:);
    end
end
img = imgTmp;
    
% rotate 30 deg & scale 0.7
alpha = 30;
A = [cosd(alpha) -sind(alpha); sind(alpha) cosd(alpha)];
A = 0.7 * A;
img = transfrom(A, img, [0,0], 0, newM);


% scale x 0.8
A = [0.8 0; 0 1.2];
newM = zeros(m*3, n*3, o);
img = transfrom(A, img, [0,0], 0, newM);

imshow(img);   % Bild darstellen