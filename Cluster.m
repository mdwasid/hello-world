clear all;
filename='Iris2.xlsx'; % Load the Iris flower dataset.
X=xlsread(filename);
[a,b]=size(X);
%% n=input('Enter number of clusters');
n=3; 
%% Initialization of random centers from the data
c=ceil(rand(n,1)*a);
for i=1:n
    C(i,:)=X(c(i),:);
end

%% Number of iteration. 
itr=30;
L1=[];
C11=[];
for it=1:itr
    clust=[]; L=zeros(1,n); jn=[]; im=[];
    %% calculation of distance of each data point to the center 
    for j=1:a % a=150
        for i1=1:n % n=3
            d(i1)=sqrt(sum((X(j,1:b)-C(i1,1:b)).^2));
        end
        [dmin,imin]=min(d);
        im=[im,imin]; % Labeling of each data point
    end
    %% Assignment of the data point to its nearest center
    for i=1:n % n=3
        for j=1:a % a=150
            if im(j)==i
                clust=[clust;X(j,:)];
                L(i)=L(i)+1; %(# of Neighbors) Keep record of number of neighbors to a center
                jn=[jn;j];
            end
        end
        z=0;
        y=zeros(max(L),n);
        for i=1:n
            if L(i)==0 % if # of neigbors are zero 
                C(i,:)=C(i,:);  
            else
                C(i,:)=mean([clust(1+z:z+L(i),:);C(i,:)]); %Updated center
                y(1:L(i),i)=jn(1+z:z+L(i)); % Final distribution of data points in cluster
                z=z+L(i);
            end
        end
    end
end 
%% 3D Plot of Actual Data
plot3(X(:,1),X(:,2),X(:,3),'*')
grid on
xlabel('Sepal width')
ylabel('Sepal Length')
zlabel('Petal Length')
title('IRIS Data Plot with 3 features')
figure
%% 3D plot after clustering 
for j=1:L(1,1)
    xx1(j,1:b)=X(y(j,1),1:b);
end
for j=1:L(1,2)
    xx2(j,1:b)=X(y(j,2),1:b);
end
for j=1:L(1,3)
    xx3(j,1:b)=X(y(j,3),1:b);
end
plot3(xx1(:,1),xx1(:,2),xx1(:,3),'*k')
hold on
plot3(C(1,1),C(1,2),C(1,3),'rv')
grid on
hold on
plot3(xx2(:,1),xx2(:,2),xx2(:,3),'ok')
hold on
plot3(C(2,1),C(2,2),C(2,3),'mv')
hold on
plot3(xx3(:,1),xx3(:,2),xx3(:,3),'+k')
hold on
plot3(C(3,1),C(3,2),C(3,3),'kv')
xlabel('Sepal width')
ylabel('Sepal Length')
zlabel('Petal Length')
title('IRIS Data Plot after clustering')

    