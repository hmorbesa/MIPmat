

function [pth]=extrac_pathc(img,x,y,z,r)
        A=img(x-r:x+r,y-r:y+r,z-r:z+r);
        pth=A(:);
end
