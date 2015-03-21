    clearvars -except eSys NVec NumBands;
    %NVec = [10,10,14];
    GlobalDim = 4*NVec(1)*NVec(2)*NVec(3);
    PlotBands = NumBands;
    %PlotLevel = ceil(1);
    PlotLevel = ceil(NVec(3));
    Zplane = 0;
    
    
    Choose = 2;
	%Extracts the four zero modes
	ModeArray = zeros(PlotBands,GlobalDim);
    
    for modeN = 1:PlotBands
        ModeArray(modeN,:) = eSys((NumBands/2)+(modeN - (PlotBands/2)),2:GlobalDim+1);
    end
    
    ProbArray = zeros(NVec(1),NVec(2),NVec(3));
    for Level = 1:NVec(3)
        for ctx = 1:NVec(1)
            for cty = 1:NVec(2)
                %Defines the site counter
                SiteEntry = (ctx-1)*4*NVec(3)*NVec(2) + (cty-1)*4*NVec(3) + (Level-1)*4;
                %Calculates the entry to the probability arrays
                modeN = (PlotBands/2)+Choose;  
                ProbArray(ctx,cty,Level) = abs(ModeArray(modeN,SiteEntry + 1))^2 + abs(ModeArray(modeN,SiteEntry + 3))^2;
            end
        end
    end
    disp(sprintf('EVAL = %f',eSys((PlotBands/2)+Choose,1)));
    
    
    for j = 1:NVec(3)
        MaxDens(j) = max(max(ProbArray(:,:,j)));
    end
    
    for i = 1:NVec(3)
        BandNVec(i) = i;
    end
    
	clf reset
	
    
    figure
    hold on
    plot(BandNVec,MaxDens,'.');
    hold off
    %{
     y = zeros(2,NVec(3));
    
    for i = 1:NVec(3)
        y(1,i) = BandNVec(i);
        y(2,i) = MaxDens(i);
    end
    
    fid = fopen('C:\Users\james\Dropbox\Work\3DDefectPersonal\Numerics\HamRRR\2DDIII\Sandwich\HamRRR\ZOccupData.txt', 'wt');
    for i=1:NVec(3)
       fprintf(fid, '%d %f\n', y(:,i));
    end
    fclose(fid);
     %}