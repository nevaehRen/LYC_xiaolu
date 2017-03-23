 
 function    Vesicle = Step3_a_Check_to_bind(SNARE_PM,Vesicle,Params)

        %##%--- if vesicle is in cells , then check to bind
        if RandomDecision(Params.Vesicle.lamda_bind,Params.dt,1)==1
%             disp('jump')
            Vesicle.status = 'stay';
            Vesicle.PM     = unidrnd(Params.n_PM);
            Vesicle.SNARE  = SNARE_PM(:,Vesicle.PM)==1;
            Vesicle.Type   = sum(Vesicle.SNARE);
        end
        
 end   
     
     