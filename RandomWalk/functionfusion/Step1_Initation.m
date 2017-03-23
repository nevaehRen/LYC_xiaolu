
 function SNARE_PM = Step1_Initation(Params)

 %% ### Generate a n_SNARE*n_PM dimension matrix, 
 %% ### with n_SNARE random distribute in PM

    Init_Sites = randi(Params.n_PM,1,Params.n_SNARE);

    SNARE_PM   = zeros(Params.n_SNARE,Params.n_PM);

    for k=1:Params.n_SNARE
        SNARE_PM(k,Init_Sites(k))=1;
    end

 end