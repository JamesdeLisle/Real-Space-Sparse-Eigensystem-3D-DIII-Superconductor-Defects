function [] = Scan()
    clear;
    GAP = zeros(1,20);
    NUM = zeros(1,20);
    for i = 1:20
        NUM(i) = (i/20)-0.05;
        Ze = (i/20)-0.05;
        [GAPTemp] = Solve(Ze);
        GAP(i) = GAPTemp;
        disp(sprintf('Interation Scale: %f',Ze));
    end
    
    assignin('base','GAP',GAP);
    figure
    hold on
    plot(NUM,GAP);
    hold off
    
end