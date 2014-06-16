clc; clear; close all;

    %Methode 1: Higher Weight
    %Methode 2: Weighted Average
    %Methode 3: Bandpass
    method = 2;
    
    img = imread('IMG_0821.JPG'); % JPG-Datei einlesen
    img2 = imread('IMG_0822.JPG'); % JPG-Datei einlesen
    img3 = imread('IMG_0823.JPG'); % JPG-Datei einlesen
    img4 = imread('IMG_0824.JPG'); % JPG-Datei einlesen

    img = im2double(img);
    img2 = im2double(img2);
    img3 = im2double(img3);
    img4 = im2double(img4);

    % real world pass points
    x1 = [10.5 12.5 224 223.5] * 10;
    x2 = [224 223.5 347.5 347.5]* 10;
    x3 = [347.5 347.5 413.5 413.5] * 10;
    x4 = [413.5 413.5 566 566]* 10;

    y = [20 97 20 97] * 10;

    % Pixels for for pass-points in the picture
    xp1 = [335  401 3100 3103];
    yp1 = [443 1443  404 1425];
    xp2 = [1471 1443 3097 3059];
    yp2 = [ 451 1447  439 1487];
    xp3 = [968  974 1960 1952];
    yp3 = [389 1561  381 1566];
    xp4 = [259  263 2754 2759];
    yp4 = [363 1655  353 1659];

    allNewM{1} = zeros(3000, 9000, 4);
    allNewM{2} = zeros(3000, 9000, 4);
    allNewM{3} = zeros(3000, 9000, 4);
    
    allNewM = rectification2(x1, xp1, y, yp1, img, allNewM, 0, 0, method);
    allNewM = rectification2(x2, xp2, y, yp2, img2, allNewM, 0, 0, method);
    allNewM = rectification2(x3, xp3, y, yp3, img3, allNewM, 0, 0, method);
    allNewM = rectification2(x4, xp4, y, yp4, img4, allNewM, 0, 0, method);

    % imshow(finalIma);
    imshow(allNewM{1}(:,:,1:3));   % Bild darstellen
% imshow(newM2);   % Bild darstellen
%  imshow(img4);