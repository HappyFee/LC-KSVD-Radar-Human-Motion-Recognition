%�������ǩ��SVM�õ�

train=train_fea'; %ѡȡѵ������
train_group=H_train;%ѡȡѵ����������ʶ
test=test_fea';%ѡȡ��������
test_group=H_test; %ѡȡ������������ʶ
 
%����Ԥ������matlab�Դ���mapminmax��ѵ�����Ͳ��Լ���һ������[0,1]֮��
%ѵ�����ݴ���
[train,pstrain] = mapminmax(train');
% ��ӳ�亯���ķ�Χ�����ֱ���Ϊ0��1
pstrain.ymin = 0;
pstrain.ymax = 1;
% ��ѵ��������[0,1]��һ��
[train,pstrain] = mapminmax(train,pstrain);
% �������ݴ���
[test,pstest] = mapminmax(test');
% ��ӳ�亯���ķ�Χ�����ֱ���Ϊ0��1
pstest.ymin = 0;
pstest.ymax = 1;
% �Բ��Լ�����[0,1]��һ��
[test,pstest] = mapminmax(test,pstest);
% ��ѵ�����Ͳ��Լ�����ת��,�Է���libsvm����������ݸ�ʽҪ��
train = train';
test = test';
 
%Ѱ������c��g
%����ѡ��c&g �ı仯��Χ�� 2^(-10),2^(-9),...,2^(10)
[bestacc,bestc,bestg] = SVMcgForClass(train_group,train,-10,10,-10,10);
%��ϸѡ��c �ı仯��Χ�� 2^(-2),2^(-1.5),...,2^(4), g �ı仯��Χ�� 2^(-4),2^(-3.5),...,2^(4)
[bestacc,bestc,bestg] = SVMcgForClass(train_group,train,-2,4,-4,4,3,0.5,0.5,0.9);
 
%ѵ��ģ��
cmd = ['-c ',num2str(bestc),' -g ',num2str(bestg)];
model=svmtrain(train_group,train,cmd);
disp(cmd);
 
%���Է���
[predict_label, accuracy, dec_values]=svmpredict(test_group,test,model);
 
%��ӡ���Է�����
figure;
hold on;
plot(test_group,'o');
plot(predict_label,'r*');
legend('ʵ�ʲ��Լ�����','Ԥ����Լ�����');
title('���Լ���ʵ�ʷ����Ԥ�����ͼ','FontSize',10);