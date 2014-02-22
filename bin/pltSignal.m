function [X Ks]=pltSignal(UFreq,IFreq,I,U)
    Is=fastsmooth(I,IFreq/50);
    Us=fastsmooth(U,UFreq/50);
%    SelectFig = figure;
Ks=1;
if length(Us)>=3e5
    Ks=2;
    if length(Us)>=5e5
        Ks=5;
        if length(Us)>=2e6
            Ks=10;
        end
    end
end
    plot(Is(1:Ks:end)/ max(Is), 'b');
    hold on
    plot(Us(1:Ks:end)/ max(Us), 'r');
    [x1, y1] = ginput(2);
    legend('');
    hold off
%    close(SelectFig);
    tic
    X=[round(min(x1)) round(max(x1)) 0 0 0 0]*Ks;
%    SelectFig = figure;
    plot(Is(X(1):Ks:round(X(2)/Ks))/ max(Is), 'b');
    [x2, y2] = ginput(2);
%    close(SelectFig);
    tic
%    SelectFig = figure;
    plot(Us(X(1):Ks:round(X(2)/Ks))/ max(Us), 'r');
    [x3, y3] = ginput(2);
%    close(SelectFig);
    tic
    
    X=round([min(x1) max(x1) min(x2) max(x2) min(x3) max(x3)]*Ks);
end