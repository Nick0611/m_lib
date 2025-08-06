%%% 计算文本文件例如csv文件的行数
% 输入1 文件名
% 输入2 ‘meth’有1和2可以选择，对应两种不同的方法一般选2
% 输出1 行数
function row = RowCount(varargin)
method = 1;
name = varargin{1};
if nargin > 1
    for i = 2:nargin-1
        switch varargin{i}
            case 'meth'
                method = varargin{i+1};
        end
    end
end
switch method
    case 1
        fid=fopen(name,'rt'); % t是告诉fread是这里文本文件
        row=0;
        while ~feof(fid)
            %一次性读取10000字符，计算其中的回车个数，其中10是回车的ASCII编码
            %'*char'表示每次读取一个字符，*表示输出也是字符
            %放心fread现在已经可以自动识别中文了，万一还是识别不了，
            % 请在fopen中指定文件编码格式，比如gbk
            row=row+sum(fread(fid,10000,'*char')==char(10));
            %下面还有一个类似的方法，但是效率低很多，大概是上面的一半
            %'char'表示每次读取一个字符，但是默认输出double，
            %也就是说读取char然后转换double中间有转换能快吗？
            %row=row+sum(fread(fid,10000,'char')==10);
        end
        fclose(fid);
    case 2
        % 判断计算机操作系统
        if (isunix) % Linux系统提供了wc命令可以直接使用
            % 使用syetem函数可以执行操作系统的函数
            % 比如window中dir，linux中ls等
            [~, numstr] = system( ['wc -l', name] );
            row=str2double(numstr);
        elseif (ispc) % Windows系统可以使用perl命令
            if exist('countlines.pl','file')~=2
                %perl文件内容很简单就两行
                % while(<>) {};
                % print$.,"\n";
                fid=fopen('countlines.pl','w');
                fprintf(fid,'%s\n%s','while(<>) {};','print $.,"\n";');
                fclose(fid);
            end
            % 执行perl脚本
            row=str2double(perl('countlines.pl', name) );
        end
end