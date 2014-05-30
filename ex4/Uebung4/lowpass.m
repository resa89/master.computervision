function lpsignal = lowpass(signal,tau)
%s[n+1] = a* x[n] + (1-a) * s[n]
% zeitdiskreter (rekursiver) Tiefpass 1. Ordnung
frames = size(signal,2);
if frames==1
    frames = size(signal,1);
end
deltaT = 1;
a = deltaT/tau;

%a = deltaT / tau
% a = w0(Grenzfrequenz=2 * Pi * f0 = 1/tau = frequenz) * deltaT
% tau  = 2 --> a = 0.5
%w0 als Grenzfrequenz (=2 * Pi * f0


%p1 = exp(-w0*T)
%
%p1 = exp(-a);
%exp(a) = (1-a)
p1 = (1-a);
old = 0;
for n=1:frames
    signal(n)  = a * signal(n) + p1 * old;
    old = signal(n);
end


lpsignal = signal;
return 