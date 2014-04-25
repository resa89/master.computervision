function outputPic = transfrom(A, gray, a0, neighbor)
    [m,n,o] = size(gray);
    newM = zeros(m*3, n*3, o);
    
    for i=1:m*3
        for j=1:n*3
            tmp = [i-m j-n 0] * A + a0;
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

