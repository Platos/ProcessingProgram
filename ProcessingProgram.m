function ProcessingProgram()
    clc;
    close all;
    
    addpath bin 
    addpath data 
    addpath dataset 
    
    global U I timeT Isn Usn Ics Ic Ks hA1;
    global UFreq IFreq IRes URes;
    global X SYSTEM FLUID NEEDLE SPEED POLARITY TEMPERATURE;
    global txtFilePathI txtFilePathU edtIFreq edtUFreq edtIRes;
    global edtURes btnSelect edtSNI edtSNU edtSNIc btnRefresh;
    global edtSYSTEM edtFLUID btnDATAsv edtTEMP edtPOLARITY edtNEEDLE;
    global edtSPEED edtTEMPres edtPOG;
    global cbCVC cbCTC cbCVCws;
    
    global commited;
	commited = 0;
    Iflag=0;
    Uflag=0;
    
    load('bin\tmp.mat');
    load('bin\tmp2.mat');
    
    creatorGUI
    
function creatorGUI()
    XLine0 = 0.05;
    XLine1 = XLine0 + 0.51;
    %XLine2 = 0.635;
    YLine0 = 0.95;
    YLine1 = 0.810;
    YLine1_2 = 0.860;
    XLine3 = XLine1+0.22;
    YLine3 = 0.2;
    
%~~~~~~~~~~~~Create GUI~~~~~~~~~~~~
%~~~~~~~~~~~~Main window~~~~~~~~~~~
figure('MenuBar','None',...
       'Name','ProcessingProgram',...
       'NumberTitle','off',...
       'Position',[100 100 700 500]);
   
figcolor = get(gcf, 'color');
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

%~~~~~~~~~~Grafics window~~~~~~~~~~
hA1 = axes;
set(hA1, 'Position', [XLine0 YLine3 0.5 0.7])
axes(hA1)
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

%~~~~~~~~~~~~~Controls~~~~~~~~~~~~~
%~~~~~~~~~~~~Open buttns~~~~~~~~~~~
% I file open buuttn
uicontrol(gcf,'Style','pushbutton','units','normal',...   
          'Position',[XLine0 YLine0 0.07 0.04],...
          'String','Open I','Callback',{@clbOpen, 'Open I File', 'I'});
txtFilePathI = uicontrol(   gcf,'style', 'text','units','normal',...
                            'position', [(XLine0+0.08) YLine0 .7 .035],'string', '','horizontalAlignment', 'left',...
                            'foregroundcolor', 'black','backgroundcolor', figcolor);
% U file open buttn(diable)
uicontrol(  gcf,'Style','pushbutton','units','normal',...   
            'Position',[XLine0 (YLine0-0.04) 0.07 0.04],'enable','off',...
            'String','Open U','Callback',{@clbOpen, 'Open U File', 'U'});
txtFilePathU = uicontrol(   gcf,'style', 'text','units','normal',...
                            'position', [(XLine0+0.08) (YLine0-0.04) .7 .035],'string', '','horizontalAlignment', 'left',...
                            'foregroundcolor', 'black','backgroundcolor', figcolor);
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

%~~~~~~~~~~~~~~Data~~~~~~~~~~~~~~~~
uicontrol(  gcf,'style', 'text','units','normal',...
            'position', [XLine1 YLine1+0.05 .2 .035],'string', 'Processing parametrs:','horizontalAlignment', 'left',...
            'foregroundcolor', 'black','backgroundcolor', figcolor);
% I obtaning frequency
uicontrol(  gcf,'style', 'text','units','normal',...
            'position', [XLine1 YLine1 .04 .035],'string', 'I freq','horizontalAlignment', 'left',...
            'foregroundcolor', 'black','backgroundcolor', figcolor);                        
edtIFreq = uicontrol(	gcf,'Style','edit','units','normal',... 
                        'Position',[(XLine1+0.04) YLine1 0.15 0.04],...
                        'String','');
