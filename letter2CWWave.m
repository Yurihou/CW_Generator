% 函数名：letter2CWWave
% 功能：把字符串转成CW波形
% 输入：
% char：需要转CW的字符，限大小写字母、数字、/和?，其他字符会输出三个dot宽度的空白
% freq：CW的频率（下面改fs可以设置，默认是11025Hz）
% wpm：CW的速度，1WPM = 50dot/min
% wpmerr：CW速度的误差值，可以模拟手键QSD，0表示无误差
% dashDotRatioErr：CW划长度/点长度-3，可以模拟手键QSD，也可以模拟bug键。0表示标准比例，划/点=3
%
% 输出：char字符的CW波形，幅值为1

function s = letter2CWWave(char, freq, wpm, wpmerr, dashDotRatioErr)
    fs = 11025;
    s = [];
    
    cwLetter = [".-" "-..." "-.-." "-.." "." "..-." "--."...
        "...." ".." ".---" "-.-" ".-.." "--" "-."...
        "---" ".--." "--.-" ".-." "..." "-"...
        "..-" "...-" ".--" "-..-" "-.--" "--.."];
    cwNumber = ["-----" ".----" "..---" "...--" "....-"...
        "....." "-...." "--..." "---.." "----."];
    cwSlash = "-..-.";
    cwQuestion = "..--..";

    if char >= 'A' && char <= 'Z'
        cwStr = cwLetter(char - 'A' + 1);
    elseif char >= 'a' && char <= 'z'
        cwStr = cwLetter(char - 'a' + 1);
    elseif char >= '0' && char <= '9'
        cwStr = cwNumber(char - '0' + 1);
    elseif char == '/'
        cwStr = cwSlash;
    elseif char == '?'
        cwStr = cwQuestion;
    else
        cwStr = '';
    end
    
    cwChar = convertStringsToChars(cwStr);
    for i = 1:length(cwChar)
        if cwChar(i) == '.'
            t = 0:1/fs:50/60/wpm*(1+(rand-0.5)*wpmerr);
        elseif cwChar(i) == '-'
            t = 0:1/fs:(3+dashDotRatioErr)*50/60/wpm*(1+(rand-0.5)*wpmerr);
        else
            t = [];
        end
        s1 = sin(2*pi*freq*t);
        s2 = [ones(1,length(t)-round(0.05*fs*50/60/wpm)) linspace(1,0,round(0.05*fs*50/60/wpm))];
        s = [s s1.*s2 zeros(1,round(50/60/wpm*fs*(1+(rand-0.5)*wpmerr)))];
    end
    s = [s zeros(1,round((3+dashDotRatioErr)*50/60/wpm*fs*(1+(rand-0.5)*wpmerr)))];
end