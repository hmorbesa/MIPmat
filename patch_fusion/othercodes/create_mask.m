

function img=create_mask(img,mask,smsk)

         img=img(mask==1);   
         img=reshape(img,smsk);

end