%% 车牌处理程序
%
%
clear
close all
clc

%% 读取车牌图像
% [fn,pn,~]=uigetfile('ChePaiKu\*.jpg','选择图片');
% Is=imread([pn fn]);%输入原始图像
% clear fn pn
Is=imread('car2.jpg');%输入原始图像

%% 找到车牌位置
Iplate=findplate(Is); clear Is;

%% 车牌字符分割
[Ipcrop, Ipchar] = cropplate(Iplate); clear Iplate;

%% 车牌字符识别
% [result, I]=recplate(Ipcrop, Ipchar);

%% 显示结果