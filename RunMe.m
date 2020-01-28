% ==============================================================================
%  MATLAB Source Codes for the book "Cooperative Dedcision and Planning for
%  Connected and Automated Vehicles" published by Mechanical Industry Press
%  in 2020.
% ��������������Эͬ������滮�������鼮���״���
%  Copyright (C) 2020 Bai Li
%  2020.01.27
% ==============================================================================
%  �ڶ���. 2.3.5С��. ����AMPLָ�����򵥵ĳ����켣�滮���⣬�����ӻ������Ż����
% ==============================================================================
%  ����˵����
%  1. ��Figure 3���������ʹ��10������Ԫ�����ֱ�ۿɼ�������Ԫ�����õ���
%     ���ݾ��飬��K = 3ǰ���£�һ��Ӧ����Nfeʹ�䱣֤tf / Nfe <= 1.0.
% ==============================================================================
close all
% ��Matlab����AMPL�նˣ���������ִ�����ڹ켣�滮����������� %
!ampl simple_case.run

% ����AMPL���õ��ľ��߱��� %
load x.txt
load y.txt
load theta.txt
load v.txt
load a.txt
load phy.txt
load w.txt
load tf.txt

% �ز����������� %
K = 3;
Nfe = length(x) / (K + 1);
precision_level = 0.01;
[~, precise_x] = GeneratePreciseProfileFromCollocationGrids(x, Nfe, tf, precision_level, 0);
[~, precise_y] = GeneratePreciseProfileFromCollocationGrids(y, Nfe, tf, precision_level, 0);
[timeline_w, precise_w] = GeneratePreciseProfileFromCollocationGrids(w, Nfe, tf, precision_level, 1);
[timeline_v, precise_v] = GeneratePreciseProfileFromCollocationGrids(v, Nfe, tf, precision_level, 0);

% �����ز����켣 %
% ���������Ļ��Ʒ�ʽ�����ͬ %
figure(1)
set(0,'DefaultLineLineWidth',3);
plot(precise_x,precise_y,'k');
axis equal; box on; grid on; axis tight;
xlabel('x axis / m','Fontsize',16,'FontWeight','bold');
ylabel('y axis / m','Fontsize',16,'FontWeight','bold');
set(gca,'FontSize',12,'FontWeight','bold');
title('������ʻ�켣');

figure(2)
set(0,'DefaultLineLineWidth',2);
plot(timeline_v, precise_v,'k');
box on; grid on;
axis([0 tf -3 3]);
hold on
plot(timeline_v, ones(1,length(precise_v)).*2.0, 'r');
plot(timeline_v, ones(1,length(precise_v)).*-2.0, 'r');
xlabel('Time /sec','Fontsize',16,'FontWeight','bold');
ylabel('Velocity [m/s]','Fontsize',16,'FontWeight','bold');
set(gca,'FontSize',12,'FontWeight','bold');
title('�����˶��ٶ�v(t)');

figure(3)
set(0,'DefaultLineLineWidth',2);
plot(timeline_w, precise_w,'k');
axis([0 tf -1 1]);
box on; grid on;
hold on
plot(timeline_w, ones(1,length(precise_w)).*0.54, 'r');
plot(timeline_w, ones(1,length(precise_w)).*-0.54, 'r');
xlabel('Time /s','Fontsize',16,'FontWeight','bold');
ylabel('Derivative of Steering Angle [rad/s]','Fontsize',16,'FontWeight','bold');
set(gca,'FontSize',12,'FontWeight','bold');
title('�����˶�ǰ��ת�ǽ��ٶ�w(t)');