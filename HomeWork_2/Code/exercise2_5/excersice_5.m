close all; 
clc;
clear all;

Xneg=[-1,0,0,1];
Yneg=[0,1,-1,0];

Xpos = [3,3,5,5];
Ypos = [1,-1,1,-1];

figure;
xlabel('x1');
ylabel('x2');
grid on;
axis([-5 5 -5 5]);
hold on;
plot(Xneg,Yneg,'ro');
plot(Xpos,Ypos,'bo');
hold off;


X = [1 1; -1 1; 1 -1; -1 -1;  2 2; -2 2; 2 -2; -2 -2;  ];
Xa = mapFeature(X);

figure(2);
grid on;
axis([-5 5 -5 5]);
xlabel('x1');
ylabel('x2');
hold on;
plot(X(1:4,1),X(1:4,2), 'bo');
plot(X(5:8,1),X(5:8,2), 'ro');
hold off;

figure(3);
grid on;
xlabel('x1');
ylabel('x2');
axis([-15 0 -15 0]);
hold on;
plot(Xa(1:4,1),Xa(1:4,2), 'bo');
plot(Xa(5:8,1),Xa(5:8,2), 'ro');
hold off;