% U obtaning frequency
uicontrol(  gcf,'style', 'text','units','normal',...
            'position', [XLine1 (YLine1-0.05) .04 .035],'string', 'Ufreq','horizontalAlignment', 'left',...
            'foregroundcolor', 'black','backgroundcolor', figcolor);
edtUFreq = uicontrol(   gcf,'Style','edit','units','normal',... 
                        'Position',[(XLine1+0.04) (YLine1-0.05) 0.15 0.04],...
                        'String','');
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

%~~~~~~~~~~~Parameters~~~~~~~~~~~~~
% I resistance
uicontrol(  gcf,'style', 'text','units','normal',...
            'position', [XLine1 (YLine1-0.10) .04 .035],'string', 'Resi','horizontalAlignment', 'left',...
            'foregroundcolor', 'black','backgroundcolor', figcolor);
edtIRes = uicontrol(gcf,'Style','edit','units','normal',... 
                    'Position',[(XLine1+0.04) (YLine1-0.10) 0.15 0.04],...
                    'String',num2str(IRes));
% U  resistance (from curren divider)
uicontrol(  gcf,'style', 'text','units','normal',...
            'position', [XLine1 (YLine1-0.15) .04 .035],'string', 'Resu','horizontalAlignment', 'left',...
            'foregroundcolor', 'black','backgroundcolor', figcolor);
edtURes = uicontrol(gcf,'Style','edit','units','normal',... 
                    'Position',[(XLine1+0.04) (YLine1-0.15) 0.15 0.04],...
                    'String',num2str(URes)); 
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

%~~~~~~~~~~~~Processing~~~~~~~~~~~~
btnSelect = uicontrol(gcf,'Style','pushbutton','units','normal',...   
                      'Position',[XLine1 (YLine1-0.20) 0.19 0.04],...
                      'String','Select Signal','Callback',@clbSelect);                      
uicontrol(gcf,'style', 'text','units','normal',...
          'position', [XLine1 (YLine1-0.26) .04 .035],'string', 'SNI','horizontalAlignment', 'left',...
          'foregroundcolor', 'black','backgroundcolor', figcolor);
edtSNI = uicontrol(gcf,'Style','edit','units','normal',... 
                   'Position',[(XLine1+0.04) (YLine1-0.26) 0.15 0.04],...
                   'String','200');                       
uicontrol(gcf,'style', 'text','units','normal',...
          'position', [XLine1 (YLine1-0.31) .04 .035],'string', 'SNU','horizontalAlignment', 'left',...
          'foregroundcolor', 'black','backgroundcolor', figcolor);
edtSNU = uicontrol(gcf,'Style','edit','units','normal',... 
                   'Position',[(XLine1+0.04) (YLine1-0.31) 0.15 0.04],...
                   'String','200');  
uicontrol(gcf,'style', 'text','units','normal',...
          'position', [XLine1 (YLine1-0.36) .04 .035],'string', 'SNIc','horizontalAlignment', 'left',...
          'foregroundcolor', 'black','backgroundcolor', figcolor);
edtSNIc = uicontrol(gcf,'Style','edit','units','normal',... 
                    'Position',[(XLine1+0.04) (YLine1-0.36) 0.15 0.04],...
                    'String','50');                        
btnRefresh = uicontrol(gcf,'Style','pushbutton','units','normal',...   
                       'Position',[XLine1 (YLine1-0.41) 0.19 0.04],...
                       'String','Refresh','Callback',@clbRefresh);
uicontrol(gcf,'style', 'text','units','normal',...
          'position', [XLine3 (YLine1_2) .06 .035],'string', 'System:','horizontalAlignment', 'left',...
          'foregroundcolor', 'black','backgroundcolor', figcolor);
edtSYSTEM = uicontrol(gcf,'Style','edit','units','normal',... 
                      'Position',[(XLine3) (YLine1_2-0.05) 0.21 0.04],...
                      'String',SYSTEM);
