function [HamLocal] = GenLocalHamiltonian(tVec, DefectMode)
    %This returns the local Hamiltonian
    

    
    %Interaction strengths
    t1 = tVec(1);
    t2 = tVec(2);
    t3 = tVec(3);
    
    %The local Hamiltonian
    
    %
    HamLocal(1,1,2,1,2)=-2i*t1;
    HamLocal(1,1,2,2,1)=-2i*t1;
    HamLocal(1,1,2,3,4)=2i*t1;
    HamLocal(1,1,2,4,3)=2i*t1;
    HamLocal(1,2,2,1,1)=t3;
    HamLocal(1,2,2,1,2)=-t1;
    HamLocal(1,2,2,2,1)=t1;
    HamLocal(1,2,2,2,2)=-t3;
    HamLocal(1,2,2,3,3)=t3;
    HamLocal(1,2,2,3,4)=-t1;
    HamLocal(1,2,2,4,3)=t1;
    HamLocal(1,2,2,4,4)=-t3;
    
    HamLocal(1,2,3,1,1)=t3;
    HamLocal(1,2,3,1,2)=-t1;
    HamLocal(1,2,3,2,1)=t1;
    HamLocal(1,2,3,2,2)=-t3;
    HamLocal(1,2,3,3,3)=t3;
    HamLocal(1,2,3,3,4)=-t1;
    HamLocal(1,2,3,4,3)=t1;
    HamLocal(1,2,3,4,4)=-t3;
    %
    HamLocal(2,1,2,1,1)=t3;
    HamLocal(2,1,2,1,2)=t1;
    HamLocal(2,1,2,1,4)=2i*t1;
    HamLocal(2,1,2,2,1)=-t1;
    HamLocal(2,1,2,2,2)=-t3;
    HamLocal(2,1,2,2,3)=2i*t1;
    HamLocal(2,1,2,3,2)=2i*t1;
    HamLocal(2,1,2,3,3)=t3;
    HamLocal(2,1,2,3,4)=t1;
    HamLocal(2,1,2,4,1)=2i*t1;
    HamLocal(2,1,2,4,3)=-t1;
    HamLocal(2,1,2,4,4)=-t3;
    
    HamLocal(2,1,3,1,1)=2*t3;
    HamLocal(2,1,3,1,2)=-2*t1;
    HamLocal(2,1,3,2,1)=2*t1;
    HamLocal(2,1,3,2,2)=-2*t3;
    HamLocal(2,1,3,3,3)=2*t3;
    HamLocal(2,1,3,3,4)=-2*t1;
    HamLocal(2,1,3,4,3)=2*t1;
    HamLocal(2,1,3,4,4)=-2*t3;
    
    if (DefectMode == 1)
        %{
        HamLocal(2,2,3,1,2)=-t1;
        HamLocal(2,2,3,2,1)=t1;
        HamLocal(2,2,3,3,4)=-t1;
        HamLocal(2,2,3,4,3)=t1;
        HamLocal(2,2,1,1,2)=t1;
        HamLocal(2,2,1,2,1)=-t1;
        HamLocal(2,2,1,3,4)=t1;
        HamLocal(2,2,1,4,3)=-t1;
        %}
        HamLocal(2,2,3,1,2)=-2i*t1;
        HamLocal(2,2,3,2,1)=-2i*t1;
        HamLocal(2,2,3,3,4)=2i*t1;
        HamLocal(2,2,3,4,3)=2i*t1;
        HamLocal(2,2,1,1,2)=2i*t1;
        HamLocal(2,2,1,2,1)=2i*t1;
        HamLocal(2,2,1,3,4)=-2i*t1;
        HamLocal(2,2,1,4,3)=-2i*t1;
    end
   
    if (DefectMode == 2)
        HamLocal(1,2,1,1,1)=t3;
        HamLocal(1,2,1,1,2)=t1;
        HamLocal(1,2,1,2,1)=-t1;
        HamLocal(1,2,1,2,2)=-t3;
        HamLocal(1,2,1,3,3)=t3;
        HamLocal(1,2,1,3,4)=t1;
        HamLocal(1,2,1,4,3)=-t1;
        HamLocal(1,2,1,4,4)=-t3;
        HamLocal(3,2,3,1,1)=t3;
        HamLocal(3,2,3,1,2)=-t1;
        HamLocal(3,2,3,2,1)=t1;
        HamLocal(3,2,3,2,2)=-t3;
        HamLocal(3,2,3,3,3)=t3;
        HamLocal(3,2,3,3,4)=-t1;
        HamLocal(3,2,3,4,3)=t1;
        HamLocal(3,2,3,4,4)=-t3;
    end
    
    if (DefectMode == 4)
        HamLocal(1,1,2,1,2)=-2i*t1;
        HamLocal(1,1,2,2,1)=-2i*t1;
        HamLocal(1,1,2,3,4)=2i*t1;
        HamLocal(1,1,2,4,3)=2i*t1;
        HamLocal(1,2,2,1,1)=t3;
        HamLocal(1,2,2,1,2)=-t1;
        HamLocal(1,2,2,2,1)=t1;
        HamLocal(1,2,2,2,2)=-t3;
        HamLocal(1,2,2,3,3)=t3;
        HamLocal(1,2,2,3,4)=-t1;
        HamLocal(1,2,2,4,3)=t1;
        HamLocal(1,2,2,4,4)=-t3;
    end
    
    HamLocal(2,2,2,1,1)=-2*t2;
    HamLocal(2,2,2,2,2)=2*t2;
    HamLocal(2,2,2,3,3)=-2*t2;
    HamLocal(2,2,2,4,4)=2*t2;
    
    HamLocal(2,3,1,1,1)=2*t3;
    HamLocal(2,3,1,1,2)=2*t1;
    HamLocal(2,3,1,2,1)=-2*t1;
    HamLocal(2,3,1,2,2)=-2*t3;
    HamLocal(2,3,1,3,3)=2*t3;
    HamLocal(2,3,1,3,4)=2*t1;
    HamLocal(2,3,1,4,3)=-2*t1;
    HamLocal(2,3,1,4,4)=-2*t3;
    %
    HamLocal(2,3,2,1,1)=t3;
    HamLocal(2,3,2,1,2)=-t1;
    HamLocal(2,3,2,1,4)=-2i*t1;
    HamLocal(2,3,2,2,1)=t1;
    HamLocal(2,3,2,2,2)=-t3;
    HamLocal(2,3,2,2,3)=-2i*t1;
    HamLocal(2,3,2,3,2)=-2i*t1;
    HamLocal(2,3,2,3,3)=t3;
    HamLocal(2,3,2,3,4)=-t1;
    HamLocal(2,3,2,4,1)=-2i*t1;
    HamLocal(2,3,2,4,3)=t1;
    HamLocal(2,3,2,4,4)=-t3;
    
    HamLocal(3,2,1,1,1)=t3;
    HamLocal(3,2,1,1,2)=t1;
    HamLocal(3,2,1,2,1)=-t1;
    HamLocal(3,2,1,2,2)=-t3;
    HamLocal(3,2,1,3,3)=t3;
    HamLocal(3,2,1,3,4)=t1;
    HamLocal(3,2,1,4,3)=-t1;
    HamLocal(3,2,1,4,4)=-t3;
    %
    HamLocal(3,2,2,1,1)=t3;
    HamLocal(3,2,2,1,2)=t1;
    HamLocal(3,2,2,2,1)=-t1;
    HamLocal(3,2,2,2,2)=-t3;
    HamLocal(3,2,2,3,3)=t3;
    HamLocal(3,2,2,3,4)=t1;
    HamLocal(3,2,2,4,3)=-t1;
    HamLocal(3,2,2,4,4)=-t3;
    HamLocal(3,3,2,1,2)=2i*t1;
    HamLocal(3,3,2,2,1)=2i*t1;
    HamLocal(3,3,2,3,4)=-2i*t1;
    HamLocal(3,3,2,4,3)=-2i*t1;
    %}
    %{
    HamLocal(1,1,2,1,2) = -2*i*t1;
    HamLocal(1,1,2,2,1) = -2*i*t1;
    HamLocal(1,1,2,3,4) = 2*i*t1;
    HamLocal(1,1,2,4,3) = 2*i*t1;
    HamLocal(1,2,2,1,1) = t3;
    HamLocal(1,2,2,1,2) = -t1;
    HamLocal(1,2,2,2,1) = t1;
    HamLocal(1,2,2,2,2) = -t3;
    HamLocal(1,2,2,3,3) = t3;
    HamLocal(1,2,2,3,4) = -t1;
    HamLocal(1,2,2,4,3) = t1;
    HamLocal(1,2,2,4,4) = -t3;
    HamLocal(1,2,3,1,1) = t3;
    HamLocal(1,2,3,1,2) = -t1;
    HamLocal(1,2,3,2,1) = t1;
    HamLocal(1,2,3,2,2) = -t3;
    HamLocal(1,2,3,3,3) = t3;
    HamLocal(1,2,3,3,4) = -t1;
    HamLocal(1,2,3,4,3) = t1;
    HamLocal(1,2,3,4,4) = -t3;
    HamLocal(2,1,2,1,4) = 2*i*t1;
    HamLocal(2,1,2,2,3) = 2*i*t1;
    HamLocal(2,1,2,3,2) = 2*i*t1;
    HamLocal(2,1,2,4,1) = 2*i*t1;
    HamLocal(2,2,2,1,1) = -2*t2;
    HamLocal(2,2,2,2,2) = 2*t2;
    HamLocal(2,2,2,3,3) = -2*t2;
    HamLocal(2,2,2,4,4) = 2*t2;
    HamLocal(2,3,2,1,4) = -2*i*t1;
    HamLocal(2,3,2,2,3) = -2*i*t1;
    HamLocal(2,3,2,3,2) = -2*i*t1;
    HamLocal(2,3,2,4,1) = -2*i*t1;
    HamLocal(3,2,1,1,1) = t3;
    HamLocal(3,2,1,1,2) = t1;
    HamLocal(3,2,1,2,1) = -t1;
    HamLocal(3,2,1,2,2) = -t3;
    HamLocal(3,2,1,3,3) = t3;
    HamLocal(3,2,1,3,4) = t1;
    HamLocal(3,2,1,4,3) = -t1;
    HamLocal(3,2,1,4,4) = -t3;
    HamLocal(3,2,2,1,1) = t3;
    HamLocal(3,2,2,1,2) = t1;
    HamLocal(3,2,2,2,1) = -t1;
    HamLocal(3,2,2,2,2) = -t3;
    HamLocal(3,2,2,3,3) = t3;
    HamLocal(3,2,2,3,4) = t1;
    HamLocal(3,2,2,4,3) = -t1;
    HamLocal(3,2,2,4,4) = -t3;
    HamLocal(3,3,2,1,2) = 2*i*t1;
    HamLocal(3,3,2,2,1) = 2*i*t1;
    HamLocal(3,3,2,3,4) = -2*i*t1;
    HamLocal(3,3,2,4,3) = -2*i*t1;
    %}
    %Normalises the Hamiltonian
    HamLocal = 0.5*HamLocal;
end

