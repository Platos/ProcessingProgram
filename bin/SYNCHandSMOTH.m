function [Isn, Usn, Ic, Ics, X]=SYNCHandSMOTH(I,U,NSmoothU,NSmoothI,NSmoothIc,X)
    Is=fastsmooth(I,NSmoothI);
    Us=fastsmooth(U,NSmoothU);
    global IFreq Tr UFreq
    
    % Find synchronization point
    if max(Is)<1e3
        
        dUs_=fastsmooth(diff(Us(X(5):X(6))),NSmoothIc);
        Is_=Is(X(3):X(4));
        a1=Is_/max(Is_);
        a2=dUs_/max(dUs_);
        asd=xcorr(a1,a2);
        %figure, plot(a1),hold on,plot(a2),plot(asd);
        [~,Nm_asd]=max(asd);
        iI_=X(3)-X(5)+Nm_asd-round(length(asd)/2);
        if iI_>0
        Isn=Is(iI_:end);
        aI=1;
        Usn=Us;
        elseif iI_<0
        Isn=Is;
        aI=0;
        Usn=Us(-iI_:end);
        else
        Isn=Is;
        aI=0;
        Usn=Us;
        end
    else
        % Find synchronization point
        [~, nI]=max(Is);
        [~, nU]=max(Us);
        % Synchronization
        iI=1+abs(nU-nI)/2+(nI-nU)/2;
        iU=1+abs(nU-nI)/2+(nU-nI)/2;
        Isn=Is(iI:end);
        Usn=Us(iU:end);
        X(1:2)=[X(1)-iI X(2)-iU];
    end
    
% %     % Synchronization
% %     iI=1+abs(nU-nI)/2+(nI-nU)/2;
% %     iU=1+abs(nU-nI)/2+(nU-nI)/2;
% %     Isn=Is(iI:end);
% %     Usn=Us(iU:end);

    L=min(length(Isn),length(Usn));
    Isn=Isn(1:L);
    Usn=Usn(1:L);
% %     % Synchronization point
% %     Psn=(X(3)+X(4))/2;
% %     dNc=IFreq/NSmoothU*Tr;
    Tr=0.1;
    if max(Isn)<1e3
        [~, NmaxI]=max(Isn(X(3)-iI_*aI:X(4)-iI_*aI));
        NmaxI=NmaxI+X(3)-iI_*aI-1;
        dNc=IFreq/NSmoothU*Tr*10;
        C=Isn(NmaxI-dNc:NmaxI+dNc)./diff(Usn(NmaxI-dNc:NmaxI+dNc+1))/UFreq;
        asd=ne(C,Inf);
        N_pos= asd;
        C=C(N_pos);
%         for k=1:length(C)
%             if C(k)==Inf
%                 C(k)=C(k-1);
%             end
%         end
        Cm=mean(C);
        Ic =Cm.*diff(Usn)*UFreq;
        Ics = fastsmooth(Ic, NSmoothIc);
    else
        Ic=zeros(1,length(Usn));
        Ics=zeros(1,length(Usn));
    end 
end