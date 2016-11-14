random = randsample(1:size(X_fg,1),size(X_fp,1));

X_fg2 = X_fg(random,:);
X_fp2 = X_fp;
Y_fp2 = l_fp;
Y_fg2 = l_fg(random);

l1 = size(X_fg2,1);
r1 = randsample(1:l1,l1);
X_fg_s=X_fg2(r1,:);
l2 = size(X_fp2,1);
r2 = randsample(1:l2,l2);
X_fp_s=X_fp2(r2,:);

ind_fg = crossvalind('Kfold',l1,5);
ind_fp = crossvalind('Kfold',l2,5);

accu=0;
accug=0;
C = zeros(2,2); 
for i = 1:5
    test_ind_fp = (ind_fp == i);
    test_ind_fg = (ind_fg == i);
    train_ind_fp = ~test_ind_fp;
    train_ind_fg = ~test_ind_fg;

    X_tr = [X_fg_s(train_ind_fg,:); X_fp_s(train_ind_fp,:)];
    y_tr = [Y_fg2(train_ind_fg); Y_fp2(train_ind_fp)];
    rtr = randsample(1:size(X_tr,1),size(X_tr,1));
    X_tr_s = X_tr(rtr,:);
    Y_tr_s = y_tr(rtr);

    X_tst = [X_fg_s(test_ind_fg,:); X_fp_s(test_ind_fp,:)];
    y_tst = [Y_fg2(test_ind_fg); Y_fp2(test_ind_fp)];
    rtst = randsample(1:size(X_tst,1),size(X_tst,1));
    X_tst_s = X_tst(rtst,:);
    Y_tst_s = y_tst(rtst);

    X_tr_new=bsxfun(@minus,X_tr_s,mean(X_tr_s));
    X_tr_final = bsxfun(@rdivide, X_tr_new, std(X_tr_s));
    X_tst_new=bsxfun(@minus,X_tst_s,mean(X_tr_s));
    X_tst_final=bsxfun(@rdivide, X_tst_new, std(X_tr_s));
    model = fitcsvm(X_tr_final, Y_tr_s,'KernelFunction','rbf');
%    model = TreeBagger(50,X_tr_final,Y_tr_s);%,'OOBPrediction','On','Method','classification');
%    model = fitcknn(X_tr_final, Y_tr_s);
%    model.NumNeighbors = 5;
    
    [label,score] = predict(model,X_tst_final);
%uncomment these two for randm forest classifier
%    label = cell2mat(label);
%    label = str2num(label);
    accu = accu + 1 - sum(abs(label - Y_tst_s))/size(Y_tst_s,1);
    [C0, order] = confusionmat(Y_tst_s, label);
    disp(C0);
    C = C+C0;
X_bulk_new=bsxfun(@minus,X_fg,mean(X_tr_s));
X_bulk_final=bsxfun(@rdivide, X_bulk_new, std(X_tr_s));
[label2,score2] = predict(model,X_bulk_final);
%uncomment these two for randm forest classifier
% label2 = cell2mat(label2);
% label2 = str2num(label2);
accug = accug + 1 - sum(label2) / size(label2,1);


end

    disp(C / 5.0);
    disp(order);

accu = accu / 5;
accug=accug/5;
disp(strcat('Validation accuracy: ',num2str(accu)));

disp('accu for all the grains:');
disp(strcat('Full grain accuracy: ',num2str(accug)));

size(label2,1);
