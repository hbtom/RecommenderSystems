function [ pre ] = pre2(Rating_Matrix ,userCorr,tarUser,tarItem, topUserN)

    %pre �� pre2�������������������ƣ�pre2Ϊ��tarItem�����ֵĲ���Ϊ�����
    % ��ʵ����������pre2��������ƽ�������������Ҹ�����Ŀ���ڱ����ֵ�
    %�û����٣����µ����������ֵtopN,ͬʱҲ�����٣�ͬʱ�����������ƿ��ܻᵼ��
    %��ʹ��ϵ�Ȳ���Ϊ��ѡ���topN����������׼ȷ�ʣ���Ҳ��MAE ֵ����ԭ��
    %����µ�����Щitem �����û�������û��topN���أ������ζ�Ÿ�itemԤ��ʱ�������ҵ�
    %tarUser������ڣ��Լ������ά�Ȳ�һ�µ����⡭��
    %�������Ƕ��û���tarItem����Ϊ0�����ǿ������Ϊδ���֣�Ҳ�������δ���־������־���0������
    Rating_Matrix(tarUser,tarItem)=0;
    %% 
    %�������ƶȾ���
    userrel=userCorr(:,tarUser);
    %�õ����������ƶȣ��Լ���Ӧ���û�ID
    [userCorr,userID]=sort(userrel,'descend');%��������
    IdAndCorr=[userID,userCorr];

    %% �õ�ǰtopUserN����
    %���ڹ���1.��tarItem�����ֵ��û�
    new_Id=find(Rating_Matrix(IdAndCorr(:,1),tarItem)~=0);

    new_IdAndCorr=IdAndCorr(new_Id,:);
    if size(new_IdAndCorr,1) < topUserN
        topUserN=size(new_IdAndCorr,1);
        tarUserNeibour=new_IdAndCorr;
    else
        tarUserNeibour=(new_IdAndCorr(1:topUserN,:));
    end

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

