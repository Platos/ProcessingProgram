function ProcessingProgram()
    clc;
    close all;
    addpath('bin');
    addpath('data');
    addpath('dataset')
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
    load('bin\tmp.mat');
    load('bin\tmp2.mat');
    XLine0 = 0.05;
    XLine1 = XLine0 + 0.51;
    XLine2 = 0.635;
    YLine0 = 0.95;
    YLine1 = 0.810;
    YLine1_2 = 0.860;
    XLine3 = XLine1+0.22;
    YLine3 = 0.2;
    
    
    ctrl_fig = figure('MenuBar','None',...
        'Name','ProcessingProgram',...
        'NumberTitle','off',...
        'Position',[100 100 700 500]);
    %plot_fh = figure; % plot figure handle
    %plot(x,y); 
    
    figcolor = get(gcf, 'color');
    
    btnOpenI = uicontrol(gcf,'Style','pushbutton','units','normal',...   
                        'Position',[XLine0 YLine0 0.07 0.04],...
                        'String','Open I','Callback',{@clbOpen, 'Open I File', 'I'}); 
    txtFilePathI = uicontrol(gcf,'style', 'text','units','normal',...
                            'position', [(XLine0+0.08) YLine0 .7 .035],'string', '','horizontalAlignment', 'left',...
                            'foregroundcolor', 'black','backgroundcolor', figcolor);                   
    
    btnOpenU = uicontrol(gcf,'Style','pushbutton','units','normal',...   
                        'Position',[XLine0 (YLine0-0.04) 0.07 0.04],...
                        'String','Open U','Callback',{@clbOpen, 'Open U File', 'U'});
    txtFilePathU = uicontrol(gcf,'style', 'text','units','normal',...
                            'position', [(XLine0+0.08) (YLine0-0.04) .7 .035],'string', '','horizontalAlignment', 'left',...
                            'foregroundcolor', 'black','backgroundcolor', figcolor);
    set(btnOpenU,'enable','off');                    
    hA1 = axes;
    set(hA1, 'Position', [XLine0 YLine3 0.5 0.7])
    axes(hA1)
    figcolor = get(gcf, 'color');
    
   
    txtIFreq = uicontrol(gcf,'style', 'text','units','normal',...
                            'position', [XLine1 YLine1+0.05 .2 .035],'string', 'Processing parametrs:','horizontalAlignment', 'left',...
                            'foregroundcolor', 'black','backgroundcolor', figcolor);
    txtIFreq = uicontrol(gcf,'style', 'text','units','normal',...
                            'position', [XLine1 YLine1 .04 .035],'string', 'I freq','horizontalAlignment', 'left',...
                            'foregroundcolor', 'black','backgroundcolor', figcolor);                        
    edtIFreq = uicontrol(gcf,'Style','edit','units','normal',... 
                         'Position',[(XLine1+0.04) YLine1 0.15 0.04],...
                         'String','');
                     
                     
    txtUFreq = uicontrol(gcf,'style', 'text','units','normal',...
                            'position', [XLine1 (YLine1-0.05) .04 .035],'string', 'Ufreq','horizontalAlignment', 'left',...
                            'foregroundcolor', 'black','backgroundcolor', figcolor);
    edtUFreq = uicontrol(gcf,'Style','edit','units','normal',... 
                         'Position',[(XLine1+0.04) (YLine1-0.05) 0.15 0.04],...
                         'String','');
                     
    txtIRes = uicontrol(gcf,'style', 'text','units','normal',...
                            'position', [XLine1 (YLine1-0.10) .04 .035],'string', 'Resi','horizontalAlignment', 'left',...
                            'foregroundcolor', 'black','backgroundcolor', figcolor);
    edtIRes = uicontrol(gcf,'Style','edit','units','normal',... 
                         'Position',[(XLine1+0.04) (YLine1-0.10) 0.15 0.04],...
                         'String',num2str(IRes));
                     
    txtURes = uicontrol(gcf,'style', 'text','units','normal',...
                            'position', [XLine1 (YLine1-0.15) .04 .035],'string', 'Resu','horizontalAlignment', 'left',...
                            'foregroundcolor', 'black','backgroundcolor', figcolor);
    edtURes = uicontrol(gcf,'Style','edit','units','normal',... 
                         'Position',[(XLine1+0.04) (YLine1-0.15) 0.15 0.04],...
                         'String',num2str(URes)); 
                     
    btnSelect = uicontrol(gcf,'Style','pushbutton','units','normal',...   
                        'Position',[XLine1 (YLine1-0.20) 0.19 0.04],...
                        'String','Select Signal','Callback',@clbSelect);                      
                     
    txtSNI = uicontrol(gcf,'style', 'text','units','normal',...
                            'position', [XLine1 (YLine1-0.26) .04 .035],'string', 'SNI','horizontalAlignment', 'left',...
                            'foregroundcolor', 'black','backgroundcolor', figcolor);
    edtSNI = uicontrol(gcf,'Style','edit','units','normal',... 
                         'Position',[(XLine1+0.04) (YLine1-0.26) 0.15 0.04],...
                         'String','200');                       
                         
    txtSNU = uicontrol(gcf,'style', 'text','units','normal',...
                            'position', [XLine1 (YLine1-0.31) .04 .035],'string', 'SNU','horizontalAlignment', 'left',...
                            'foregroundcolor', 'black','backgroundcolor', figcolor);
    edtSNU = uicontrol(gcf,'Style','edit','units','normal',... 
                         'Position',[(XLine1+0.04) (YLine1-0.31) 0.15 0.04],...
                         'String','200');  
                     
    txtSNIc = uicontrol(gcf,'style', 'text','units','normal',...
                            'position', [XLine1 (YLine1-0.36) .04 .035],'string', 'SNIc','horizontalAlignment', 'left',...
                            'foregroundcolor', 'black','backgroundcolor', figcolor);
    edtSNIc = uicontrol(gcf,'Style','edit','units','normal',... 
                         'Position',[(XLine1+0.04) (YLine1-0.36) 0.15 0.04],...
                         'String','50');                       
                     
    btnRefresh = uicontrol(gcf,'Style','pushbutton','units','normal',...   
                        'Position',[XLine1 (YLine1-0.41) 0.19 0.04],...
                        'String','Refresh','Callback',@clbRefresh); 
                    
    txtSYSTEM = uicontrol(gcf,'style', 'text','units','normal',...
                            'position', [XLine3 (YLine1_2) .06 .035],'string', 'System:','horizontalAlignment', 'left',...
                            'foregroundcolor', 'black','backgroundcolor', figcolor);
    edtSYSTEM = uicontrol(gcf,'Style','edit','units','normal',... 
                         'Position',[(XLine3) (YLine1_2-0.05) 0.21 0.04],...
                         'String',SYSTEM);
    txtFLUID = uicontrol(gcf,'style', 'text','units','normal',...
                            'position', [XLine3 (YLine1_2-0.1) .06 .035],'string', 'Fluid:','horizontalAlignment', 'left',...
                            'foregroundcolor', 'black','backgroundcolor', figcolor);
    edtFLUID = uicontrol(gcf,'Style','edit','units','normal',... 
                         'Position',[(XLine3) (YLine1_2-0.15) 0.21 0.04],...
                         'String',FLUID);
    txtPOLARITY = uicontrol(gcf,'style', 'text','units','normal',...
                            'position', [XLine3 (YLine1_2-0.2) .06 .035],'string', 'Polarity:','horizontalAlignment', 'left',...
                            'foregroundcolor', 'black','backgroundcolor', figcolor);
    edtPOLARITY = uicontrol(gcf,'Style','edit','units','normal',... 
                         'Position',[(XLine3) (YLine1_2-0.25) 0.21 0.04],...
                         'String',POLARITY);
    txtNEEDLE = uicontrol(gcf,'style', 'text','units','normal',...
                            'position', [XLine3 (YLine1_2-0.3) .21 .035],'string', 'Needle radius [mkm]:','horizontalAlignment', 'left',...
                            'foregroundcolor', 'black','backgroundcolor', figcolor);
    edtNEEDLE = uicontrol(gcf,'Style','edit','units','normal',... 
                         'Position',[(XLine3) (YLine1_2-0.35) 0.21 0.04],...
                         'String',NEEDLE);  
    txtSPEED = uicontrol(gcf,'style', 'text','units','normal',...
                            'position', [XLine3 (YLine1_2-0.40) .21 .035],'string', 'Modulation rate [kV/s]:','horizontalAlignment', 'left',...
                            'foregroundcolor', 'black','backgroundcolor', figcolor);
    edtSPEED = uicontrol(gcf,'Style','edit','units','normal',... 
                         'Position',[(XLine3) (YLine1_2-0.45) 0.21 0.04],...
                         'String','');
    set(edtSPEED, 'Enable', 'off');
    txtTEMP = uicontrol(gcf,'style', 'text','units','normal',...
                            'position', [XLine3 (YLine1_2-0.50) .21 .035],'string', 'Temperature R [kOhm],T [C]:','horizontalAlignment', 'left',...
                            'foregroundcolor', 'black','backgroundcolor', figcolor);
    edtTEMPres = uicontrol(gcf,'Style','edit','units','normal',... 
                         'Position',[(XLine3) (YLine1_2-0.55) 0.21 0.04],...
                         'String','','CallBack',@clbRES2TEMP);
    edtTEMP = uicontrol(gcf,'Style','edit','units','normal',... 
                         'Position',[(XLine3) (YLine1_2-0.60) 0.21 0.04],...
                         'String','');
    set(edtTEMP, 'Enable', 'off');
    
    btnDATAsv = uicontrol(gcf,'Style','pushbutton','units','normal',...   
                        'Position',[(XLine3) (YLine3-0.1) 0.21 0.04],...
                        'String','Create data set','Callback',@clbDATAsv);
    btnPROCESSING = uicontrol(gcf,'Style','pushbutton','units','normal',...   
                        'Position',[(XLine3) (YLine3-0.15) 0.21 0.04],...
                        'String','Swich to processing','Callback',@clbPROC);
    function clbPROC(source,event)
        Processing();
    end
    set(btnDATAsv, 'Enable', 'off');                
    
    init();

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
 
   function saveNumber(source,event,handles,varargin)
        fprintf('Plotting...\n');
        power=get(hPwrNumber,'String');
        Number=str2num(power);
        fprintf('Setting power to %d\n',Number);
        axes(hA1)
        cla(hA1)
        graficreplot(Usn,Isn,ICsm)
    end

    function pwrHandler(source,event,handles,varargin) 
        power=str2num(get(hPwr,'string'));
        fprintf('Setting power to %s\n',get(hPwr,'string'));
    end


    
    function clbOpen(src,evt,dialogTitle, type)
        [FileName,PathName] = uigetfile('*I.dat', dialogTitle);
        fprintf('FileName = %s PathName = %s\n', FileName, PathName) 
        if type=='I'
            addpath(PathName);
            
            [I timeT IFreq]=getSIGNAL(FileName);
            maxI=max(I);
            minI=min(I);
            I = sign(maxI+minI)*I;
            Ip=I;
            set(edtIFreq, 'String', num2str(IFreq));
            set(edtSNI,'string',num2str(IFreq/50));
            set(txtFilePathI, 'string', [PathName FileName]);
            Iflag=1;
            
            
            FileName(end-4)='U';
            [U timeT UFreq]=getSIGNAL(FileName);
            maxI=max(U);
            minI=min(U);
            U = sign(maxI+minI)*U;
            Up=U;
            set(edtUFreq, 'String', num2str(UFreq));
            set(edtSNU,'string',num2str(UFreq/50));
            set(txtFilePathU, 'string', [PathName FileName])
            Uflag=1;
        else
            if type=='U'
            addpath(PathName);
            
            [U timeT UFreq]=getSIGNAL(FileName);
            maxI=max(U);
            minI=min(U);
            U = sign(maxI+minI)*U;
            Up=U;
            set(edtUFreq, 'String', num2str(UFreq));
            set(edtSNU,'string',num2str(UFreq/50));
            set(txtFilePathU, 'string', [PathName FileName])
            Uflag=1;
            
            FileName(end-4)='I';
            [I timeT IFreq]=getSIGNAL(FileName);
            maxI=max(I);
            minI=min(I);
            I = sign(maxI+minI)*I;
            Ip=I;
            set(edtIFreq, 'String', num2str(IFreq));
            set(edtSNI,'string',num2str(IFreq/50));
            set(txtFilePathI, 'string', [PathName FileName]);
            Iflag=1;
            else
                fprintf('Error type in clbOpen')
            end
        end
        if Iflag==1 && Uflag==1

            set(edtIRes, 'Enable', 'on');
            set(edtURes, 'Enable', 'on');
            set(btnSelect, 'Enable', 'on');
        end
    end
    

    
    
    function clbSelect(src,evt)
        
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
            [X Ks]=pltSignal(UFreq,IFreq,Ip,Up);
            I=Ip(X(1):X(2))*1e9/IRes;       %nA
            U=Up(X(1):X(2))/URes*1e6;       %kV
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
    function clbRefresh(src,evt)
            NSmoothU = str2double(get(edtSNU, 'string'));
            NSmoothI = str2double(get(edtSNI, 'string'));
            NSmoothIc = str2double(get(edtSNIc, 'string'));
            [Isn Usn Ic Ics]=SYNCHandSMOTH(I,U,NSmoothU,NSmoothI,NSmoothIc,X);
            
            axes(hA1)
            cla(hA1)
            Ti=[0:length(Isn)-1]/IFreq;
            Tu=[0:length(Usn)-1]/UFreq;
            %,grid on
            
            % Signals and IC
            
            strtI=fix(0.05*length(Isn));
            stpI=fix(0.95*length(Isn));
            plot(Ti(strtI:Ks:stpI),Isn(strtI:Ks:stpI)/max(Isn),'r')
            hold on
            plot(Tu(strtI:Ks:stpI),Usn(strtI:Ks:stpI)/max(Usn),'k')
            plot(Ti(strtI:Ks:stpI),Ics(strtI:Ks:stpI)/max(Isn),'g')
            grid on
            legend('Current','Voltage','Capacitive current','Location','NorthEast');
            xlabel('time [s]');
            hold off
            Ls=[length(Usn) length(Isn) length(Ics)];
           
            ENDd=fix(min(Ls)*0.95);
            BEGINd=fix(0.05*ENDd);
            VACsm=200;
            
            suppFIG=figure(101);
            set(suppFIG,'NumberTitle','off','Name','ProcessingProgram:CVC');
            
            plot(Usn(BEGINd:Ks:ENDd),Isn(BEGINd:Ks:ENDd)-Ics(BEGINd:Ks:ENDd),'y','LineWidth',2),grid on,hold on
            
            Uout=fastsmooth(Usn(BEGINd:ENDd),VACsm);
            Iout=fastsmooth(Isn(BEGINd:ENDd)-Ics(BEGINd:ENDd),VACsm);
            [value nWAY]=max(Uout);
            % Вычисление периода модуляции сигнала
            for k=1:nWAY
                if Uout(k)>=value*0.05
                    tSTARTn=k;
                    break;
                end
            end
            set(edtSPEED,'string',num2str(value/(nWAY-tSTARTn)*UFreq));
            SPEED=num2str(value/(nWAY-tSTARTn)*UFreq);
            for k=nWAY:length(Uout)
                if Uout(k)<=value*0.05
                    tENDn=k;
                    break;
                end
            end
            Tsig=(tENDn-tSTARTn)/UFreq;
            plot(Uout(1:Ks:nWAY),Iout(1:Ks:nWAY),'r','LineWidth',2)
           
            plot(Uout(nWAY:Ks:end),Iout(nWAY:Ks:end),'b','LineWidth',2),grid on
            hold off
            legend('Experimental data','Increase voltage','Decrease voltage','Location','NorthWest');
            ylabel('I [nA]');
            xlabel('U [kV]');
            
            suppFIG2=figure(102);
            set(suppFIG2,'NumberTitle','off','Name','ProcessingProgram:CVC');
            
            plot(Usn(1:Ks:end),Isn(1:Ks:end),'k','LineWidth',2),grid on,hold on
            plot(Uout(1:Ks:end),Iout(1:Ks:end),'r','LineWidth',2),hold off
            legend('Without subtraction Ic','With subtraction Ic','Location','North');
            ylabel('I [nA]');
            xlabel('U [kV]');
            NEEDLE=get(edtNEEDLE,'string');
            SYSTEM=get(edtSYSTEM,'string');
            FLUID=get(edtFLUID,'str');
            POLARITY=get(edtPOLARITY,'str');
            save('bin\tmp2.mat','NEEDLE','SYSTEM','FLUID','POLARITY','TEMPERATURE')
            fprintf('Temporary information saved \n');
            set(btnDATAsv, 'Enable', 'on');
    end
