clc
clear
load 'rating_matrix'
Rating_Matrix=real_matrix;
%length�Ǽ�������еĳ���
[line,row]=size(Rating_Matrix);
%% 
%���ò��Ե�Ŀ���û�����
numTarUser=floor(0.05*line);
%������ҵ��û�id
randLine=round(rand(1,numTarUser)*line);
%���ѡ��ǰnumTaruser��
tarUser=randLine(1:numTarUser);
%% 
for i=1:numTarUser
    figure(i)
    plotUserItem(Rating_Matrix,tarUser(i));
end