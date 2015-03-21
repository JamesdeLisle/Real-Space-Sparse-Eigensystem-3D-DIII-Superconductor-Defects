function [] = PlotSpectrum(eSys, NVec, PlotBands, PlotLevel)
    GlobalDim = 4*NVec(1)*NVec(2)*NVec(3);
    
    for count = 1:GlobalDim
        numV(count) = count;
    end
    
    figure(PlotBands+1)
	hold on
	plot(numV,eSys(:,1),'.')
	hold off
end