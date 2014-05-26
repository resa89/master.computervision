function [ img_entz ] = stitching( img, dimX, dimY, passPunkte, methode )
    
    numImgs = length(img);
    img_tpass = zeros(dimY,dimX,3);
    img_hpass = zeros(dimY,dimX,3);
        
    % extra matrices for tpass, hpass and weights for every image
    for i=1:numImgs
        imgs_entz{i} = zeros(dimY,dimX,3);
        imgs_tpass{i} = zeros(dimY,dimX,3);
        imgs_hpass{i} = zeros(dimY,dimX,3);
        weights{i} = zeros(dimY,dimX);
        weights_entz{i} = zeros(dimY,dimX);
    end
    
    % calculation of weights
    for i=1:numImgs
        imSize = size(img{i});
        mitte = imSize(1:2)/2;
        for x=1:imSize(2)
            for y=1:imSize(1)
                dx = abs(mitte(2)-x);
                dy = abs(mitte(1)-y);
                weights{i}(y,x) = (1-dx/mitte(2))*(1-dy/mitte(1))*255;
            end            
        end
    end
    
    %Methode 1: Higher Weight
    %Methode 2: Weighted Average
    %Methode 3: Bandpass
    
    % Create the gaussian filter with hsize = [5 5] and sigma = 2
    h = fspecial('gaussian',[5 5],2);
    
    for i=1:numImgs
        fprintf('Image %d\n', i);
        
        % 3 Bandpass ------------------------------------------------------
        if methode == 3
            %imgs_tpass{i} = filter2(h, imgs_entz{i});
            imSize = size(img{i});
            imgs_tpass{i} = imfilter(img{i},h);
            imgs_hpass{i} = img{i} - imgs_tpass{i};
            imgs_tpass{i} = projEntzerr(imgs_tpass{i},passPunkte{i},[dimX,dimY]); %'symmetric'
            imgs_hpass{i} = projEntzerr(imgs_hpass{i},passPunkte{i},[dimX,dimY]);
        % 1-2 Higher Weight or Weighted Average ---------------------------
        else
            imgs_entz{i} = projEntzerr(img{i},passPunkte{i},[dimX,dimY]);
            imgs_tpass{i} = imgs_entz{i};
            imgs_hpass{i} = imgs_entz{i};
        end
        weights_entz{i} = projEntzerr(weights{i},passPunkte{i},[dimX,dimY]);
    end
    
    dist = zeros(numImgs,1);
    for x=1:dimX
        for y=1:dimY
            % 1 + 3 Heigher Weight and Bandpass ---------------------------
            if mod(methode,2) == 1 % Pixel mit dem größeren Gewicht (nur wenn methode!=2)
                maxWeight = 0;
                index = 1;
                for i=1:numImgs
                    if weights_entz{i}(y,x) > maxWeight
                        maxWeight = weights_entz{i}(y,x);
                        index = i;
                    end
                end
                
                img_hpass(y,x,:) = imgs_hpass{index}(y,x,:);
            end
            
            % 3 Bandpass --------------------------------------------------
            if floor(methode/2) == 1 % gewichteter Mittelwert (nur wenn methode==3)
                weight = 0;
                sum = zeros(1,3);
                for i=1:numImgs
                    sum = sum + reshape(weights_entz{i}(y,x)*imgs_tpass{i}(y,x,1:3),1,3);
                    weight = weight + weights_entz{i}(y,x);
                end
                if weight==0
                    img_tpass(y,x,:) = [0 0 0];
                else
                    img_tpass(y,x,:) = sum/weight;
                end
            end
            
        end
        if mod(x,100)==0
            fprintf('At x=%d\n',x);
        end
    end
    
    
    
    img_entz = img_tpass + img_hpass;
    % 3 Bandpass ----------------------------------------------------------
    if methode == 3
        figure
        show_img(img_tpass(:,:,1:3));
        figure
        show_img(img_hpass(:,:,1:3));
    end
end

