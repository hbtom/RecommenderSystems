function ItemSimilartyIUF = Item_Similarty_IUF( Rating )
    n = size(Rating,2);
   disp('�����������ƶ�')
%% �����û����ƶ�
    W = zeros(n,n);
    % ����N��ʾϲ��ĳ��Ʒ���û���
    Rating2 = Rating;
    Rating(find(Rating2~=0))=1;
    N=sum(Rating2,1);
    
    disp('��Ŀ���ƶȼ��㵽��')
    for  row = 1:n
      
        disp(row)
        
        for col = 1:n
            if row == col
                W(row,col)=0;
            else
                fenzi = 0;
                u = intersect(find(Rating(:,row)~=0),find(Rating(:,col)~=0));
                if u ~= 0
                    for uu =1:length(u)
                        fenzi = fenzi + 1/log(1+length(find(Rating(u(uu),:)~=0)));
                    end
                end
                fenmu = sqrt(N(1,row)*N(1,col));
                if fenmu ~= 0
                    W(row,col) = fenzi/fenmu;
                else
                    W(row,col)=0;
                end
            end
        end
    end
    ItemSimilartyIUF = W;
    disp('�����ƶȼ������')
    
end
