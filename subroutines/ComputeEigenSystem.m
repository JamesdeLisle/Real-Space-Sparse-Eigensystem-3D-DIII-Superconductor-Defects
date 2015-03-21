function [eSys] = ComputeEigenSystem(Ham, NumBands)
    HamSparse = sparse(Ham);
    [V,D] = eigs(HamSparse,NumBands,0);
	eSys(:,:) = sortrows([diag(D)+200,V'],1);
	eSys(:,1) = eSys(:,1)-200;
    assignin('base','eSys',eSys);
end