function [X Y]=CDFF(Set)

% Set-All events set
% Set=Delay{1,1};

% step 1: choose unique random variable X
X=unique(Set);
Y=X;
Total=sum(size(Set))-1;

% step 2: calculate P(X>D), probability of next fusion happens after D seconds

a=sum(size(X))-1;

for j=1:a

Y(j,1)=sum(Set>X(j));

end



    
    
    
    
    
    
    
    