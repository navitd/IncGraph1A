% find high impact reviews
% by histogram of average score in window


clear all
close all
fig=1;
%% within item check
load EitemCell

s0 = 4;         % choose subgroup around s0 
deltas = 1;   
sa = s0-deltas;  
sb = s0+deltas;

hdip = -1.5;      % define dip
w=20;

%% statistics of occurances
gCell=cell(Nitem,2);
Sall = [];
rowIngCell = 1;
for item = 1:Nitem
    %what is average score?
    if itemCell{item,4}>=sa & itemCell{item,4}<sb
        gCell(rowIngCell,1) = itemCell(item,1);
        ZeroMeanS = cell2mat( itemCell(item,2) ) - cell2mat( itemCell(item,4) );
        gCell{rowIngCell,2}(:) = ZeroMeanS;
        % column 2 is zero-mean score
        Sall = cat(1,Sall,ZeroMeanS);
        rowIngCell = rowIngCell+1;
    end
end
clear itemCell
gCell2 = gCell(1:rowIngCell-1,:);
clear gCell
gCell = gCell2;
clear gCell2
save gCell

%load gCell % length 102
%%
Ning = rowIngCell-1;
dipix = cell(Ning,1);
countdip=1;
for item = 1:Ning
    rv = cell2mat(gCell(item,2));
    ix = find(rv<=hdip);
    dipix{item,1} = ix;
    if ~isempty(ix) & ix(end)+w<=length(rv)
        for iii = 1:length(ix)
            dip(countdip,1) = item;
            dip(countdip,2) = ix(iii);
            wS1(countdip) = mean( rv( ix(iii):ix(iii)+w ));
            countdip = countdip+1;
        end
    end
end
Ndip = length(wS1);



%% Histogram analysis
Nhistbin = 30;
mark = floor(Nhistbin/3);
Nhistitr=1;

edgess1 = linspace(min(wS1),max(wS1),Nhistbin);
edgesgen = edgess1;
[counts1,inds1] = histc(wS1,edgess1);
counts1norm = counts1/sum(counts1);    %area under graph normalized to 1
redarea  = counts1norm(1:mark)*(edgess1(2:mark+1)'-edgess1(1:mark)');
NIdip1   = sum(counts1(1:mark));
for itr = 1:Nhistitr
    [bmean] = meanBootStrap(w,Sall,10^5); % mean in shuffled window
    [countgen,indgen] = histc(bmean,edgesgen);
    countgennorm = countgen/sum(countgen); %area under graph normalized to 
    %% blue area under line smaller than mark
    bluearea(itr) = countgennorm(1:mark)*(edgesgen(2:mark+1)'-edgesgen(1:mark)');
    rat(itr)      = bluearea(itr)/redarea;
end 
area_ratio = mean(rat)
std_area_ratio = std(rat)


%% plotting histogram
figure(fig), fig = fig+1;
plot(edgesgen+s0,countgennorm,'o-','LineWidth',1.4), hold all 
plot(edgess1+s0,counts1norm,'o-','LineWidth',1.4)
legend('general (shuffled)','High Impact Reviews')
hold off
title(['Histogram of mean score in window, w=',num2str(w)])
xlabel('Score')
ylabel('Frequency')
set(gca,'FontSize',14)
