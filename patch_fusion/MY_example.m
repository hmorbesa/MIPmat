

addpath(genpath( 'C:\Users\Mauro\Dropbox\MAESTRIA\NEUROIMAGE\PATCH_FUSION_Optimization\Patch_fusion_V4\SLEP_package_4.1\SLEP' ));
addpath('C:\Users\mauro\Dropbox\MAESTRIA\NEUROIMAGE\PATCH_FUSION_COMMONSPACE\PATH_FUSION_SOURCES\othercodes');


sourcefolder='D:\NUEVOPAPER\MICCAIDATABASE\labels_reg_ants\ganglia_labels\';
Isorucefolder='D:\NUEVOPAPER\MICCAIDATABASE\images_reg_ants\';
savefolder  ='D:\NUEVOPAPER\PAPPER_IBpria2015\Label-propagation\MICCAI_results\';

IDq=struct2cell(dir([Isorucefolder '*.nii']));
for i=1:size(IDq,2); img_qry{i} = [Isorucefolder IDq{1,i}];end

Dq=struct2cell(dir([sourcefolder '*.nii']));
for i=1:size(Dq,2); lbl_qry{i} = [sourcefolder Dq{1,i}];end

load('MASK_CUBE_V2.mat')

for sj=10
    tic
    [imgqry,HeaderInfo]=read_nii_spm(img_qry{sj});
    imgqry= create_mask(imgqry,mask,smsk);
    
    [lblqry,HeaderInfo]=read_nii_spm(lbl_qry{sj});
    lblqry= create_mask(lblqry,mask,smsk);
    
    qq=1;
    for si=[1:sj-1 sj+1:numel(img_qry)]
 
        img_names{qq}=img_qry{si};
        lbl_names{qq}=lbl_qry{si}; 
        qq=qq+1;
    end
    
    segc=zeros([size(imgqry) 7]);
    [resseg,ss,ampa]=atlasvoting_wheighted(lbl_names,segc,33,1,ones(1,33),mask,smsk);
    
    [schspels]=find(ampa<30);
    
%     NG=floor(5/2);
%     PTH=floor(3/2);

    NG=floor(5/2);
    PTH=floor(3/2);
       
    supdata=zeros([size(imgqry) 33]);
    supdata_lbl=zeros([size(imgqry) 33]);
    
     for isj=1:17
        [img]=read_nii_spm(img_names{isj});
        [lbl]=read_nii_spm(lbl_names{isj});
        
        supdata(:,:,:,isj)=create_mask(img,mask,smsk);
        supdata_lbl(:,:,:,isj)=create_mask(lbl,mask,smsk);
        
     end
    
    band_method=1;
    
    [L]=Patch_fusion_MAS(imgqry,supdata,supdata_lbl,band_method,NG,PTH,schspels);
   
    resseg(schspels)=L(schspels);

    nii_spm_write(resseg,HeaderInfo,['coupe'  num2str(sj,'%02d') '.nii']);

    toc
    
end