clear; clc; close all;

% Daten zu späteren Anpassung (Verschiebung + Umrechnung von Einheiten)
res = 10;
dx = 700; dy = 500;
dimX = 5000/res; dimY = 2500/res;

img{1}(:,:,:)=imread('I1.jpg');
img{2}(:,:,:)=imread('I2.jpg');
img{3}(:,:,:)=imread('I3.jpg');
img{4}(:,:,:)=imread('I4.jpg');

numImgs = length(img);

% Passpunkte für jedes Image
for i=1:numImgs
    passPunkte{i} = zeros(4,4);
end
mitten = zeros(2,numImgs);

% Passpunkte beinhalten Welt- und Pixelkoordinaten
% 4 Dimensionen - 4 Passpunkte pro Bild
passPunkte{1}(:,1) = [-150    1350     788     816]'; % Haus1kante links oben
passPunkte{1}(:,2) = [-150       0     843    2063]'; % Haus1kante links unten
passPunkte{1}(:,3) = [1300    1350    2253     449]'; % Haus1kante rechts oben
passPunkte{1}(:,4) = [1300       0    2298    2246]'; % Haus1kante rechts unten
mitten(:,1) = [600 600];

passPunkte{2}(:,1) = [1300    1350     994     629]'; % Haus1kante rechts oben
passPunkte{2}(:,2) = [1300       0    1002    2309]'; % Haus1kante rechts unten
passPunkte{2}(:,3) = [2100    1200    2104     716]'; % Haus2fenster rechts oben
passPunkte{2}(:,4) = [2100     200    2110    2081]'; % Haus2fenster rechts unten
mitten(:,2) = [1800 600];

passPunkte{3}(:,1) = [2100    1200     776     792]'; % Haus2fenster rechts oben
passPunkte{3}(:,2) = [2100     200     801    2105]'; % Haus2fenster rechts unten
passPunkte{3}(:,3) = [2650    1200    1526     828]'; % Haus3fenster links oben
passPunkte{3}(:,4) = [2650      50    1533    2240]'; % Haus3fenster links unten
mitten(:,3) = [2400 600];

passPunkte{4}(:,1) = [2650    1200     284     846]'; % Haus3fenster links oben
passPunkte{4}(:,2) = [2650      50     271    2325]'; % Haus3fenster links unten
passPunkte{4}(:,3) = [3650    1200    1409    1038]'; % Hauskante rechts oben
passPunkte{4}(:,4) = [3650      50    1412    2156]'; % Hauskante rechts unten
mitten(:,4) = [3150 600];

% jeder Passpunkt wird entsprechend oben genannter Daten angepasst
for j=1:numImgs
    for i=1:length(passPunkte{j})
        passPunkte{j}(:,i) = passPunkte{j}(:,i) + [dx;dy;0;0];
        passPunkte{j}(1:2,i) = passPunkte{j}(1:2,i)/res;
    end
    mitten(:,j) = mitten(:,j) + [dx;dy];
    mitten(:,j) = mitten(:,j)/res;
end

% alle Bilder einzeln anzeigen
figure('name','Input Images','NumberTitle','off');
for i=1:numImgs
    subplot(1,numImgs,i)
    show_img(img{i});
end

%Methode 1: Higher Weight
%Methode 2: Weighted Average
%Methode 3: Bandpass

% Bilder zusammenfügen
img_entz = stitching(img, dimX, dimY, passPunkte, 1);
figure('name','Higher Weight','NumberTitle','off');
show_img(img_entz(:,:,1:3));

img_entz = stitching(img, dimX, dimY, passPunkte, 2);
figure('name','Weighted Average','NumberTitle','off');
show_img(img_entz(:,:,1:3));

img_entz = stitching(img, dimX, dimY, passPunkte, 3);
figure('name','Bandpass','NumberTitle','off');
show_img(img_entz(:,:,1:3));
