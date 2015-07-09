


function [BTH,LBL]=extrac_neighboring(img,lbl,x,y,z,rn,rp)

         b=1;
  %       BTH=zeros((rp*2+1)^3,(rn*2+1)^3);
         
         BTH=zeros((rp*2+1)^3,size(img,4),(rp*2+1)^3);
        % BTH=zeros(125,33,1331);
         for i=x-rn:x+rn
             for j=y-rn:y+rn
                 for k=z-rn:z+rn
                          
                      BTH(:,:,b) = extrac_pathc_neighs(img,i,j,k,rp);
                      LBL(:,b)     = squeeze(lbl(i,j,k,:));                                
                      
                      b=b+1;
                      
                 end
             end
         end
         
         LBL=reshape(LBL,[1  prod([size(img,4) (rn*2+1)^3]) ]);
         BTH=reshape(BTH,[(rp*2+1)^3 prod([size(img,4) (rn*2+1)^3 ])]);
%          siz = size(BTH);
%          BTH = reshape(BTH,[siz(1) prod(siz(2:end))]);
%          LBL = reshape(LBL,[1 prod(siz(2:end))]);
         
end