uicontrol(gcf,'style', 'text','units','normal',...
          'position', [XLine3 (YLine1_2-0.1) .06 .035],'string', 'Fluid:','horizontalAlignment', 'left',...
          'foregroundcolor', 'black','backgroundcolor', figcolor);
edtFLUID = uicontrol(gcf,'Style','edit','units','normal',... 
                     'Position',[(XLine3) (YLine1_2-0.15) 0.21 0.04],...
                     'String',FLUID);
uicontrol(gcf,'style', 'text','units','normal',...
          'position', [XLine3 (YLine1_2-0.2) .06 .035],'string', 'Polarity:','horizontalAlignment', 'left',...
          'foregroundcolor', 'black','backgroundcolor', figcolor);
edtPOLARITY = uicontrol(gcf,'Style','edit','units','normal',... 
                        'Position',[(XLine3) (YLine1_2-0.25) 0.21 0.04],...
                        'String',POLARITY);
uicontrol(gcf,'style', 'text','units','normal',...
          'position', [XLine3 (YLine1_2-0.3) .21 .035],'string', 'Needle radius [mkm]:','horizontalAlignment', 'left',...
          'foregroundcolor', 'black','backgroundcolor', figcolor);
edtNEEDLE = uicontrol(gcf,'Style','edit','units','normal',... 
                      'Position',[(XLine3) (YLine1_2-0.35) 0.21 0.04],...
                      'String',NEEDLE);  
uicontrol(gcf,'style', 'text','units','normal',...
                            'position', [XLine3 (YLine1_2-0.40) .21 .035],'string', 'Modulation rate [kV/s]:','horizontalAlignment', 'left',...
                            'foregroundcolor', 'black','backgroundcolor', figcolor);
edtSPEED = uicontrol(gcf,'Style','edit','units','normal', 'Enable', 'off',... 
                     'Position',[(XLine3) (YLine1_2-0.45) 0.21 0.04],...
                     'String','');
uicontrol(gcf,'style', 'text','units','normal',...
          'position', [XLine3 (YLine1_2-0.50) .21 .035],'string', 'Temperature R [kOhm],T [C]:','horizontalAlignment', 'left',...
          'foregroundcolor', 'black','backgroundcolor', figcolor);
edtTEMPres = uicontrol(gcf,'Style','edit','units','normal',... 
                       'Position',[(XLine3) (YLine1_2-0.55) 0.21 0.04],...
                       'String','','CallBack',@clbRES2TEMP);
edtTEMP = uicontrol(gcf,'Style','edit','units','normal',... 
                    'Position',[(XLine3) (YLine1_2-0.60) 0.21 0.04],...
                    'String','', 'Enable', 'off');
btnDATAsv = uicontrol(gcf,'Style','pushbutton','units','normal','Enable', 'off',...   
                      'Position',[(XLine3) (YLine3-0.1) 0.21 0.04],...
                      'String','Create data set','Callback',@clbDATAsv);
uicontrol(gcf,'Style','pushbutton','units','normal',...   
          'Position',[(XLine3) (YLine3-0.15) 0.21 0.04],...
          'String','Swich to processing','Callback',@clbPROC);
% Ks editor - coeff point on graf
uicontrol(gcf,'style', 'text','units','normal',...
          'position', [XLine1 (YLine1-0.46) .10 .035],'string', 'N POG','horizontalAlignment', 'left',...
          'foregroundcolor', 'black','backgroundcolor', figcolor);
edtPOG=uicontrol(gcf,'Style','edit','units','normal',... 
          'Position',[(XLine1+0.05) (YLine1-0.46) 0.15 0.04],...
          'String','1000');
% plot this
cbCVC=uicontrol(gcf,'style', 'checkbox','units','normal',...
          'position', [XLine1 (YLine1-0.51) .035 .035],...
          'foregroundcolor', 'black','backgroundcolor', figcolor);
