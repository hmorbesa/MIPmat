

function nii_spm_write(img,HeaderInfo,name)

         HeaderInfo.fname= name;
         HeaderInfo.dim=  size(img);
         HeaderInfo.private.dat.fname = HeaderInfo.fname;
         spm_write_vol(HeaderInfo,img);
    
    
end

    
    
    