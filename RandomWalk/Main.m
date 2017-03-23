
clear;
clc;


%% 
n_PM           = 100; % ##- number of fusion sites in PM
n_SNARE        = 20;  % ##- number of SNAREs 
R              = 0.1; % ##- number of labeled SNAREs 
Vesicle.status = 'in';% ##- vesicle state: 'in' = within cell  'stay' = in PM  'fusion' = Fusion 
Vesicle.PM     = 0;   % ##- vesicle binding site, index for PM
Vesicle.SNARE  = zeros(n_SNARE,1); %## - vesicle binding site snares
Vesicle.Type   = 0;   % ## - vesicle binding site snares

dt             = 0.1;   % ##- time resolution
lamda_jump     = 4;     % ##- SNARE stay average time
lamda_unbind   = 4;     % ##- when vesicle comes, SNARE stay average time
lamda_fusion   = 1.6;   % ##- when vesicle goes,  SNARE stay average time

Vesicle.lamda_bind   = 2;   % ##- vesicle waiting time
Vesicle.lamda_unbind = 4;   % ##- vesicle waiting time
Vesicle.lamda_fusion = 4;   % ##- vesicle waiting time

%% ##- Process 0. SNARE distribution on PM


%Step 0.1: initial random distribute SNARE in PM
    Init_Sites = randi(n_PM,1,n_SNARE);

    SNARE_PM   = zeros(n_SNARE,n_PM);

    for k=1:n_SNARE
        SNARE_PM(k,Init_Sites(k))=1;
    end

    
    
    
 for i=1:10000   
   
     Record(i).Vesicle = Vesicle;
     Record(i).SNARE_PM = SNARE_PM;

%% ##- Process I: SNARE random walk   *--Start--*

% Step1.1: check movable SNAREs and distance -1 or 1
    Jump     = RandomDecision(lamda_jump,dt,n_SNARE);

    % if vesivle bind snare, then it's harder for snare to unbind 
    if  strcmpi(Vesicle.status,'stay')
       Jump(Vesicle.SNARE) = RandomDecision(lamda_unbind,dt,Vesicle.Type);
    end
    % if vesivle fused, then it's easyier for snare to fusion 
    if  strcmpi(Vesicle.status,'fusion')
       Jump(Vesicle.SNARE) = RandomDecision(lamda_fusion,dt,Vesicle.Type);
    end
    
    Distance = 1-2*(unidrnd(2)>1); 
    Move     = Jump*Distance;

% Step1.2: move SNAREs
    % move left
    SNARE_PM(Move==-1,:) = SNARE_PM( Move==-1,[ 2:end  1 ] ) ;

    % move right
    SNARE_PM( Move==1,:) = SNARE_PM( Move==1,[ end  1:end-1 ]) ;

%% ##- Process I: SNARE random walk     *--end--*





%% ##- Process II: Vesicle random bind  *--Start--*

% Step2.1:

    if    strcmpi(Vesicle.status,'in')
        %##%--- if vesicle is in cells , then check to bind
        if RandomDecision(Vesicle.lamda_bind,dt,1)==1
            Vesicle.status = 'stay';
            Vesicle.PM     = unidrnd(n_PM);
            Vesicle.SNARE  = SNARE_PM(:,Vesicle.PM)==1;
            Vesicle.Type   = sum(Vesicle.SNARE);
        end
            
    elseif  strcmpi(Vesicle.status,'stay')
        %##%--- if vesicle is in PM , then update SNARE numbers
            Vesicle.SNARE  = SNARE_PM(:,Vesicle.PM)==1;
            Vesicle.Type   = sum(Vesicle.SNARE);
            
            if  Vesicle.Type==0
            %--- if SNARE number is 0
                Vesicle.status = 'in';
                Vesicle.PM     = 0;
                Vesicle.SNARE  = SNARE_PM(:,1)*0;
                Vesicle.Type   = sum(Vesicle.SNARE);

            elseif Vesicle.Type==1
            %--- if SNARE number is 1, then wait or unbind or fusion
                if RandomDecision(Vesicle.lamda_unbind,dt,1)
                    Vesicle.status = 'in';
                    Vesicle.PM     = 0;
                    Vesicle.SNARE  = SNARE_PM(:,1)*0;
                    Vesicle.Type   = sum(Vesicle.SNARE);
                end
                if RandomDecision(Vesicle.lamda_fusion,dt,1)
                    Vesicle.status = 'fusion';
                end
                
            elseif Vesicle.Type==2
            %--- if SNARE number is 2, then fusion
                Vesicle.status = 'fusion';
            end
         
     elseif  strcmpi(Vesicle.status,'fusion')
        %##%--- if vesicle is fused , then check snare diffusion
        Vesicle.SNARE  = SNARE_PM(:,Vesicle.PM)==1;
        Vesicle.Type   = sum(Vesicle.SNARE);
        
        if  Vesicle.Type==0
            break;
        end

    end

    
    
    
    
%% ##- Process II: Vesicle random bind  *--end--*



 end










