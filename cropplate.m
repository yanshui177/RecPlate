function [Ipcrop, Ipchar] = cropplate(Iplate)
% 车牌字符裁剪，将二值车牌图像中所有字符
% 裁剪成单个字符图像
% -----------------------------------
% 参数   
% [Ipcrop, Ipchar] = cropplate(Iplate)
% @输入 Iplate 输入的车牌图像
% @输出 Icrop  输出裁剪后的图像序列
% @输出 Ipchar 裁剪后第一个图像，汉字
% -----------------------------------
%                  作者：李波 @2017

%%
% 预处理
% subplot(1,2,1),plot(Iplate),title('车牌图像');
Ipf=bwareaopen(Iplate,20);% 形态学滤波（车牌图像是二值图像%）
Ippcrop=double(Ipf);

[h,w]=size(Ippcrop); 
X3=zeros(1,w);%产生1行q列全零数组
for j=1:w
    for i=1:h
       if(Ippcrop(i,j)==1) 
           X3(1,j)=X3(1,j)+1;
       end
    end
end
% subplot(1,2,2),plot(0:q-1,X3),title('列方向像素点灰度值累计和'),xlabel('列值'),ylabel('累计像素量');

% 字符分割 h高w宽，倒序分割
Px0=w;%字符右侧限
Px1=w;%字符左侧限
for i=1:6
    while((X3(1,Px0)<3)&&(Px0>0))
       Px0=Px0-1;
    end
    Px1=Px0;
    while(((X3(1,Px1)>=3))&&(Px1>0)||((Px0-Px1)<15))
        Px1=Px1-1;
    end
    Ipcrop{i}=Ipf(:,Px1:Px0,:);
%     figure(6);subplot(1,7,8-i);imshow(Ipcrop);
%     ii=int2str(8-i);
%     imwrite(Ipcrop,strcat(ii,'.jpg'));%strcat连接字符串。保存字符图像。
    Px0=Px1;
end

% 对第一个字符进行特别处理
PX3=Px1;%字符1右侧限
while((X3(1,PX3)<3)&&(PX3>0))
       PX3=PX3-1;
end
Ipchar=Ippcrop(:,1:PX3,:);
% subplot(1,7,1);imshow(Ipchar);
% imwrite(Ipchar,'1.jpg');

end

