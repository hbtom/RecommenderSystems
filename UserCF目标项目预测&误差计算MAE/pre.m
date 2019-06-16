function [ pre ] = pre(Rating_Matrix ,userCorr,tarUser,tarItem, topUserN)

    %pre �� pre2�������������������ƣ�pre2Ϊ��tarItem�����ֵĲ���Ϊ�����
    
    Rating_Matrix(tarUser,tarItem)=0;
    %% 
    %�������ƶȾ���
    userrel=userCorr(:,tarUser);
    %�õ����������ƶȣ��Լ���Ӧ���û�ID
    [userCorr,userID]=sort(userrel,'descend');%��������
    IdAndCorr=[userID,userCorr];
    tarUserSortID=find(IdAndCorr(:,1)==tarUser);
    IdAndCorr(tarUserSortID,:)=[];

    %% �õ�ǰtopUserN����
    tarUserNeibour=(IdAndCorr(1:topUserN,:));

    %% ��tarUser �µ�tarItem ����ֵԤ�� 
    fenzi=0;

    for w=1:topUserN
        rb_aver=sum(Rating_Matrix(tarUserNeibour(w,1),:))/nnz(Rating_Matrix(tarUserNeibour(w,1),:));
        rb_p=Rating_Matrix(tarUserNeibour(w,1),tarItem);
        fen=tarUserNeibour(w,2)*(rb_p - rb_aver);
        fenzi = fenzi+fen;
    end

    rTarUserAver=sum(Rating_Matrix(tarUser,:))/nnz(Rating_Matrix(tarUser,:));
    fenmu=sum(tarUserNeibour(:,2));

    pre=rTarUserAver + fenzi/fenmu;

end

