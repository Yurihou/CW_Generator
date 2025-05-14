clear;

fs=11025;% 采样率

t_all = 30;
y=zeros(1,t_all*fs);

y = y + 0.1*rand(1,length(y)); % 白噪声

y1 = string2CWWave("CQ CQ DE BY1QH PSE K", 800, 25, 0.2, 0.1, 0);
y = audioSuperpose(y,y1,2);

y2 = string2CWWave("QRZ DE BH9DWE", 600, 20, 0.1, 0, 0);
y = audioSuperpose(y,y2,6);

y3 = string2CWWave("BI1QGX", 750, 25, 0.3, 0, 0);
y = audioSuperpose(y,y3,9.6);
y = audioSuperpose(y,y3,15.6);

y4 = string2CWWave("BY1QH DE BI1NWO BI1NWO", 1000, 20, 0.05, 0, 0);
y = audioSuperpose(y,y4,9.8);

y5 = string2CWWave("QRZ DE BY1QH", 800, 25, 0.2, 0, 0);
y = audioSuperpose(y,y5,22);

y6 = string2CWWave("QRZ DE BH9DWE", 600, 20, 0.1, 0, 0);
y = audioSuperpose(y,y6,19);

n1 = chirp(0:1/fs:1,20,1,11025,"logarithmic") * 0.1; % 扫频信号
y = audioSuperpose(y,n1,3);

n2 = chirp(0:1/fs:1,11025,1,20,"logarithmic") * 0.1; % 扫频信号
y = audioSuperpose(y,n2,7);

n2 = chirp(0:1/fs:3,11025,3,20,"logarithmic") * 0.1; % 扫频信号
y = audioSuperpose(y,n2,12);

% 滤波器
Wc1 = 2*650/fs;
Wc2 = 2*1050/fs;
[b,a] = butter(4, [Wc1 Wc2], 'bandpass');
y = filter(b,a,y);

% 画波形
plot(0:1/fs:1/fs*(length(y)-1), y, 'LineWidth', 1.5);
set(gca, 'linewidth', 1.5, 'fontsize', 16);
xlabel("时间/s");

% 输出音频
sound(y, fs);
audiowrite("test.wav", y, fs); 