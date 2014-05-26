function outputPic = rectification2(x, xp, y, yp, img, allNewM, xStart, yStart, method)
    M = [];
    s = size(x);
    for i=1:s(2)
        tmp = [xp(i) yp(i) 1 0     0     0 -x(i)*xp(i) -x(i)*yp(i);
               0     0     0 xp(i) yp(i) 1 -y(i)*xp(i) -y(i)*yp(i)];
        M = [M; tmp];
    end

    xv = [x(1); y(1); x(2); y(2); x(3); y(3); x(4); y(4)];

    a = pinv(M) * xv;
    a1 = a(1);
    a2 = a(2);
    a3 = a(3);
    b1 = a(4);
    b2 = a(5);
    b3 = a(6);
    c1 = a(7);
    c2 = a(8);

    [m,n,o] = size(img);
    % newM = zeros(m, n, o);
        
    % 3 Bandpass ----------------------------------------------------------
    if method == 3
        imgs_tpass = zeros(m,n,o);
        imgs_hpass = zeros(m,n,o);

        % Create the gaussian filter with hsize = [5 5] and sigma = 2
        h = fspecial('gaussian',[5 5],2);

        %imgs_tpass{i} = filter2(h, imgs_entz{i});
        imSize = size(img);
        imgs_tpass = imfilter(img,h);
        imgs_hpass = img - imgs_tpass;
        %imgs_tpass{i} = projEntzerr(imgs_tpass{i},passPunkte{i},[dimX,dimY]); %'symmetric'
        %imgs_hpass{i} = projEntzerr(imgs_hpass{i},passPunkte{i},[dimX,dimY]);
    end
    
    allImg{1} = img;
    
        
    %newM_TP = zeros(3000, 9000, 4, 3);
    %newM_HP = zeros(3000, 9000, 4, 3);
    
    
    if method == 3
        allImg{2} = imgs_tpass;
        allImg{3} = imgs_hpass;
        imgCount = 3;
    else
        imgCount = 1;
    end
    
    n2 = n/2;
    m2 = m/2;
    
    for image=1:imgCount  
        for y=1:m
            for x=1:3*n
                denominator = (b1*c2 - b2*c1)*x + (a2*c1 - a1*c2)*y + a1*b2 - a2*b1;
                xCorrected = ((b2-c2*b3)*x + (a3*c2-a2)*y + a2*b3-a3*b2) / denominator;
                yCorrected = ((b3*c1-b1)*x + (a1-a3*c1)*y + a3*b1-a1*b3) / denominator;
                xCorrected = floor(xCorrected);
                yCorrected = floor(yCorrected);
                if yCorrected > 0 && yCorrected <= m && xCorrected > 0 && xCorrected <= n

                    weight = (1 - abs(xCorrected-n2) / n2) * (1 - abs(m2-yCorrected)/m2);
                    % pixel is not colored
                    if allNewM{image}(y + yStart, x + xStart, 1) == 0
                        allNewM{image}(y + yStart, x + xStart,1:3) = allImg{image}(yCorrected, xCorrected, :);
                        allNewM{image}(y + yStart, x + xStart,4) = weight;
                    % pixel is colored
                    else
                        w1 = allNewM{image}(y + yStart, x + xStart,4);
                        w3 = 1/(w1 + weight);
                        % Higher Weight 
                        if method == 1
                            if weight >= w1
                                allNewM{image}(y + yStart, x + xStart,1:3) = allImg{image}(yCorrected, xCorrected, :);
                            end
                        % Weighted Average and Bandpass
                        else
                            if image == 3   %Hochhpass
                                if weight >= w1
                                    allNewM{image}(y + yStart, x + xStart,1:3) = allImg{image}(yCorrected, xCorrected, :);
                                end
                            else
                                allNewM{image}(y + yStart, x + xStart,1:3) = w1*w3*allNewM{image}(y + yStart, x + xStart,1:3) + weight*w3*allImg{image}(yCorrected, xCorrected, :);
                            end
                        end
                    end

                end
            end
        end
    end
    % 3 Bandpass ----------------------------------------------------------
    if method == 3
        allNewM{1} = allNewM{2} + allNewM{3};   % muss bevor in newM geschrieben wird     
        %figure
        %show_img(img_tpass(:,:,1:3));
        %figure
        %show_img(img_hpass(:,:,1:3));
    else
        %newM = allNewM{1};
    end
    outputPic = allNewM;
end