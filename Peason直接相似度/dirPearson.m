%% �õ�ÿ���û��������û���ֱ�����ƶȾ������ƶ�
clc
clear
load('rating_matrix.mat')
Real_Matrix=real_matrix;
m=size(Real_Matrix,1);
directPearson=abs(corr(Real_Matrix',Real_Matrix'));