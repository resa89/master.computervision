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
        
        yx0=floor(tmp);
        yx1=ceil(tmp);
        
        if yx1(1) <= m && yx0(1) > 0 && yx1(2) <=n && yx0(2) > 0
            wt = tmp - yx0; 
            wtConj = 1 - wt;
            
            interTop = wtConj(2) * gray(yx0(1),yx0(2)) + wt(2) * gray(yx0(1),yx1(2));
            interBtm = wtConj(2) * gray(yx1(1),yx0(2)) + wt(2) * gray(yx1(1),yx1(2));
            interVal=wtConj(1) * interTop + wt(1) * interBtm;
            
            newM(i, j) = interVal;
        end
    end
end

imshow(newM);   % Bild darstellen