function clbDATAsv(src,evt)
    NEEDLE=get(edtNEEDLE,'string');
    SYSTEM=get(edtSYSTEM,'string');
    FLUID=get(edtFLUID,'str');
    POLARITY=get(edtPOLARITY,'str'); 

    NameS=SYSTEM;
    y=findstr(NameS,' ');
    if length(y)~=0
        for k=1:length(y)
            NameS(y(k))='_';
        end
    end
    NameF=FLUID;
    y=findstr(NameF,' ');
    if length(y)~=0
        for k=1:length(y)
            NameF(y(k))='_';
        end
    end
    NameN=NEEDLE;
    y=findstr(NameN,' ');
    if length(y)~=0
        for k=1:length(y)
            NameN(y(k))='_';
        end
    end
    NameSp=num2str(fix(str2double(SPEED)*1000));

    NameP=POLARITY;
    y=findstr(NameP,' ');
    if length(y)~=0
        for k=1:length(y)
            NameP(y(k))='_';
        end
    end
    NameT=timeT;
    y=findstr(NameT,' ');
    if length(y)~=0
        for k=1:length(y)
            NameT(y(k))='_';
        end
    end 
    y=findstr(NameT,':');
    if length(y)~=0
        for k=1:length(y)
            NameT(y(k))='-';
        end
    end 
    NameDS=['dataset\' 'ds' NameT '_' NameS '_' NameF '_' NameP '_' NameN '_' NameSp '.mat'];
    
    save(NameDS,'SYSTEM','FLUID','NEEDLE','SPEED',...
        'Usn','Isn','Ics','Ic','timeT','UFreq','TEMPERATURE');
end
    function clbRES2TEMP(src,evt)
        dataT=[0 5 10 15 20 25 30 35 40 45 50 55 60 65];
        dataRES=[3.265 2.539 1.99 1.571 1.249 1 0.8057 0.6531 0.5327 0.4369 0.3603 0.2986 0.2488 0.2083];
        tempRES=str2double(get(edtTEMPres,'string'));
        TEMPERATURE=interp1(dataRES,dataT,tempRES/10);
        TEMPERATURE=(round(TEMPERATURE*10))/10;
        set(edtTEMP,'string',num2str(TEMPERATURE));
    end
end

