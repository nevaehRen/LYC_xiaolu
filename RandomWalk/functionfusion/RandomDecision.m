
function Decision = RandomDecision(lamda,dt,n)
%%--%% This is a random decision process with parameters:
%%--%%   
%%--%%   Inputs:
%%--%%   ### lamda: average waiting time
%%--%%   ###    dt: time resolution
%%--%%   ###     n: number of decisions
%%--%%   
%%--%%   Outputs:
%%--%%   ### Decision: happen or not


% dt     = 0.1;                       % time resolution
% lamda  = 4;                   % mean time
p_jump = 1/(lamda/dt);       % n*p=lamda=1


Decision = [];           % Decision!

for i=1:n
    
Decision = [ Decision; 0+(rand(1)<p_jump)];           % Decision!

end


end






% 
% Happens=[];
% 
% t=0;
% for i=1:100000
% t=t+dt;    
% if rand(1)<lamda_jump
% Happens=[Happens;t];
% t=0;
% end
% end
% 
% 
% 
% 
% 
% 
% 
% 
% Docking_High=Happens;
% 
% 
% 
% 
% figure(10)
% set(gcf,'Position',[100  60  600 400], 'color',[1 1 1]);
% hist(Docking_High,0:0.1:max(Docking_High))
% set(gca,'FontName','American Typewriter','FontSize',16)
% set(gca,'xlim',[0 max(Docking_High)])
% 
% title('DF')
% 
% 
% 
% 
% figure(2)  
% BGD; 
% [X Y]=CDFF(Docking_High);
% 
% 
% hold on
% Colors=summer(5);
% 
% 
% plot((X),(Y),'.','MarkerSize',10,'Color',Colors(1,:))
% 
% %  set(gca,'xscale','log')
%   set(gca,'yscale','log')
% 
% set(gca,'Fontsize',16)
% 
% xlabel('Fusion Delay','Fontsize',15)
% ylabel('Event Frequency','Fontsize',15)
% 
% 
% TestResult=[];
% alpha_Range=0.05;
% 
% 
% for alpha=alpha_Range:-0.01:0.01
%  
% TestResult=[TestResult;p_judge(Docking_High,alpha)];
% 
% end
% 
% 
% 
% 
% 
%  
% 
% figure(8)
% set(gcf,'Position',[100  60  600 400], 'color',[1 1 1]);
% 
% imagesc(~TestResult)
% name = {'Gauss','Gamma','Possion','exponent','rayleigh'};
% set(gca, 'XTick',[1:5],'XTickLabel', name);
% set(gca, 'YTick',[1  alpha_Range/0.01],'YTickLabel', [alpha_Range  0.01]);
% ylabel('Alpha') 
% % title('DF & CF1 & CF2 :  T_g_1 - T_c_1')
% % title('CF1 :  T_g_1 - T_c_1')
% 
% set(gca, 'LineWidth',1) 
% set(gca,'FontName','American Typewriter','FontSize',16)
% 
% mean(Docking_High)
% 
% 
