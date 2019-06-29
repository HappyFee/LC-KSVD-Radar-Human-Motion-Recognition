% ========================================================================
% ���� 
% [prediction, accuracy, err] = classification(D, W, data, Hlabel,
%                                       sparsity)
% ����
%       D               -ѧϰ�����ֵ�
%       W               -learned classifier parametersѧϰ���ķ������
%       data            -testing features ��������
%       Hlabel          -labels matrix for testing feature �������ݵ���ʵ���
%       iterations      -iterations for KSVD ��������
%       sparsity        -sparsity threshold ϡ����ֵ
% outputs
%       prediction      -predicted labels for testing features Ԥ������
%       accuracy        -classification accuracy ׼ȷ��
%       err             -misclassfication information  �������Ϣ
%                       [errid featureid groundtruth-label predicted-label]
% ========================================================================

function [prediction, accuracy, err] = classification(D, W, data, Hlabel, sparsity)

% ϡ�����
G = D'*D;
Gamma = omp(D'*data,G,sparsity);

% classify process
errnum = 0;
err = [];
prediction = [];
for featureid=1:size(data,2)
    spcode = Gamma(:,featureid);
    score_est =  W * spcode;
    score_gt = Hlabel(:,featureid);
    [maxv_est, maxind_est] = max(score_est);  % classifying
    [maxv_gt, maxind_gt] = max(score_gt);
    prediction = [prediction maxind_est];
    if(maxind_est~=maxind_gt)
        errnum = errnum + 1;
        err = [err;errnum featureid maxind_gt maxind_est];
    end
end
accuracy = (size(data,2)-errnum)/size(data,2);



