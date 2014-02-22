clear all; clc

%Params
IDaqBand = 5;   
UDaqBand = 10;
IDaqFactor = 1/64;
UDaqFactor = 1/4;
DaqCapacity = 2^13;
Resistance = 1e5;
IFreq = 100000;
UFreq = 100000;
C = 3.7e-13 * 5;

%Number of experiment
Number = 10;
TimeModulation = 100;

%Load files and get values
CurrentFile = sprintf('_%04dI.dat', Number);
VoltageFile = sprintf('_%04dU.dat', Number);
CurrentFileInd = fopen(CurrentFile,'r');
I_= fread(CurrentFileInd, 'int16'); fclose(CurrentFileInd);
VoltageFileInd = fopen(VoltageFile,'r');
U_= fread(VoltageFileInd, 'int16'); fclose(VoltageFileInd);
IT = length(I_)/IFreq;
UT = length(U_)/UFreq;

% DAQ points to physics values
I_ = I_ / DaqCapacity * IDaqBand * IDaqFactor / Resistance * 1e9; % nA
U_ = U_ / DaqCapacity * UDaqBand * UDaqFactor * 10; %kV

%Subtract zero level
NSubtract = IFreq;
IZero = mean(I_(1:NSubtract));
UZero = mean(U_(1:NSubtract));
I_ = I_ - IZero;
U_ = U_ - UZero;

SelectFig = figure;
plot(I_(1:100:end) / max(I_(1:100:end)), 'b');
hold on
plot(U_(1:100:end) / max(U_(1:100:end)), 'r');

%keyboard
[x, y] = ginput(2);
x = x * 100;
hold off
close(SelectFig);
tic

Tolerance = 0.02;
Start = x(1) - length(I_) * Tolerance;
Start = max(1, Start);
Finish = x(2) + length(I_) * Tolerance;
Finish = min(length(I_), Finish);

I_ = I_(Start : Finish);
U_ = U_(Start : Finish);

Skip = 1;

% Smoothing
NSmooth = 2000;
I = fastsmooth(I_(1 : Skip : end), NSmooth);
U = fastsmooth(U_(1 : Skip : end), NSmooth);

% Cut start interval 
I = I(NSmooth * 2 : end - NSmooth * 2);
U = U(NSmooth * 2 : end - NSmooth * 2);
IC = UFreq * diff(U) * 1e3 * C / 1e-9;
IC = fastsmooth(IC, NSmooth);

figure, hold on 
grid on
myplot(linspace(0, length(U)/UFreq/Skip, length(U)), U/max(U), 'r');
myplot(linspace(0, length(I)/UFreq/Skip, length(I)), I/max(I), 'b');
title('Smoothed VTC and CTC');
legend('Voltage', 'Current');
xlabel('Time, s');
hold off
figure, hold on
L = min(length(U), length(I));
myplot(U(1:L), I(1:L), 'b');
xlabel('Voltage, kV');
ylabel('Current, nA');
grid on
title('VAC without postproccessing.');
hold off
IFreq = IFreq / Skip;
UFreq = UFreq / Skip; 


% Find start of modulation
MaxCalibr = 0;
% Threshold = 9e-3; %For quickr VAC
Threshold = 1e-3;
IStart = find(I > max(I) * Threshold); IStart = IStart(1);
ICStart = find(IC > max(IC) * Threshold); ICStart = ICStart(1)+100;
UStart = find(U > max(U) * Threshold); UStart = UStart(1);
[MaxI NumMaxI] = max(I);
[MaxU NumMaxU] = max(U);
[MaxIC NumMaxIC] = max(IC);

if ~MaxCalibr
    I = I(IStart*0+1:end);
    U = U(UStart*0+1:end);
    IC = IC(ICStart*0+1:end);
else
    %Offset time
    OffsetT = max((NumMaxIC - ICStart) / UFreq, (NumMaxI - IStart) / IFreq);
    IOffset = NumMaxI - OffsetT * IFreq ;
    ICOffset = NumMaxIC - OffsetT * UFreq;
    I = I(IOffset:end);
    U = U(ICOffset:end);
    IC = IC(ICOffset:end);
end

% Align vectors
Length = min([length(I), length(U), length(IC)]);
I = I(1:Length);
U = U(1:Length);
IC = IC(1:Length);
IS = fastsmooth(I - IC, NSmooth);
toc
% Time-characteristics
TFig = figure;
hold on
grid on
ITimes = linspace(0, length(I)/(IFreq), length(I));
UTimes = linspace(0, length(U)/(IFreq), length(U));
myplot(ITimes, I/max(I), 'b');
myplot(UTimes, U/max(U), 'r');
myplot(UTimes, IC/max(IC), 'm');
myplot(UTimes, IS/max(IS), 'g');
xlabel('Time, s');
ylabel('Normalized value');
title(['Time characteristics with ' num2str(TimeModulation) 's modulation'] );
legend('Original Current', 'Voltage', 'Capacitance currnt', 'Real current' );
hold off
toc
%VAC

%% Linearization
MinT = min(max(ITimes), max(UTimes));
Times = linspace(0, MinT, 10000);
UInterp = interp1(UTimes, U, Times);
IInterp = interp1(ITimes, IS, Times);
VacFig = figure; 
myplot(UInterp, IInterp, 'b')
grid on 
xlabel('Voltage, kV');
ylabel('Current, nA');
title(['Dynamic VAC with ' num2str(TimeModulation) 's modulation']);
grid on


LinLength = .15 * NumMaxU;
LinStart = LinLength * .5;
hold on
UBegin = U(LinStart: LinLength);
IBegin = IS(LinStart: LinLength);
PBegin = polyfit(UBegin, IBegin, 1);
XLin = U(LinStart: NumMaxU);
YLin = polyval(PBegin, XLin);
myplot(XLin, YLin, 'r--' )

figure, plot(U(LinStart: NumMaxU), IS(LinStart: NumMaxU) ./ YLin)

%% BiLog
ULog = log10(UInterp(1:end/2));
ILog = log10(IInterp(1:end/2));
LogStart = length(ULog) * 3 / 4;
LogEnd = length(ULog);
PLog = polyfit(ULog(LogStart: LogEnd), ILog(LogStart: LogEnd), 1);

