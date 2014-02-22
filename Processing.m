function Processing()
    clc;
    close all;
    addpath('bin');
    addpath('dataset')
%     global timeT
    ctrl_fig = figure('MenuBar','None',...
        'Name','ProcessingProgram',...
        'NumberTitle','off',...
        'Position',[100 100 700 500]);
    figcolor = get(gcf, 'color');
    XLine1=0.03;
    YLine1=0.92;
    XLine2=0.25;
    YLine2=0.82;
    XLine3=0.08;
    
    btnOpenDS = uicontrol(gcf,'Style','pushbutton','units','normal',...   
                        'Position',[XLine1 YLine1 0.2 0.04],...
                        'String','Back','Callback',@clbback);
    btnPLOT = uicontrol(gcf,'Style','pushbutton','units','normal',...   
                        'Position',[XLine1 YLine1-0.10 0.2 0.04],...
                        'String','CVC','Callback',@clbPLOT);
    btnIdep = uicontrol(gcf,'Style','pushbutton','units','normal',...   
                        'Position',[XLine1 YLine1-0.15 0.2 0.04],...
                        'String','Dependence of current','Callback',@clbIdep);
    txtIdep = uicontrol(gcf,'Style','text','units','normal',...   
                        'Position',[XLine1 YLine1-0.21 0.07 0.04],...
                        'String','Voltage:','horizontalAlignment', 'left',...
                        'foregroundcolor', 'black','backgroundcolor', figcolor);
    chboxIdep = uicontrol(gcf,'Style','checkbox','units','normal',...   
                        'Position',[XLine1+0.13 YLine1-0.20 0.1 0.04],...
                        'String','in title','horizontalAlignment', 'left',...
                        'foregroundcolor', 'black','backgroundcolor', figcolor); 
    edtIdep = uicontrol(gcf,'Style','edit','units','normal',... 
                         'Position',[XLine1+0.07 YLine1-0.2 0.05 0.04],...
                         'String','20','value',1);
    txtIdepON = uicontrol(gcf,'Style','text','units','normal',...   
                        'Position',[XLine1 YLine1-0.25 0.1 0.04],...
                        'String','Depends on:','horizontalAlignment', 'left',...
                        'foregroundcolor', 'black','backgroundcolor', figcolor);
    popIdep = uicontrol(gcf,'Style','popup','units','normal',... 
                         'Position',[XLine1+0.1 YLine1-0.25 0.1 0.04],...
                         'String','Conductivity|Temperature','value',2);
                        
    %set(btnIdep,'enable','off');
    %set(edtIdep,'enable','off');
    txtTITLE = uicontrol(gcf,'Style','text','units','normal',...   
                        'Position',[XLine1 YLine2-0.30 0.2 0.04],...
                        'String','In title:','horizontalAlignment', 'left',...
                        'foregroundcolor', 'black','backgroundcolor', figcolor);    
    chboxFLUIDit = uicontrol(gcf,'Style','checkbox','units','normal',...   
                        'Position',[XLine1+0.01 YLine2-0.35 0.2 0.04],...
                        'String','','backgroundcolor', figcolor);
    chboxSYSTEMit = uicontrol(gcf,'Style','checkbox','units','normal',...   
                        'Position',[XLine1+0.01 YLine2-0.40 0.2 0.04],...
                        'String','','backgroundcolor', figcolor);    
    chboxSPEEDit = uicontrol(gcf,'Style','checkbox','units','normal',...   
                        'Position',[XLine1+0.01 YLine2-0.45 0.2 0.04],...
                        'String','','backgroundcolor', figcolor);
    chboxCURVit = uicontrol(gcf,'Style','checkbox','units','normal',...   
                        'Position',[XLine1+0.01 YLine2-0.50 0.2 0.04],...
                        'String','','backgroundcolor', figcolor);
    chboxTEMPit = uicontrol(gcf,'Style','checkbox','units','normal',...   
                        'Position',[XLine1+0.01 YLine2-0.55 0.2 0.04],...
                        'String','','backgroundcolor', figcolor);
    chboxTIMEit = uicontrol(gcf,'Style','checkbox','units','normal',...   
                        'Position',[XLine1+0.01 YLine2-0.60 0.2 0.04],...
                        'String','','backgroundcolor', figcolor);
                    
    
    txtLEGEND = uicontrol(gcf,'Style','text','units','normal',...   
                        'Position',[XLine3 YLine2-0.30 0.2 0.04],...
                        'String','In legend:','horizontalAlignment', 'left',...
                        'foregroundcolor', 'black','backgroundcolor', figcolor);    
    chboxFLUID = uicontrol(gcf,'Style','checkbox','units','normal',...   
                        'Position',[XLine3 YLine2-0.35 0.2 0.04],...
                        'String','Fluid','backgroundcolor', figcolor);
    chboxSYSTEM = uicontrol(gcf,'Style','checkbox','units','normal',...   
                        'Position',[XLine3 YLine2-0.40 0.2 0.04],...
                        'String','System','backgroundcolor', figcolor);    
    chboxSPEED = uicontrol(gcf,'Style','checkbox','units','normal',...   
                        'Position',[XLine3 YLine2-0.45 0.2 0.04],...
                        'String','Modulation rate','backgroundcolor', figcolor);
    chboxCURV = uicontrol(gcf,'Style','checkbox','units','normal',...   
                        'Position',[XLine3 YLine2-0.50 0.2 0.04],...
                        'String','Curvature radius','backgroundcolor', figcolor);
    chboxTEMP = uicontrol(gcf,'Style','checkbox','units','normal',...   
                        'Position',[XLine3 YLine2-0.55 0.2 0.04],...
                        'String','Temperature','backgroundcolor', figcolor);
    chboxTIME = uicontrol(gcf,'Style','checkbox','units','normal',...   
                        'Position',[XLine3 YLine2-0.60 0.2 0.04],...
                        'String','Date','backgroundcolor', figcolor);
                    
                    
                    txtDS = uicontrol(gcf,'Style','text','units','normal',...   
                        'Position',[XLine2 YLine1 0.5 0.04],...
                        'String','Data sets:','horizontalAlignment', 'left',...
                        'foregroundcolor', 'black','backgroundcolor', figcolor);
    lboxDS = uicontrol(gcf,'Style','listbox','units','normal',...   
                        'Position',[XLine2 YLine1-0.85 0.65 0.85],'Max',2);
    dir_struct = dir('.\dataset');
    [sorted_names,sorted_index] = sortrows({dir_struct.name}');
    handles.file_names = sorted_names(3:end);
    guidata(ctrl_fig,handles);
    set(lboxDS,'String',handles.file_names,...
	'Value',1);
    
    function clbback(source,evnt)
        ProcessingProgram()
    end
    function clbPLOT(source,evnt)
        strDS=get(lboxDS,'String');
        Nneeds=get(lboxDS,'value');
        pltfig=figure(103);
       
        %linestyle_={'--','--','-','-','-.','-.'};
        lnCOLOR={[0.1,0.1,0.1],[0.1,0.1,0.9],[0.9,0.1,0.1],[0.1,0.5,0.1],[0.7,0.1,0.7],[0.5,0.2,0],[0.5,0.5,0.5],[0.7,0.7,0.1]};
        for k=1:length(Nneeds)
            global SYSTEM FLUID NEEDLE SPEED Usn Isn Ics Ic timeT UFreq TEMPERATURE
            SYSTEM=0; FLUID=0; NEEDLE=0; SPEED=0; Usn=0; Isn=0; Ics=0; Ic=0; timeT=0; UFreq=0;
            load(['dataset\' strDS{Nneeds(k)}]);
            
            Ls=[length(Usn) length(Isn) length(Ics)];
            Ls=min(Ls);
            ENDd=fix(min(Ls)*0.95);
            BEGINd=fix(0.05*ENDd);
            Uout=fastsmooth(Usn,UFreq/50);
            Iout=fastsmooth(Isn(1:Ls)-Ics(1:Ls),UFreq/50);
            [valueU maxU]=max(Uout);                           
            plot(Uout(BEGINd:maxU),Iout(BEGINd:maxU),'color',lnCOLOR{k},'LineWidth',2,'LineStyle','-')
            hold on
            plot(Uout(maxU:ENDd),Iout(maxU:ENDd),'color',lnCOLOR{k},'LineWidth',2,'LineStyle','--')
            lgndNAME=legendDROW(source,evnt,SYSTEM, FLUID, NEEDLE, SPEED,TEMPERATURE,timeT);
            SPEEDds{2*k-1}=lgndNAME;%round(str2double(SPEED)*100)/100;
            SPEEDds{2*k}='';
            
        end
        grid on
        hold off
        legend(SPEEDds',2)
        ttlNAME=titleDROW(source,evnt,0);
        title(ttlNAME,'fontweight','b');
        xlabel('Voltage [kV]','fontweight','b');
        ylabel('Current [nA]','fontweight','b')
        set(gca,'fontweight','b')
    end
    function clbIdep(source,evnt)
        strDS=get(lboxDS,'String');
        Nneeds=get(lboxDS,'value');
        pltfig=figure(104);
        iDEPv=get(edtIdep,'string');
        ttlMODp=0;
        ttlMOD='';
        
            for k=1:length(Nneeds)
                global SYSTEM FLUID NEEDLE SPEED Usn Isn Ics Ic timeT UFreq TEMPERATURE
                SYSTEM=0; FLUID=0; NEEDLE=0; SPEED=0; Usn=0; Isn=0; Ics=0; Ic=0; timeT=0; UFreq=0;
                load(['dataset\' strDS{Nneeds(k)}]);
                Ls=min([length(Usn) length(Isn) length(Ics)]);
                Uout=fastsmooth(Usn,UFreq/50);
                Iout=fastsmooth(Isn(1:Ls)-Ics(1:Ls),UFreq/50);
                [valueU maxU]=max(Uout);
                for p=1:round(maxU/1000):maxU
                    findP=1;
                    
                    if Uout(p)>=str2double(get(edtIdep,'string'))
                        findP=p;
                        break;
                    else
                        if p==maxU
                            if ttlMODp==0
                                ttlMOD=[ttlMOD 'Voltage not found in file with date' timeT];
                            else
                                ttlMOD=[ttlMOD ', ' timeT];
                            end
                        end
                    end
                end
                dataI(k)=Iout(findP);
                dataT(k)=TEMPERATURE;
            end
            if get(popIdep,'value')==2
                plot(dataT,dataI,'k.','linewidth',2)
                grid on
                %legend('',2);
                ttlNAME=titleDROW(source,evnt,1);
                title([ttlNAME ttlMOD],'fontweight','b');
                xlabel('Temperature [C]','fontweight','b');
                ylabel('Current [nA]','fontweight','b')
                set(gca,'fontweight','b')
            end
        end
   
    function [lgndNAME]=legendDROW(source,evnt,SYSTEM, FLUID, NEEDLE, SPEED,TEMPERATURE,timeT)
            lgndNAME='';
            if get(chboxFLUID,'value')==1
                lgndNAME=[lgndNAME FLUID ' '];
            end
            if get(chboxSYSTEM,'value')==1
                lgndNAME=[lgndNAME SYSTEM ' '];
            end
            if get(chboxSPEED,'value')==1
                lgndNAME=[lgndNAME ' m.r.=' num2str(num2str(round(str2double(SPEED)*100)/100)) '[kV/s] '];
            end
            if get(chboxCURV,'value')==1
                lgndNAME=[lgndNAME ' r=' num2str(NEEDLE) '[mkm] '];
            end
            if get(chboxTEMP,'value')==1
                lgndNAME=[lgndNAME ' T=' num2str(TEMPERATURE) ' '];
            end
            if get(chboxTIME,'value')==1
                lgndNAME=[lgndNAME num2str(timeT) ' '];
            end
    end
    function [ttlNAME]=titleDROW(source,evnt,funUSE)
        ttlNAME='';
        if funUSE==1
        if get(chboxIdep,'value')==1
           iDEPv=get(edtIdep,'string');
           if class(iDEPv)=='char'
               ttlNAME=[ttlNAME 'U = ' iDEPv '[kV] '];
           else
            if class(iDEPv)=='double'
                ttlNAME=[ttlNAME 'U = ' num2str(iDEPv) '[kV] '];
            end
           end
        end
        end
        strDS=get(lboxDS,'String');
        Nneeds=get(lboxDS,'value');
        global SYSTEM FLUID NEEDLE SPEED Usn Isn Ics Ic timeT UFreq TEMPERATURE
        SYSTEM=0; FLUID=0; NEEDLE=0; SPEED=0; Usn=0; Isn=0; Ics=0; Ic=0; timeT=0; UFreq=0;
        load(['dataset\' strDS{Nneeds(1)}]);        
        
            if get(chboxFLUIDit,'value')==1
                
                ttlNAME=[ttlNAME FLUID ' '];
            end
            if get(chboxSYSTEMit,'value')==1
                ttlNAME=[ttlNAME SYSTEM ' '];
            end
            if get(chboxSPEEDit,'value')==1
                ttlNAME=[ttlNAME ' Modulation rate ' num2str(round(str2double(SPEED)*100)/100) '[kV/s] '];
            end
            if get(chboxCURVit,'value')==1
                ttlNAME=[ttlNAME ' Curvature radius ' num2str(NEEDLE) '[mkm] '];
            end
            if get(chboxTEMPit,'value')==1
                ttlNAME=[ttlNAME ' T = ' num2str(TEMPERATURE) '[C] '];
            end
    end
    %addpath(fullfile('dataset'));
    %run(fullfile('dataset','lboxDS'));
end