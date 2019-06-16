function [accRate,coverage] = ItemCF(real_matrix,ratio,NeibourK,N)
    %% ���������ݵ��뵽������
    Rating=real_matrix;
    [m,n] = size(Rating);
    
    TestS = zeros(m,n);
    TrainS = zeros(m,n);


    %% �����ȡ20%��Ϊ���Լ�,ʣ�µ�80%��Ϊѵ����

    for user_id = 1:m
        for item_id = 1:n
            if  Rating(user_id,item_id)~=0
                randNum = rand();
                if randNum < ratio
                    TrainS(user_id,item_id) = Rating(user_id,item_id);
                else
                    TestS(user_id,item_id) = Rating(user_id,item_id);
                end
            end
        end
    end


%     for user_id = 1:m
%          Watched = find(Rating(user_id,:)~=0);
%          lenWatched = length(Watched);
%          lenTr = round(ratio*lenWatched);
% 
%          randWatched = randperm(lenWatched);
%          TrainS(user_id,randWatched(1:lenTr)) = Rating(user_id,randWatched(1:lenTr));
%          TestS(user_id,randWatched(lenTr+1:lenWatched)) = Rating(user_id,randWatched(lenTr+1:lenWatched));
%     end
    %% ������Ŀ������ƶȣ��õ���Ŀ���ƶȾ���ItemSimilarty[1682*1682]

    ItemSimilarty = Item_Similarty(TrainS);

    %% �Բ��Լ�User����Item��Ȥ��Ԥ��

    InterestP = zeros(m,n);
    W = ItemSimilarty;
    
    ItemNeiK = zeros(n,NeibourK);
    for  item_id = 1:n
        %ItemNeiK��ItemID�͵�i����Ŀ���������Ʒ����
        [z,SItemSort] = sort(W(item_id,:),'descend');
        ItemNeiK(item_id,:) = SItemSort(1:NeibourK);
    end
    disp('����ItemID��k������Ʒ�� ���')

    for UserId = 1:m
        %N(u)���û������ֵ���Ŀ����
        NuItem= find(TrainS(UserId,:)~=0);
        for ItemId = 1:n

            

            %JiaojiΪ�û���ʷϲ��������Ʒ���͵�ItenID��Ŀ���������Ŀ���Ľ���
            Jiaoji = intersect(ItemNeiK(ItemId,:),NuItem);


            pui=0;
            if length(Jiaoji) >= 1
                % ������Ȥ��
                for j=1:length(Jiaoji)
                    p = W(ItemId,Jiaoji(j))* TrainS(UserId,Jiaoji(j));
                    pui = pui + p;
                end   
            end

            InterestP(UserId,ItemId) = pui;
        end
    end

    %% �������û�����Ŀ����Ȥ�Ȱ���������
    sortInterestItem = zeros(m,n);
    for i=1:m
        [PL,PitemId] = sort(InterestP(i,:),'descend');
        sortInterestItem(i,:) = PitemId;
    end

    %% �Ƽ�׼ȷ�ʼ���
    %���Ƽ��б�ΪNʱ���Ա�ǰN���Ͳ��Լ��ж�����ͬ����Ŀ

    accNum = zeros(m,1);
    for tu = 1:m
        Testid = find(TestS(tu,:) ~= 0);
        accNum(tu,1) = length(intersect(Testid,sortInterestItem(tu,1:N)));
    end
    accRate = sum(accNum)/(N*m);
    disp('ItemCF ��׼ȷ��Ϊ��')
    disp(accRate)
    %% �Ƽ������ʼ���

    recItem = sortInterestItem(:,1:N);
    recDiff = length(unique(recItem));
    
    coverage = recDiff/n;
    disp('ItemCF �ĸ�����Ϊ:')
    disp(coverage)


end

