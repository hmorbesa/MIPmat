
function [resseg,segc,ampa]=atlasvoting_wheighted(lbl_names,segc,nn,nna,w,mask,smsk)

for i=nna:nn;
         
        [seg]=read_nii_spm(lbl_names{i});
        [seg]=create_mask(seg,mask,smsk);
        disp([lbl_names{i} ': ' num2str(w(i))]);
        C=unique(seg);
        
        for c=1:numel(C)
            segc(:,:,:,c)=w(i).*(seg==C(c))+segc(:,:,:,c);
        end
        
end

[ampa,resseg]=max(segc,[],4);
resseg=resseg-1;

