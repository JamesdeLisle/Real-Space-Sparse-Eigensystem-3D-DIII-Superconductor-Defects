function [] = Solve()
    %DON'T FORGET TO CHANGE THIS TO THE RELEVANT DIRECTORY!
    addpath('C:\Users\james\Dropbox\Work\3DDefectPersonal\Numerics\HamRRR\2DDIII\Sandwich\ZPlaneDef\HamRRRTestSparse\subroutines')

    %clearvars;
	
	TheModelNum = 1;            % TheModelNum = 1 contains the winding numbers 0,-1,+1 (The New and Improved One from James - We are using this)
    NumBands = 10;              %Number of states to compute
    assignin('base','NumBands',NumBands);
	tVec = [1.0, 3.0, 1.0];     % Defines the interaction strengths
	NVec = [14,24,14];          % Defines the number of sites. (Nx*Ny*Nz must be even)
    assignin('base','NVec',NVec);
    ModelMode = 6;              % Defines Boundary Condition (see GenGlobalHam)
    DefectMode = 3;
    ByZVal = 5.0;               % Zeeman field strength
    DefectScale = 0.75;         % Zeeman defect strength
    DefectSign = -1.0;          % Zeeman defect relative sign
    LineInt = 1.0;              % Strenth of interaction between 1D modes
    RelInt = -1.0;               % Relative interaction strength
    CheckHerm = 0;              % Check Hermiticity: 1 (Yes), 0 (No) 
    PrinttoFile = 0;            % Print eigensystem to file: 1 (Yes), 0 (No)
    
    %disp(sprintf('Def Mode: %d; Zee Def Scale: %f; Gap Int Str: %f; Gap Rel Int Str: %f; Zee Str: %f', DefectMode, DefectScale, LineInt, RelInt, ByVal));

    
	%--------------------------------------------------------------
	%--------------------------------------------------------------
	%Nothing below this point should be modified
	%--------------------------------------------------------------
	%--------------------------------------------------------------
    
    BBotVec = zeros(3); 
    BTopVec = zeros(3);
    BBotVec(3,1) = ByZVal;      %Z 
    BTopVec(3,1) = ByZVal;      %Z
    BTopVec(3,3) = 0.0;         %Y
    BBotVec(3,3) = 0.0;         %Y
    BTopVec(3,2) = 0.0;         %X
    BBotVec(3,2) = 0.0;         %X
    
    tic
	disp(sprintf('Dimensions: %dx%dx%d',NVec(1),NVec(2),NVec(3)));
    disp(sprintf('Defect Mode: %d',DefectMode));
	disp('Creating Hamiltonian...');
    [Ham] = GenGlobalHamiltonian(NVec, tVec, BTopVec, BBotVec, ModelMode, DefectMode, DefectScale, LineInt, RelInt, DefectSign);
    CheckHermiticity(Ham, CheckHerm);
	disp('Solving...');
    [eSys] = ComputeEigenSystem(Ham, NumBands);
    GAP = eSys((NumBands/2)+1,1)-eSys(NumBands/2,1);
    disp(sprintf('Gap size: %f',GAP));
    disp('Done!');
    toc
    PrintEigenSystemToFile(NVec, eSys, ModelMode,DefectMode, NumBands, PrinttoFile);
end