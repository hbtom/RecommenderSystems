clc
clear
load 'rating_matrix'
Rating_Matrix=real_matrix;
%length�Ǽ�������еĳ���
[line,row]=size(Rating_Matrix);
%% 
%���ò��Ե�Ŀ���û�����
%numTarUser=floor(0.05*line);
%������ҵ��û�id
%randLine=round(rand(1,numTarUser)*line);
%���ѡ��ǰnumTaruser��
%tarUser=Rating_Martix(randLine(1:numTarUser),:);
tarUser=1;
%% 
%����������û�N
topUserN=10;
%% 
userrel=abs(corr(Rating_Matrix(tarUser,:)',Rating_Matrix'));
[userCorr,userID]=sort(userrel,'descend');%��������
IdAndCorr=[userID',userCorr'];
tarUserSortID=find(IdAndCorr(:,1)==tarUser);
IdAndCorr(tarUserSortID,:)=[];

tarUserNeibour=(IdAndCorr(1:topUserN,:));
for j=1:topUserN
    numCli=find(Rating_Matrix(tarUserNeibour(j,1),:)~=0);
end
%% ѡ����Լ�
allPayItemID=find(Rating_Matrix(tarUser,:)~=0);
allPayItemLength=length(find(Rating_Matrix(tarUser,:)~=0));
randItem=randperm(allPayItemLength);
TextItemLength=floor(0.2*allPayItemLength);
%������ҵĲ�Ϊ0����ƷID
textItemID=allPayItemID(randItem(1:TextItemLength));

%���ѡ��ǰnumTextItem��

%diff=setdiff(allPayItemID,textItemID);
%same=intersect(allPayItemID,textItemID);

%allPayItemID
%�����Լ���ƷID��0
newRating_Matrix=Rating_Matrix;
newRating_Matrix(tarUser,textItemID)=0;

tarItem=find(newRating_Matrix(tarUser,:)==0);
%% ������δ������Ŀ����Ԥ��
%�Ƽ��б�������topItemN=15;
%����׼ȷ�ʡ��ٻ���

%ȡ�����û����۹�����Ʒ�Ĳ��� �� tarItem����
%����Щ��Ŀ��������Ԥ��
newPayItemID=find(newRating_Matrix(tarUser,:)~=0);
rTarUserAver=sum(newRating_Matrix(tarUser,newPayItemID))/nnz(newRating_Matrix(tarUser,:));
fenmu=sum(tarUserNeibour(:,2));
for w=1:topUserN
    rNeiAver=sum(newRating_Matrix(tarUserNeibour(w,1),:))/nnz(newRating_Matrix(tarUserNeibour(w,1),:));
    fenz=tarUserNeibour(w,2)*(newRating_Matrix(tarUserNeibour(w,1),20)-rNeiAver);
    fenzi = fenz+fenz;
end
pre=rTarUserAver + fenzi/fenmu




