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

%% Aufgabe 3 a-d
clear all;

t = 100;
y = 5;
x = 50;

corArr1 = zeros([51 51]);
iV = 1;
iCor = 2;
for v=0:50

    signal = make_seq(t, y, x, v-25);
    signal1 = signal(:,1,10);
    signal2 = signal(:,1,20);

    tau = 1.1;
    
%     figure;
    % subplot(2,2,1);
    % plot(signal1);
    % title('signal1');
    % subplot(2,2,2);
    % plot(signal2);
    % title('signal2');
    % 
    % lowpass = lowpass(signal1,tau);
    % 
    corrSignal = detector(signal1, signal2, tau);

    % subplot(2, 2,3);
    % plot(lowpass);
    % title('signal 1 - lowpass');
    % subplot(2, 2,4);
%     plot(corrSignal);
%     title('correlation detector');
    corArr1(v+1,iV) = v-25;
    corArr1(v+1,iCor) = corrSignal;
end
% figure; 
% plot(corArr1(:,iV),corArr1(:,iCor));

find(corArr1(:,iCor)==max(corArr1(:,iCor))) -25
corArr1(26,iCor)


% Aufgabe 3 c

t = 100;
y = 5;
x = 50;

corArr2 = zeros([51 51]);
for v=0:50

    signal = make_seq(t, y, x, v-25);
    signal1 = signal(:,1,10);
    signal2 = signal(:,1,20);

    tau = 1.1;
    
    corrSignal = leftdetector(signal1, signal2, tau);

    corArr2(v+1,iV) = v-25;
    corArr2(v+1,iCor) = corrSignal;
end
% figure; 
% plot(corArr2(:,iV),corArr2(:,iCor));

find(corArr2(:,iCor)==max(corArr2(:,iCor))) -25
corArr2(26,iCor)


figure;
subplot(2,2,1);
plot(corArr1(:,iV),corArr1(:,iCor));
title('right');
subplot(2,2,2);
plot(corArr2(:,iV),corArr2(:,iCor));
title('left');

corArrSub = zeros([51 51]);
corArrAdd = zeros([51 51]);
for v=0:50
    corArrSub(v+1,iV) = v-25;
    corArrAdd(v+1,iV) = v-25;
    corArrSub(v+1,iCor) = corArr1(v+1,iCor) - corArr2(v+1,iCor);
    corArrAdd(v+1,iCor) = corArr1(v+1,iCor) + corArr2(v+1,iCor);
end
subplot(2,2,3);
plot(corArrSub(:,iV),corArrSub(:,iCor));
title('left - right');
subplot(2,2,4);
plot(corArrAdd(:,iV),corArrAdd(:,iCor));
title('left + right');
