%% To determin the maximum value of function Y= Sin(x) in the range [0,2pi] with GA

clc;
close all;
clear all;
tic
%% Initialization 
ch=10; % No of chromosome
gn=10; % No Genes 
a=hardlim(rand(ch,gn)-0.5); % population

%% Encoding 
d=(gn-1):-1:0;
dec=a*(2.^d)';
x=(dec/(2^gn-1))*2*pi;

%% Fitness evaluation
f=sin(x);

%% sorting
s=sort(f,'descend');
for i=1:ch
    for j=1:ch
        if s(i)==f(j)
            s1(i,:)=a(j,:);
        end
    end
end

%% Iteration
itr=20;
for z=1:itr
    %% crossover
    pc=0.8; % Probablity of crossover 
    %Total no of crossover
    tn=pc*ch/2;
    %% Randomly selecting cromosomes for crossover 
    C_Child1=[];
    for i=1:tn
        r1=rand(1,2);
        b=ceil(r1*(ch-1)); % Parent ch. for crossover
        r2=ceil(rand*(gn-1)); % point of crossover
        c1=s1(b(1,1),1:gn);
        c2=s1(b(1,2),1:gn);
        chd1=[c1(1,1:r2),c2(1,r2+1:gn)];
        chd2=[c2(1,1:r2),c1(1,r2+1:gn)];
        chd=[chd1;chd2];
        C_Child1=[C_Child1;chd];
    end
    
    %% Mutation
    m_rate=0.2; %probablity of Mutation 
    no_mutation=2*tn*gn*m_rate; % total no of mutated bits
    C_Child2=C_Child1;
    for i=1:no_mutation
        r3=ceil(rand*(2*tn-1)); %selecting random child 
        r4=ceil(rand*(gn-1)); % selecting random gene
        C_Child2(r3,r4)=~C_Child2(r3,r4);
    end
    
    %% Reselection
    new=[s1;C_Child1;C_Child2]; % total available parents 
    p=(gn-1):-1:0;
    dec2=new*(2.^p)';
    x2=(dec2/(2^gn-1))*2*pi;
    
    %% Again Fitness
    f2=sin(x2);
    % again Sorting 
    s0=sort(f2,'descend');
    for i=1:size(new,1)
        for j=1:size(new,1)
            if s0(i)==f2(j)
                s11(i,:)=new(j,:);
            end
        end
    end
    s1=s11(1:10,:); % Reassignment as parents 
    fit(z)=s0(1,1); % Top fitness
end
toc
plot(fit)
grid on
xlabel('Generation'); ylabel('Fitness Value');