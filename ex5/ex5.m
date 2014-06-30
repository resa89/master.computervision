%% 1. Gradientenverfahren
clc; clear; close all;

% whos -file flow.mat;
theta = 0.01;

img = matfile('flowtest3.mat');
img1 = img.pic1;
img2 = img.pic2;

w = fspecial('gaussian',[3 3],1.5);
img1 = imfilter(img1,w);
img2 = imfilter(img2,w);

figure;
subplot(2, 2, 1);
show_img(img1);
title('img1');
subplot(2, 2, 2);
show_img(img2);
title('img2');


M1 = [-0.5 0 0.5];
M2 = M1';

dx = filter2(M1, img1);      % (/dx)
dy = filter2(M2, img1);     % (/dy)
dt = img2 - img1; % zeitliche ableitung (diff bild2 bild1) (/dt)
normGrad = (dx.*dx + dy.*dy).^(0.5);

subplot(2, 2, 3);
show_img(dx);
title('filtered');
subplot(2, 2, 4);
show_img(dy);
title('filtered2');



sum1 = 0;
sum2 = 0;

w = fspecial('gaussian',[5 5],1.5);

u = zeros(64, 64);
v = zeros(64, 64);
u2 = zeros(64, 64);
v2 = zeros(64, 64);
x = zeros(64);
y = zeros(64);
lambda1 = zeros(64, 64);
lambda2 = zeros(64, 64);

for i=1:64
    x(i) = i;
    y(i) = i;
    for j=1:64
        b = zeros(2);
        A = zeros(2, 2);
        gt = zeros(5, 5);
        normG = zeros(5, 5);
        for k=(i-2):(i+2)
            for l=(j-2):(j+2)
               if k>=1 && l>=1 && k<=64 && l<=64
                 b(1) = b(1) + w(i-k+3,j-l+3)*dt(k,l)*dx(k,l);
                 b(2) = b(2) + w(i-k+3,j-l+3)*dt(k,l)*dy(k,l);
                 A(1, 1) = A(1, 1) + w(i-k+3,j-l+3)*dx(k,l)^2;
                 A(1, 2) = A(1, 2) + w(i-k+3,j-l+3)*dx(k,l)*dy(k,l);
                 A(2, 1) = A(2, 1) + w(i-k+3,j-l+3)*dx(k,l)*dy(k,l);
                 A(2, 2) = A(2, 2) + w(i-k+3,j-l+3)*dy(k,l)^2;  
                 gt(i-k+3,j-l+3) = dt(k,l);
                 normG(i-k+3,j-l+3) = normGrad(k,l);
               end
            end
        end
        
        D = eig(A,'matrix');    %[~,D] = eig(A); 
        lambda1(i,j) = D(1,1);
        lambda2(i,j) = D(2,2);

        if lambda1(i,j) > theta && lambda2(i,j) > theta
            tmp = -pinv(A)*b; 
            u(i,j) = tmp(1);
            v(i,j) = tmp(2);
        % Aperturproblem
        elseif lambda2(i,j) > theta && theta > lambda1(i,j)
           uv = [dx(i,j); dy(i,j)]; 
           if norm(uv) > 0
                uv = uv./norm(uv);

                %m*u+b=0 => u=-m'*b 
                B = reshape(gt.*w,numel(w),1);
                M = reshape(normG.*w,numel(w),1);
                us = -pinv(M)*B;
                
                tmp = us*uv;
                u2(i,j) = tmp(1);
                v2(i,j) = tmp(2);
            end
        end
    end
end

[x,y] = meshgrid(1:64,1:64);

figure
show_img(img2);
hold on
quiver(x,y,u,v);
quiver(x,y,u2,v2, 'r');

figure('name','Lambda','NumberTitle','off');
subplot(1,2,1)
show_img(lambda1);
subplot(1,2,2)
show_img(lambda2);

% [x,y] = meshgrid(0:0.2:2,0:0.2:2);
% u = cos(x).*y;
% v = sin(x).*y;
% 
% figure
% quiver(x,y,u,v)

