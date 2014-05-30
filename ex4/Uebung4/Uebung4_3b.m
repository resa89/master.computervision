function Uebung4_3b()

dimt = 100;
dimy = 5;
dimx = 50;
v = 5;

result_r = zeros([51 51]);

%figure;
for c=0:50
    %c=25;
    seq1 = make_seq(dimt, dimy, dimx, c-25);
    tau = 1.1;
    speed = c-25;
    s1 = seq1.seq(:,1,10);
    %subplot(2, 2,1);
    %plot(s1)
    s2 = seq1.seq(:,1,20);
    %subplot(2, 2,2);
    %plot(s2);
    corr = detector(s1,s2,tau);
    result_r(c+1,1) = speed;
    result_r(c+1,2) = corr;
end

figure; 
plot(result_r(:,1),result_r(:,2));

ind1 = find(result_r(:,2)==max(result_r(:,2)));
result_r(ind1,1)



result_l = zeros([51 51]);

%Linksdetektor
%figure;
for c=0:50
    %c=25;
    seq1 = make_seq(dimt, dimy, dimx, c-25);
    tau = 1.1;
    speed = c-25;
    s1 = seq1.seq(:,1,10);
    %subplot(2, 2,1);
    %plot(s1)
    s2 = seq1.seq(:,1,20);
    %subplot(2, 2,2);
    %plot(s2);
    corr = ldetector(s1,s2,tau);
    result_l(c+1,1) = speed;
    result_l(c+1,2) = corr;
end

figure; 
plot(result_l(:,1),result_l(:,2));

ind2 = find(result_l(:,2)==max(result_l(:,2)));
result_l(ind2,1)


%Differenz
diff = zeros([51 51]);
diff(:,1) = result_l(:,1);
diff(:,2) = abs(result_l(:,2) - result_r(:,2));
figure; 
plot(diff(:,1),diff(:,2));




end