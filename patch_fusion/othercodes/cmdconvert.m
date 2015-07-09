
%%
function [dice]=cmdconvert(cmdout)

if prod(size(cmdout))> 1017
    cmdout=cmdout(1:1017);
    C=reshape(cmdout,113,9)';
else
   C=reshape(cmdout,113,9)';
end
k=1;
for i=3:9
    
    measure(k,:)=str2num(C(i,:));
    k=k+1;

end
dice=measure(:,4);