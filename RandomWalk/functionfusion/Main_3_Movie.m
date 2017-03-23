
vidObj = VideoWriter('peakss.avi');
open(vidObj);
 


t_tot = Record(1).Params.dt*(sum(size(Record))-1);

close;
figure(1)

set(gcf,'Position',[100  60  1200 400], 'color',[1 1 1]);

% % 产生新的图像显示框
% hAxe=axes('Parent',gcf,... % 设置新的axe， 将'parent' 属性设置为当前窗口gcf
%     'Units','pixels',...  %设置单位为pixels
%     'Position',[0  0  600 400]);  % 指定axe的位置，格式为[left bottom width height]， left和bottom设定了axe的左下 %角坐标，width和height设定了窗口的宽度和高度


for i=2:sum(size(Record))-1
t=i*Record(1).Params.dt;
 
    if ~strcmpi(Record(i).Vesicle.status,'in')
       Record(i).SNARE_PM(:,Record(i).Vesicle.PM)=Record(i).SNARE_PM(:,Record(i).Vesicle.PM)/2;
       Record(i).SNARE_PM(:,Record(i).Vesicle.PM)=Record(i).SNARE_PM(:,Record(i).Vesicle.PM)+0.1;
    end
    
subplot(2,2,[1,3])    
imagesc(Record(i).SNARE_PM)
xlabel('PM')
ylabel('SNARE')
% title(strcat(Record(1).Label,'    time:',num2str(t),'s'))

subplot(2,2,2)    
hold on

plot([t-Record(1).Params.dt t],[Record(i-1).Vesicle.Fusion Record(i).Vesicle.Fusion],'b','Linewidth',2)


ylim([-0.3,3])

set(gca, 'YTick', [0 1 2],'yticklabel',{'intracellular','dock','fusion'}) 


xlim([0,t_tot])

title('Vesicle')


subplot(2,2,4)    
hold on
plot([t-Record(1).Params.dt t],[Record(i-1).Vesicle.Type Record(i).Vesicle.Type],'r','Linewidth',2)
ylim([-0.3,3])
xlim([0,t_tot])
xlabel('time  s')

title('SNAREs')




figure(1);

currFrame = getframe(gcf);
writeVideo(vidObj,currFrame);
  
%        
% if ~strcmpi(Record(i).Vesicle.status,'in')
%     pause(0.005)
% else
%     pause(0.001)
% end

    end


    % Close the file.
    close(vidObj);
  




