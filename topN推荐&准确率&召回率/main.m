clc
clear
load 'rating_matrix'
Rating_Matrix=real_matrix;
%ȫ���û����ƶȾ���
userCorr=abs(corr(Rating_Matrix',Rating_Matrix'));
topUserN=30;
topItemN=50;
%% 
tarUser=2;
%% 
%ȷ��tarItem
%��ѡ���tarUser��Ϊ0����Ŀ����������ѡ��20%��Ϊ���Լ���ѡΪtarItem
allPayItemID=find(Rating_Matrix(tarUser,:)~=0);
allPayItemLength=length(allPayItemID);
%ѡ��ǰ20%����Ϊ���Լ�tarItems
TextItemLength=round(0.2*allPayItemLength);
%����������ҵ���������1��allPayItemLength,��allPayItemLength��
randItem=randperm(allPayItemLength);
%ѡ������Լ�tarItem
textItemID=allPayItemID(randItem(1:TextItemLength));
%% �����û����Լ���itemȫ����Ϊ0��Ȼ�������δ���ֵ���Ŀ����Ԥ�⣬�������Ƽ��б��׼ȷ��/������
bridge=Rating_Matrix(tarUser,:);
Rating_Matrix(tarUser,textItemID)=0;
%Ԥ��
tarItem=find(Rating_Matrix(tarUser,:)==0);
preRating=zeros(2,length(tarItem));
for j=1:length(tarItem)
    preRating(1,j)=tarItem(j);
    preRating(2,j)=pre(Rating_Matrix ,userCorr,tarUser,tarItem(j),topUserN );
end
%��һ���û�ʱ,��ԭ���ݼ�
Rating_Matrix(tarUser,:)=bridge;
%����ĿԤ��ֵ��������,�õ��Ƽ��б�listItemN
sort_PreRat=sortrows(preRating',-2);
listItemAndpreR=sort_PreRat(1:topItemN,:);
listItemAndpreR=listItemAndpreR';
%
[c,ia,ib]=intersect(listItemAndpreR(1,:),textItemID);
%��ȷ��(������)���ٻ���
acc=length(c)/topItemN;
zhaohui=length(c)/TextItemLength;

%%  ����Ҳ���ԶԲ��Լ��ٴθ��ģ�
%   ��Ϊ���������ֵ���Ŀ������ȷ�8�ݣ��ֱ������8�ε���ȷ�ʡ��ٻ���ƽ��ֵ
%   ��Ȼ����Ҳ��