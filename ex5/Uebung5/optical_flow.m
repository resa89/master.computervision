function [flow, flow_ortho] = optical_flow( pic1, pic2, theta )
%OPTICAL_FLOW Summary of this function goes here
%   Detailed explanation goes here

    % Create the gaussian filter with hsize = [5 5] and sigma = 1.5
    gaussSize = 1;
    h = fspecial('gaussian',[2*gaussSize+1 2*gaussSize+1],1.5);
    h
    
    flow(:,1) = [0 0 0 0]';
    flow_ortho(:,1) = [0 0 0 0]';
    
    pic1 = imfilter(pic1,h);
    pic2 = imfilter(pic2,h);
    
    M1 = [-0.5 0 0.5]; M2 = M1';
    gradX = filter2(M1,pic2);
    gradY = filter2(M2,pic2);
    gradT = pic2 - pic1;
    
    gradX2 = gradX.*gradX;
    gradY2 = gradY.*gradY;
    gradXY = gradX.*gradY;
    gradTX = gradT.*gradX;
    gradTY = gradT.*gradY;
    
    normGrad = (gradX2 + gradY2).^(0.5);
        
    figure('name','Gradienten','NumberTitle','off');
    subplot(3,3,1);
    show_img(gradX);
    title('X');
    
    subplot(3,3,2);
    show_img(gradY);
    title('Y');
    
    subplot(3,3,3);
    show_img(gradT);
    title('T');
    
    subplot(3,3,4);
    show_img(gradX2);
    title('X^2');
    
    subplot(3,3,5);
    show_img(gradY2);
    title('Y^2');
    
    subplot(3,3,6);
    show_img(gradXY);
    title('X*Y');
    
    subplot(3,3,7);
    show_img(gradTX);
    title('T*X');
    
    subplot(3,3,8);
    show_img(gradTY);
    title('T*Y');
    
    subplot(3,3,9);
    show_img(normGrad);
    title('||grad||');
    
    flowCount = 0;
    flowOrthoCount = 0;
    
    neighbourSize = 2;
    h = fspecial('gaussian',[2*neighbourSize+1 2*neighbourSize+1],1.5);
    h
    
    imSize = size(pic2);
    
    lambda1 = zeros(imSize(1)-2*neighbourSize, imSize(2)-2*neighbourSize);
    lambda2 = zeros(imSize(1)-2*neighbourSize, imSize(2)-2*neighbourSize);
    uAbs = zeros(imSize(1)-2*neighbourSize, imSize(2)-2*neighbourSize);
    
    for x=1+neighbourSize:imSize(2)-neighbourSize
        for y=1+neighbourSize:imSize(1)-neighbourSize
            gx2 = gradX2(y-neighbourSize:y+neighbourSize,x-neighbourSize:x+neighbourSize);
            gy2 = gradY2(y-neighbourSize:y+neighbourSize,x-neighbourSize:x+neighbourSize);
            gxy = gradXY(y-neighbourSize:y+neighbourSize,x-neighbourSize:x+neighbourSize);
            gtx = gradTX(y-neighbourSize:y+neighbourSize,x-neighbourSize:x+neighbourSize);
            gty = gradTY(y-neighbourSize:y+neighbourSize,x-neighbourSize:x+neighbourSize);
            
            a11 = sum(sum(gx2.*h));
            a12 = sum(sum(gxy.*h));
            a22 = sum(sum(gy2.*h));
            
            A = [a11 a12;a12 a22];
            
            [~,D] = eig(A);
            lambda1(y,x) = D(1,1);
            lambda2(y,x) = D(2,2);
            
            if D(1,1) > theta && D(2,2) > theta
                b1 = sum(sum(gtx.*h));
                b2 = sum(sum(gty.*h));
                b = [b1;b2];
                u = -pinv(A)*b;
                
                uAbs(y,x) = norm(u);
                
                flowCount = flowCount + 1;
                flow(:,flowCount) = [x; y; u];
            elseif D(2,2) > theta && theta > D(1,1)              
                uv = [gradX(y,x); gradY(y,x)];
                if norm(uv) > 0
                    uv = uv./norm(uv);

                    gt = gradT(y-neighbourSize:y+neighbourSize,x-neighbourSize:x+neighbourSize);
                    normG = normGrad(y-neighbourSize:y+neighbourSize,x-neighbourSize:x+neighbourSize);
                    
                    B = reshape(gt.*h,numel(h),1);
                    M = reshape(normG.*h,numel(h),1);
                    us = -pinv(M)*B;
                    
                    u = us*uv;
                    uAbs(y,x) = abs(us);

                    flowOrthoCount = flowOrthoCount + 1;
                    flow_ortho(:,flowOrthoCount) = [x; y; u];
                end
            end 
        end
    end
    figure('name','Lambda','NumberTitle','off');
    subplot(1,2,1)
    show_img(lambda1);
    subplot(1,2,2)
    show_img(lambda2);

    figure('name','u Absolute','NumberTitle','off');
    surf(uAbs);
end

