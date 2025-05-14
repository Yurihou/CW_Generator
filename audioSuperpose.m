% 函数名：string2CWWave
% 功能：给y在i秒后叠加上y1的波形
% 输入：
% y：原波形
% y1：需要叠加的波形
% i：叠加的位置，单位秒（采样率下面可以改，默认11025）
% 输出：y在i秒后叠加上y1的波形

function y = audioSuperpose(y,y1,i)
    fs=11025;
    i=round(i*fs);
    y(i:i+length(y1)-1) = y(i:i+length(y1)-1) + y1;
end