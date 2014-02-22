function [y time Freq] = getSIGNAL(FileName)
    FileName = regexprep(FileName, '.dat$', '.m');
    needed_words = {'DataCalibrScale', 'RealChannelsQuantity', ...
        'RealKadrsQuantity', 'DataCalibrZeroK','DataCalibrScale',...
        'DataCalibrOffset','time_string','AdcRate'};
    fid_ = fopen(FileName, 'r');
    while true
        % считываем строку
        tline = fgetl(fid_);
        
        % если она не содержит читабельных символов, то завершаем чтение
        if ~ischar(tline), break, end
        
        % ищем нужные нам переменные
        num_words = 0;
        for i=1:length(needed_words)
            if(~isempty(strfind(tline, needed_words{i})))
                % если находим, то "забиваем" их мусором
                needed_words{i} = 'unexisting value';
                num_words = num_words + 1;
            end
        end
        % если не находим ни одного, то читаем след. строку
        if num_words == 0, continue, end
        
        % иначе выолняем эту строку.
        eval(tline);
    end
    fclose(fid_);
    FileName = regexprep(FileName, '.m$', '.dat');
    
    % Открываем файл для чтения, устанавливаем курсор в 0 и читаем все
    % данные из файла. Формат .dat файла имеет следующий вид: каждый отсчет
    % для каждого канала записывается последовательно в виде 16 битного
    % числа. Соответственно, в y мы получаем вектор из всех отсчетов.
    fid = fopen(FileName, 'r');
    fseek(fid, 0, -1);
    [y] = fread(fid, 'int16');
    
    % Эта команда разбивает отсчеты в y по каналам
    y = reshape(y, RealChannelsQuantity, RealKadrsQuantity);
    fclose(fid);
    
    % преобрауем данные из отсчетов в вольты.
    y=(y(1,:)+DataCalibrZeroK(1))*DataCalibrScale(1)+DataCalibrOffset(1);
    time=time_string;
    Freq=AdcRate;

end

