    
    for i = 1:20
        a(i) = (i/20)-0.05;
    end

    y = zeros(2,120);
    
    for i = 1:20
        y(1,i) = a(i);
        y(2,i) = GAP(i);
    end
    
    fid = fopen('C:\Users\james\Dropbox\Work\3DDefectPersonal\Numerics\HamRRR\2DDIII\Sandwich\HamRRRTestSparse\1DGapData.txt', 'wt');
    for i=1:20
       fprintf(fid, '%f %f\n', y(:,i));
    end
    fclose(fid);