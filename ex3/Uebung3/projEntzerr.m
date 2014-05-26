function [ newImg ] = projEntzerr( img, passPunkte, dims)
%PROJENTZERR Summary of this function goes here
%   passPunkte in form [x,y,x',y']'

    imSizeTmp = size(img);
    if numel(imSizeTmp) == 2
        imSize = [imSizeTmp 1];
    else
        imSize = imSizeTmp;
    end

    passCount = length(passPunkte);
    if passCount < 4
        disp('Nicht genug Passpunkte!')
        return;
    end
    
    M = zeros(2*passCount,8);
    x = zeros(2*passCount,1);
    for i=1:passCount
        xi_world = passPunkte(1,i);
        yi_world = passPunkte(2,i);
        
        xi_img = passPunkte(3,i);
        yi_img = passPunkte(4,i);
        
        M(2*i-1,:) = [xi_img yi_img 1 0 0 0 -xi_world*xi_img -xi_world*yi_img];
        M(2*i,:) = [0 0 0 xi_img yi_img 1 -yi_world*xi_img -yi_world*yi_img];
        
        x(2*i-1:2*i) = [xi_world; yi_world];
    end
    
    a = pinv(M)*x;
    
    a1 = a(1);
    a2 = a(2);
    a3 = a(3);
    b1 = a(4);
    b2 = a(5);
    b3 = a(6);
    c1 = a(7);
    c2 = a(8);
    
    newImg = zeros(dims(2),dims(1),imSize(3));
    imgSize = size(img);
        
    for x=1:dims(1)
        for y=1:dims(2)
            denom = (b1*c2-b2*c1)*x + (a2*c1-a1*c2)*y + a1*b2 - a2*b1;
            x_img = ((b2-c2*b3)*x + (a3*c2-a2)*y + a2*b3 - a3*b2)/(denom);
            y_img = ((b3*c1-b1)*x + (a1-a3*c1)*y + a3*b1 - a1*b3)/(denom);
            
            if y_img >= 1 && y_img < imgSize(1) && x_img >= 1 && x_img < imgSize(2)
                tmpX = round(x);
                tmpY = round(dims(2)-y+1);
                tmpXimg = round(x_img);
                tmpYimg = round(y_img);
                newImg(tmpY,tmpX,:) = img(tmpYimg, tmpXimg,:);
            end
        end
    end
end

