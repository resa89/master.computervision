%% Aufgabe 1 a
clear all;
m = matfile('robot-corridor.mat');

show_seq(m.seq);

%% Aufgabe 1 b
clear all;
make_seq(10, 10, 50, 2);


%% Aufgabe 2
clear all;

signal = matfile('signals.mat');

rectangle = signal.rectangle;
step = signal.step;

%tau = 2 -----------------------------------------
tau = 2;

figure('name','tau=2');
subplot(2, 2,1);
plot(rectangle);
title('rectangle');
subplot(2, 2,2);
plot(step);
title('step');

lpsignal_rec = lowpass(rectangle, tau);
lpsignal_step = lowpass(step, tau);

subplot(2, 2,3);
plot(lpsignal_rec);
title('lowpass rectangle');
subplot(2, 2,4);
plot(lpsignal_step);
title('lowpass step');

%tau = 1.3 -----------------------------------------
tau = 1.3;

figure('name','tau=1.3');
subplot(2, 2,1);
plot(rectangle);
title('rectangle');
subplot(2, 2,2);
plot(step);
title('step');

lpsignal_rec = lowpass(rectangle, tau);
lpsignal_step = lowpass(step, tau);

subplot(2, 2,3);
plot(lpsignal_rec);
title('lowpass rectangle');
subplot(2, 2,4);
plot(lpsignal_step);
title('lowpass step');

%% Aufgabe 3 a
clear all;

signal = matfile('signals.mat');


signal1 = signal.rectangle;
signal2 = signal.rectangle;

tau = 2;

figure;
subplot(2,2,1);
plot(signal1);
title('signal1');
subplot(2,2,2);
plot(signal2);
title('signal2');

lowpass = lowpass(signal1,tau);
corrSignal = detector(signal1, signal2, tau);

subplot(2, 2,3);
plot(lowpass);
title('signal 1 - lowpass');
subplot(2, 2,4);
plot(corrSignal);
title('correlation detector');



%% Aufgabe 3 b

dimt = 100;
dimy = 5;
dimx = 50;
%v = 5;

result_r = zeros([51 51]);

%figure;
for velocity=0:50
    %c=25;
    seq1 = make_seq(dimt, dimy, dimx, velocity-25);
    tau = 1.1;
    speed = velocity-25;
    s1 = seq1.seq(:,1,10);
    %subplot(2, 2,1);
    %plot(s1)
    s2 = seq1.seq(:,1,20);
    %subplot(2, 2,2);
    %plot(s2);
    corr = detector(s1,s2,tau);
    result_r(velocity+1,1) = speed;
    result_r(velocity+1,2) = corr;
end

figure; 
plot(result_r(:,1),result_r(:,2));

ind1 = find(result_r(:,2)==max(result_r(:,2)));
result_r(ind1,1)



result_l = zeros([51 51]);

%Linksdetektor
%figure;
for velocity=0:50
    %c=25;
    seq1 = make_seq(dimt, dimy, dimx, velocity-25);
    tau = 1.1;
    speed = velocity-25;
    s1 = seq1.seq(:,1,10);
    %subplot(2, 2,1);
    %plot(s1)
    s2 = seq1.seq(:,1,20);
    %subplot(2, 2,2);
    %plot(s2);
    corr = ldetector(s1,s2,tau);
    result_l(velocity+1,1) = speed;
    result_l(velocity+1,2) = corr;
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



