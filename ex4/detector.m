function result = detector(signal1, signal2, tau)

    %size(signal1);

    lpsignal = lowpass(signal1,tau);
    a = floor(1/tau); %Abstand
    
    if size(signal1) == size(signal2)
        signalSize = size(signal1,2);
        if signalSize==1
            signalSize = size(signal1,1);
        end
        
        result = zeros([signalSize signalSize]);

        for n=1:signalSize
            if n<=a
                result(n) = lpsignal(n);
            else
                result(n) = lpsignal(n) + signal2(n-a);
            end
        end
    end
return