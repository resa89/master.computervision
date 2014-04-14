function outputPic = zxcvb(A, gray)
    [m,n] = size(gray);
    newM = repmat(uint8(0),m*3, n*3);
    
    for i=1:m*3
        for j=1:n*3
            tmp = [i-m j-n 0] * A;
            yx0=floor(tmp);
            yx1=ceil(tmp);

            if yx1(1) <= m && yx0(1) > 0 && yx1(2) <=n && yx0(2) > 0
                wt = tmp - yx0; 
                wtConj = 1 - wt;

                interTop = wtConj(2) * gray(yx0(1),yx0(2)) + wt(2) * gray(yx0(1),yx1(2));
                interBtm = wtConj(2) * gray(yx1(1),yx0(2)) + wt(2) * gray(yx1(1),yx1(2));
                interVal=wtConj(1) * interTop + wt(1) * interBtm;

                newM(i, j) = interVal;
            end
        end
    end
    outputPic = newM;
end

