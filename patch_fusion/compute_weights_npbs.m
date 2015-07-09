
function [w]=compute_weights_npbs(BTH,Aph)


Aph=repmat(Aph,1,size(BTH,2));

w1=sqrt(sum((Aph-BTH).^2));
% [~,mn]=min(w1);
% h=BTH((size(BTH,1)+1)/2,mn);

%%dcardenasp
h = median(pdist(BTH'));
%%dcardenasp

w=exp(-(w1.^2)/(2*h^2));



