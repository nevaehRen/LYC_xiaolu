
% DF.T_c1 - DF.T_g1 ;CF1.T_c1 - CF1.T_g1;CF2.T_c1 - CF2.T_g1 

% Docking_High=abs([CF2.T_c1; CF2.T_c2; CF1.T_c1; ] );

% Docking_High=abs([CF2.T_c1-CF2.T_g1; CF2.T_c2-CF2.T_g2; CF1.T_c1-CF1.T_g1; DF.T_c1-DF.T_g1] );

% Docking_High=abs([CF2.T_g1; CF2.T_g2; CF1.T_g1; DF.T_g1 ] );


Docking_High=abs([CF2.T_c2;DF.T_c1;] );

 

% Docking_High=abs([CF2.T_c1; ] );




mean(Docking_High)

figure(10)
set(gcf,'Position',[100  60  600 400], 'color',[1 1 1]);
hist(Docking_High,0:0.1:max(Docking_High))
set(gca,'FontName','American Typewriter','FontSize',16)
set(gca,'xlim',[0 max(Docking_High)])

title('DF')
% 6.7056
% 0.1284




figure(2)  
 BGD;
 
 
[X Y]=CDFFN(Docking_High);


hold on
Colors=summer(5);


plot((X),(Y),'.','MarkerSize',10,'Color','r')
%fit(log(X(2:end)),log(Y(2:end)),'poly1')


% plot(X_low,Y_low,'.','MarkerSize',10,'Color',[1 0 0])

%  set(gca,'xscale','log')
  set(gca,'yscale','log')

set(gca,'Fontsize',16)

xlabel('Fusion Delay','Fontsize',15)
ylabel('Event Frequency','Fontsize',15)


TestResult=[];
alpha_Range=0.91;


Docking_High(Docking_High==0)=[];


for alpha=alpha_Range:-0.01:0.01
 
TestResult=[TestResult;p_judge(Docking_High,alpha)];

end





% 
% 
% 

figure(8)
set(gcf,'Position',[100  60  600 400], 'color',[1 1 1]);

imagesc(~TestResult)
name = {'Gauss','Gamma','Possion','exponent','rayleigh'};
set(gca, 'XTick',[1:5],'XTickLabel', name);
set(gca, 'YTick',[1  alpha_Range/0.01],'YTickLabel', [alpha_Range  0.01]);
ylabel('Alpha') 
% title('DF & CF1 & CF2 :  T_g_1 - T_c_1')
title('CF1 :  T_g_1 - T_c_1')

set(gca, 'LineWidth',1) 
set(gca,'FontName','American Typewriter','FontSize',16)


mean(Docking_High)
phat = gamfit(Docking_High)

% 
% 
% 
% 
% 