uicontrol(gcf,'style', 'text','units','normal',...
          'position', [XLine1+0.035 (YLine1-0.51) .10 .035],'string', 'CVC','horizontalAlignment', 'left',...
          'foregroundcolor', 'black','backgroundcolor', figcolor); 
cbCVCws=uicontrol(gcf,'style', 'checkbox','units','normal',...
          'position', [XLine1 (YLine1-0.56) .035 .035],...
          'foregroundcolor', 'black','backgroundcolor', figcolor);
uicontrol(gcf,'style', 'text','units','normal',...
          'position', [XLine1+0.035 (YLine1-0.56) .10 .035],'string', 'CVCws','horizontalAlignment', 'left',...
          'foregroundcolor', 'black','backgroundcolor', figcolor);
cbCTC=uicontrol(gcf,'style', 'checkbox','units','normal',...
          'position', [XLine1 (YLine1-0.61) .035 .035],...
          'foregroundcolor', 'black','backgroundcolor', figcolor);
uicontrol(gcf,'style', 'text','units','normal',...
          'position', [XLine1+0.035 (YLine1-61) .15 .035],'string', 'CTCaVTC','horizontalAlignment', 'left',...
          'foregroundcolor', 'black','backgroundcolor', figcolor);      
      
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
end

function clbPROC(~,~)
    Processing();
end
    
    init

function init()
	set(edtUFreq, 'Enable', 'off');
	set(edtIFreq, 'Enable', 'off');
	set(edtIRes, 'Enable', 'off');
	set(edtURes, 'Enable', 'off');
	set(btnSelect, 'enable', 'off');
	set(edtSNU, 'Enable', 'off'); 
	set(edtSNI, 'Enable', 'off');
	set(edtSNIc, 'Enable', 'off');
	set(btnRefresh, 'Enable', 'off');
end
 
function clbOpen(~,~,dialogTitle,~)
    
%~~ChecKing "addPathName.mat" existing & dir 'addPathName' existing~~   
    if exist('bin/addPathName.mat','file')
        load addPathName;
        if exist(addPathName,'dir')
            [FileName,PathName] = uigetfile('*I.dat', dialogTitle,...
                                    addPathName);
        else
            [FileName,PathName] = uigetfile('*I.dat', dialogTitle);
        end
    else
        [FileName,PathName] = uigetfile('*I.dat', dialogTitle);
    end
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	fprintf('FileName = %s PathName = %s\n', FileName, PathName)
    
	addpath(PathName);
            
	[I, timeT, IFreq]=getSIGNAL(FileName);
	maxI=max(I);
	minI=min(I);
	I = sign(maxI+minI)*I*1e9/IRes;        %nA

	set(edtIFreq, 'String', num2str(IFreq));
	set(edtSNI,'string',num2str(IFreq/50));
	set(txtFilePathI, 'string', [PathName FileName]);
	Iflag=1;
            
	FileName(end-4)='U';
	[U, timeT, UFreq]=getSIGNAL(FileName);
	maxU=max(U);
	minU=min(U);
	U = sign(maxU+minU)*U/URes*1e6;       %kV
            
	set(edtUFreq, 'String', num2str(UFreq));
	set(edtSNU,'string',num2str(UFreq/50));
	set(txtFilePathU, 'string', [PathName FileName])
	Uflag=1;
    addPathName=PathName;
    save('bin/addPathName.mat','addPathName')

	if Iflag==1 && Uflag==1
        set(edtIRes, 'Enable', 'on');
        set(edtURes, 'Enable', 'on');
        set(btnSelect, 'Enable', 'on');
	end
end

