
 function  SNARE_PM = Step2_SNARE_Random_Walk(SNARE_PM,Vesicle,Params)
%% ##
%% ##  SNARE jumps randomly
%% ##
%% ##  if SNARE is free,              then waiting time = Params.SNARE.lamda_jump 
%% ##  if SNARE is binded to vesicle, then waiting time = Params.SNARE.lamda_bind 
%% ##  if SNARE is used for fusion,   then waiting time = Params.SNARE.lamda_fusion 
%% ## 
%% ##  if it decide to jump, it random jump to left or right.
%% ##


 
% Step1.1: check movable SNAREs and distance -1 or 1
    Jump = RandomDecision(Params.SNARE.lamda_jump,Params.dt,Params.n_SNARE);

    % if vesivle bind snare, then it's harder for snare to unbind 
    if  strcmpi(Vesicle.status,'stay')
       Jump(Vesicle.SNARE) = RandomDecision(Params.SNARE.lamda_unbind,Params.dt,Vesicle.Type);
    end
    % if vesivle fused, then it's easyier for snare to fusion 
    if  strcmpi(Vesicle.status,'fusion')
       Jump(Vesicle.SNARE) = RandomDecision(Params.SNARE.lamda_fusion,Params.dt,Vesicle.Type);
    end
    
    Distance = 1-2*(unidrnd(2)>1); 
    Move     = Jump*Distance;

% Step1.2: move SNAREs
    % move left
    SNARE_PM(Move==-1,:) = SNARE_PM( Move==-1,[ 2:end  1 ] ) ;

    % move right
    SNARE_PM( Move==1,:) = SNARE_PM( Move==1,[ end  1:end-1 ]) ;

 end