alpha = 30;

im_uint8 = imread('gletscher.jpg'); % JPG-Datei einlesen
gray = rgb2gray(im_uint8);
%imagesc(gray);   % Bild darstellen
[m,n] = size(gray);

newM = repmat(uint8(0),m*3, n*3);

transform = [cosd(alpha) -sind(alpha) 0; sind(alpha) cosd(alpha) 0; 0 0 1];
transform = transpose(transform);

for i=1:m*3
    for j=1:n*3
        tmp = [i-m j-n 0] * transform;
        iOld = round(tmp(1));
        jOld = round(tmp(2));
        if iOld <= m && iOld > 0 && jOld <=n && jOld > 0
            newM(i, j) = gray(iOld, jOld);
        end
    end
end

imshow(newM);   % Bild darstellen