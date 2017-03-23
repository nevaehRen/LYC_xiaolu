 
 function    Vesicle = Step3_1_Update(SNARE_PM,Vesicle)
%##%--- since SNARE has rondom walked, check latest fusion site SNARE number

        if ~Vesicle.PM==0
            Vesicle.SNARE  = SNARE_PM(:,Vesicle.PM)==1;
            Vesicle.Type   = sum(Vesicle.SNARE);
        end  
 end   
     
 
     