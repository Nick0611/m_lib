%%% �����ı��ļ�����csv�ļ�������
% ����1 �ļ���
% ����2 ��meth����1��2����ѡ�񣬶�Ӧ���ֲ�ͬ�ķ���һ��ѡ2
% ���1 ����
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
        fid=fopen(name,'rt'); % t�Ǹ���fread�������ı��ļ�
        row=0;
        while ~feof(fid)
            %һ���Զ�ȡ10000�ַ����������еĻس�����������10�ǻس���ASCII����
            %'*char'��ʾÿ�ζ�ȡһ���ַ���*��ʾ���Ҳ���ַ�
            %����fread�����Ѿ������Զ�ʶ�������ˣ���һ����ʶ���ˣ�
            % ����fopen��ָ���ļ������ʽ������gbk
            row=row+sum(fread(fid,10000,'*char')==char(10));
            %���滹��һ�����Ƶķ���������Ч�ʵͺܶ࣬����������һ��
            %'char'��ʾÿ�ζ�ȡһ���ַ�������Ĭ�����double��
            %Ҳ����˵��ȡcharȻ��ת��double�м���ת���ܿ���
            %row=row+sum(fread(fid,10000,'char')==10);
        end
        fclose(fid);
    case 2
        % �жϼ��������ϵͳ
        if (isunix) % Linuxϵͳ�ṩ��wc�������ֱ��ʹ��
            % ʹ��syetem��������ִ�в���ϵͳ�ĺ���
            % ����window��dir��linux��ls��
            [~, numstr] = system( ['wc -l', name] );
            row=str2double(numstr);
        elseif (ispc) % Windowsϵͳ����ʹ��perl����
            if exist('countlines.pl','file')~=2
                %perl�ļ����ݺܼ򵥾�����
                % while(<>) {};
                % print$.,"\n";
                fid=fopen('countlines.pl','w');
                fprintf(fid,'%s\n%s','while(<>) {};','print $.,"\n";');
                fclose(fid);
            end
            % ִ��perl�ű�
            row=str2double(perl('countlines.pl', name) );
        end
end