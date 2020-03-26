function [lb,ub,dim,fobj] =Get_fitnessfunction(F)
global XaN min1 max1
 switch F
   case 'F1'
       fobj = @F1;
       %min1=6;
       %max1=21;
       dim=size(XaN,2)+1;
       lb=[0.*ones(1,dim-1) min1];
       ub=[1.*ones(1,dim-1) max1];
 end 
end
function o = F1(x)
global XaN Class
len=round(x(end));
[val2,ind2]=sort(x(1:end-1));
x1=XaN(:,ind2(1:len));
TrainingSet=x1;%(x1-min(x1,1))./(max(x1,1)-min(x1,1));
TestSet=x1;%(x1-min(x1,1))./(max(x1,1)-min(x1,1));
GroupTrain=Class;
%tic
Mdl = fitcecoc(TrainingSet, GroupTrain, 'Learners',templateSVM('Standardize',true));
%td=toc
[label,score] = predict(Mdl, TestSet);
ind=find(Class~=label');
misAcc=numel(ind)/numel(label);
o=(misAcc+0.01.*(len));
end


