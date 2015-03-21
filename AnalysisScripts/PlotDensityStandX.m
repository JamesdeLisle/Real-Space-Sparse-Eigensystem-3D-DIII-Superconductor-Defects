    clearvars -except eSys;
    NVec = [14,14,14];
    PlotBands = 8;
    %PlotLevel = ceil(1);
    PlotLevel = ceil(ceil(1));
    Zplane = 0;
    
    GlobalDim = 4*NVec(1)*NVec(2)*NVec(3);
    
	%Extracts the four zero modes
	ModeArray = zeros(PlotBands,GlobalDim);
    
    for modeN = 1:PlotBands
        ModeArray(modeN,:) = eSys((8/2)+(modeN - (PlotBands/2)),2:GlobalDim+1);
    end
    
    ProbArray = zeros(NVec(2),NVec(3),PlotBands);
    for modeN = 1:PlotBands
        for cty = 1:NVec(2)
            for ctz = 1:NVec(3)
                %Defines the site counter
                SiteEntry = (PlotLevel-1)*4*NVec(3)*NVec(2) + (cty-1)*4*NVec(3) + (ctz-1)*4;
                %Calculates the entry to the probability arrays
                             
                %ProbArray(ctx,cty,modeN) = abs(gam1)^2 +  abs(gam2)^2;% + abs(gam3)^2 + abs(gam4)^2;    
                ProbArray(cty,ctz,modeN) = abs(ModeArray(modeN,SiteEntry + 1))^2 + abs(ModeArray(modeN,SiteEntry + 3))^2;
            end
        end
    end
    
    
    %Creates vectors of site numbers for plotting probability distributions of zero modes
	for cty = 1:NVec(2)
		ctyVec(cty) = cty;
	end
	for ctz = 1:NVec(3)
		ctzVec(ctz) = ctz;
    end

	clf reset
	
    for modeN = 1:PlotBands
        figure(modeN);
        hold on
        surf(ctyVec,ctzVec,ProbArray(:,:,modeN));
        hold off
    end
    
    for count = 1:8
        numV(count) = count;
    end
    
    figure(PlotBands+1)
	hold on
	plot(numV,eSys(:,1),'.')
	hold off
     