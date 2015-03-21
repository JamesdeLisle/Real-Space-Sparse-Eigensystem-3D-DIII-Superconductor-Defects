function [MaxDens] = LocalMax(NVec, eSys, PlotLevel, PlotBands)
    GlobalDim = 4*NVec(1)*NVec(2)*NVec(3);

	%Extracts the four zero modes
	ModeArray = zeros(PlotBands,GlobalDim);
    
    for modeN = 1:PlotBands
        ModeArray(modeN,:) = eSys((GlobalDim/2)+(modeN - (PlotBands/2)),2:GlobalDim+1);
    end
    
    ProbArray = zeros(NVec(1),NVec(2),PlotBands);
    for modeN = 1:PlotBands
        for ctx = 1:NVec(1)
            for cty = 1:NVec(2)
                %Defines the site counter
                SiteEntry = (ctx-1)*4*NVec(3)*NVec(2) + (cty-1)*4*NVec(3) + (PlotLevel-1)*4;
                %Calculates the entry to the probability arrays
                
                gam1 = 0.5*(ModeArray(modeN,SiteEntry + 1) + ModeArray(modeN,SiteEntry + 2));
                gam3 = -0.5*1i * (ModeArray(modeN,SiteEntry +1) - ModeArray(modeN,SiteEntry + 2));
                gam2 = 0.5*(ModeArray(modeN,SiteEntry + 3) + ModeArray(modeN,SiteEntry + 4));
                gam4 = -0.5*1i * (ModeArray(modeN,SiteEntry + 3) - ModeArray(modeN,SiteEntry + 4));
                               
                %ProbArray(ctx,cty,modeN) = abs(gam1)^2 +  abs(gam2)^2;% + abs(gam3)^2 + abs(gam4)^2;    
                ProbArray(ctx,cty,modeN) = abs(ModeArray(modeN,SiteEntry + 1))^2 + abs(ModeArray(modeN,SiteEntry + 3))^2;
            end
        end
    end
    
    for j = 1:PlotBands/2
        modeN = (PlotBands/2)+j;
        MaxDens(j) = max(max(ProbArray(:,:,modeN)));
    end
    
end
    
     