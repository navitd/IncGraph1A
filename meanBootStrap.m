function [bmean] = meanBootStrap(w,vec,Nitr)
% not [bootstrapmean] = meanBootStrap(w,vec,Nitr)
%w=20;
%Nitr = length(ixdip1);
%vec = pSall;

for i = 1:Nitr
    ix = ceil(rand(w,1)*length(vec)); %rand vec
    bmean(i) = mean(vec(ix));
end
%bootstrapmean = mean(bmean);