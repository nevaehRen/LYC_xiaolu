


close;
figure(1)
set(gcf,'Position',[100  60  600 300], 'color',[1 1 1]);
% % 产生新的图像显示框
% hAxe=axes('Parent',gcf,... % 设置新的axe， 将'parent' 属性设置为当前窗口gcf
%     'Units','pixels',...  %设置单位为pixels
%     'Position',[0  0  600 400]);  % 指定axe的位置，格式为[left bottom width height]， left和bottom设定了axe的左下 %角坐标，width和height设定了窗口的宽度和高度


for i=1:sum(size(Record))-1
 
    if ~strcmpi(Record(i).Vesicle.status,'in')
       Record(i).SNARE_PM(:,Record(i).Vesicle.PM)=Record(i).SNARE_PM(:,Record(i).Vesicle.PM)/2;
    i
    end
    
imagesc(Record(i).SNARE_PM) 

pause(0.01)

    
    end











