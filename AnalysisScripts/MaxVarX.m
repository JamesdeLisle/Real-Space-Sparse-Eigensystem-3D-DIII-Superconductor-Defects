    clearvars -except eSys;
    NVec = [14,14,14];
    GlobalDim = 4*NVec(1)*NVec(2)*NVec(3);
    PlotBands = 8;
    %PlotLevel = ceil(1);
    PlotLevel = ceil(NVec(1));
    Zplane = 0;
    
    
    
	%Extracts the four zero modes
	ModeArray = zeros(PlotBands,GlobalDim);
    
    for modeN = 1:PlotBands
        ModeArray(modeN,:) = eSys((8/2)+(modeN - (PlotBands/2)),2:GlobalDim+1);
    end
    
    ProbArray = zeros(NVec(1),NVec(2),NVec(3));
    for Level = 1:NVec(1)
        for ctz = 1:NVec(3)
            for cty = 1:NVec(2)
                %Defines the site counter
                SiteEntry = (Level-1)*4*NVec(3)*NVec(2) + (cty-1)*4*NVec(3) + (ctz-1)*4;
                %Calculates the entry to the probability arrays
                modeN = (PlotBands/2)+3;  
                ProbArray(ctz,cty,Level) = abs(ModeArray(modeN,SiteEntry + 1))^2 + abs(ModeArray(modeN,SiteEntry + 3))^2;
            end
        end
    end
    
    
    
    for j = 1:NVec(1)
        MaxDens(j) = max(max(ProbArray(:,:,j)));
    end
    
    for i = 1:NVec(1)
        BandNVec(i) = i;
    end
    
	clf reset
	
    

    hold on
    plot(BandNVec,MaxDens,'.');
    hold off
    
    
     