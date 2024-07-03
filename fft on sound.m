[y,fs] = audioread('Music.mp3');
y = y(:,1); 
sound(y,fs);

t = linspace(0, length(y)/fs, length(y));

figure;
plot(t, y);
title('Signal in time domain');

f=linspace(-fs/2,fs/2,length(y));
y_freq=real(fftshift(fft(y))); 
figure;
plot(f,y_freq);
title('Signal in frequency domain');

h1=[1 zeros(1,length(y)-1)];
y_1=conv(h1,y);
y_1 = y_1(t<=length(y)); 
figure;
subplot(2,1,1);
plot(t,y_1); 
title('The output after passing over channel 1');
subplot(2,1,2);
plot(t,y);
title('The original signal');

h2=exp(-2*pi*5000*t);
y_2=conv(h2,y);
y_2 = y_2(t<=length(y));
figure;
subplot(2,1,1);
plot(t,y_2); 
title('The output after passing over channel 2');
subplot(2,1,2);
plot(t,y);
title('The original signal');

h3=exp(-2*pi*1000*t);
y_3=conv(h3,y);
y_3 = y_3(t<=length(y));    
figure;
subplot(2,1,1);
plot(t,y_3); 
title('The output after passing over channel 3');
subplot(2,1,2);
plot(t,y);
title('The original signal');

h4=[2 zeros(1,length(0:0.1:1)-2) 0.5];
y_4=conv(h4,y);
y_4= y_4(t<=length(y));    
figure;
subplot(2,1,1);
plot(t,y_4); 
title('The output after  passing over channel 4');
subplot(2,1,2);
plot(t,y);
title('The original signal');

sigma = input('Enter the sigma value of the noise: ');
Channel = input('Enter the channel number that the noise will be added to it: ');
switch Channel
    case 1
        Z = (sigma*randn(1,length(y_1)))';
        y_noise = y_1 + Z ; 
    case 2
        Z = (sigma*randn(1,length(y_2)))';
        y_noise = y_2 + Z ; 
    case 3
        Z = (sigma*randn(1,length(y_3)))';
        y_noise = y_3 + Z ;         
    case 4
        Z = (sigma*randn(1,length(y_4)))';
        y_noise = y_4 + Z ;
end

sound(y_noise,fs);

figure;
plot(t, y_noise);
title('Signal after adding noise in time domain');

f=linspace(-fs/2,fs/2,length(y_noise));
y_freq=real(fftshift(fft(y_noise)));
figure;
plot(f,y_freq);
title('Signal after adding noise in frequency domain');

cutoff_frequency = 3400;
y_freq([1:round((-cutoff_frequency-(-fs./2))*(length(y_noise)/fs)) round((cutoff_frequency-(-fs./2))*(length(y_noise)/fs)):length(y_noise)])= 0; 

filtered_signal_time = real(ifft(ifftshift(y_freq)));
figure ; 
plot(t , filtered_signal_time); 
title ('filterd signal in time domain');

f=linspace(-fs/2,fs/2,length(y_noise));
figure ; 
plot (f,y_freq);
title ('filterd signal in freq domain');

sound(filtered_signal_time , fs);