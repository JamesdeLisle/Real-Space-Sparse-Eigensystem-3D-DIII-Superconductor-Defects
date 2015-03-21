function [] = PrintEigenSystemToFile(NVec, eSys, ModelMode,DefectMode, NumBands, PrinttoFile)
    if (PrinttoFile == 1)
        filenameREAL = sprintf('ModMode%dNx%dNy%dNz%dDefMode%dREAL.txt',ModelMode,NVec(1),NVec(2),NVec(3),DefectMode);
        filenameIMAG = sprintf('ModMode%dNx%dNy%dNz%dDefMode%dIMAG.txt',ModelMode,NVec(1),NVec(2),NVec(3),DefectMode);
        fid1 = fopen(filenameREAL, 'wt');
        fid2 = fopen(filenameIMAG, 'wt');
        for i=1:NumBands
            fprintf(fid1, '%f ', real(eSys(i,:)));
            fprintf(fid1, '\n');
            fprintf(fid2, '%f ', imag(eSys(i,:)));
            fprintf(fid2, '\n');
        end
        fclose(fid1);
        fclose(fid2);
    end
end