clear
MaxIter=10;
beta=0.9;
K=0:0.01:1; % grid over cake size
[rk,dimK]=size(K);
V=zeros(dimK,MaxIter); % initialize the value function matrix
for iter=1:MaxIter % iteration of the Bellman equation
disp(iter); % displays iteration number
aux=zeros(dimK,dimK)+NaN; % matrix of all possible values of consumption
% initialize this to missing values.
% When taking the max, the missings are not
% taken into account.
for ik=1:dimK % loop over all size of cake at beginning of period
    for ik2=1:(ik-1) % loop over all size of cake at end of period
        aux(ik,ik2)=log(K(ik)-K(ik2))+beta*V(ik2,iter);
    end
end % Note: these two loops do not fill in entirely the aux matrix
% The size of cake next period has to be lower than the current one.
V(:,iter+1)=max(aux')'; % take the max value over vij ignoring
%the missing values
end
[Val,Ind]=max(aux'); % find the index of next period cake which
% maximizes the utility
optK=K(Ind); % Tomorrows optimal cake size
optK=optK+Val*0;
optC=K'-optK'; % optimal consumption
figure(1)
plot(K,V);
xlabel('Size of Cake');
ylabel('Value Function');
% plot optimal consumption rule as a function of cake size
figure(2)
plot(K,[optC K'],'LineWidth',2) % plot graph
xlabel('Size of Cake');
ylabel('Optimal Consumption');
text(0.4,0.65,'45 deg. line','FontSize',12) % add text to the graph
text(0.4,0.13,'Optimal Consumption','FontSize',12)