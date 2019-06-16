%%
%������δ��װ�ɺ���
%ֱ���޸ĸ�ֵ������Ԥ��ֵ�Լ�MAEƫ��
%������ԡ�����ʵ��
%preΪ�ó���ĺ����汾��������Ӧ�Ĳ�������
%��preMain�ļ��¿�ֱ�ӵ�������pre����
%��simplePreMain�ļ���Ҳ��ֱ�ӵ�������pre���� �Դ˼���Ԥ��ֵ���Լ�ƽ����������С
clc
clear
load 'rating_matrix'
load 'directPearson'
%% 
Rating_Matrix=real_matrix;%%�ǵ��޸ĳ��Լ��ļ�������
%% 
%����������û�N
topUserN=20;
%Ŀ���û�
tarUser=1;
%Ŀ����Ŀ
tarItem=10;
Rating_Matrix(tarUser,tarItem)=0;
%% 
%�������ƶȾ���
userrel=directPearson(:,tarUser);%%�޸ĳ��Լ��ļ�������

%�õ����������ƶȣ��Լ���Ӧ���û�ID
[userCorr,userID]=sort(userrel,'descend');%��������
IdAndCorr=[userID,userCorr];

%ȥ������
tarUserSortID=find(IdAndCorr(:,1)==tarUser);
IdAndCorr(tarUserSortID,:)=[];

%% �õ�ǰtopUserN����
%���ڹ���1.��tarItem�����ֵ��û�
% new_Id=find(Rating_Matrix(IdAndCorr(:,1),tarItem)~=0);
% 
% new_IdAndCorr=IdAndCorr(new_Id,:);
% tarUserNeibour=(new_IdAndCorr(1:topUserN,:));
tarUserNeibour=(IdAndCorr(1:topUserN,:));
%% ��tarUser �µ� tarItem ����ֵԤ�� 
fenzi=0;

for w=1:topUserN
    rb_aver=sum(Rating_Matrix(tarUserNeibour(w,1),:))/nnz(Rating_Matrix(tarUserNeibour(w,1),:));
    rb_p=Rating_Matrix(tarUserNeibour(w,1),tarItem);
    fen=tarUserNeibour(w,2)*(rb_p - rb_aver);
    fenzi = fenzi+fen;
end
rTarUserAver=sum(Rating_Matrix(tarUser,:))/nnz(Rating_Matrix(tarUser,:));
fenmu=sum(tarUserNeibour(:,2));

%% 
pre=rTarUserAver + fenzi/fenmu
MAE=pre-real_matrix(tarUser,tarItem)


