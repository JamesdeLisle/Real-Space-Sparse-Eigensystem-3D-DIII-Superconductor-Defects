function [TermScale] = Defects(ctx, cty, ctz, ctxInt, ctyInt, ctzInt, ct1, ct2, Nx, Ny, Nz, DefectMode, LineInt, RelInt)
    
    switch DefectMode
        case 1;
            
            TermScale = 1.0;
            if (ctz == Nz/2) && (ctzInt > 0)
                TermScale = 0.0;
            elseif (ctz == (Nz/2)+1) && (ctzInt < 0)
                TermScale = 0.0;
            end
            
            %{
            if (ctxInt == 0) && (ctyInt == 0) && (ctzInt == 1)
                if (ctz == Nz/2)
                    if (ctx > Nx/4) && (ctx < 3*Nx/4) 
                        if (cty == ceil(Ny/4)+1) 
                            TermScale = LineInt;
                        elseif (cty == ceil(3*Ny/4)-1)
                            TermScale = LineInt;
                        else
                            TermScale = 0.0;
                        end
                    else
                        if (cty == ceil(Ny/4)+1)
                            TermScale = RelInt * LineInt;
                        elseif (cty == ceil(3*Ny/4)-1)
                            TermScale = RelInt * LineInt;
                        else
                            TermScale = 0.0;
                        end
                    end
                elseif (ctz ~= Nz/2)
                    TermScale = 0.0;
                end 
            elseif (ctxInt == 0) && (ctyInt == 0) && (ctzInt == -1)
                if (ctz == (Nz/2)+1)
                    if (ctx > Nx/4) && (ctx < 3*Nx/4) 
                        if (cty == ceil(Ny/4)+1)
                            TermScale = LineInt;
                        elseif (cty == ceil(3*Ny/4)-1)
                            TermScale = LineInt;
                        else
                            TermScale = 0.0;
                        end
                    else
                        if (cty == ceil(Ny/4)+1)
                            TermScale = RelInt * LineInt;
                        elseif (cty == ceil(3*Ny/4)-1)
                            TermScale = RelInt * LineInt;
                        else
                            TermScale = 0.0;
                        end
                    end
                elseif (ctz ~= (Nz/2)+1) 
                    TermScale = 0.0;
                end
            end
            %}
            if (ctxInt == 0) && (ctyInt == 0) && (ctzInt == 1)
                if (ctz == Nz/2)
                    if (cty > ceil(Ny/4)-2) && (cty < ceil(Ny/4)+2)
                        if (ctx > ceil(Nx/4)) && (ctx + ctxInt > ceil(Nx/4)) && (ctx < ceil(3*Nx/4)) && (ctx + ctxInt < ceil(3*Nx/4))
                            TermScale = LineInt;
                        else
                            TermScale = RelInt * LineInt;
                        end
                    elseif (cty > ceil(3*Ny/4)-2) && (cty < ceil(3*Ny/4)+2)
                        if (ctx > ceil(Nx/4)) && (ctx + ctxInt > ceil(Nx/4)) && (ctx < ceil(3*Nx/4)) && (ctx + ctxInt < ceil(3*Nx/4))
                            TermScale = LineInt;
                        else
                            TermScale = RelInt * LineInt;
                        end
                    end
                elseif (ctz ~= Nz/2)
                    TermScale = 0.0;
                end 
            elseif (ctxInt == 0) && (ctyInt == 0) && (ctzInt == -1)
                if (ctz == (Nz/2)+1)
                    if (cty > ceil(Ny/4)-2) && (cty < ceil(Ny/4)+2)
                        if (ctx > ceil(Nx/4)) && (ctx + ctxInt > ceil(Nx/4)) && (ctx < ceil(3*Nx/4)) && (ctx + ctxInt < ceil(3*Nx/4))
                            TermScale = LineInt;
                        else
                            TermScale = RelInt * LineInt;
                        end
                    elseif (cty > ceil(3*Ny/4)-2) && (cty < ceil(3*Ny/4)+2)
                        if (ctx > ceil(Nx/4)) && (ctx + ctxInt > ceil(Nx/4)) && (ctx < ceil(3*Nx/4)) && (ctx + ctxInt < ceil(3*Nx/4))
                            TermScale = LineInt;
                        else
                            TermScale = RelInt * LineInt;
                        end
                    end
                elseif (ctz ~= (Nz/2)+1) 
                    TermScale = 0.0;
                end
            end
            
            if (ctz <= Nz/2) && (ctxInt == 0) && (ctyInt == 0) && (ctzInt == 0)
                TermScale = -1.0;
            elseif (ctz > Nz/2) && (ctxInt == 0) && (ctyInt == 0) && (ctzInt == 0)
                TermScale = 1.0;
            end
            
        case 2;
            TermScale = 1.0;
            if (ctz == Nz/2) && (ctzInt > 0)
                TermScale = 0.0;
            elseif (ctz == (Nz/2)+1) && (ctzInt < 0)
                TermScale = 0.0;
            end

            if (ctxInt == 1) && (ctyInt == 0) && (ctzInt == 1)
                if (ctz == Nz/2)
                    if (ctx > Nx/4) && (ctx + ctxInt > Nx/4) && (ctx < 3*Nx/4) && (ctx + ctxInt < 3*Nx/4) 
                        if (cty > ceil(Ny/4)-1) && (cty < ceil(Ny/4)+3) && (ct1 ~= ct2) 
                            TermScale = LineInt;
                        elseif (cty > ceil(3*Ny/4)-3) && (cty < ceil(3*Ny/4)+1) && (ct1 ~= ct2)
                            TermScale = LineInt;
                        else
                            TermScale = 0.0;
                        end
                    else
                        if (cty > ceil(Ny/4)-1) && (cty < ceil(Ny/4)+3) && (ct1 ~= ct2)
                            TermScale = RelInt * LineInt;
                        elseif (cty > ceil(3*Ny/4)-3) && (cty < ceil(3*Ny/4)+1) && (ct1 ~= ct2)
                            TermScale = RelInt * LineInt;
                        else
                            TermScale = 0.0;
                        end
                    end
                else 
                    TermScale = 0.0;
                end
            elseif (ctxInt == -1) && (ctyInt == 0) && (ctzInt == -1)
                if (ctz == (Nz/2)+1)
                    if (ctx > Nx/4) && (ctx < 3*Nx/4) 
                        if (cty > ceil(Ny/4)-1) && (cty < ceil(Ny/4)+3)  && (ct1 ~= ct2)
                            TermScale = LineInt;
                        elseif (cty > ceil(3*Ny/4)-3) && (cty < ceil(3*Ny/4)+1) && (ct1 ~= ct2)
                            TermScale = LineInt;
                        else
                            TermScale = 0.0;
                        end
                    else
                        if (cty > ceil(Ny/4)-1) && (cty < ceil(Ny/4)+3)  && (ct1 ~= ct2)
                            TermScale = RelInt * LineInt;
                        elseif (cty > ceil(3*Ny/4)-3) && (cty < ceil(3*Ny/4)+1) && (ct1 ~= ct2)
                            TermScale = RelInt * LineInt;
                        else
                            TermScale = 0.0;
                        end
                    end
                else 
                    TermScale = 0.0;
                end
            end
    
            if (ctz == Nz/2) && (ctzInt > 0)
                    if (ctx > Nx/4) && (ctx + ctxInt > Nx/4) && (ctx < 3*Nx/4) && (ctx + ctxInt < 3*Nx/4) 
                        if (cty > ceil(Ny/4)-1) && (cty < ceil(Ny/4)+3)  && (ctyInt == 0) && (ct1 ~= ct2) 
                            TermScale = LineInt;
                        elseif (cty > ceil(3*Ny/4)-3) && (cty < ceil(3*Ny/4)+1) && (ctyInt == 0) && (ct1 ~= ct2)
                            TermScale = LineInt;
                        else
                            TermScale = 0.0;
                        end
                    else
                        if (cty > ceil(Ny/4)-1) && (cty < ceil(Ny/4)+3)  && (ctyInt == 0)  && (ct1 ~= ct2)
                            TermScale = RelInt * LineInt;
                        elseif (cty > ceil(3*Ny/4)-3) && (cty < ceil(3*Ny/4)+1) && (ctyInt == 0) && (ct1 ~= ct2)
                            TermScale = RelInt * LineInt;
                        else
                            TermScale = 0.0;
                        end
                    end
            elseif (ctz == (Nz/2)+1) && (ctzInt < 0)
                if (ctx > Nx/4) && (ctx + ctxInt > Nx/4) && (ctx < 3*Nx/4) && (ctx + ctxInt < 3*Nx/4) 
                    if (cty > ceil(Ny/4)-1) && (cty < ceil(Ny/4)+3) && (ctyInt == 0)  && (ct1 ~= ct2)
                        TermScale = LineInt;
                    elseif (cty > ceil(3*Ny/4)-3) && (cty < ceil(3*Ny/4)+1) && (ctyInt == 0) && (ct1 ~= ct2)
                        TermScale = LineInt;
                    else
                        TermScale = 0.0;
                    end
                else
                    if (cty > ceil(Ny/4)-1) && (cty < ceil(Ny/4)+3)  && (ctyInt == 0)  && (ct1 ~= ct2)
                        TermScale = RelInt * LineInt;
                    elseif (cty > ceil(3*Ny/4)-3) && (cty < ceil(3*Ny/4)+1) && (ctyInt == 0) && (ct1 ~= ct2)
                        TermScale = RelInt * LineInt;
                    else
                        TermScale = 0.0;
                    end
                end
            end 

            if (ctz <= Nz/2) && (ctxInt == 0) && (ctyInt == 0) && (ctzInt == 0)
                TermScale = -1.0;
            elseif (ctz > Nz/2) && (ctxInt == 0) && (ctyInt == 0) && (ctzInt == 0)
                TermScale = 1.0;
            end
            
        case 3;
            
            TermScale = 1.0;
            if (ctz == Nz/2) && (ctzInt > 0)
                if (ctx > Nx/4) && (ctx + ctxInt > Nx/4) && (ctx < 3*Nx/4) && (ctx + ctxInt < 3*Nx/4)
                    TermScale = LineInt;
                else
                    TermScale = RelInt * LineInt;
                end
            elseif (ctz == (Nz/2)+1) && (ctzInt < 0)
                if (ctx > Nx/4) && (ctx + ctxInt > Nx/4) && (ctx < 3*Nx/4) && (ctx + ctxInt < 3*Nx/4)
                    TermScale = LineInt;
                else
                    TermScale = RelInt * LineInt;
                end
            end
            
            if (ctz <= Nz/2) && (ctxInt == 0) && (ctyInt == 0) && (ctzInt == 0)
                TermScale = -1.0;
            elseif (ctz > Nz/2) && (ctxInt == 0) && (ctyInt == 0) && (ctzInt == 0)
                TermScale = 1.0;
            end
        
        case 4;
            
            
            
        otherwise
            TermScale = 0.0;
    end
            







end