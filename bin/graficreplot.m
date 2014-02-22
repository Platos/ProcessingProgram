function graficreplot(Usn,Isn,ICsm)
hold on 
grid on
plot(Usn(1:end)/max(Usn),'k')
plot(Isn(1:end)/max(Isn),'r')
plot(ICsm/max(Isn),'g')
hold off
% 
% L=min([length(Usn) length(Isn) length(ICsm)]);
% figure, hold on 
% grid on
% plot(Usn(1:L),Isn(1:L)-ICsm(1:L))
% hold off
end