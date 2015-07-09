function [L]=Patch_fusion_MAS(imgqry,supdata,supdata_lbl,band_method,NG,PTH,schspels)

% Generate the label segmentation by Multi-atlas Patch based segmentation methods.
% 
%% Inputs
% imgqry       - Intensity MRI wich is wanted to segment.
% supdata      - Is a 4-D Matrix size: [m x n x p x NS] wich holds a set of 
%               NS Intensity Atlases.
% supdata_lbl  - Is a 4-D Matrix size: [m x n x p x NS] wich holds a set of 
%               NS Labeled Atlases.
% band_method  - Type of method used to compute the weights used in patch
%                label fusion methods
% 
%                0 = All weights are set to 1 (same value);
%                1 = w are computed according to [1] (similarity measure);
%                2 = w are computed according to [2] (sparse restriction);
% 
% 
% NG            - Radius of Search neighborhood
% PTH           - Radius of Patch
% schspels      -(optional) Holds the set of spels where the labels are
%                estimated, If it is not specified. 
% 
%% Output      
%              - L The resulting segmentation on the specified
%                spels(schspels ).
% 
%% Requirements
%  
%  SLEP package, available in http://yelab.net/software/SLEP/
% 
%% Related Papers
% [1] Coupé, P., Manjon, J.V., Fonov, V., Pruessner, J., Robles, M., Collins
%    D.L., 2011. Patch-based segmentation using expert priors: application
%    to hippocampus and ventricle segmentation. Neuroimage 54, 904-954
% 
% [2] Tong, T.,Wolz, R., Hajnal, J.V., Rueckert, D., 2012. Segmentation of 
%    brain images via sparse patch representation. MICCAIWorkshop on 
%    Sparsity Techniques inMedical Imaging, Nice, France.


if nargin<7
    schspels=1:numel(imgqry);
end

[x,y,z]=ind2sub(size(imgqry),schspels);
L=zeros(size(imgqry));

for indc=1:numel(schspels)
    
    Aph=extrac_pathc(imgqry,x(indc),y(indc),z(indc),PTH);
    [BTH,LBL]=extrac_neighboring(supdata,supdata_lbl,x(indc),y(indc),z(indc),NG,PTH);
    
    [BTH,LBL]=patch_selected_fast(Aph,BTH,LBL,0.9);
    
    switch band_method
        
        case 0
            w=ones(1,size(BTH,2));
        case 1
            w=compute_weights_npbs(BTH,Aph);
        case 2
            w=compute_weights(BTH,Aph,0.01);
            
    end
    
    L(x(indc),y(indc),z(indc))=label_fusion_estimation(w,LBL');
    
    
end




end

