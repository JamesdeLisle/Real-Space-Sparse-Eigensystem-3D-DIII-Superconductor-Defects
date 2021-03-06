    clearvars -except eSys NVec NumBands;
    %NVec = [10,10,14];
    PlotBands = 10;
    %PlotLevel = ceil(1);
    PlotLevel = ceil((NVec(3)/2));
    Zplane = 0;
    
    GlobalDim = 4*NVec(1)*NVec(2)*NVec(3);
    
	%Extracts the four zero modes
	ModeArray = zeros(PlotBands,GlobalDim);
    
    for modeN = 1:PlotBands
        ModeArray(modeN,:) = eSys((NumBands/2)+(modeN - (PlotBands/2)),2:GlobalDim+1);
    end
    
    ProbArray = zeros(NVec(1),NVec(2),PlotBands);
    for modeN = 1:PlotBands
        for ctx = 1:NVec(1)
            for cty = 1:NVec(2)
                SiteEntry = (ctx-1)*4*NVec(3)*NVec(2) + (cty-1)*4*NVec(3) + (PlotLevel-1)*4;   
                ProbArray(ctx,cty,modeN) = abs(ModeArray(modeN,SiteEntry + 1))^2 + abs(ModeArray(modeN,SiteEntry + 3))^2;
            end
        end
    end
    
    
	for ctx = 1:NVec(1)
		ctxVec(ctx) = ctx;
	end
	for cty = 1:NVec(2)
		ctyVec(cty) = cty;
    end

	clf reset
	
    for modeN = 1:PlotBands
        figure(modeN);
        hold on
        surf(ctyVec,ctxVec,ProbArray(:,:,modeN));
        hold off
    end
    
    for count = 1:NumBands
        numV(count) = count;
    end
    
    figure(PlotBands+1)
	hold on
	plot(numV,eSys(:,1),'.')
	hold off
     
    %{
    y = zeros(2,GlobalDim);
    
    for i = 1:GlobalDim
        y(1,i) = numV(i);
        y(2,i) = eSys(i,1);
    end
    
    fid = fopen('C:\Users\james\Dropbox\Work\3DDefectPersonal\Numerics\HamRRR\2DDIII\Sandwich\HamRRR\SpecData.txt', 'wt');
    for i=1:GlobalDim
       fprintf(fid, '%d %f\n', y(:,i));
    end
    fclose(fid);
    %}