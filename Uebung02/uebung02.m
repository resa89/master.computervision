clc; clear; close all;

img = imread('schraegbild_tempelhof.jpg'); % JPG-Datei einlesen
img = im2double(img);

%hdt = datacursormode;
%set(hdt,'UpdateFcn',{@labeldtips,hdt});

%if(event)
%position = getPoint(hdt);

% lu (1) = 52.470616, 13.392907
% ru (2) = 52.470975, 13.392880
% ld (3) = 52.471188, 13.416473
% rd (4) = 52.471537, 13.416452

dx = 500;
dy = 100;

x1 = 0 + dx;
x2 = 41 + dx;
x3 = 0 + dx;
x4 = 41 + dx;
y1 = 0 + dx;
y2 = 0 + dx;
y3 = 3000 + dx;
y4 = 3000 + dx;

xp1 = 346;
yp1 = 339;
xp2 = 364;
yp2 = 338;
xp3 = 313;
yp3 = 433;
xp4 = 343;
yp4 = 433;

% x1 = 0 + dx;
% x2 = 0 + dx;
% x3 = 80 + dx;
% x4 = 75 + dx;
% y1 = 0 + dx;
% y2 = 300 + dx;
% y3 = 1 + dx;
% y4 = 300 + dx;
% 
% xp1 = 313;
% yp1 = 433;
% xp2 = 346;
% yp2 = 339;
% xp3 = 681;
% yp3 = 424;
% xp4 = 552;
% yp4 = 340;

M = [xp1 yp1 1 0   0   0 -x1*xp1 -x1*yp1;
 0   0   0 xp1 yp1 1 -y1*xp1 -y1*yp1;
 xp2 yp2 1 0   0   0 -x2*xp2 -x2*yp2;
 0   0   0 xp2 yp2 1 -y2*xp2 -y2*yp2;
 xp3 yp3 1 0   0   0 -x3*xp3 -x3*yp3;
 0   0   0 xp3 yp3 1 -y3*xp3 -y3*yp3;
 xp4 yp4 1 0   0   0 -x4*xp4 -x4*yp4;
 0   0   0 xp4 yp4 1 -y4*xp4 -y4*yp4];

x = [x1; y1; x2; y2; x3; y3; x4; y4];

a = pinv(M) * x;
a1 = a(1);
a2 = a(2);
a3 = a(3);
b1 = a(4);
b2 = a(5);
b3 = a(6);
c1 = a(7);
c2 = a(8);

[m,n,o] = size(img);
newM = zeros(6000, 2000, o);

for y=1:6000
    for x=1:2000
        denominator = (b1*c2 - b2*c1)*x + (a2*c1 - a1*c2)*y + a1*b2 - a2*b1;
        xCorrected = ((b2-c2*b3)*x + (a3*c2-a2)*y + a2*b3-a3*b2) / denominator;
        yCorrected = ((b3*c1-b1)*x + (a1-a3*c1)*y + a3*b1-a1*b3) / denominator;
        xCorrected = floor(xCorrected);
        yCorrected = floor(yCorrected);
        if yCorrected > 0 && yCorrected <= m && xCorrected > 0 && xCorrected <= n
            newM(y, x,:) = img(yCorrected, xCorrected, :);
        end
    end
end

imshow(newM);   % Bild darstellen
%imshow(img);