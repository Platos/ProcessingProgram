function [X, Ks]=pltSignal(UFreq,IFreq,I,U)
Is=fastsmooth(I,IFreq/50);% Averaging with respect the fundamental frequency 
Us=fastsmooth(U,UFreq/50);% interference (industrial frequency of 50 Hz)

Ks=round(length(Us)/1000);% Drow grafic in 1000 points ratio

%~~~~~~~Select signal length~~~~~~~
plot(Is(1:Ks:end)/ max(Is), 'b');
hold on
plot(Us(1:Ks:end)/ max(Us), 'r');
[x1, ~] = ginput(2);
x1=round(x1*Ks);
legend('');
hold off
tic
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

%~~Select sinchronization interval~~
plot(Is(1:Ks:end)/ max(Is), 'b');
hold on
plot(Us(1:Ks:end)/ max(Us), 'r');
hold off
[xs, ~] = ginput(2);
xs=round(xs*Ks);
tic
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

%~~~~~Select current sinch leap~~~~~
L=length(Is(min(xs):max(xs)));
tKs=round(L/1000);
plot(Is(min(xs):tKs:max(xs))/ max(Is(min(xs):tKs:max(xs))), 'b');
[x2, ~] = ginput(2);
x2=round(x2*tKs)+min(xs);
tic
%figure, plot(Is(min(x2):tKs:max(x2))) test
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

%~~~~~Select voltage sinch leap~~~~~
L=length(Us(min(xs):max(xs)));
tKs=round(L/1000);
plot(Us(min(xs):tKs:max(xs))/ max(Us(min(xs):max(xs))), 'r');
[x3, ~] = ginput(2);
x3=round(x3*tKs)+min(xs);
tic
%figure, plot(Us(min(x3):tKs:max(x3))) test
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

X = [min(x1) max(x1) min(x2) max(x2) min(x3) max(x3)];
%~~~~~~~~Signal~~~~~~~~~~Current~~~~~~~~~Voltage~~~~~~
end