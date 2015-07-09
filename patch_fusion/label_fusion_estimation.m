

function [l]=label_fusion_estimation(w,LBL)

          lb=unique(LBL);
          
          for i=1:numel(lb)
              
              lst(i)=sum(w(LBL==lb(i)))./sum(w);
                            
          end
          
          [~,ind] = max (lst);
          l=lb(ind);
          
                    
          
end