function clbSelect(~,~)
    if commited==0
        commited=1;

        IRes = str2double(get(edtIRes, 'string'));
        URes = str2double(get(edtURes, 'string'));
        save('bin\tmp.mat','IRes','URes');
        set(edtUFreq, 'Enable', 'off');
        set(edtIFreq, 'Enable', 'off');
        set(edtIRes, 'Enable', 'off');
        set(edtURes, 'Enable', 'off');
        set(btnSelect, 'string', 'Uncommit');
        axes(hA1)
        cla(hA1)
            
        [X, Ks]=pltSignal(UFreq,IFreq,I,U);

        set(edtSNU, 'Enable', 'on'); 
        set(edtSNI, 'Enable', 'on');
        set(edtSNIc, 'Enable', 'on');
        set(btnRefresh, 'Enable', 'on');
    else
        commited=0;
        set(edtSNU, 'Enable', 'off'); 
        set(edtSNI, 'Enable', 'off');
        set(edtSNIc, 'Enable', 'off');
        set(btnRefresh, 'Enable', 'off');
        set(btnSelect, 'string', 'Select Signal');
        set(edtIRes, 'Enable', 'on');
        set(edtURes, 'Enable', 'on');
    end
end

function clbRefresh(~,~)
	NSmoothU = str2double(get(edtSNU, 'string'));
	NSmoothI = str2double(get(edtSNI, 'string'));
	NSmoothIc = str2double(get(edtSNIc, 'string'));
	[Isn, Usn, Ic, Ics, X]=SYNCHandSMOTH(I,U,NSmoothU,NSmoothI,NSmoothIc,X);
            
	axes(hA1)
	cla(hA1)
	Ti=(0:length(Isn)-1)/IFreq;
	Tu=(0:length(Usn)-1)/UFreq;

% Signals and IC
            
	strtI=X(1);
	stpI=X(2);
    % n POG
    Lu=length(Usn);
    Ks=round(Lu/str2double(get(edtPOG,'string')));
    
% ??????????? ??????? ???? ?????? ??????? "set"
% Undefined function or variable "set"
% Error in ProcessingProgram/clbRefresh (line 312)
% set(101,'NumberTitle','off','Name','ProcessingProgram:CVC'); 
% Error while evaluating uicontrol Callback

%     if Ks>Lu
%         set(edtPOG,'string')=num2str(Lu);
%     end
    
	plot(Ti(strtI:Ks:stpI),Isn(strtI:Ks:stpI)/max(Isn),'r')
	hold on
	plot(Tu(strtI:Ks:stpI),Usn(strtI:Ks:stpI)/max(Usn),'k')
	plot(Ti(strtI:Ks:stpI),Ics(strtI:Ks:stpI)/max(Isn),'g')
	grid on
	legend('Current','Voltage','Capacitive current','Location','NorthEast');
	xlabel('time [s]');
	hold off
    
	%Ls=[length(Usn) length(Isn) length(Ics)];
    
	BEGINd=X(1);
    ENDd=X(2);
	VACsm=200;


    
	Uout=fastsmooth(Usn(BEGINd:ENDd),VACsm);
	Iout=fastsmooth(Isn(BEGINd:ENDd)-Ics(BEGINd:ENDd),VACsm);
	[value, nWAY]=max(Uout);

	for k=1:nWAY
        if Uout(k)>=value*0.05
            tSTARTn=k;
            break;
        end
	end

	set(edtSPEED,'string',num2str(value/(nWAY-tSTARTn)*UFreq));
	SPEED=num2str(value/(nWAY-tSTARTn)*UFreq);
    
    if get(cbCVC,'value')
        figure(101);
        set(101,'NumberTitle','off','Name','ProcessingProgram:CVC');

        plot(Usn(BEGINd:Ks:ENDd),Isn(BEGINd:Ks:ENDd)-Ics(BEGINd:Ks:ENDd),'y','LineWidth',2)
        grid on,hold on

        plot(Uout(1:Ks:nWAY),Iout(1:Ks:nWAY),'r','LineWidth',2)
        plot(Uout(nWAY:Ks:end),Iout(nWAY:Ks:end),'b','LineWidth',2),grid on
        hold off
        legend('Experimental data','Increase voltage','Decrease voltage','Location','NorthWest');
        ylabel('I [nA]');
        xlabel('U [kV]');
        
    end
    
    if get(cbCVCws,'value')
        figure(102);
        set(102,'NumberTitle','off','Name','ProcessingProgram:CVC');

        plot(Usn(1:Ks:end),Isn(1:Ks:end),'k','LineWidth',2),grid on,hold on
        plot(Uout(1:Ks:end),Iout(1:Ks:end),'r','LineWidth',2),hold off
        legend('Without subtraction Ic','With subtraction Ic','Location','North');
        ylabel('I [nA]');
        xlabel('U [kV]');
    end
    
	NEEDLE=get(edtNEEDLE,'string');
	SYSTEM=get(edtSYSTEM,'string');
	FLUID=get(edtFLUID,'str');
	POLARITY=get(edtPOLARITY,'str');
	save('bin\tmp2.mat','NEEDLE','SYSTEM','FLUID','POLARITY','TEMPERATURE')
	fprintf('Temporary information saved \n');
	set(btnDATAsv, 'Enable', 'on');
    
    if get(cbCTC,'value')
        figure(103);
        set(103,'NumberTitle','off','Name','ProcessingProgram:CTC&VTC');
        plot(Ti(strtI:Ks:stpI),Isn(strtI:Ks:stpI)/max(Isn),'r')
        hold on
        plot(Tu(strtI:Ks:stpI),Usn(strtI:Ks:stpI)/max(Usn),'k')
        plot(Ti(strtI:Ks:stpI),Ics(strtI:Ks:stpI)/max(Isn),'g')
        grid on
        legend('Current','Voltage','Capacitive current','Location','NorthEast');
        xlabel('time [s]');
        hold off
    end
    
