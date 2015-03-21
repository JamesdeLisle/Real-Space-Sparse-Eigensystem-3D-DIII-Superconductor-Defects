function [HamGlobal] = GenGlobalHamiltonian(NVec, tVec, BTopVec, BBotVec, ModelMode, DefectMode, DefectScale, LineInt, RelInt, DefectSign)

    Nx = NVec(1);
    Ny = NVec(2);
    Nz = NVec(3);
    GlobalDim = 4*Nx*Ny*Nz;    
    disp(sprintf('Hamiltonian size: %d',GlobalDim));
    HamLocal = GenLocalHamiltonian(tVec, DefectMode);
    MaxIntLength = 1;
    
    switch ModelMode
        case 1; AllowPerX = 0; AllowPerY = 0; AllowPerZ = 1;
        case 2; AllowPerX = 0; AllowPerY = 1; AllowPerZ = 0;
        case 3; AllowPerX = 0; AllowPerY = 1; AllowPerZ = 1;
        case 4; AllowPerX = 1; AllowPerY = 0; AllowPerZ = 0;
        case 5; AllowPerX = 1; AllowPerY = 0; AllowPerZ = 1;
        case 6; AllowPerX = 1; AllowPerY = 1; AllowPerZ = 0;
        case 7; AllowPerX = 1; AllowPerY = 1; AllowPerZ = 1;
        otherwise; AllowPerX = 0; AllowPerY = 0; AllowPerZ = 0;
    end
    
    HamGlobal = zeros(GlobalDim);
    
    for ctx = 1:Nx
        for cty = 1:Ny
            for ctz = 1:Nz
                ctxIntMin = (1-AllowPerX)*min(MaxIntLength, ctx-1) + AllowPerX*MaxIntLength;
                ctxIntMax = (1-AllowPerX)*min(MaxIntLength, Nx-ctx) + AllowPerX*MaxIntLength;
                ctyIntMin = (1-AllowPerY)*min(MaxIntLength, cty-1) + AllowPerY*MaxIntLength;
                ctyIntMax = (1-AllowPerY)*min(MaxIntLength, Ny-cty) + AllowPerY*MaxIntLength;
                ctzIntMin = (1-AllowPerZ)*min(MaxIntLength, ctz-1) + AllowPerZ*MaxIntLength;
                ctzIntMax = (1-AllowPerZ)*min(MaxIntLength, Nz-ctz) + AllowPerZ*MaxIntLength;
                for ctxInt = -ctxIntMin:ctxIntMax
                    for ctyInt = -ctyIntMin:ctyIntMax
                        for ctzInt = -ctzIntMin:ctzIntMax
                            for ct1 = 1:4
                                for ct2 = 1:4
                                    StateIn = (ctx-1)*4*Nz*Ny + (cty-1)*4*Nz + (ctz-1)*4 + ct1;
                                    StateOut = mod(ctx+ctxInt-1,Nx)*4*Nz*Ny + mod(cty+ctyInt-1,Ny)*4*Nz + mod(ctz+ctzInt-1,Nz)*4 + ct2;
                                    TermScale = 1.0;
                                    [TermScale] = Defects(ctx, cty, ctz, ctxInt, ctyInt, ctzInt, ct1, ct2, Nx, Ny, Nz, DefectMode, LineInt, RelInt);
                                    HamGlobal(StateOut,StateIn) = HamGlobal(StateOut,StateIn) + TermScale * HamLocal(MaxIntLength+1+ctxInt, MaxIntLength+1+ctyInt, MaxIntLength+1+ctzInt, ct1, ct2);
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    BFieldTopZ = BTopVec(1,1)*kron([[1,0];[0,-1]],eye(2)) + BTopVec(2,1)*kron([[0,1];[1,0]],eye(2)) + BTopVec(3,1)*kron([[0,-1i];[1i,0]],eye(2));
    BFieldBotZ = BBotVec(1,1)*kron([[1,0];[0,-1]],eye(2)) + BBotVec(2,1)*kron([[0,1];[1,0]],eye(2)) + BBotVec(3,1)*kron([[0,-1i];[1i,0]],eye(2));
    if (AllowPerZ == 0)
        for ctx = 1:Nx
            for cty = 1:Ny
                for ct1 = 1:4
                    for ct2 = 1:4
                        
                        StateIn = (ctx-1)*4*Nz*Ny + (cty-1)*4*Nz + (((Nz/2))-1)*4 + ct1;
                        StateOut = (ctx-1)*4*Nz*Ny + (cty-1)*4*Nz + (((Nz/2))-1)*4 + ct2;
                        if (cty > ceil(Ny/4)) && (cty < ceil(3*Ny/4))
                            HamGlobal(StateOut,StateIn) = HamGlobal(StateOut,StateIn) - DefectSign * DefectScale * BFieldTopZ(ct1,ct2);
                        else
                            HamGlobal(StateOut,StateIn) = HamGlobal(StateOut,StateIn) - DefectScale * BFieldTopZ(ct1,ct2);
                        end
                        
                        StateIn = (ctx-1)*4*Nz*Ny + (cty-1)*4*Nz + (((Nz/2)+1)-1)*4 + ct1;
                        StateOut = (ctx-1)*4*Nz*Ny + (cty-1)*4*Nz + (((Nz/2)+1)-1)*4 + ct2;
                        if (cty > ceil(Ny/4)) && (cty < ceil(3*Ny/4))
                            HamGlobal(StateOut,StateIn) = HamGlobal(StateOut,StateIn) + DefectSign * DefectScale * BFieldTopZ(ct1,ct2);
                        else
                            HamGlobal(StateOut,StateIn) = HamGlobal(StateOut,StateIn) + DefectScale * BFieldTopZ(ct1,ct2);
                        end

                        StateIn = (ctx-1)*4*Nz*Ny + (cty-1)*4*Nz + (Nz-1)*4 + ct1;
                        StateOut = (ctx-1)*4*Nz*Ny + (cty-1)*4*Nz + (Nz-1)*4 + ct2;
                        HamGlobal(StateOut,StateIn) = HamGlobal(StateOut,StateIn) + BFieldTopZ(ct1,ct2);

                        StateIn = (ctx-1)*4*Nz*Ny + (cty-1)*4*Nz + (1-1)*4 + ct1;
                        StateOut = (ctx-1)*4*Nz*Ny + (cty-1)*4*Nz + (1-1)*4 + ct2;
                        HamGlobal(StateOut,StateIn) = HamGlobal(StateOut,StateIn) - BFieldTopZ(ct1,ct2);

                    end
                end
            end
        end
    end
    if (AllowPerY == 0)
        BFieldTopY = BTopVec(1,3)*kron([[1,0];[0,-1]],eye(2)) + BTopVec(2,3)*kron([[0,1];[1,0]],eye(2)) + BTopVec(3,3)*kron([[0,-1i];[1i,0]],eye(2));
        BFieldBotY = BBotVec(1,3)*kron([[1,0];[0,-1]],eye(2)) + BBotVec(2,3)*kron([[0,1];[1,0]],eye(2)) + BBotVec(3,3)*kron([[0,-1i];[1i,0]],eye(2));
        for ctx = 1:Nx
            for ctz = 1:Nz
                for ct1 = 1:4
                    for ct2 = 1:4
                        
                        StateIn = (ctx-1)*4*Nz*Ny + (1-1)*4*Nz + (ctz-1)*4 + ct1;
                        StateOut = (ctx-1)*4*Nz*Ny + (1-1)*4*Nz + (ctz-1)*4 + ct2;
                        if (ctz <= Nz/2)
                            HamGlobal(StateOut,StateIn) = HamGlobal(StateOut,StateIn) + BFieldTopY(ct1,ct2);
                        else
                            HamGlobal(StateOut,StateIn) = HamGlobal(StateOut,StateIn) + BFieldTopY(ct1,ct2);
                        end

                        StateIn = (ctx-1)*4*Nz*Ny + (Ny-1)*4*Nz + (ctz-1)*4 + ct1;
                        StateOut = (ctx-1)*4*Nz*Ny + (Ny-1)*4*Nz + (ctz-1)*4 + ct2;
                        if (ctz <= Nz/2)
                            HamGlobal(StateOut,StateIn) = HamGlobal(StateOut,StateIn) + BFieldTopY(ct1,ct2);
                        else
                            HamGlobal(StateOut,StateIn) = HamGlobal(StateOut,StateIn) + BFieldTopY(ct1,ct2);
                        end
                        
                    end
                end
            end
        end
    end
    if (AllowPerX == 0)
        BFieldTopX = BTopVec(1,2)*kron([[1,0];[0,-1]],eye(2)) + BTopVec(2,2)*kron([[0,1];[1,0]],eye(2)) + BTopVec(3,2)*kron([[0,-1i];[1i,0]],eye(2));
        BFieldBotX = BBotVec(1,2)*kron([[1,0];[0,-1]],eye(2)) + BBotVec(2,2)*kron([[0,1];[1,0]],eye(2)) + BBotVec(3,2)*kron([[0,-1i];[1i,0]],eye(2));
        for cty = 1:Ny
            for ctz = 1:Nz
                for ct1 = 1:4
                    for ct2 = 1:4
                        StateIn = (1-1)*4*Nz*Ny + (cty-1)*4*Nz + (ctz-1)*4 + ct1;
                        StateOut = (1-1)*4*Nz*Ny + (cty-1)*4*Nz + (ctz-1)*4 + ct2;
                        if (ctz <= Nz/2)
                            HamGlobal(StateOut,StateIn) = HamGlobal(StateOut,StateIn) + BFieldTopX(ct1,ct2);
                        else
                            HamGlobal(StateOut,StateIn) = HamGlobal(StateOut,StateIn) + BFieldTopX(ct1,ct2);
                        end

                        StateIn = (Nx-1)*4*Nz*Ny + (cty-1)*4*Nz + (ctz-1)*4 + ct1;
                        StateOut = (Nx-1)*4*Nz*Ny + (cty-1)*4*Nz + (ctz-1)*4 + ct2;
                        if (ctz <= Nz/2)
                            HamGlobal(StateOut,StateIn) = HamGlobal(StateOut,StateIn) + BFieldTopX(ct1,ct2);
                        else
                            HamGlobal(StateOut,StateIn) = HamGlobal(StateOut,StateIn) + BFieldTopX(ct1,ct2);
                        end
                        
                    end
                end
            end
        end
    end
end

