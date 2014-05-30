function lpsignal = lowpass(signal,tau)

    a = 1/tau;
    
    %dimension of signal depends on input array (vertical/horizontal)
    signalSize = size(signal,2);
        if signalSize==1
            signalSize = size(signal,1);
        end
    
    %signal(1) = 0;
    
    old = 0;
    
    for n=1:signalSize
        % zeitdiskreter, rekursiver Tiefpass 1. Ordnung:
        % s[n+1] = a * x[n] + (1-a) * s[n],     0<a<1
%         if n==1
%             signal(n)  = 0;
%         else
%             signal(n)  = a * signal(n-1) + (1-a) * signal(n);
%         end
        
        signal(n)  = a * signal(n) + (1-a) * old;
        old = signal(n);

    end

    lpsignal = signal;
    
return 