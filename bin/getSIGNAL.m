function [y time Freq] = getSIGNAL(FileName)
    FileName = regexprep(FileName, '.dat$', '.m');
    needed_words = {'DataCalibrScale', 'RealChannelsQuantity', ...
        'RealKadrsQuantity', 'DataCalibrZeroK','DataCalibrScale',...
        'DataCalibrOffset','time_string','AdcRate'};
    fid_ = fopen(FileName, 'r');
    while true
        % ��������� ������
        tline = fgetl(fid_);
        
        % ���� ��� �� �������� ����������� ��������, �� ��������� ������
        if ~ischar(tline), break, end
        
        % ���� ������ ��� ����������
        num_words = 0;
        for i=1:length(needed_words)
            if(~isempty(strfind(tline, needed_words{i})))
                % ���� �������, �� "��������" �� �������
                needed_words{i} = 'unexisting value';
                num_words = num_words + 1;
            end
        end
        % ���� �� ������� �� ������, �� ������ ����. ������
        if num_words == 0, continue, end
        
        % ����� �������� ��� ������.
        eval(tline);
    end
    fclose(fid_);
    FileName = regexprep(FileName, '.m$', '.dat');
    
    % ��������� ���� ��� ������, ������������� ������ � 0 � ������ ���
    % ������ �� �����. ������ .dat ����� ����� ��������� ���: ������ ������
    % ��� ������� ������ ������������ ��������������� � ���� 16 �������
    % �����. ��������������, � y �� �������� ������ �� ���� ��������.
    fid = fopen(FileName, 'r');
    fseek(fid, 0, -1);
    [y] = fread(fid, 'int16');
    
    % ��� ������� ��������� ������� � y �� �������
    y = reshape(y, RealChannelsQuantity, RealKadrsQuantity);
    fclose(fid);
    
    % ���������� ������ �� �������� � ������.
    y=(y(1,:)+DataCalibrZeroK(1))*DataCalibrScale(1)+DataCalibrOffset(1);
    time=time_string;
    Freq=AdcRate;

end

