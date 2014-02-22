function ProcessingCTC()
%Current time caracteristic
ctrl_fig = figure('MenuBar','None',...
        'Name','ProgramCTC',...
        'NumberTitle','off',...
        'Position',[100 100 700 500]);
    global U;
    global I;
    global timeT Ip Up Isn Usn Ics Ic Ks
    Iflag=0;
    Uflag=0;
    global commited;
    commited = 0;
    global UFreq;
    global IFreq;
    global IRes;
    global URes;
    global X Tr SYSTEM FLUID NEEDLE SPEED POLARITY TEMPERATURE;
    IRes=99700;
    URes=110500;
    Tr=0.1;
    SYSTEM='needle-plane';
    FLUID='transformer oil';
    NEEDLE='16';
    POLARITY='negative';

    XLine0 = 0.05;
    XLine1 = XLine0 + 0.51;
    XLine2 = 0.635;
    YLine0 = 0.95;
    YLine1 = 0.810;
    YLine1_2 = 0.860;
    XLine3 = XLine1+0.22;
    YLine3 = 0.2;
    addpath('bin');
    addpath('data');
    addpath('dataset')
    
figcolor = get(gcf, 'color');
    
btnOpen = uicontrol(gcf,'Style','pushbutton','units','normal',...   
                        'Position',[XLine0 YLine0 0.07 0.04],...
                        'String','Open','Callback',{@clbOpen, 'Open I File', 'I'});

function clbOpen(src,evt,dialogTitle, type)
    [FileName,PathName] = uigetfile('*I.dat', dialogTitle);
    fprintf('FileName = %s PathName = %s\n', FileName, PathName)
    addpath(PathName);


    [I timeT IFreq]=getSIGNAL(FileName);
    I = sign(max(I)+min(I))*I;

    FileName(end-4)='U';
    [U timeT UFreq]=getSIGNAL(FileName);
    U = sign(max(U)+min(U))*U;
    figure(10)
    plot()
end
end