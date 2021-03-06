function outputPic = transfrom(A, gray, a0, neighbor, newM)
    %[m,n,o] = size(gray);
    %newM = zeros(m*3, n*3, o);
    [m,n,o] = size(newM);
    
    m2 = m/2;
    n2 = n/2;
    
    for i=1:m
        for j=1:n
            tmp = [i-m2 j-n2] * A + a0;
            tmp(1) = tmp(1) + m2;
            tmp(2) = tmp(2) + n2;
            yx0=floor(tmp);
            yx1=ceil(tmp);

            if yx1(1) <= m && yx0(1) > 0 && yx1(2) <=n && yx0(2) > 0
                wt = tmp - yx0; 
                wtConj = 1 - wt;

                if neighbor
                    % use the value of the next neighbor
                    if wt(1) >= 0.5
                        y=yx1(1);
                    else
                        y=yx0(1);
                    end
                    if wt(2) >= 0.5
                        x = yx1(2);
                    else 
                        x=yx0(2);
                    end
                    interVal = gray(y,x);
                else
                    % biliniar interpolation
                    px11 = gray(yx0(1),yx0(2),:);
                    px12 = gray(yx0(1),yx1(2),:);
                    px21 = gray(yx1(1),yx0(2),:);
                    px22 = gray(yx1(1),yx1(2),:);
                    
                    interTop = wtConj(2) * px11 + wt(2) * px12;
                    interBtm = wtConj(2) * px21 + wt(2) * px22;
                    
                    interVal=wtConj(1) * interTop + wt(1) * interBtm;
                end
                newM(i, j, :) = interVal(1,1,:);
            end
        end
    end
    outputPic = newM;
end

