clear;
clc;
n=10;
A=sprandn(n,n,0.2)+eye(n)*n;%ʹ��sprandn��������һ�����ϡ�����A,���Խ���Ԫ������Ϊn
b=randn(n, 1); %����һ��n��1�е��������b
disp('A����');
disp(A);
disp('b����');
disp(b);
P=diag(diag(A));% ����һ��Ԥ�������,�þ����ǶԽ��󣬶Խ���Ԫ��ΪA�ĶԽ���Ԫ��
i_m=200; %����������
% ʹ��Ԥ�������ݶȷ���PCG�����ϡ����󷽳�
x=zeros(length(b), 1);% ��ʼ��
r=b-A*x;%�����ʼ�в�
z=P\r;%����Ԥ����
p=z;%����Ϊ��ʼ��������
r_k=dot(r,z);%���������ڻ�
rs=zeros(i_m, 1);
for i=1:200
    Ap=A*p; %������������˻�
    al=r_k/dot(p,Ap);%���㲽��
    x=x+al*p; %���½����� 
    r=r-al*Ap; %����в� 
    rs(i)=norm(r); %�������ķ���
    if norm(r)<1e-7  %����в�С����ֵ������Ϊ������������ر���������ѭ��
       chancha=norm(r)/norm(b);
       f=0;
       break;
    end
    z_k=P\r; %ʹ��Ԥ�������Ե�ǰ�в����Ԥ�����õ��µ��½�����
    r_k1 =dot(r,z_k); %�����µĲв�����½�����
    be=r_k1/r_k; 
    p=z_k+be*p;%����������򣬸���
    r_k=r_k1;
end
if i==i_m  %����жϵ����Ƿ�ﵽ������
    f=1;
    chancha=norm(r)/norm(b);
end
rs(i+1:i_m)=[];
disp(['������������ ', num2str(i)]);
disp(['��Բв�: ', num2str(chancha)]);
figure;
semilogy(rs, '-o');%�����Զ�����ʽ��ʾY���ͼ��
xlabel ('��������');
ylabel('���');