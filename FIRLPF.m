%Sampling Period
Fs = 200e3;
Ts = 1/Fs;

%Time interval
t = 0:Ts:5e-3-Ts;

%Input Frequencies
F1 = 1e3;
F2 = 2e3;
F3 = 50e3;

%Input with noice
y = 3*sin(2*pi*F1*t) + 4*sin(2*pi*F2*t) + 6*sin(2*pi*F3*t);

subplot(5,1,1);
plot(t,y)
title('Input x(t)'), xlabel('time');

%detect frequencies of input
nfft = length(y);
nfft2 = 2.^nextpow2(nfft);
fy = fft(y,nfft2);
fy = fy(1:nfft2/2);
xfft=Fs.*(0:nfft2/2-1)/nfft2;
subplot(5,1,2);
plot(xfft, abs(fy/max(fy)))
title('Frequencies in input')
xlabel('Hz');

%Impulse response with cutoff Frequency 2KHz
cutoff = 2e3/Fs/2;
order = 10;
h = fir1(order,cutoff, 'low');
subplot(5,1,3);
time = linspace(-4.5,4.5,order+1);
plot(time, h*5);
title('Impulse response H(W)')
xlabel('Hz');

%Convolution of x(t) and h(t)
convolution = conv(h,y);
subplot(5,1,4);
plot(convolution)
title('output y(t)')
xlabel('time in ms')
xlim([0 1000]);

subplot(5,1,5);
plot(t, y, linspace(0,5e-3,1010), convolution, '-r')
title('Input vs output')
xlabel('time in ms')
legend('input', 'output');