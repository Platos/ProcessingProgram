function [data]=obtaining(Name,nLCARD,Number,endI,endU)
    if nLCARD==2
        CurrentFile = [Name sprintf('_%04d', Number) endI '.dat'];
        VoltageFile = [Name sprintf('_%04d', Number) endU '.dat'];
        CurrentFileInd = fopen(CurrentFile,'r');
        I_= fread(CurrentFileInd, 'int16'); fclose(CurrentFileInd);
        VoltageFileInd = fopen(VoltageFile,'r');
        U_= fread(VoltageFileInd, 'int16'); fclose(VoltageFileInd);
        data=[I_ U_];
    end
end