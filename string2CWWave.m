% 函数名：string2CWWave
% 功能：把字符串转成CW波形
% 输入：
% str：需要转CW的字符串
% freq：CW的频率（音频采样率在函数letter2CWWave里面设置，默认是11025Hz）
% wpm：CW的速度，1WPM = 50dot/min
% vol：CW幅值
% wpmerr：CW速度的误差值，可以模拟手键QSD，0表示无误差
% dashDotRatioErr：CW划长度/点长度-3，可以模拟手键QSD，也可以模拟bug键。0表示标准比例，划/点=3
%
% 输出：一段波形

function s = string2CWWave(str, freq, wpm, vol, wpmerr, dashDotRatioErr)
    s=[];
    chStr = convertStringsToChars(str);
    for i = 1 : length(chStr)
        s = [s letter2CWWave(chStr(i),freq,wpm,wpmerr, dashDotRatioErr)];
    end
    s = s * vol;
end