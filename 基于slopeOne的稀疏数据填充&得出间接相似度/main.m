clc
clear
load('rating_matrix.mat')
Real_Matrix=real_matrix;
m=size(real_matrix,1);
zo_real_matrix=Real_Matrix;
spaPearson=zeros(m,m);
%% Ŀ��,���user�ļ�����ƶ�spaPearson��943*943��
Real_Matrix=real_matrix;
%�õ�ÿ���û��������û������ƶȾ���
for i=1:m
    i
    for j=1:m
        j
        %��i�û������£��������û���ԭʼ���־���
        newRating=Real_Matrix(j,:);
        %01����
        zo_real_matrix(zo_real_matrix~=0)=1;
        %%���Ƚ��û��������û��Ĳ������Ԥ����� ����ʽ����
        %
        %����zo_real_matrix(i,:)�û���Ϊ1��id����zo_real_matrix(j,:)��Ϊ0��id �����ǵĽ���id �õ��ܹ���B������Ŀid
        fill_ID=intersect(find(zo_real_matrix(i,:)==1), find(zo_real_matrix(j,:)==0));
        %
        %�õ���Ҫ����Ŀ����Ŀ�������������鳤��
        len_fill_ID=length(fill_ID);

        %����slope one �㷨 ��  ��Ҫ����item�������
        for k=1:len_fill_ID
            newRating(:,fill_ID(k))=slope(Real_Matrix,j,fill_ID(k));
        end
        spaPearson(i,j)=myPearson(Real_Matrix(i,:),newRating);
    end

end
%�˾����еõ����ݼ� new_Real_Matrix���µ������� �Լ�spaPearson��ÿ���û���slope one ����ļ�����ƶ�
