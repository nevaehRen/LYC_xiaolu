
clear;
clc;

%%  ##- Process 0. Paramters Defination

Params.n_PM           = 100;   % ##- number of fusion sites in PM
Params.n_SNARE        = 50;    % ##- number of SNAREs 
Params.R              = 0.1;   % ##- number of labeled SNAREs 
Params.dt             = 0.05;   % ##- time resolution
Params.SNARE.lamda_jump     = 2;     % ##- SNARE stay average time
Params.SNARE.lamda_unbind   = 2;     % ##- when vesicle comes, SNARE stay average time
Params.SNARE.lamda_fusion   = 1.42;   % ##- when vesicle goes,  SNARE stay average time

Params.Vesicle.lamda_wait   = 4.15;
Params.Vesicle.lamda_bind   = 3.1918;   % ##- vesicle waiting time
Params.Vesicle.lamda_unbind = 4.15;   % ##- vesicle waiting time
Params.Vesicle.lamda_fusion = 3.56;   % ##- vesicle waiting time


Vesicle.status = 'in';  % ##- vesicle state: 'in' = within cell  'stay' = in PM  'fusion' = Fusion 
Vesicle.PM     = 0;     % ##- vesicle binding site, index for PM
Vesicle.SNARE  = zeros(Params.n_SNARE,1); %## - vesicle binding site snares
Vesicle.Type   = 0;     % ## - vesicle binding site snares
Vesicle.Fusion = 0;

%% ##- Process I. SNARE distribution on PM

SNARE_PM = Step1_Initation(Params);
Record(1).Label    = 'going';
Record(1).Params   = Params;

 for i=1:10000   

%% ##- Process II: SNARE random walk *--start--*  

    SNARE_PM = Step2_SNARE_Random_Walk(SNARE_PM,Vesicle,Params);

    
%% ##- Process III: Vesicle fusion  *--Start--*
    
   Vesicle = Step3_1_Update(SNARE_PM,Vesicle);

   %##%--- a. if vesicle is free , then check to bind
    
   if strcmpi(Vesicle.status,'in')&strcmpi(Record(1).Label,'going')
        Vesicle = Step3_a_Check_to_bind(SNARE_PM,Vesicle,Params);
   end
    
    
   %##%--- b. if vesicle is in PM , then update SNARE numbers
   if  strcmpi(Vesicle.status,'stay')&strcmpi(Record(1).Label,'going')
            
            %--- if SNARE number is 0
            if  Vesicle.Type   == 0
            
                if RandomDecision(Params.Vesicle.lamda_wait,Params.dt,1)
                    Vesicle.status   = 'in';
                    Record(1).Label  = 'DU';
                end
            
            %--- if SNARE number is 1, then wait or unbind or fusion
            elseif Vesicle.Type == 1
                
                if RandomDecision(Params.Vesicle.lamda_unbind,Params.dt,1)
                    Vesicle.status   = 'in';
                    Record(1).Label  = 'DU';
                end
                
                if RandomDecision(Params.Vesicle.lamda_fusion,Params.dt,1)
                    Vesicle.status   = 'fusion';
                    Record(1).Label  = 'DF';
                end
                
            elseif Vesicle.Type>=2
            %--- if SNARE number is 2, then fusion
                if strcmpi(Vesicle.status,'stay')
                    Record(1).Label  = 'DF';
                else
                    Record(1).Label  = 'CF';
                end
                Vesicle.status   = 'fusion';

            end
    end
  
       
     Record(i).Vesicle  = Vesicle;
     Record(i).SNARE_PM = SNARE_PM;
     
    %##%--- c. wait until all snare gone
    if  ~strcmpi(Record(1).Label,'going')&Vesicle.Type==0
    	Record(1).Label
        break;
    end
    
%% ##- Process  III: Vesicle fusion  *--end--*


 end


 
 
 
  
     
 %% ##- Process IV: Revise vesicle fusion

 for i=1:sum(size(Record))-1
 
    if      strcmpi(Record(i).Vesicle.status,'in')

     Record(i).Vesicle.Fusion = 0;
     
    elseif  strcmpi(Record(i).Vesicle.status,'stay')

     Record(i).Vesicle.Fusion = 1;

    elseif  strcmpi(Record(i).Vesicle.status,'fusion')

     Record(i).Vesicle.Fusion = 2;  
     
     break;
     
    end
    
 end
     
     
     
