


close;
figure(1)
set(gcf,'Position',[100  60  600 300], 'color',[1 1 1]);
% % �����µ�ͼ����ʾ��
% hAxe=axes('Parent',gcf,... % �����µ�axe�� ��'parent' ��������Ϊ��ǰ����gcf
%     'Units','pixels',...  %���õ�λΪpixels
%     'Position',[0  0  600 400]);  % ָ��axe��λ�ã���ʽΪ[left bottom width height]�� left��bottom�趨��axe������ %�����꣬width��height�趨�˴��ڵĿ�Ⱥ͸߶�


for i=1:sum(size(Record))-1
 
    if ~strcmpi(Record(i).Vesicle.status,'in')
       Record(i).SNARE_PM(:,Record(i).Vesicle.PM)=Record(i).SNARE_PM(:,Record(i).Vesicle.PM)/2;
    i
    end
    
imagesc(Record(i).SNARE_PM) 

pause(0.01)

    
    end