end

function clbDATAsv(~,~)
    NEEDLE=get(edtNEEDLE,'string');
    SYSTEM=get(edtSYSTEM,'string');
    FLUID=get(edtFLUID,'str');
    POLARITY=get(edtPOLARITY,'str'); 

    NameS=SYSTEM;
    y=srtfind(NameS,' ');
    if ~isempty(y)
        for k=1:length(y)
            NameS(y(k))='_';
        end
    end
    NameF=FLUID;
    y=srtfind(NameF,' ');
    if ~isempty(y)
        for k=1:length(y)
            NameF(y(k))='_';
        end
    end
    NameN=NEEDLE;
    y=srtfind(NameN,' ');
    if ~isempty(y)
        for k=1:length(y)
            NameN(y(k))='_';
        end
    end
    NameSp=num2str(fix(str2double(SPEED)*1000));
    NameP=POLARITY;
    y=srtfind(NameP,' ');
    if ~isempty(y)
        for k=1:length(y)
            NameP(y(k))='_';
        end
    end
    NameT=timeT;
    y=srtfind(NameT,' ');
    if ~isempty(y)
        for k=1:length(y)
            NameT(y(k))='_';
        end
    end 
    y=srtfind(NameT,':');
    if ~isempty(y)
        for k=1:length(y)
            NameT(y(k))='-';
        end
    end 
    NameDS=['dataset\' 'ds' NameT '_' NameS '_' NameF '_' NameP '_' NameN '_' NameSp '.mat'];
    
    save(NameDS,'SYSTEM','FLUID','NEEDLE','SPEED',...
        'Usn','Isn','Ics','Ic','timeT','UFreq','TEMPERATURE');
end

function clbRES2TEMP(~,~)
	dataT=[0 5 10 15 20 25 30 35 40 45 50 55 60 65];
	dataRES=[3.265 2.539 1.99 1.571 1.249 1 0.8057 0.6531 0.5327 0.4369 0.3603 0.2986 0.2488 0.2083];
	tempRES=str2double(get(edtTEMPres,'string'));
	TEMPERATURE=interp1(dataRES,dataT,tempRES/10);
	TEMPERATURE=(round(TEMPERATURE*10))/10;
	set(edtTEMP,'string',num2str(TEMPERATURE));
end
end

