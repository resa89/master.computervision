%% 1. Gradientenverfahren
clc; clear; close all;

whos -file flow.mat;

img = matfile('flow.mat');
img1 = img.pic1;
img2 = img.pic2;

figure;
subplot(2, 2, 1);
show_img(img1);
title('img1');
subplot(2, 2, 2);
show_img(img2);
title('img2');


M1 = [-0.5 0 0 0.5];
M2 = M1';

dx = filter2(M1, img1);      % (/dx)
dy = filter2(M2, img1);     % (/dy)


subplot(2, 2, 3);
show_img(dx);
title('filtered');
subplot(2, 2, 4);
show_img(dy);
title('iltered2');

dt = img2 - img1; % zeitliche ableitung (diff bild2 bild1) (/dt)

sum1 = 0;
sum2 = 0;

w = [0 1 2 1 0;
    1 3 5 3 1;
    2 5 9 5 2;
    1 3 5 3 1;
    0 1 2 1 0];
%b = zero(64, 64, 2);
%A = zero(64, 64, 2, 2);

u = zeros(64, 64);
v = zeros(64, 64);
x = zeros(64);
y = zeros(64);
for i=1:64
    x(i) = i;
    y(i) = i;
    for j=1:64
        b = zeros(2);
        A = zeros(2, 2);
        for k=(i-2):(i+2)
            for l=(j-2):(j+2)
               if k>=1 && l>=1 && k<=64 && l<=64
%                  b(i, j, 1) = b(1) + w(i-k+3,i-l+3)*dt(i,j)*dx(i,j);
%                  b(i, j, 2) = b(2) + w(i-k+3,i-l+3)*dt(i,j)*dy(i,j);
%                  A(i, j, 1, 1) = A(i, j, 1, 1) + w(i-k+3,i-l+3)*dx(i,j)^2;
%                  A(i, j, 1, 2) = A(i, j, 1, 2) + w(i-k+3,i-l+3)*dx(i,j)*dy(i,j);
%                  A(i, j, 2, 1) = A(i, j, 2, 1) + w(i-k+3,i-l+3)*dx(i,j)*dy(i,j);
%                  A(i, j, 2, 2) = A(i, j, 2, 2) + w(i-k+3,i-l+3)*dy(i,j)^2;               
                 b(1) = b(1) + w(i-k+3,j-l+3)*dt(i,j)*dx(i,j);
                 b(2) = b(2) + w(i-k+3,j-l+3)*dt(i,j)*dy(i,j);
                 A(1, 1) = A(1, 1) + w(i-k+3,j-l+3)*dx(i,j)^2;
                 A(1, 2) = A(1, 2) + w(i-k+3,j-l+3)*dx(i,j)*dy(i,j);
                 A(2, 1) = A(2, 1) + w(i-k+3,j-l+3)*dx(i,j)*dy(i,j);
                 A(2, 2) = A(2, 2) + w(i-k+3,j-l+3)*dy(i,j)^2;               
              
               end
            end
        end
       tmp = -A'*b; 
%        u(i,j,1,1) = tmp(1);
%        u(i,j,1,2) = tmp(2);
        u(i,j) = tmp(1);
        v(i,j) = tmp(2);
    end
end

figure
[x,y] = meshgrid(1:64,1:64);
quiver(x,y,u,v);

% [x,y] = meshgrid(0:0.2:2,0:0.2:2);
% u = cos(x).*y;
% v = sin(x).*y;
% 
% figure
% quiver(x,y,u,v)

%% 2. Normalfluss






%% 3. Anweundung auf Testbilder


