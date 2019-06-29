%clear;
clc;
extractfeature1
addpath(genpath('.\ksvdbox'));  % add K-SVD box  ����KSVD������
addpath(genpath('.\OMPbox')); % add sparse coding algorithem OMP  ����OMP������
%load('trainingdata\featurevectors.mat','training_feats', 'testing_feats', 'H_train', 'H_test');


%% constant���ò���
sparsitythres = 5; % sparsity prior   ����ʲô������
sqrt_alpha = 4; % weights for label constraint term ��ǩԼ�����Ȩ��
sqrt_beta = 2; % weights for classification err term ����������Ȩ��
dictsize = 100; % dictionary size �ֵ��С
iterations = 50; % iteration number ����50��
iterations4ini = 20; % iteration number for initialization ��ʼ���ĵ�������20


%% dictionary learning process
% get initial dictionary Dinit and Winit
fprintf('\nLC-KSVD ��ʼ��... ');
[Dinit,Tinit,Winit,Q_train] = initialization4LCKSVD(train_fea,H_train1,dictsize,iterations4ini,sparsitythres);%��ʼ���ֵ�
fprintf('���!');


%run LC K-SVD Training (reconstruction err + class penalty)
% fprintf('\nDictionary learning by LC-KSVD1...');
% [D1,X1,T1,W1] = labelconsistentksvd1(train_fea,Dinit,Q_train,Tinit,H_train1,iterations,sparsitythres,sqrt_alpha);
% save('trainingdata\dictionarydata1.mat','D1','X1','W1','T1');
% fprintf('���!');


% run LC k-svd training (reconstruction err + class penalty + classifier err)
fprintf('\nDictionary and classifier learning by LC-KSVD2...')
[D2,X2,T2,W2] = labelconsistentksvd2(train_fea,Dinit,Q_train,Tinit,H_train1,Winit,iterations,sparsitythres,sqrt_alpha,sqrt_beta);
save('trainingdata\dictionarydata2.mat','D2','X2','W2','T2');
fprintf('���!');



% %% classification process
% [prediction1,accuracy1] = classification(D1, W1, test_fea, H_test1, sparsitythres);
% fprintf('\nLC-KSVD1 ��ʶ��׼ȷ��: %.03f ', accuracy1);


[prediction2,accuracy2] = classification(D2, W2, test_fea, H_test1, sparsitythres);
fprintf('\nLC-KSVD2 ��ʶ��׼ȷ��: %.03f ', accuracy2);


