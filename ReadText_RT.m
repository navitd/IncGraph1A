% data from http://jmcauley.ucsd.edu/data/amazon/
% there are 1,689,188 reviews
% reading Amazon data and saving cell with asin, Score and Time
clear all
close all

FileName='Electronics_5.txt';
fid = fopen(FileName, 'r');

% for i = 1:3
%     Rv = fgets(fid)
% end
maxBlocks    = 1,689,188;        % Number of reviews is given
countRv = zeros(7050,1);         % number of items 
ERT       = cell( maxBlocks, 3);
item       = 0;
Keya = '"asin": ';
KeyS = '"overall": ';
KeyD = '"unixReviewTime": ';
previd = 'a';
iid=0;

while ~feof(fid)
   item = item+1;
   singleRv = fgets(fid);  %all infromation about a single review
   if ~ischar(singleRv)
      break;
   end
   %% reading Review asin
   Indexasin = strfind( singleRv, Keya )+length(Keya)+1;
   asinstr = singleRv(Indexasin:Indexasin+9);
   ERT{item,1}=asinstr;
   %% reading Review date and score
   IndexS = strfind( singleRv, KeyS )+length(KeyS);
   score = str2num(singleRv(IndexS:IndexS+3));
   ERT{item,2} = score;
   
   IndexD = strfind( singleRv, KeyD )+length(KeyD);
   chi=0;
   Dstr='';
   ch=singleRv(IndexD);
   while ch~=','
        chi=chi+1;
        Dstr=strcat(Dstr,ch);
        ch = singleRv(IndexD+chi);
   end
   ERT{item,3} = str2num(Dstr);
   % converting unixTime to date:
   % datetime(1303603200,'ConvertFrom','posixtime')
   %% how many Reviews per item?
   id = asinstr;
   if strcmp(id,previd)
       countRv(iid) = countRv(iid)+1;
   else
       iid=iid+1;
       countRv(iid) = countRv(iid)+1;
   end
   previd = id;
end
Nitem=length(countRv);
fclose(fid); 
save ElectronicRT

