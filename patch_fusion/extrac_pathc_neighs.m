

function [pth]=extrac_pathc_neighs(img,x,y,z,r)
        
         A=img(x-r:x+r,y-r:y+r,z-r:z+r,:);
         s=size(A);
         pth=reshape(A,[prod(s(1:3)) s(4)]);
end
